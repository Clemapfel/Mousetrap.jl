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

!!! danger 
    February, 2024: This section used to contain an example of how to get `GLMakie` to work with `Mousetrap.GLArea`. Recent changes to the internals of `GLMakie` have broken this example, and the corresponding experimental package `MousetrapMakie`. Both no longer work, and `MousetrapMakie` is now unmaintained.