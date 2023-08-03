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

(source: [learnopengl.com]())

Where for now, we assume the z-coordinate for any vertex is set to 0, reducing the coordinate system to a 2D plane. 

We will refer to this coordinate system as **gl coordinates**, while the widget coordinate system used for `ClickEventController` and the like as **widget space coordinates**.

To further illustrate the difference between gl and widget space coordinates, consider this table, where `w` is the widgets width, `h` is the widgets height, in pixels:
 
| Conceptual Position | GL Coordinate | Widget Space Coordinate |
|---------------------|---------------|-------------------------|
| top left            | `(-1, +1)`    | `(0, 0)` |
| top                 | `( 0, +1)`    | `(w / 2, 0)`
| top right           | `(+1, +1)`    | `(w, 0)`
| left                | `(-1,  0)`    | `(0, y / 2)`
| center              | `( 0,  0)`    | `(w / 2, y / 2)`
| right               | `(+1,  0)`    | `(w, y / 2)`
| bottom left         | `(-1, -1)`    | `(0, y)`
| bottom              | `( 0, -1)`    | `(w / 2, y)`
| bottom right        | `(+1, -1)`    | `(w, y)`

We see that the OpenGL coordiante system is **normalized**, meaning the values of each coordinate are inside `[-1, 1]`, while the widget-space coordinate system is **absolute**, meaning the values of each coordinate take the allocate size of the widget into account, being inside `[0, w]` and `[0, h]` for the x- and y- coordinate, respectively.

At any point, we can convert between the coordinate system using [`from_gl_coordinates`](@ref) and [`to_gl_coordinates`](@ref), which convert gl-to-widget-space and widget-space-to-gl coordinates, respectively. Of course, the widget space coordinates depend on the current size of the `RenderArea`. When it is resized, the old coordinates may be out of date, which is why using the *normalized* gl system is preferred. 

### Rendering Shapes

Before we can learn about the different types of shapes, we need to learn how to render them. Consider the simplest shape, which is a point. A point is always exactly 1 pixel on screen.

We construct a [`Shape`](@ref) of this type like so: 

```cpp
point = Shape()
as_point!(point, Vector2f(0, 0));
```
Where {0, 0} is the center of the viewport.

Mousetrap also offers the following, more syntactically convenient form:

```cpp
point = Point(Vector2f(0, 0));
```
Which is exactly equivalent. Note that in both examples, `point` is of type `mousetrap.Shape`.

To render this point, we use our `RenderArea` instance from before, then we need to bind our shape for rendering. 

This is done using a **render task**. A render task takes all objects needed for rendering, and groups them together. When a frame is painted each time the monitor updates, `RenderArea` will iterate through all of its render tasks and draw each task, in order.

\a{RenderTask} needs to be instantiated, then registered to a `RenderArea` using `RenderArea::add_render_task`:

Putting it all together:

```cpp
auto render_area = RenderArea();
auto point = Shape::Point({0, 0});

// create task and register it
render_area.add_render_task(RenderTask(task));
```

\image html render_area_point_hello_world.png

\how_to_generate_this_image_begin
```cpp
auto render_area = RenderArea();
auto point = Shape::Point({0, 0});
render_area.add_render_task(RenderTask(point));

auto aspect_frame = AspectFrame(1);
aspect_frame.set_child(render_area);
aspect_frame.set_size_request({150, 150});

auto base = Separator();
auto overlay = Overlay();
overlay.set_child(base);
overlay.add_overlay(aspect_frame, true);

window.set_child(overlay);
```
\how_to_generate_this_image_end

Where we created a `RenderTask` using only `point`, then immediately registered it with our `RenderArea`.

This process will be identical for any kind of shape, as, regardless of the number or location of vertices, all natively renderable shapes are instance of `Shape`.

### Shape Types

Mousetrap offers a wide variety of pre-defined 2D shapes, all constructed using the correspondingly named function of `Shape`.

#### Point

A `Point` is always exactly one pixel in size. Its constructor takes a single \a{Vector2f}:

```cpp
auto point = Shape::Point({0, 0});
```

\image html render_area_shape_point.png

#### Points

`Points` is number of points. Instead of taking a single `Vector2f`, its constructor takes `std::vector<Vector2f>`:

```cpp
auto points = Shape::Points({
    {-0.5,  0.5}, 
    {+0.5,  0.5}, 
    { 0.0, -0.5}
});
```

\image html render_area_shape_points.png

Using this, we can express a cloud of points using only a single `Shape` instance.

#### Line

A `Line` draws a straight line between two vertices. The line is always exactly 1 pixel thick

```cpp
auto line = Shape::Line({-0.5, 0.5}, {0.5, -0.5});
```

\image html render_area_shape_line.png

If we want a line of arbitrary thickness, we should use a `Rectangle` from later on in this section.

