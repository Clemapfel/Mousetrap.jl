using mousetrap_jll
using Mousetrap
using ModernGL, GLMakie, Colors, GeometryBasics, ShaderAbstractions
using GLMakie: empty_postprocessor, fxaa_postprocessor, OIT_postprocessor, to_screen_postprocessor
using GLMakie.GLAbstraction
using GLMakie.Makie

const WindowType = Mousetrap.Window
const screens = Dict{Ptr{Cvoid}, GLMakie.Screen}();

function GLMakie.resize_native!(window::WindowType, resolution...)
end

function on_makie_canvas_render(self, context)
    hash = Mousetrap.as_widget_pointer(self)
    if haskey(screens, hash)
        screen = screens[hash]
        isopen(screen) || return false
        screen.render_tick[] = nothing
        glarea = win2glarea[screen.glscreen]
        glarea.framebuffer_id[] = glGetIntegerv(GL_FRAMEBUFFER_BINDING)
        GLMakie.render_frame(screen)    
    end
    return true
end

function on_makie_canvas_realize(self)
    make_current(self)
end

mutable struct GtkGLMakie <: Widget

    glarea::GLCanvas
    framebuffer_id::Ref{Int}

    function GtkGLMakie()
        glarea = GLCanvas()
        #set_auto_render!(glarea, false)
        connect_signal_realize!(on_makie_canvas_realize, glarea)
        connect_signal_render!(on_makie_canvas_render, glarea)
        return new(glarea, Ref{Int}(0))
    end
end
Mousetrap.get_top_level_widget(x::GtkGLMakie) = x.glarea

const win2glarea = Dict{WindowType, GtkGLMakie}()

GLMakie.framebuffer_size(w::WindowType) = GLMakie.framebuffer_size(win2glarea[w])
GLMakie.framebuffer_size(w::GtkGLMakie) = size(w) .* GLMakie.retina_scaling_factor(w)
GLMakie.window_size(w::GtkGLMakie) = size(w)
GLMakie.to_native(w::WindowType) = win2glarea[w]
GLMakie.pollevents(::GLMakie.Screen{Mousetrap.Window}) = nothing

function GLMakie.was_destroyed(window::WindowType)
    return false #get_is_closed(window)
end

function Base.isopen(w::WindowType)
    return !GLMakie.was_destroyed(win)
end

function GLMakie.set_screen_visibility!(w::WindowType, b::Bool)
    if b 
        present!(w)
    else
        set_hide_on_close!(w, true)
        close!(w)
    end
end

function GLMakie.apply_config!(screen::GLMakie.Screen{Mousetrap.Window}, config::GLMakie.ScreenConfig; start_renderloop=true) 
    # TODO
    return screen
end

function Makie.colorbuffer(screen::GLMakie.Screen{Mousetrap.Window}, format::Makie.ImageStorageFormat = Makie.JuliaNative)
    if !isopen(screen)
        error("Screen not open!")
    end
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

function Base.close(screen::GLMakie.Screen{Mousetrap.Window}; reuse = true)
    GLMakie.set_screen_visibility!(screen, false)
    GLMakie.stop_renderloop!(screen; close_after_renderloop=false)
    if screen.window_open[]
        screen.window_open[] = false
    end
    if !GLMakie.was_destroyed(screen.glscreen)
        empty!(screen)
    end
    if reuse && screen.reuse
        @debug("reusing screen!")
        push!(SCREEN_REUSE_POOL, screen)
    end
    glw = screen.glscreen
    if haskey(win2glarea, glw)
        glarea = win2glarea[glw]
        delete!(screens, Mousetrap.get_top_level_widget(glarea))
        delete!(win2glarea, glw)
    end        
    close(toplevel(screen.glscreen))
    return
end

ShaderAbstractions.native_switch_context!(a::GtkGLMakie) = make_current(a.glarea)
ShaderAbstractions.native_switch_context!(a::WindowType) = ShaderAbstractions.native_switch_context!(win2glarea[a])

ShaderAbstractions.native_context_alive(x::WindowType) = !GLMakie.was_destroyed(x)
ShaderAbstractions.native_context_alive(x::GtkGLMakie) = get_is_realized(x)

