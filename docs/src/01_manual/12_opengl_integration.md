# Chapter 12: OpenGL Integration & Makie Support

In this chapter we will learn:
+ How to use `GLArea` to allow foreign libraries to render to a mousetrap widget
+ How to display a `GLMakie` plot in a mousetrap window

---

# Introduction: Use Case

If we want to render shapes or images using `OpenGL`, mousetraps `RenderArea` offers a convenient interface for this. Some users may choose to disregard this interface completely and may prefer to instead render OpenGL graphics using [OpenGL](https://github.com/JuliaGL/ModernGL.jl) itself. One common use case for this is integration of another, separate library that is unrelated to mousetrap, and shares no interface with it, except for the fact that both use OpenGL for rendering. For situations like this, mousetrap offers a low-level, generic widget, [`GLArea`](@ref), which provides an OpenGL context and render surface, thus allowing other libraries graphcis to be displayed and inserted into a mousetrap application just like any mosuetrap-native widget would.

# GLArea

`GLarea` is a very simple widget, it acts exactly as `RenderArea` in terms of appearance and behavior, though there is no in-mousetrap way to display graphics.

We create it like so:

```julia
area = GLArea()
```

After which it can be used just like any other widget. 

`GLArea` holds it's own OpenGL context, which is **initialized after `realize` has been emitted**. This is important to understand, we cannot call any OpenGL code before the widget is fully realized and displayed on screen. To delay execution, we should connect to one of `GLArea`s signals.

## Signals

`GLArea` has two unique signals, `render` and `resize`. Alongside these, in most situations we will also want to connect to the `realize` signal, which all widgets share.

We recognize `resize` from `RenderArea`, it also requires a signal handler with the signature

```julia
(::GLArea, width::Integer, height::Integer, [::Data_t]) -> Nothing
```

`resize` is emitted anytime `GLArea` changes size, according to its widget properties. Crucially, this also means it's framebuffer and viewport are resized accordingly, we cannot change eithers size ourself, mousetraps back-end handles this for use. For each `resize` invocation, we can assume that it's framebuffer has a size of `width * height` pixels.

`render` is usually emitted once per frame, whenever the widget is drawn on screen. This signal requires a callback with the signature

```julia
(::GLArea, gdk_gl_context::Ptr{Cvoid}, [::Data_t]) -> Bool
```

Where `gdk_gl_context` is a C-pointer to the internally held [OpenGL context](https://docs.gtk.org/gdk4/class.GLContext.html). We usually do not have to interact with this context, though any signal handler still requires it to conform to the signature.

The return value of signal `render` notifies mousetrap as to whether the `GLArea`s framebuffer was updated during the draw step. If we modified the image we want to appear on screen, we should return `true`, if no drawing has taken place and the `GLArea` does not need to be updated, `false` should be returned.

In the callback of `render`, we should make sure to bind the current `GLArea`s OpenGL context as the active one using `make_current`. This is to make sure that we are rendering to the buffer associated with the `GLArea` emitting the signal, not another instance of the same widget type, or a completely separate OpenGL context from another library.

`GLArea` will only be drawn when necessary, as is the case for all objects subtyping `Widget`. We can manually request `GLArea` to update the next frame by calling [`queue_render`](@ref), which will request the image on screen to be updated as soon as possible.

General usage of `GLarea` with another OpenGL-based library will have the following structure:

```julia
glarea = GLArea()

connect_signal_realize!(glarea) do self::GLArea
    make_current(self)

    # do initialization here, only after this callback was invoked is the 
    # internal OpenGL context fully initialized and ready to be used

    queue_render(self)
    return nothing
end

connect_signal_render!(glarea) do self::GLArea, _::Ptr{Cvoid}
    make_current(self)

    # do opengl renderloop here

    return true
end

connect_signal_resize!(glarea) do self::GLArea, width, height
    make_current(self)

    # handle new size here

    queue_render(self)
    return nothing
end

connect_signal_destroy!(glarea) do self::GLArea
    make_current(self)

    # do shutdown here

    return nothing
end
```

We see that we make sure to bind the context using `make_current`, and to request a redraw after thw dinwo was initialized or resized.

# Example: GLMakie 

[`GLMakie`](https://docs.makie.org/stable/explanations/backends/glmakie/index.html) is one backend for the hugely popular [`Makie`](https://github.com/MakieOrg/Makie.jl) plotting library. As it's name suggests, `GLMakie` uses OpenGL for rendering, which means it is possible to allow makie to render to a mousetrap `GLArea`, allowing us to integrate plots and graphics not really possible in mousetrap into our application.

Given here will be a minimum working example that displays a scatterplot inside a `Mousetrap.Window`, by creating a `GLArea`-based widget, that can be used to create a `GLMakie.Screen`.

Note that this example is incomplete and does not support all of Makies features. One conflict that mousetrap users will have to resolve for themself is how to handle input events. In the following, all of Makies input-related behavior was surpressed, making it so users will have to handle input events and window behavior using only mousetrap.