#### Lines

`Lines` is a series of *unconnected* lines. Its constructor takes a `std::vector<std::pair<Vector2f, Vector2f>>`, or a vector of vertex-cordinate pairs. Each pair represents one line:

```cpp
auto lines = Shape::Lines({
    {{-0.5, 0.5}, {0.5, -0.5}}, // first line
    {{0.5, 0.5}, {-0.5, -0.5}}  // second line
});
```

\image html render_area_shape_lines.png

#### LineStrip

`LineStrip` should not be confused with `Lines`. `LineStrip` is a *connected* series of lines. It takes `std::vector<Vector2f>`. A line will be drawn between each successive pair of coordinates, meaning the last vertex of the previous line will be used as the first vertex of the current line.

In general, if the supplied vector of points is `{a1, a2, a3, ..., an}` then `LineStrip` will render as a series of lines with coordinate pairs `{a1, a2}, {a2, a3}, ..., {a(n-1), a(n)}`

```cpp
auto line_strip = Shape::LineStrip({
    {-0.5, +0.5},  // a1
    {+0.5, +0.5},  // a2
    {+0.5, -0.5},  // a3
    {-0.5, -0.5}   // a4
});
```

\image html render_area_shape_line_strip.png

#### Wireframe

`Wireframe` is similar to a `LineStrip`, except that it also connects the last and first vertex. So for a supplied vector `{a1, a2, a3, ..., an}`, the series of lines will be `{a1, a2}, {a2, a3}, ..., {a(n-1), a(n)}, {a(n), a1}`, the last vertex-coordinate pair is what distinguishes it from a `LineStrip`. As such, `Wireframe` is sometimes also called a **line loop**.

```cpp
auto wireframe = Shape::Wireframe({
    {-0.5, +0.5}, 
    {+0.5, +0.5}, 
    {+0.5, -0.5}, 
    {-0.5, -0.5}
});
```

\image html render_area_shape_wireframe.png

#### Triangle

A `Triangle` is constructed using three `Vector2f`, one for each of its vertices:

```cpp
auto triangle = Shape::Triangle({-0.5, 0.5}, {+0.5, 0.5}, {0, -0.5});
```

\image html render_area_shape_triangle.png

#### Rectangle

A `Rectangle` is perhaps the most common shape. It has four vertices, but it's constructor takes two `Vector2f`, the top-left vertex, and the rectangles width and height

```cpp
auto rectangle = Shape::Rectangle(
    {-0.5, 0.5}, // top-left
    {1, 1}       // {width, height}
);
```
\image html render_area_shape_rectangle.png

This way, all `Rectangle` are axis-aligned. If we wanted a non-axi aligned rectangle, we should use a 4-vertex polygon, or rotate a shape returned by `Shape::Rectangle`, by calling `Shape::rotate`.

#### Circle

A `Circle` is constructed from a center point and radius. We also need to specify the number of outer vertices used for the circle. This number will determine how "smooth" the outline is. For example, a circle with 3 outer vertices is a equilaterla triangle, a circle with 4 outer vertices is a square, a circle with 5 is a pentagon, etc. 

As the number of outer vertices increase, the shape approaches a mathematical circle, but will also require more processing power.

```cpp
auto circle = Shape::Circle(
    {0, 0},     // center
    0.5,        // radius
    32          // n outer vertices
);
```

\image html render_area_shape_circle.png

#### Ellipse

A `Ellipse` is a more generalized from of a `Circle`. It's x- and y-radius determine the shape of the ellipse:

```cpp
auto ellipse = Shape::Ellipse(
    {0, 0},     // center
    0.6,        // x-radius
    0.5,        // y-radius
    32          // n outer vertices
);
```

\image html render_area_shape_ellipse.png

#### Polygon