function GLMakie.destroy!(w::WindowType)
    was_current = ShaderABstractions.is_current_context(w)
    if !GLMakie.was_destroyed(nw)
        close!(nw)
    end
    return was_current && ShaderAbstractions.switch_context!()
end

function GtkScreen(app::Mousetrap.Application; resolution, screen_config...)
    config = Makie.merge_screen_config(GLMakie.ScreenConfig, screen_config)
    window = Mousetrap.Window(app)
    glarea = GtkGLMakie()

    if config.fullscreen
        set_fullscreen!(window)
    end

    if config.visible 
        present!(window)
    end

    set_expand!(glarea, true)
    set_child!(window, glarea)

    shader_cache = GLAbstraction.ShaderCache(glarea)
    ShaderAbstractions.switch_context!(glarea)
    fb = GLMakie.GLFramebuffer(resolution)

    postprocessors = [
        config.ssao ? ssao_postprocessor(fb, shader_cache) : empty_postprocessor(),
        OIT_postprocessor(fb, shader_cache),
        config.fxaa ? fxaa_postprocessor(fb, shader_cache) : empty_postprocessor(),
        to_screen_postprocessor(fb, shader_cache, glarea.framebuffer_id)
    ]

    screen = GLMakie.Screen(
        window, shader_cache, fb,
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
    screens[Mousetrap.as_widget_pointer(glarea)] = screen
    win2glarea[window] = glarea

    set_tick_callback!(glarea) do clock::FrameClock
        if GLMakie.requires_update(screen)
            queue_render(glarea.glarea)
        end

        if GLMakie.was_destroyed(window)
            return TICK_CALLBACK_RESULT_DISCONTINUE
        else
            return TICK_CALLBACK_RESULT_CONTINUE
        end
    end

    return screen
end

Makie.disconnect!(window::WindowType, f) = Makie.disconnect!(win2glarea[window], f)
function Makie.disconnect!(window::GtkGLMakie, f)
    s = Symbol(f)
    if !haskey(window.handlers, s)
        return
    end

    disconnect_signal_render!(window)
    disconnect_signal_realize!(window)
end

function Makie.window_open(scene::Scene, window::GtkGLMakie)
end


function Makie.window_area(scene::Scene, screen::GLMakie.Screen{Mousetrap.Window})
    area = scene.events.window_area
    dpi = scene.events.window_dpi

    function on_resize(self, w, h)
        dpi[] = 165.87755102040816
        area[] = Recti(0, 0, w, h)
        return nothing
    end

    glarea = win2glarea[Makie.to_native(screen)]
    connect_signal_resize!(on_resize, glarea.glarea)
    queue_render(glarea.glarea)
end

function Makie.mouse_buttons(scene::Scene, glarea::GtkGLMakie)
end

function Makie.disconnect!(glarea::GtkGLMakie, ::typeof(mouse_buttons))
end

function Makie.keyboard_buttons(scene::Scene, glarea::GtkGLMakie)
end

function Makie.disconnect!(glarea::GtkGLMakie, ::typeof(keyboard_buttons))
end

function Makie.dropped_files(scene::Scene, window::GtkGLMakie)
end

function Makie.unicode_input(scene::Scene, window::GtkGLMakie)
end

function GLMakie.retina_scaling_factor(window::GtkGLMakie)
    (1, 1) # TODO
end

function GLMakie.correct_mouse(window::GtkGLMakie, w, h)
end

function Makie.mouse_position(scene::Scene, screen::GLMakie.Screen{Mousetrap.Window})
end

function Makie.scroll(scene::Scene, window::GtkGLMakie)
end

function Makie.hasfocus(scene::Scene, window::GtkGLMakie)
end

function Makie.entered_window(scene::Scene, window::GtkGLMakie)
end

function Makie.disconnect!(glarea::GtkGLMakie, ::typeof(entered_window))
end

main() do app::Application
    screen = GtkScreen(app, resolution = (800, 800))
    display(screen, scatter(1:4))
end