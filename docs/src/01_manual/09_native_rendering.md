# Chapter 9: Native Rendering

In this chapter we will learn:
+ How to use `RenderArea`
+ How to draw any shape
+ How to bind a shape, transform, shader, and blend mode for rendering
+ How to render to a (multi-sampled) texture

---

!!! danger "Native Rendering on MacOS"
    All classes and functions in this chapter **are impossible to use on MacOS**. For this platform,
    mousetrap was compiled in a way where any function relating to OpenGL was made unavailable. This 
    is because of Apples decision to deprecate OpenGL in a way where only physical owners of a Mac
    can compile libraries that have it as a dependency. See [here](https://github.com/users/Clemapfel/projects/2?pane=issue&itemId=33978341) for more information.

    If we try to use a disabled object, a **fatal error** will be thrown.

---

!!! details "Running snippets from this Chapter"
    To run any partial code snippet from this section, we can use the following `main.jl` file:
    ```julia
    using mousetrap
    main() do app::Application
        window = Window(app)

        render_area = RenderArea()

        # snippet code here

        aspect_frame = AspectFrame(1)
        set_child!(aspect_frame, render_area)
        set_size_request!(aspect_frame, Vector2f(200, 200))
        set_child!(window, aspect_frame)
        present!(window)
    end
    ```

In the [chapter on widgets](04_widgets.md), we learned that we can create new widgets by combining already pre-defined widgets as a *compound widget*. We can create a new widget that has a `Scale`, but we can't render our own scale with, for example, a square knob. In this chapter, this will change.

By using the native rendering facilities mousetrap provides, we are free to create any shape we want, assembling displays and new widgets pixel-by-pixel, line-by-line.

## RenderArea

The central widget of this chapter is [`RenderArea`](@ref), which is a canvas used to display native graphics. At first, it may seem very simple:

```julia
render_area = RenderAre()
```

This will render as a transparent area, because `RenderArea` has no graphic properties of its own. Instead, we need to create separate **shapes**, then **bind them for rendering**, after which `RenderArea` will display the shapes for us.

## Shapes

Shapes are defined by a number of **vertices**. A vertex has a position in 2D space, a color, and a texture coordinate. In this chapter, we will learn how to user each of these, starting with the position.

### Vertex Coordinate System

A shape's vertices define where inside the `RenderArea` it will be rendered. The coordinate system for these is different from the one we used for widgets. OpenGL, and thus mousetraps `Shape`, use the **right hand coordinate system**, which is familiar from traditional math:

![](https://learnopengl.com/img/getting-started/coordinate_systems_right_handed.png)

Where for now, we assume the z-coordinate for any vertex is set to 0, reducing the coordinate system to a 2D plane. 

We will refer to this coordinate system as **gl coordinates**, while the widget coordinate system used for `ClickEventController` and the like as **widget space coordinates**.

To further illustrate the difference between gl and widget space coordinates, consider this table, where `w` is the widgets width, `h` is the widgets height, in pixels:
 
| Conceptual Position | GL Coordinate | Widget Space Coordinate |
|---------------------|---------------|-------------------------|
| top left            | `(-1, +1)`    | `(, )` |
| top                 | `( 0, +1)`    | `(0, 0.5 * h)`
| top right           | `(+1, +1)`    | `(w, 0)`
| left                | `(-1,  0)`    | `(0, 0.5 * h)`
| center              | `( 0,  0)`    | `(0.5 * w, 0.5 * h)`
| right               | `(+1,  0)`    | `(, )`
| bottom left         | `(-1, -1)`    | `(, )`
| bottom              | `( 0, -1)`    | `(, )`
| bottom right        | `(+1, -1)`    | `(, )`

We see that the OpenGL coordiante system is **normalized**, meaning the values of each coordinate are inside `[-1, 1]`, while the widget-space coordinate system is **absolute**, meaning the values of each coordinate take the allocate size of the widget into account, being inside `[0, w]` and `[0, h]` for the x- and y- coordinate, respectively.

At any point, we can convert between the coordinate system using [`from_gl_coordinates`](@ref) and [`to_gl_coordinates`](@ref), which convert gl-to-widget-space and widget-space-to-gl coordinates, respectively. Of course, the widget space coordinates depend on the current size of the `RenderArea`. When it is resized, the old coordinates may be out of date, which is why using the *normalized* gl system is preferred. 

### Rendering Shapes

All shapes are instances of the type [`Shape`](@ref), the actual "shape" of `Shape`, meaning the which geometrical form it will take up on screen, depends on how it is intitialized. The simplest shape is a **point**, which is always exactly one pixel in size. We create a `Shape` of this type using [`Point`](@ref):

```julia
shape =


