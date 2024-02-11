```@meta
DocTestSetup = quote
  using Mousetrap
  function Window(app::Application)
      out = Mousetrap.Window(app)
      set_tick_callback!(out, out) do clock, self
          close!(self)
          return TICK_CALLBACK_RESULT_DISCONTINUE
      end
      return out
  end
end
```

# Chapter 12: OpenGL Integration & Makie Support

In this chapter, we will learn:
+ How to use `GLArea` to allow foreign OpenGL libraries to render to a Mousetrap widget
+ How to display a `GLMakie` plot in a Mousetrap window

!!! compat 
    Features from this chapter are only available in Mousetrap `v0.3.0` or newer.

---

# Introduction: Use Case

If we want to render shapes or images using `OpenGL`, Mousetraps `RenderArea` offers a convenient interface for this. In some applications, we may want to use [OpenGL](https://github.com/JuliaGL/ModernGL.jl) itself. One common use case for this is the integration of another, separate library that is unrelated to Mousetrap and shares no interface with it, except for the fact that both use OpenGL for rendering. 

For situations like this, Mousetrap offers a low-level, generic widget, [`GLArea`](@ref), which provides an OpenGL context and render surface, thus allowing OpenGL-based graphics to be displayed inside a Mousetrap application.

# GLArea

`GLarea` is a very simple widget, it acts exactly as `RenderArea` in terms of appearance and behavior, though there is no in-Mousetrap way to display graphics.

We create it like so:

```julia
area = GLArea()
```

After which it can be used just like any other widget, meaning it has a size request, opacity, adheres to CSS, etc.

`GLArea` holds its own OpenGL context, which is **initialized after `realize` has been emitted**. This is important to understand, we cannot call any OpenGL code before the widget is fully realized and displayed on screen. To delay execution, we should connect to one of `GLArea`s signals.

!!! danger "OpenGL Context is only available after Realization"
    To reiterate, Mousetrap will only be able to provide an OpenGL context after `GLArea` is realized, which usually happens when the window it is contained within is shown for the first time. If we try to interact with the context before this point, a critical log message will be printed and the OpenGL operation will fail.

## Signals

`GLArea` has two unique signals, `render` and `resize`. Alongside these, in most situations, we will also want to connect to the `realize` signal, which all widgets share.

We recognize `resize` from `RenderArea`. Just as then, it requires a signal handler with the signature

```julia
(::GLArea, width::Integer, height::Integer, [::Data_t]) -> Nothing
```

`resize` is emitted anytime `GLArea` changes size, according to its widget properties. Crucially, this also means its [default framebuffer](https://www.khronos.org/opengl/wiki/Default_Framebuffer) and [viewport](https://www.khronos.org/opengl/wiki/GLAPI/glViewport) are resized accordingly. **We cannot change either size ourselves**, Mousetrap's back-end handles this for us. 

For each `resize` invocation, we can assume that the default frame buffer has a size of `width * height` pixels.

Signal `render` is usually emitted once per frame, whenever the widget is drawn on screen. This signal requires a callback with the signature

```julia
(::GLArea, gdk_gl_context::Ptr{Cvoid}, [::Data_t]) -> Bool
```

Where `gdk_gl_context` is a C-pointer to the internally held [OpenGL context](https://docs.gtk.org/gdk4/class.GLContext.html). We usually do not have to interact with this context, though any `render` signal handler still requires including this argument to conform to the above signature.

We note that signal `render` requires its callback to return a boolean. This return value notifies Mousetrap whether the `GLArea`s framebuffer was updated during the draw step. If we have modified the image we want to appear on screen, we should return `true`, if no drawing has taken place and the `GLArea` does not need to be updated, `false` should be returned.

In the signal handler of `render`, we should make sure to bind the current `GLArea`s OpenGL context as the active one using [`make_current`](@ref) (see below). This is to make sure that we are rendering to the buffer associated with the specific `GLArea` emitting the signal, not another instance of the same widget type, or a completely separate OpenGL context from another library.

!!! warning "GLAreas do not share a Context"
    Unlike `RenderArea`, which all share a singular global OpenGL context, each `GLArea` instance has its own OpenGL context, meaning objects cannot be transmitted between `GLArea`s, and, if one is unrealized, all objects associated with that context will be inaccessible (but not freed).

For performance optimization reasons, `GLArea` will only be drawn when necessary, as is the case for all objects subtyping `Widget`. We can manually request `GLArea` to update the frame after this one, by calling [`queue_render`](@ref).

General usage of `GLarea` with another OpenGL-based library will have the following structure:

```julia
glarea = GLArea()

# realize callback
connect_signal_realize!(glarea) do self::GLArea
    make_current(self)

    # do initialization here, only after this callback was invoked is the 
    # internal OpenGL context fully initialized and ready to be used

    queue_render(self)
    return nothing
end

# render callback
connect_signal_render!(glarea) do self::GLArea, _::Ptr{Cvoid}
    make_current(self)

    # do opengl renderloop here

    return true
end

# resize callback
connect_signal_resize!(glarea) do self::GLArea, width, height
    make_current(self)

    # handle new size here

    queue_render(self)
    return nothing
end

# destroy callback
connect_signal_destroy!(glarea) do self::GLArea
    make_current(self)

    # do shutdown here

    return nothing
end
```

We see that we should make sure to bind the context using `make_current` before doing any OpenGL-related work and to manually request a redraw after the area was initialized or resized.

# Example: GLMakie 

[`GLMakie`](https://docs.makie.org/stable/explanations/backends/glmakie/index.html) is one backend for the hugely popular [`Makie`](https://github.com/MakieOrg/Makie.jl) plotting library. As its name suggests, `GLMakie` uses OpenGL for rendering, which means it is possible to allow Makie to render to a Mousetrap `GLArea`, allowing us to integrate plots and graphics into our Mousetrap application.

Given here will be a minimum working example that displays a scatter plot inside a `Mousetrap.Window` by creating a `GLArea`-based widget that can be used to create a `GLMakie.Screen`.

Note that this example is incomplete and does not support all of Makies features. One conflict that Mousetrap users will have to resolve for themselves is how to handle input events. In the following, all of Makies input-related behavior was suppressed, making it so users will have to handle input events and window behavior using only the Mousetrap event model.

!!! details "Note from the Author: Makie Interface"
    The example here most likely does not implement enough of Makies interface to be fully ready for usage. Most of the code was based on [`Gtk4GLMakie`](https://github.com/JuliaGtk/Gtk4Makie.jl), which itself is still rough. I'm not that familiar with Makie in general usage, and fully implementing an interface requires knowledge of Makies internals on top of that. 

    If you or your project is very familiar with Makie and would like to improve this code, feel free to [open a PR](https://github.com/Clemapfel/Mousetrap.jl/pulls) that modifies [`test/makie_test.jl`](https://github.com/Clemapfel/Mousetrap.jl/blob/main/test/makie_test.jl), which ideally will become its own Julia package in the future, similar to `Gtk4GLMakie`. Any contributor will be credited as an author. Thank you for your consideration.

    C.

!!! details "MousetrapMakie: Click to expand"
    ```julia
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

        """
        ## GLMakieArea <: Widget
        `GLArea` wrapper that automatically connects all necessary callbacks to be used as a GLMakie render target. 

        Use `create_glmakie_screen` to initialize a screen you can render to using Makie from this widget. Note that `create_glmakie_screen` needs to be 
        called **after** `GLMakieArea` has been realized, as only then will the internal OpenGL context be available. See the example below.

        ## Constructors
        `GLMakieArea()`

        ## Signals
        (no unique signals)

        ## Fields
        (no public fields)

        ## Example

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
        """
        mutable struct GLMakieArea <: Widget

            glarea::GLArea              # wrapped native widget
            framebuffer_id::Ref{Int}    # set by render callback, used in MousetrapMakie.create_glmakie_screen
            framebuffer_size::Vector2i  # set by resize callback, used in GLMakie.framebuffer_size

            function GLMakieArea()
                glarea = GLArea()
                set_auto_render!(glarea, false) # should `render` be emitted everytime the widget is drawn
                connect_signal_render!(on_makie_area_render, glarea)
                connect_signal_resize!(on_makie_area_resize, glarea)
                return new(glarea, Ref{Int}(0), Vector2i(0, 0))
            end
        end
        Mousetrap.get_top_level_widget(x::GLMakieArea) = x.glarea

        # maps hash(GLMakieArea) to GLMakie.Screen
        const screens = Dict{UInt64, GLMakie.Screen}()

        # maps hash(GLMakieArea) to Scene, used in `on_makie_area_resize`
        const scenes = Dict{UInt64, GLMakie.Scene}()

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

        # destruction callback ignored, lifetime is managed by Mousetrap instead
        function GLMakie.destroy!(w::GLMakieArea)
            # noop
        end

        # check if canvas is still realized
        GLMakie.was_destroyed(window::GLMakieArea) = !get_is_realized(window)

        # check if canvas should signal it is open
        Base.isopen(w::GLMakieArea) = !GLMakie.was_destroyed(w)

        # react to makie screen visibility request
        GLMakie.set_screen_visibility!(screen::GLMakieArea, bool) = bool ? show(screen.glarea) : hide!(screen.glarea)

        # apply glmakie config
        function GLMakie.apply_config!(screen::GLMakie.Screen{GLMakieArea}, config::GLMakie.ScreenConfig; start_renderloop=true) 
            @warn "In MousetrapMakie: GLMakie.apply_config!: This feature is not yet implemented, ignoring config"
            # cf https://github.com/JuliaGtk/Gtk4Makie.jl/blob/main/src/screen.jl#L111
            return screen
        end

        # screenshot framebuffer
        function Makie.colorbuffer(screen::GLMakie.Screen{GLMakieArea}, format::Makie.ImageStorageFormat = Makie.JuliaNative)
            @warn "In MousetrapMakie: GLMakie.colorbuffer: This feature is not yet implemented, returning framecache"
            # cf https://github.com/JuliaGtk/Gtk4Makie.jl/blob/main/src/screen.jl#L147
            return screen.framecache
        end

        # ignore makie event model, use Mousetrap event controllers instead
        Makie.window_open(::Scene, ::GLMakieArea) = nothing
        Makie.disconnect!(::GLMakieArea, f) = nothing
        GLMakie.pollevents(::GLMakie.Screen{GLMakieArea}) = nothing
        Makie.mouse_buttons(::Scene, ::GLMakieArea) = nothing
        Makie.keyboard_buttons(::Scene, ::GLMakieArea) = nothing
        Makie.dropped_files(::Scene, ::GLMakieArea) = nothing
        Makie.unicode_input(::Scene, ::GLMakieArea) = nothing
        Makie.mouse_position(::Scene, ::GLMakie.Screen{GLMakieArea}) = nothing
        Makie.scroll(::Scene, ::GLMakieArea) = nothing
        Makie.hasfocus(::Scene, ::GLMakieArea) = nothing
        Makie.entered_window(::Scene, ::GLMakieArea) = nothing

        """
        
            create_gl_makie_screen(::GLMakieArea; screen_config...) -> GLMakie.Screen{GLMakieArea}
        
        For a `GLMakieArea`, create a `GLMakie.Screen` that can be used to display makie graphics
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
    ```

We can test the above using:

```julia
using Mousetrap, .MousetrapMakie, GLMakie
main() do app::Application
    window = Window(app)
    set_title!(window, "Mousetrap x Makie")

    canvas = GLMakieArea()
    set_size_request!(canvas, Vector2f(200, 200))
    set_child!(window, canvas)

    # use optional ref to delay screen allocation after `realize`
    screen = Ref{Union{Nothing, GLMakie.Screen{GLMakieArea}}}(nothing)
    connect_signal_realize!(canvas) do self

        # initialize GLMakie.Screen
        screen[] = create_glmakie_screen(canvas)

        # use screen to display plot
        display(screen[], scatter(rand(123)))
        return nothing
    end

    present!(window)
end
```

![](../assets/makie_scatter.png)

Where we delayed the call to `create_gl_makie_screen` to *after* `realize` was emitted for reasons discussed [earlier in this chapter](#glarea). Since we still need to reference the created screen outside the `realize` signal handler, we used the **optional pattern**:

```julia
optional = Ref{Union{Nothing, T}}(nothing)
```

Which initializes a reference with `nothing`, such that the reference value can later be assigned with a value of `T`, `GLMakie:Screen{GLMakieArea}` in our example above. After `realize` was emitted, we can access the screen using `screen[]`.
