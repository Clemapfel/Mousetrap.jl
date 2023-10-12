using mousetrap_jll
using Mousetrap
using ModernGL, GLMakie, Colors, GeometryBasics, ShaderAbstractions
using GLMakie: empty_postprocessor, fxaa_postprocessor, OIT_postprocessor, to_screen_postprocessor
using GLMakie.GLAbstraction
using GLMakie.Makie

const screens = Dict{UInt64, GLMakie.Screen}()

mutable struct GtkGLMakie <: Widget

    glarea::GLArea
    framebuffer_id::Ref{Int}
    framebuffer_size::Vector2i

    function GtkGLMakie()
        glarea = GLArea()
        set_auto_render!(glarea, false)
        connect_signal_realize!(on_makie_canvas_realize, glarea)
        connect_signal_render!(on_makie_canvas_render, glarea)
        connect_signal_resize!(on_makie_canvas_resize, glarea)
        return new(glarea, Ref{Int}(0), Vector2i(0, 0))
    end
end
Mousetrap.get_top_level_widget(x::GtkGLMakie) = x.glarea

function GLMakie.resize_native!(window::GtkGLMakie, resolution...)
    # noop, ignore makie size request in favor of GTK4 layout manager
end

function on_makie_canvas_render(self, context)
    key = Base.hash(self)
    if haskey(screens, key)
        screen = screens[key]
        if !isopen(screen) return false end
        screen.render_tick[] = nothing
        glarea = screen.glscreen
        glarea.framebuffer_id[] = glGetIntegerv(GL_FRAMEBUFFER_BINDING)
        GLMakie.render_frame(screen) 
    end
    return true
end

function on_makie_canvas_realize(self)
    make_current(self)
end

function on_makie_canvas_resize(self, w, h)
    key = Base.hash(self)
    if haskey(screens, key)
        screen = screens[key]
        glarea = screen.glscreen
        glarea.framebuffer_size.x = w
        glarea.framebuffer_size.y = h
        queue_render!(glarea)
    end
    return nothing
end

function GLMakie.window_size(w::GtkGLMakie)
    size = get_natural_size(w)
    size.x = size.x * GLMakie.retina_scaling_factor(w)
    size.y = size.y * GLMakie.retina_scaling_factor(w)
    return (size.x, size.y)
end

GLMakie.framebuffer_size(self::GtkGLMakie) = (self.framebuffer_size.x, self.framebuffer_size.y)
GLMakie.pollevents(::GLMakie.Screen{GtkGLMakie}) = nothing

function GLMakie.was_destroyed(window::GtkGLMakie)
    return !get_is_realized(window)
end

function Base.isopen(w::GtkGLMakie)
    return !GLMakie.was_destroyed(w)
end

function GLMakie.set_screen_visibility!(screen::GtkGLMakie, bool)
    if bool 
        show!(screen.glarea)
    else
        hide!(screen.glarea)
    end
end

function GLMakie.apply_config!(screen::GLMakie.Screen{GtkGLMakie}, config::GLMakie.ScreenConfig; start_renderloop=true) 
    # TODO
    return screen
end

function Makie.colorbuffer(screen::GLMakie.Screen{GtkGLMakie}, format::Makie.ImageStorageFormat = Makie.JuliaNative)

    ShaderAbstractions.switch_context!(screen.glscreen)
    ctex = screen.framebuffer.buffers[:color]
    if size(ctex) != size(screen.framecache)
        screen.framecache = Matrix{RGB{Colors.N0f8}}(undef, size(ctex))
    end
    GLMakie.fast_color_data!(screen.framecache, ctex)
    if format == Makie.GLNative
        return screen.framecache
    elseif format == Makie.JuliaNative
        img = screen.framecache
        return PermutedDimsArray(view(img, :, size(img, 2):-1:1), (2, 1))
    end
end

function Base.close(screen::GLMakie.Screen{GtkGLMakie}; reuse = true)
    GLMakie.set_screen_visibility!(screen, false)
    GLMakie.stop_renderloop!(screen; close_after_renderloop=false)
    if screen.window_open[]
        screen.window_open[] = false
    end
    if !GLMakie.was_destroyed(screen.glscreen)
        empty!(screen)
    end
    if reuse && screen.reuse
        push!(SCREEN_REUSE_POOL, screen)
    end
    glarea = screen.glscreen
    delete!(screens, hash(glarea))      
    close(toplevel(screen.glscreen))
    return
end

