"""
Minimum working example showing how to display a GLMakie plot using Mousetrap `GLArea`
"""
module MousetrapMakie

    export GLMakieArea, create_glmakie_screen

    using Mousetrap
    using ModernGL, GLMakie, Colors, GeometryBasics, ShaderAbstractions
    using GLMakie: empty_postprocessor, fxaa_postprocessor, OIT_postprocessor, to_screen_postprocessor
    using GLMakie.GLAbstraction
    using GLMakie.Makie

    # maps hash(GLMakieArea) to GLMakie.Screen
    const screens = Dict{UInt64, GLMakie.Screen}()

    # maps hash(GLMakieArea) to Scene, used in `on_makie_area_resize`
    const scenes = Dict{UInt64, GLMakie.Scene}()

    """
    ## GLMakieArea <: Widget
    `GLArea` wrapper that automatically connects all necessary callbacks in order for it to be used as a GLMakie render target. 

    Use `create_glmakie_screen` to initialize a screen you can render to using Makie from this widget. Note that `create_glmakie_screen` needs to be 
    called **after** `GLMakieArea` has been realized, as only then will the internal OpenGL context be available. See the example below.

    ## Constructors
    `GLMakieArea()`

    ## Signals
    (no unique signals)

    ## Fields
    (no public fields)

    ## Example
    ```
    using Mousetrap, MousetrapMakie
    main() do app::Application
        window = Window(app)
        canvas = GLMakieArea()
        set_size_request!(canvas, Vector2f(200, 200))
        set_child!(window, canvas)
    
        # use optional ref to delay screen allocation after `realize`
        screen = Ref{Union{Nothing, GLMakie.Screen{GLMakieArea}}}(nothing)
        connect_signal_realize!(canvas) do self
            screen[] = create_glmakie_screen(canvas)
            display(screen[], scatter(1:4))
            return nothing
        end
        present!(window)
    end
    ```
    """
    mutable struct GLMakieArea <: Widget
        glarea::GLArea
        framebuffer_id::Ref{Int}
        framebuffer_size::Vector2i

        function GLMakieArea()
            glarea = GLArea()
            set_auto_render!(glarea, false) # should `render` be emitted everytime the widget is drawn
            connect_signal_render!(on_makie_area_render, glarea)
            connect_signal_resize!(on_makie_area_resize, glarea)
            return new(glarea, Ref{Int}(0), Vector2i(0, 0))
        end
    end
    Mousetrap.get_top_level_widget(x::GLMakieArea) = x.glarea

    # render callback: if screen is open, render frame to `GLMakieArea`s OpenGL context
    function on_makie_area_render(self, context)
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

    # resize callback: update framebuffer size, necessary for `GLMakie.framebuffer_size`
    function on_makie_area_resize(self, w, h)
        key = Base.hash(self)
        if haskey(screens, key)
            screen = screens[key]
            glarea = screen.glscreen
            glarea.framebuffer_size.x = w
            glarea.framebuffer_size.y = h
            queue_render(glarea.glarea)
        end

        if haskey(scenes, key)
            scene = scenes[key]
            scene.events.window_area[] = Recti(0, 0, glarea.framebuffer_size.x, glarea.framebuffer_size.y)
            scene.events.window_dpi[] = Mousetrap.calculate_monitor_dpi(glarea)
        end
        return nothing
    end

    # resolution of `GLMakieArea` OpenGL framebuffer
    GLMakie.framebuffer_size(self::GLMakieArea) = (self.framebuffer_size.x, self.framebuffer_size.y)

    # forward retina scale factor from GTK4 back-end
    GLMakie.retina_scaling_factor(w::GLMakieArea) = Mousetrap.get_scale_factor(w)

    # resolution of `GLMakieArea` widget itself`
    function GLMakie.window_size(w::GLMakieArea)
        size = get_natural_size(w)
        size.x = size.x * GLMakie.retina_scaling_factor(w)
        size.y = size.y * GLMakie.retina_scaling_factor(w)
        return (size.x, size.y)
    end

    # calculate screen size and dpi
    function Makie.window_area(scene::Scene, screen::GLMakie.Screen{GLMakieArea})
        glarea = screen.glscreen
        scenes[hash(glarea)] = scene
    end

    # resize request by makie will be ignored
    function GLMakie.resize_native!(native::GLMakieArea, resolution...)
        # noop
    end

    # bind `GLMakieArea` OpenGL context
    ShaderAbstractions.native_switch_context!(a::GLMakieArea) = make_current(a.glarea)

    # check if `GLMakieArea` OpenGL context is still valid, it is while `GLMakieArea` widget stays realized
    ShaderAbstractions.native_context_alive(x::GLMakieArea) = get_is_realized(x)

    # destruction callback ignored, lifetime is managed by mousetrap instead
    function GLMakie.destroy!(w::GLMakieArea)
        # noop
    end

    GLMakie.was_destroyed(window::GLMakieArea) = !get_is_realized(window)
    Base.isopen(w::GLMakieArea) = !GLMakie.was_destroyed(w)
    GLMakie.set_screen_visibility!(screen::GLMakieArea, bool) = bool ? show(screen.glarea) : hide!(screen.glarea)

    function GLMakie.apply_config!(screen::GLMakie.Screen{GLMakieArea}, config::GLMakie.ScreenConfig; start_renderloop=true) 
        @warn "In MousetrapMakie: GLMakie.apply_config!: This feature is not yet implemented, ignoring config"
        # cf https://github.com/JuliaGtk/Gtk4Makie.jl/blob/main/src/screen.jl#L111
        return screen
    end

    function Makie.colorbuffer(screen::GLMakie.Screen{GLMakieArea}, format::Makie.ImageStorageFormat = Makie.JuliaNative)
        @warn "In MousetrapMakie: GLMakie.colorbuffer: This feature is not yet implemented, returning framecache"
        # cf https://github.com/JuliaGtk/Gtk4Makie.jl/blob/main/src/screen.jl#L147
        return screen.framecache
    end

    # ignore makie event model, use the mousetrap event controllers instead
    Makie.window_open(scene::Scene, window::GLMakieArea) = nothing
    Makie.disconnect!(window::GLMakieArea, f) = nothing
    GLMakie.pollevents(::GLMakie.Screen{GLMakieArea}) = nothing
    Makie.mouse_buttons(scene::Scene, glarea::GLMakieArea) = nothing
    Makie.keyboard_buttons(scene::Scene, glarea::GLMakieArea) = nothing
    Makie.dropped_files(scene::Scene, window::GLMakieArea) = nothing
    Makie.unicode_input(scene::Scene, window::GLMakieArea) = nothing
    Makie.mouse_position(scene::Scene, screen::GLMakie.Screen{GLMakieArea}) = nothing
    Makie.scroll(scene::Scene, window::GLMakieArea) = nothing
    Makie.hasfocus(scene::Scene, window::GLMakieArea) = nothing
    Makie.entered_window(scene::Scene, window::GLMakieArea) = nothing

    """
    ```
    create_gl_makie_screen(::GLMakieArea; screen_config...) -> GLMakie.Screen{GLMakieArea}
    ```
    For a `GLMakieArea`, create a GLMakie screen that can be used to display makie graphics
    """
    function create_glmakie_screen(area::GLMakieArea; screen_config...)

        if !get_is_realized(area) 
            log_critical("MousetrapMakie", "In MousetrapMakie.create_glmakie_screen: GLMakieArea is not yet realized, it's internal OpenGL context cannot yet be accessed")
        end

        config = Makie.merge_screen_config(GLMakie.ScreenConfig, screen_config)

        set_is_visible!(area, config.visible)
        set_expand!(area, true)

        # quote from https://github.com/JuliaGtk/Gtk4Makie.jl/blob/main/src/screen.jl#L342
        shader_cache = GLAbstraction.ShaderCache(area)
        ShaderAbstractions.switch_context!(area)
        fb = GLMakie.GLFramebuffer((1, 1)) # resized on GLMakieArea realization later

        postprocessors = [
            config.ssao ? ssao_postprocessor(fb, shader_cache) : empty_postprocessor(),
            OIT_postprocessor(fb, shader_cache),
            config.fxaa ? fxaa_postprocessor(fb, shader_cache) : empty_postprocessor(),
            to_screen_postprocessor(fb, shader_cache, area.framebuffer_id)
        ]

        screen = GLMakie.Screen(
            area, shader_cache, fb,
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
        # end quote

        hash = Base.hash(area.glarea)
        screens[hash] = screen
        
        set_tick_callback!(area.glarea) do clock::FrameClock
            if GLMakie.requires_update(screen)
                queue_render(area.glarea)
            end

            if GLMakie.was_destroyed(area)
                return TICK_CALLBACK_RESULT_DISCONTINUE
            else
                return TICK_CALLBACK_RESULT_CONTINUE
            end
        end
        return screen
    end
end

# test
using Mousetrap, .MousetrapMakie, GLMakie
main() do app::Application
    window = Window(app)
    canvas = GLMakieArea()
    set_size_request!(canvas, Vector2f(400, 400))
    set_child!(window, canvas)

    # use optional ref to delay screen allocation after `realize`
    screen = Ref{Union{Nothing, GLMakie.Screen{GLMakieArea}}}(nothing)
    connect_signal_realize!(canvas) do self
        screen[] = create_glmakie_screen(canvas)
        display(screen[], scatter(rand(1234)))
        return nothing
    end
    present!(window)
end