The most general form of convex shapes, `Polygon` is constructed using a vector of vertices, which will be sorted clockwise, then their [outer hull](https://en.wikipedia.org/wiki/Convex_hull) will be calculated, which results in the final convex polygon:

```cpp
auto polygon = Shape::Polygon({
    {0, 0.75}, 
    {0.75, 0.25}, 
    {0.5, -0.75}, 
    {-0.5, -0.5},
    {-0.75, 0}
});
```

\image html render_area_shape_polygon.png

#### Rectangular Frame

A `RectangularFrame` takes the top-left vertex, the outer size, and the x- and y-width, which will be the thickness of the frame horizontally and vertically:

```cpp
auto rectangular_frame = Shape::RectangularFrame(
    {-0.5, 0.5},  // top left
    {1, 1},       // outer {width, height}
    0.15,         // horizontal thickness
    0.15          // vertical thickness
);
```
\image html render_area_shape_rectangular_frame.png

#### Circular Ring

The round form of a rectangular frame, we have `CircularRing`, which takes a center, the radius of the outer perimeter, as well as the thickness. Like `Circle` and `Ellipse`, we have to specify the number of outer vertices, which decides the smoothness of the ring:

```cpp
auto circular_ring = Shape::CircularRing(
    {0, 0},     // center
    0.5,        // outer radius
    0.15,       // thickness
    32          // n outer vertices
);
```
\image html render_area_shape_circular_ring.png

#### Elliptical Ring

A generalization of `CircularRing`, `EllipticalRing` has an ellipse as its outer shape. Its thickness along the horizontal and vertical dimension are supplied separately, making it far more flexible than `CircularRing`.

```cpp
auto elliptical_ring = Shape::EllipticalRing(
    {0, 0},     // center
    0.6,        // x-radius
    0.5,        // y-radius
    0.15,       // x-thickness
    0.15,       // y-thickness
    32          // n outer vertices
);
```
\image html render_area_shape_elliptical_ring.png

#### Outline

Lastly, we have a very special shape, \link mousetrap::Shape::Outline `Outline`\endlink. `Outline` takes as the only argument to its constructor **another shape**. It will then generate a number of lines that trace the conceptual perimeter of the shape. 

As the name suggest, this is useful for generating outlines of another shape. By rendering the `Outline` on top of the original shape, we can achieve a similar effect to how `Frame` is used for widgets.

\image html render_area_shape_triangle_outline.png "Shape::Outline(triangle)"
\image html render_area_shape_rectangle_outline.png "Shape::Outline(rectangle)"
\image html render_area_shape_circle_outline.png "Shape::Outline(circle)"
\image html render_area_shape_ellipse_outline.png "Shape::Outline(ellipse)"
\image html render_area_shape_polygon_outline.png "Shape::Outline(polygon)"
\image html render_area_shape_rectangular_frame_outline.png "Shape::Outline(rectangular_frame)"
\image html render_area_shape_circular_ring_outline.png "Shape::Outline(circular_ring)"
\image html render_area_shape_elliptical_ring_outline.png "Shape::Outline(elliptical_ring)"

Rendering these white outline on top of a white shape would make them invisible, of course. To achieve the desired effect, we need to make the outline another color, which brings us to the additional properties of all `Shape`s.

### Shape Properties

Shapes are made up of vertices whose properties we have discussed before. In addition to this, the \a{Shape} as a whole has some properties of its own:

#### Centroid

The **centroid** of a shape is the intuitive "center of mass". In mathematical terms, it is the component-wise mean of all vertex coordinates. In practice, for many rotationally symmetrical shapes such as rectangles, triangle, circle, and ellipses, the centroid will be the "center" of the shape, as it is defined in common language. 

We can access the centroid using `Shape::get_centroid`. To move a shape a certain distance, we move its centroid by that distance by calling `Shape::set_centroid`, which will automatically move all other vertices of the shape by the same amount.

#### Rotation

We can rotate all of a `Shape`s vertices around a point in gl space by calling `Shape::rotate`, which takes an `Angle` as its first argument:

```cpp
auto shape = // ...

// rotate shape around its centroid
shape.rotate(degrees(90), shape.get_centroid());
```

#### Color

To change the color of a shape, we use `Shape::set_color`. This simply calls `Shape::set_vertex_color` on all of a shapes vertices. By default, a shapes color will be `RBGA(1, 1, 1, 1)`, white.

#### Visibility

We can prevent a shape from being rendered by calling `Shape::set_is_visible(false)`. This is different from making all vertices of a shape have an opacity of `0`. `is_visible` directly hooks into the shapes render function and prevents it from being called, as opposed to it completing rendering and not being visible on screen.

#### Bounding Box

We can access the [axis aligned bounding box](https://en.wikipedia.org/wiki/Bounding_volume) of a shape with `Shape::get_bounding_box`, which returns a \a{Rectangle}. Using this, we can query the top-left coordinate and size of the bounding box.

---

## RenderArea Size

Because shapes do not take into account the size and aspect ratio of their `RenderArea`, we, as developers, should take care that shapes are displayed correctly when this size changes.  The `resize` signal of `RenderArea` is emitted when the `RenderArea` widgets allocated size on screen changes. At first, this may not seem very useful, we can query the size using `Widget::get_allocation` anyway. In actuality, it will usually be necessary to connect to this signal in almost any case where we want to draw a shape to a `RenderArea` of variable size. 

Consider the following example:

```cpp
auto render_area = RenderArea();
auto circle = Shape::Circle({0, 0}, 0.5);
render_area.add_render_task(circle);

render_area.set_size_request({300, 300});
window.set_child(render_area);
```

\image html render_area_circle_unstretched.png

Everything appears as expected. If we now manually resize the window to a non-square resolution:

\image html render_area_circle_stretched.png

The circle appears as an ellipse, despite being a `Shape::Circle`. This is due to the fact the the vertices of this circle use the gl coordinate system, which is **relative**. Relative coordinate systems do not respect the size and aspect ratio of the viewport, the distance between the left edge of the widget and the right edge of the widget will always be `1`, thus, stretching the viewport stretches horizontally stretches all shapes.

The easiest way to prevent this is by putting the `RenderArea` into an `AspectFrame`, which will force the viewport to always have the correct aspect ratio, `1` in this example using a `Circle`. If we want the `RenderArea` to be freely resizable, however, we will need to do some simple geometry:

```cpp
auto render_area = RenderArea();

// create shape
// recall that an ellipse for whom equal x- and y-radius is identical to a circle
static auto circle = Shape::Ellipse({0, 0}, 0.5, 0.5, 32); 
render_area.add_render_task(circle);

// react to render area changing size
render_area.connect_signal_resize([](RenderArea& area, int32_t width, int32_t height)
{
    // calculate y-to-x-ratio
    float new_ratio = float(height) / width;

    // multiply x-radius to normalize it. Then reformat the `circle` shape
    circle.as_ellipse({0, 0}, 0.5 * new_ratio,  0.5, 32);
    
    // force an update
    area.queue_render()
});

render_area.set_size_request({200, 200});
window.set_child(render_area);
```

Where `RenderArea::queue_render` makes sure the area will be updated one frame after `resize` was emitted.

We connected to signal `resize`, which provides us with the current width and height of the `RenderArea`, in pixels. By changing `Shape::Circle` to `Shape::Ellipse`, we can modify the "circles" x-radius by multiplying it with the current aspect ratio of the viewport. This normalizes the shapes radii, such that it always appears as a circle, regardless of `RenderArea`s allocated size:

\image html render_area_circle_normalized.png

While this isn't that much effort, if we need our `RenderArea` to always have a specific size or aspect ratio, an `AspectFrame` may be an easier solution than manually doing geometry.

---

## Textures

We've learned before that we can us `ImageDisplay` to render an image on screen. This works for most purposes, though it has a number of disadvantages:

+ image data is not updated every frame that it is rendered
+ uploading data is costly
+ scaling the image will always trigger linear interpolation
+ the image is always shown in full, as a rectangle

If we need the additional flexiblity at the cost of ease-of-use, we should use \a{Texture}, which represents an image living in the graphics card memory.

We create a texture from an \a{Image} like so:

```cpp
auto image = Image();
image.load_from_file(// ...

auto texture = Texture();
texture.create_from_image(image);
```

Once `create_from_image` is called, the image data is uploaded to the graphics cards' RAM, so we can safely discard the `Image` instance, unless we want to update the texture later on.

To display this texture, we need to bind it to a shape, then render that shape:

```cpp
auto texture_shape = Shape::Rectangle({-1, 1}, {2, 2});
texture_shape.set_texture(texture);
```

Where this shape is a rectangle that is the size of the entire viewport. 

\todo figure 
\todo texture coordinate mapping

#### Scale Mode

Similar to `Image::as_scaled`, we have options with how we want the texture to behave when scaled to a size other than its native resolution (the resolution of the image we created the texture from). Mousetrap offers the following texture scale modes, which are represented by the enum \a{TextureScaleMode}:

+ `NEAREST`: nearest-neighbor scaling
+ `LINEAR`: linear scaling

Which are roughly equivalent to `Image`s `InterpolationType::NEAREST` and `InterpolationType::BILINEAR`, except much, much more performant. Rescaling a texture is essentially free when done by the graphics card, which is in stark contrast to the capabilities of a CPU.

#### Wrap Mode

Wrap mode governs how the texture behaves when a vertices texture coordinates are outside of `[0, 1]`. Mousetrap offers the following wrap modes, which are all part of the enum \a{TextureWrapMode}:

+ `ZERO`: Pixels will appear as `RGBA(0, 0, 0, 0)`
+ `ONE`: Pixels will appear as `RGBA(1, 1, 1, 1)`
+ `REPEAT`: \todo figure
+ `MIRROR`: \todo figure
+ `STRETCH`: \todo figure

With this, by being able to modify the vertex coordinates for every shapes vertices, we have much more control over how image data is displayed on screen. Only the part of the texture that conceptually overlaps a shape will be displayed.

Modifying textures is also viable for real-time applications, simply keep an `Image` in RAM that is modified by the application, then `create_from_image` every frame the image changes to update the `Texture` rendered on screen.

---

## Anti Aliasing

When graphics are drawn to the screen, they are rasterized, is when the graphics card takes the mathematical shape in memory and translates it such that it can be displayed using pixels. This process is imprefect, no number of pixels will be able to draw a perfect circle. One artifact that can appear during this process is **aliasing**, which is when lines appear "jagged":

![](https://learnopengl.com/img/advanced/anti_aliasing_zoomed.png)

(Source: [learnopengl.com](https://learnopengl.com/Advanced-OpenGL/Anti-Aliasing))

## Intermission

For most users, what we have learned so far will be enough to create new widgets from scratch. Using render tasks and textures, we have full control over rendering any shape or image. Using signal `resize` or `AspectFrame`, we can create complex images at any resolution. To animate these images, we can react to user-behavior by adding one or more of the [event controllers from the previous chapter](05_events.md) to `RenderArea`, then modifying a shapes property from within any of the signals provided by these controllers. 

The rest of this chapter is intended users familiar with OpenGL. We will learn how to integrate native OpenGL into mousetrap, write our own shaders, and how to perform advanced rendering techniques, such as rendering to a texture and applying multi-sample anti-aliasing. This requires external knowledge not supplied by this manual, which is why we recommend users unfamiliar with these topics to simply [skip to the last chapter](10_closing_statements.md), as the tools already provided are powerful enough to create an application for most tasks.

---

---

## Render Task

So far, we registered render tasks using `render_area.add_render_task(RenderTask(shape))`. This is shortform for the following:

```cpp
auto render_task = RenderTask(
    shape,        // const Shape&
    shader,       // const Shader*
    transform,    // const GLTransform*
    blend_mode    // mousetrap::BlendMode
)
render_area.add_render_task(render_task);
```

Using these four components, `RenderTask` gathers all objects necessary to render a shape to the screen. All of these except for `Shape` are optional. If not specified, a default value will be used finstead. This is what allows less experienced users to fully ignore shaders, transforms and blendmodes.

In this section, we'll go through each render task component, learning how we can hook our own OpenGL behavior into mousetraps rendering architecture.

---

## Shaders

Mousetrap offers two types of shaders, **fragment** and **vertex** shaders. These shaders are written in [GLSL](https://learnopengl.com/Advanced-OpenGL/Advanced-GLSL), which will not be taught in this manual. 

### Compiling Shaders

To create a shader, we first instantiate \a{Shader}, which is a class representing a **shader program** (a compiled vertex- and fragment shader, bound to a shader program on the graphics card). 

After instantiating `Shader`, we compile one or both of the vertex- and fragment-shaders with our own custom code like so:

```cpp
// create default shader
auto shader = Shader();

// replace default fragment shader with custom fragment shader
shader.create_from_string(ShaderType::FRAGMENT, R"(
    #version 330
    
    in vec4 _vertex_color;
    in vec2 _texture_coordinates;
    in vec3 _vertex_position;
    
    out vec4 _fragment_color;
    
    void main()
    {
        vec2 pos = _vertex_position.xy;
        _fragment_color = vec4(pos.y, dot(pos.x, pos.y), pos.x, 1);
    }
)");
```

We can then supply a pointer to the shader as the 2nd argument to `RenderArea::add_render_task`, which automatically binds it for rendering:

```cpp
// create rectangle shape that occupise 100% of the viewport
auto shape = Shape::Rectangle({-1, -1}, {2, 2});

// create fragment shader
auto shader = Shader();
shader.create_from_string(ShaderType::FRAGMENT, R"(
    (...)
)");

// bind shape and shader for rendering
render_area.add_render_task(RenderTask(
    shape, 
    &shader
);
```

\image html shader_hello_world.png

\how_to_generate_this_image_begin
```cpp
auto render_area = RenderArea();
static auto shape = Shape::Rectangle({-1, -1}, {2, 2});
static auto shader = Shader();
shader.create_from_string(ShaderType::FRAGMENT, R"(
    #version 130

    in vec4 _vertex_color;
    in vec2 _texture_coordinates;
    in vec3 _vertex_position;

    out vec4 _fragment_color;

    void main()
    {
        vec2 pos = _vertex_position.xy;
        _fragment_color = vec4(pos.y, dot(pos.x, pos.y), pos.x, 1);
    }
)");

render_area.add_render_task(RenderTask(shape, &shader));

auto aspect_frame = AspectFrame(1);
aspect_frame.set_child(render_area);
window.set_child(aspect_frame);
```
\how_to_generate_this_image_end

We see that the first argument to `Shader::create_from_string` is the **shader type**, which is either `ShaderType::FRAGMENT` or `ShaderType::VERTEX`. If we do not call `create_from_string` for either or both of these, the **default shader program will be used**. 

It may be instructive to see what te default shaders behavior actually is, in detail:

### Default Vertex Shader

This is the default vertex shader used whenever we do not supply a custom vertex shader for `Shader`:

```glsl
#version 330

layout (location = 0) in vec3 _vertex_position_in;
layout (location = 1) in vec4 _vertex_color_in;
layout (location = 2) in vec2 _vertex_texture_coordinates_in;

uniform mat4 _transform;

out vec4 _vertex_color;
out vec2 _texture_coordinates;
out vec3 _vertex_position;

void main()
{
    gl_Position = _transform * vec4(_vertex_position_in, 1.0);
    _vertex_color = _vertex_color_in;
    _vertex_position = _vertex_position_in;
    _texture_coordinates = _vertex_texture_coordinates_in;
}
```

We see that it requires OpenGL 3.3, which is the reason that mousetrap also requires that version as a dependency. This shader simply forwards the corresponding shapes attributes to the fragment shader.

The current vertices position is supplied via `_vertex_position_in`, the vertices texture coordinates as `_vertex_color_in` and the vertices texture coordinates are `_vertex_texture_coordinates`.

The output variables are `_vertex_color`, `_texture_coordinates` and `_vertex_position`, which should be assigned with the interpolated result of the vertex shader. The shader has furthermore access to the uniform `_transform`, which holds the `GLTransform` the current `RenderTask` associates with the current `Shape`.

### Default Fragment Shader

```glsl
#version 330

in vec4 _vertex_color;
in vec2 _texture_coordinates;
in vec3 _vertex_position;

out vec4 _fragment_color;

uniform int _texture_set;
uniform sampler2D _texture;

void main()
{
    if (_texture_set != 1)
        _fragment_color = _vertex_color;
    else
        _fragment_color = texture2D(_texture, _texture_coordinates) * _vertex_color;
}
```

The fragment shader is handed `_vertex_color`, `_texture_coordinate` and `_vertex_position`, which we recognize as the output of the vertex shader. The output of the fragment shader is `_fragment_color`.

The default fragment shader respects two uniforms, `_texture`, which is the texture of the shape we are currently rendering and `_texture_set`, which is `1` if `Shape::set_texture` was called before, `0` otherwise.

Users aiming to experiment with shaders should take care to not modify the name or `location` of any of the `in` or `out` variables of either shader. These names along with the required shader version should not be altered.

### Binding Uniforms

Both the vertex and fragment shader make use of uniforms. We've seen that `_transform`, `_texture` and `_texture_set` are assigned automatically. 

Mousetrap offers a convenient way to add additional uniforms:

To bind a uniform, we first need a CPU-side value that should be uploaded to the graphics card. Let's say we want our fragment shader to color the shape a certain color, which is specified by a CPU-side program. This fragment shader would look something like this:

```glsl
#version 330

in vec4 _vertex_color;
in vec2 _texture_coordinates;
in vec3 _vertex_position;

out vec4 _fragment_color;

uniform vec4 _color_rgba; // new uniform

void main()
{
    _fragment_color = _color_rgba;
}
```

To set the value of `_color_rgba`, we use `RenderTask::set_uniform_rgba`. This is one of the many `set_uniform_*` functions, which allow us to bind C++ values to OpenGL Shader Uniforms:

The following types can be assigned this way:

| C++ Type      | `RenderTask` function   | GLSL Uniform Type |
|---------------|-------------------------|-------------------|
| `float`       | `set_uniform_float`     | `float`           |
| `int32_t`     | `set_uniform_int`       | `int`             |
 | `uint32_t`    | `set_uniform_uint`      | `uint`            |
 | `Vector2f`    | `set_uniform_vec2`      | `vec2`            |
| `Vector3f`    | `set_uniform_vec3`      | `vec3`            |
| `Vector4f`    | `set_uniform_vec4`      | `vec4`            |
| `GLTransform` | `set_uniform_transform` | `mat4x4`          |
| `RGBA`        | `set_uniform_rgba`      | `vec4`            |
| `HSVA`        | `set_uniform_hsva`      | `vec4`            |

\todo Add `set_uniform_texture` so users do not have to use texture locations

With this, we can set our custom `_color_rgba` uniform value like this:

```cpp
// create shader
auto shader = Shader();
shader.create_from_string(ShaderType::FRAGMENT, R"(
    #version 330

    in vec4 _vertex_color;
    in vec2 _texture_coordinates;
    in vec3 _vertex_position;

    out vec4 _fragment_color;

    uniform vec4 _color_rgba;

    void main()
    {
        _fragment_color = _color_rgba;
    }
)");

// create shape
auto shape = Shape::Rectangle({-1, -1}, {2, 2});

// create task
auto task = RenderTask(shape, &shader);

// register uniform with task, this deep-copies the color
task.set_uniform_rgba("_color_rgba", RGBA(1, 0, 1, 1));

// register task with render area
render_area.add_render_task(task);
```

\image html shader_rbga_uniform.png

\how_to_generate_this_image_begin
```cpp
auto render_area = RenderArea();

static auto shader = Shader();
shader.create_from_string(ShaderType::FRAGMENT, R"(
    #version 330

    in vec4 _vertex_color;
    in vec2 _texture_coordinates;
    in vec3 _vertex_position;

    out vec4 _fragment_color;

    uniform vec4 _color_rgba;

    void main()
    {
        _fragment_color = _color_rgba;
    }
)");

static auto shape = Shape::Rectangle({-1, -1}, {2, 2});
static auto task = RenderTask(shape, &shader);
task.set_uniform_rgba("_color_rgba", RGBA(1, 0, 1, 1));
render_area.add_render_task(task);

auto aspect_frame = AspectFrame(1);
aspect_frame.set_child(render_area);
window.set_child(aspect_frame);
```
\how_to_generate_this_image_end

In summary, while we do not have control over the `in` and `out` variables of either shader type, we have full control over uniforms, giving us all the flexibility we need to accomplish complex shader-aided tasks.

---

## Transforms

As mentioned before, \a{GLTransform} is the C++-side object that represents spatial transforms. It is called **GL**Transform, because it **uses the GL coordinate system**. Applying a `GLTransform` to a vector in widget- or texture-space will produce incorrect results. They should only be applied to the `vertex_position` attribute of a `Shape`s vertices.

Internally, a `GLTransform` is a 4x4 matrix of 32-bit floats. At any time, we can directly access this matrix as the public member `GLTransform::transform`. 

When constructed, the matrix will be the identity transform:
```
1 0 0 0
0 1 0 0
0 0 1 0
0 0 0 1
```
No matter the current state of the transform, we can reset it back to the identity matrix by calling `GLTransform::reset`.

`GLTransform` has basic spatial transform already programmed in, so we usually do not need to modify the internal matrix ourself. It provides the following transforms:

+ `GLTransform::translate` for translation in 3d space
+ `GLTransform::scale` for scaling
+ `GLTransform::rotate` for rotation around a point

We can combine two transforms using `GLTransform::combine`. If we wish to apply the transfrom CPU-side to a `Vector2f` or `Vector3f`, we can use `GLTransform::apply_to`. We can check the \link mousetrap::GLTransform corresponding documentation page\endlink for more information about the signature of these funcions.

While we could apply the transform to each vertex of a `Shape` manually, then render the shape, it is much more performant to do this kind of math GPU-side. By register the transform with a `RenderTask`, the transform will be forwarded to the vertex shaders `_transform` uniform, which is then applied to the shapes vertices automatically:

```cpp
auto shape = // ...
auto transform = GLTransform();
transform.translate({-0.5, 0.1});
transform.rotate(degrees(180), {0,0);

auto task = RenderTask(
   shape,     // shape
   nullptr,   // set null to use the default shader
   transform  // use our transform instead of identity
);
```

This, of course, only works if the vertex shader is implemented to apply this uniform, which the [default vertex shader](#default-vertex-shader) does.

---

## Blend Mode

As the last component of a render task, we have **blend mode**. This governs how two colors behave when rendered on top of each other. We call the color currently in the frame buffer `destination`, while the newly added color is called `origin`. 
Mousetrap offers the following blend modes, which are part of the enum \a{BlendMode}:

| `BlendMode`        | Resulting Color                     |
|--------------------|-------------------------------------|
| `NONE`             | `origin.rgb + 0 * destination.rgb`  | 
| `NORMAL`           | traditional alpha-blending          |
 | `ADD`              | `origin.rgba + destination.rgba`    |
| `SUBTRACT`         | `origin.rgba - destination.rgba`    |
| `REVERSE_SUBTRACT` | `destination.rgba - origin.rgba`    | 
| `MULTIPLY`         | `origin.rgba * destination.rgba`    |
| `MIN`              | `min(origin.rgba, destination.rgba)` |
 | `MAX`              | `max(origin.rgba, destination.rgba)` | 

These are the familiar blend modes from graphics editors such as GIMP or Photoshop.

If left unspecified, `RenderTask` will use `BlendMode::NORMAL`, which represents traditional alpha blending. Using this blend mode, the opacity of `destination` and `origin` is treated as their emission, and then the weighted mean is calculated, producing the final result we expect. This mimics how mixing colored light behaves in the real world.

---

## The Render Signal

While available, for most purposes we do not need to connect to signal `render` of `RenderArea`. This signal is emitted once per frame, right before the internal framebuffer is "flushed", meaning the state of viewports framebuffer is send to the monitor to be displayed for the user. The default handler for signal `render` handles clearing the framebuffer, blending, and rendering all the registered `RenderTask`s. Once we connect a new signal handler, we will have to do all of this ourself.

To reproduce the behavior of the default signal handler, we would implement the handler for signal `render` like this:

```cpp
static auto render_area = RenderArea();
render_area.connect_signal_render([](RenderArea& area, GdkGLContext*)
{
    // clear framebuffer
    glClearColor(0, 0, 0, 0);
    glClear(GL_COLOR_BUFFER_BIT);

    // set blend mode to default
    glEnable(GL_BLEND);
    set_current_blend_mode(BlendMode::NORMAL);

    // render all tasks
    area.render_render_tasks();

    // flush to screen
    glFlush();

    // signal that the framebuffer was updated
    return true;
});
```

Where `RenderArea::render_render_tasks` was used to call \link mousetrap::RenderTask::render `RenderTask::render`\endlink for all registered render tasks. We can invoke rendering of any `RenderTask`, regardless of whether it was associated with the current `RenderArea` or not, by calling `RenderTask::render`.

The `render` signal handler uses native OpenGL functions, which we have so far avoided completely. Functions like these should only be called within the handler for `render`, as this is the only time we can be sure that a valid OpenGL context is bound and ready to be used.

## Rendering to a Texture

With our newfound ability to manually implement how rendering takes place, we can perform one of the more complex tasks: rendering to a texture. This is achieved by \a{RenderTexture}, which is an object than can both be used as a texture, and can be bound as the current render target, meaning anything that would trigger shapes being displayed on screen will instead write into the textures memory, with each pixel of the textures memory being treates as if it was a pixel of the screen.

Mousetrap offers two classes that can be used as render texture, `RenderTexture` and `MultisampledRenderTexture`. Both work in the exact same way, though the latter will perform [multisampling anti aliasing (MSAA)](https://learnopengl.com/Advanced-OpenGL/Anti-Aliasing) (MSAA), which causes jagged edges to look smoother. In return, `MultiSampledRenderTexture` takes about 2.5 times the memory of `RenderTexture`, and should thus be used sparingly. 

### Creating a Render Texture

We first need to instantiate and allocate our render texture:

```cpp
auto render_texture = RenderTexture();
render_texture.create(400, 300);

// or, if we want MSAA:

auto render_texture = MultisampledRenderTexture();
render_texture.create(400, 300);
```

This creates a render texture with a resolution of 400x300 pixels. To render to this texture, we will need to modify the signal handler for the `render` signal. To bind the current render texture as the render target, we use `RenderTexture::bind_as_render_target`. After this call, any  rendering will be pasted into the render textures buffer, as opposed to the buffer owned by the `RenderArea`, which will be shown on screen. 

Afterwards, `RenderTexture::unbind_as_render_target` switches the active buffer back to what it was before `bind_as_render_target` was called. After this call, any rendering will instead be pasted onto the `RenderArea`s framebuffer again.

Rendering to a texture will look like this:

```cpp
// create render texture
static auto render_texture = RenderTexture();
render_texture.create(400, 300);

// create shape that will be used to display the contents of render texture
static auto render_texture_shape = Shape::Rectangle({-1, -1}, {2, 2});
render_texture_shape.set_texture(&render_texture);

// create task that will render this shape
static auto render_texture_shape_task = RenderTask(render_texture_shape);

// connect to signal render
static auto render_area = RenderArea();
render_area.connect_signal_render([](RenderArea& area, GdkGLContext*)
{
    // render to render texture
    {
        // bind texture for rendering
        render_texture.bind_as_render_target();
        
        // clear textures buffer with RGBA(0, 0, 0, 0); 
        glClearColor(0, 0, 0, 0);
        glClear(GL_COLOR_BUFFER_BIT);
        
        /* rendering to texture happens here */
 
        // flush to texture
        glFlush();
        
        // unbind textue from rendering
        render_texture.unbind_as_render_target();
    }
    
    // now, render to screen, not to a texture
    {
        // clear screens framebuffer
        glClearColor(0, 0, 0, 0);
        glClear(GL_COLOR_BUFFER_BIT);
    
        // set blend mode to default
        glEnable(GL_BLEND);
        set_current_blend_mode(BlendMode::NORMAL);
    
        // display render textures contents
        render_texture_shape_task.render();
    
        // flush to screen
        glFlush();
    }

    // signal that the RenderAreas framebuffer was updated
    return true;
});
```

Where the two `{}` blocks were added for stylistic emphasis.

The concepts discussed in the latter part of this chapter require knowledge about OpenGL and rendering in general. The `RenderTask`-based architecture may seem unusual to someone more used to the regular render-loop-based structure of libraries like [SFML](https://www.sfml-dev.org/tutorials/2.5/graphics-draw.php) or [SDL](http://www.libsdl.org/), but the render task architecture was deemed superior when used along with the signal-based architecture of widgets. Much like we register signal handlers to later be triggered by signals, we register render tasks to later be rendered when needed.

```