ShaderAbstractions.native_switch_context!(a::GtkGLMakie) = make_current(a.glarea)
ShaderAbstractions.native_context_alive(x::GtkGLMakie) = get_is_realized(x)

function GLMakie.destroy!(w::GtkGLMakie)
    # noop, lifetime is managed by mousetrap instead
end

function GtkScreen(glarea::GtkGLMakie; screen_config...)

    config = Makie.merge_screen_config(GLMakie.ScreenConfig, screen_config)
    if config.fullscreen
        # noop
    end

    set_is_visible!(glarea, config.visible)
    set_expand!(glarea, true)

    shader_cache = GLAbstraction.ShaderCache(glarea)
    ShaderAbstractions.switch_context!(glarea)
    fb = GLMakie.GLFramebuffer((800, 800))

    postprocessors = [
        config.ssao ? ssao_postprocessor(fb, shader_cache) : empty_postprocessor(),
        OIT_postprocessor(fb, shader_cache),
        config.fxaa ? fxaa_postprocessor(fb, shader_cache) : empty_postprocessor(),
        to_screen_postprocessor(fb, shader_cache, glarea.framebuffer_id)
    ]

    screen = GLMakie.Screen(
        glarea, shader_cache, fb,
        config, false,
        nothing,
        Dict{WeakRef, GLMakie.ScreenID}(),
        GLMakie.ScreenArea[],
        Tuple{GLMakie.ZIndex, GLMakie.ScreenID, GLMakie.RenderObject}[],
        postprocessors,
        Dict{UInt64, GLMakie.RenderObject}(),
        Dict{UInt32, Makie.AbstractPlot}(),
        false,
    )

    hash = Base.hash(glarea.glarea)
    screens[hash] = screen
    println("register: $hash")
    
    set_tick_callback!(glarea.glarea) do clock::FrameClock
        if GLMakie.requires_update(screen)
            queue_render(glarea.glarea)
        end

        if GLMakie.was_destroyed(glarea)
            return TICK_CALLBACK_RESULT_DISCONTINUE
        else
            return TICK_CALLBACK_RESULT_CONTINUE
        end
    end

    return screen
end

function Makie.disconnect!(window::GtkGLMakie, f)
    s = Symbol(f)
    if !haskey(window.handlers, s)
        return
    end

    disconnect_signal_render!(window)
    disconnect_signal_realize!(window)
    disconnect_signal_resize!(window)
end

function Makie.window_open(scene::Scene, window::GtkGLMakie)
    # noop
end

function Makie.window_area(scene::Scene, screen::GLMakie.Screen{GtkGLMakie})
    area = scene.events.window_area
    dpi = scene.events.window_dpi
    glarea = screen.glscreen

    function on_resize(self, w, h)
        dpi[] = Mousetrap.calculate_monitor_dpi(glarea)
        area[] = Recti(0, 0, w, h)
        return nothing
    end

    connect_signal_resize!(on_resize, glarea.glarea)
    queue_render(glarea.glarea)
end

function GLMakie.retina_scaling_factor(window::GtkGLMakie)
    return Mousetrap.get_scale_factor(window.glarea)
end

function Makie.mouse_buttons(scene::Scene, glarea::GtkGLMakie)
    # noop, use mousetrap event controllers to handle input
end

function Makie.keyboard_buttons(scene::Scene, glarea::GtkGLMakie)
    # noop, use mousetrap event controllers to handle input
end

function Makie.dropped_files(scene::Scene, window::GtkGLMakie)
    # noop
end

function Makie.unicode_input(scene::Scene, window::GtkGLMakie)
    # noop
end

function Makie.mouse_position(scene::Scene, screen::GLMakie.Screen{GtkGLMakie})
    # noop, use mousetrap event controllers to handle input
end

function Makie.scroll(scene::Scene, window::GtkGLMakie)
    # noop, use mousetrap event controllers to handle input
end

function Makie.hasfocus(scene::Scene, window::GtkGLMakie)
    # noop, use mousetrap event controllers to handle input
end

function Makie.entered_window(scene::Scene, window::GtkGLMakie)
    # noop, use mousetrap event controllers to handle input
end

main() do app::Application
    window = Window(app)

    glarea = GtkGLMakie()
    set_size_request!(glarea, Vector2f(200, 200))
    set_child!(window, glarea)

    screen = Ref{Union{GLMakie.Screen, Nothing}}(nothing)
    connect_signal_map!(glarea.glarea) do self
        make_current(glarea.glarea)
        screen[] = GtkScreen(glarea)
        display(screen[], scatter(1:4))
        return nothing
    end

    present!(window)
end