# Chapter 9: Native Rendering

In this chapter we will learn:
+ How to use `RenderArea`
+ How to draw any shape
+ How to efficiently show an image as a texture
+ What blend modes mousetrap offers
+ How to apply a 3D transform to a shape
+ How to compile a GLSL Shader and set its uniforms
---

!!! danger "Native Rendering on MacOS"
    All classes and functions in this chapter **are impossible to use on MacOS**. For this platform,
    mousetrap was compiled in a way where any function relating to OpenGL was made unavailable. This 
    is because of Apples decision to deprecate OpenGL in a way where only physical owners of a Mac
    can compile libraries that have it as a dependency. See [here](https://github.com/users/Clemapfel/projects/2?pane=issue&itemId=33978341) for more information.

    If we try to use a disabled object on MacOS, a **fatal error** will be thrown at runtime.

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

In general, shapes are defined by a number of **vertices**. A vertex has a position in 2D space, a color, and a texture coordinate. In this chapter, we will learn how to user each of these, starting with the position.

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

## Creating Shapes



## Anti Aliasing

When graphics are drawn to the screen, they are *rasterized*, which is when the graphics card takes the mathematical shape in memory and translates it such that it can be displayed using pixels. This process is imperfect, no number of pixels will be able to draw a perfect circle. One artifact that can appear during this process is **aliasing**, which is when lines appear "jagged":

![](https://learnopengl.com/img/advanced/anti_aliasing_zoomed.png)

(Source: [learnopengl.com](https://learnopengl.com/Advanced-OpenGL/Anti-Aliasing))

For this, a number of remedies are available, the most appropriate of which is called [multi-sampled anti aliasing (MSAA)](https://www.khronos.org/opengl/wiki/Multisampling). User of mousetrap are not required to understand this process, only that it causes jagged edges to appear smoother. 

To enable MSAA, we provide an enum value of type [`AntiAliasingQuality`](@ref) to `RenderArea`s constructor:

```julia
msaa_on = RenderArea(ANTI_ALIASING_QUALITY_BETTER)
msaa_off = RenderArea(ANTI_ALIASING_QUALITY_OFF)
```

| `AntiAliasingQuality` Value | # MSAA Samples | 
|-----------------------------|------------|
| `ANTI_ALIASING_QUALITY_OFF` | 0 (no MSAA) |
| `ANTI_ALIASING_QUALITY_MINIMAL` | 2 | 
| `ANTI_ALIASING_QUALITY_GOOD` | 4 | 
| `ANTI_ALIASING_QUALITY_BETTER` | 8 | 
| `ANTI_ALIASING_QUALITY_BEST` | 16 | 

The higher the number of samples, the better smoothing will be performed. MSAA comes at a cost, any quality other than `OFF` will induces the `RenderArea` to take about twice as much space in the graphic cards memory. Furthermore, the higher the number of samples, the more time each render step will take.

MSAA should only be enabled when necessary, and we should avoid having many different `RenderArea`s with MSAA enabled.

As images online rarely accurately present what the user can see on their screen, we can use the following `main.jl`, which shows off the effect of MSAA:

![](../assets/msaa_comparison.png)

!!! details "How to generate this Image"
    ```julia
    main() do app::Application

        window = Window(app)
        set_title!(window, "mousetrap.jl")

        # create render areas with different MSAA modes
        left_area = RenderArea(ANTI_ALIASING_QUALITY_OFF)
        right_area = RenderArea(ANTI_ALIASING_QUALITY_BEST)

        # paned that will hold both areas
        paned = Paned(ORIENTATION_HORIZONTAL)

        # create singular shape, which will be shared between areas
        shape = Rectangle(Vector2f(-0.5, 0.5), Vector2f(1, 1))
        add_render_task!(left_area, RenderTask(shape))
        add_render_task!(right_area, RenderTask(shape))

        # rotate shape 1° per frame
        set_tick_callback!(paned) do clock::FrameClock

            # rotate shape 
            rotate!(shape, degrees(1), get_centroid(shape))

            # force redraw for both areas
            queue_render(left_area) 
            queue_render(right_area)

            # continue callback indefinitely
            return TICK_CALLBACK_RESULT_CONTINUE
        end

        # setup window layout for viewing
        for area in [left_area, right_area]
            set_size_request!(area, Vector2f(150, 150))
        end

        # caption labels
        left_label = Label("<tt>OFF</tt>")
        right_label = Label("<tt>BEST</tt>")

        for label in [left_label, right_label]
            set_margin!(label, 10)
        end

        # format paned
        set_start_child_shrinkable!(paned, false)
        set_end_child_shrinkable!(paned, false)
        set_start_child!(paned, vbox(AspectFrame(1.0, left_area), left_label))
        set_end_child!(paned, vbox(AspectFrame(1.0, right_area), right_label))

        # present
        set_child!(window, paned)
        present!(window)
    end
    ```
---

!!! info 
    The rest of this chapter will assume that readers are familiar with the basics of OpenGL, how to write GLSL shaders, what a shader uniform is, how blending works, and how a linear transform allows use to move a point in 3D space.

    With what we have learned so far in this chapter, we are well equipped to be able to accomplish most tasks that require a native rendering component, such as displaying static images or rendering shapes.

## Render Task

So far, we registered render tasks using `render_area.add_render_task(RenderTask(shape))`, but we can also use `RenderTask` on its own. 

A `RenderTask` bundles the following objects:
+ a `Shape`, which is the shape being rendered
+ a `Shader`, which is a shader program containing a vertex- and fragment- shader
+ a `GLTransform`, which is a spatial transform supplied to the vertex shader
+ a `BlendMode`, which governs which type of blending will take place during the blit step

Using these four components, `RenderTask` gathers all objects necessary to render a shape to the screen. All components except for the `Shape` are *optional*. If not specified, a default value will be used instead. This is what allows less experienced users to fully ignore shaders, transforms and blendmodes, by simple calling `RenderTask(shape)`.

In this section, we'll go through each render task component. When creating a `RenderTask`, we should assign the corresponding components to the keyword arguments `shader`, `transform`, and `blend_mode`.

---

## Transforms

[`GLTransform`](@ref) is an object represents spatial transforms. It is called **GL**Transform, because it **uses the GL coordinate system**. Applying a `GLTransform` to a vector in widget- or texture-space will produce incorrect results. They should only be applied to the `vertex_position` attribute of a `Shape`s vertices.

Internally, a `GLTransform` is a 4x4 matrix of 32-bit floats. It is this size because it is intended to be applied to OpenGL positional vectors, which are vectors in 3D space. In mousetrap, the last coordinate is usually assumed to be `0`, though this is not enforced.

At any time, we can directly access this matrix using `getindex` or `setindex!`:

```julia
transform = GLTransform()
for i in 1:4
    for j in 1:4
        print(transform[i, j], " ")
    end
    print("\n")
end
```
```
1 0 0 0
0 1 0 0
0 0 1 0
0 0 0 1
```

We see that after construction, `GLTransform` is initialized as the identity transform. No matter the current state of the transform, we can reset it back to the identity matrix by calling `GLTransform::reset`.

`GLTransform` has many common spatial transform already available, meaning we rarely have to modify its values manually. It provides the following transforms:

+ [`translate!`](@ref) for translation in 3d space
+ [`scale!`](@ref) for scaling
+ [`rotate!`](@ref) for rotation around a point

We can combine two transforms using [`combine_with`](@ref). If we wish to apply the transfrom CPU-side to a `Vector2f` or `Vector3f`, we can use [`apply_to`](@ref). 

While we could apply the transform to each vertex of a `Shape` manually, then render the shape, it is much more performant to do this kind of math GPU-side. By registering the transform with a `RenderTask`, the transform will be forwarded to the vertex shaders, which is then applied to the shapes vertices automatically:

```julia
shape = Shape() 
transform = Transform()
translate!(transform, Vector2f(-0.5, 0.1))
rotate!(transform, degrees(180))

task = RenderTask(shape; transform = transform)
```

Where we used the `transform` keyword argument to specify the transform, while leaving the other render tasks component unspecified.

---

## Blend Mode

As the third component of a render task, we have the **blend mode**. This governs how two colors behave when rendered on top of each other. 

 Let color currently in the frame buffer be `destination`, while the newly added color will be called `origin`. then mousetraps blend modes, which are values of enum [`BlendMode`](@ref), behave as follows:

| `BlendMode`        | Resulting Color                     |
|--------------------|-------------------------------------|
| `BLEND_MODE_NONE`             | `origin.rgb + 0 * destination.rgb`  | 
| `BLEND_MODE_NORMAL`           | [traditional alpha-blending](https://en.wikipedia.org/wiki/Alpha_compositing)          |
| `BLEND_MODE_ADD`              | `origin.rgba + destination.rgba`    |
| `BLEND_MODE_SUBTRACT`         | `origin.rgba - destination.rgba`    |
| `BLEND_MODE_REVERSE_SUBTRACT` | `destination.rgba - origin.rgba`    | 
| `BLEND_MODE_MULTIPLY`         | `origin.rgba * destination.rgba`    |
| `BLEND_MODE_MIN`              | `min(origin.rgba, destination.rgba)` |
| `BLEND_MODE_MAX`              | `max(origin.rgba, destination.rgba)` | 

We may be familiar with these blend modes from graphics editors such as GIMP or Photoshop.

If left unspecified, `RenderTask` will use `BLEND_MODE_NORMAL`.

---

## Shaders

As the last component of a `RenderTask`, we have [`Shader`](@ref), which represents an OpenGL shader program, with already compiled **fragment** and **vertex** shaders. These shaders are written in [GLSL](https://learnopengl.com/Advanced-OpenGL/Advanced-GLSL), which will not be taught in this manual. 

### Compiling Shaders

To create a shader, we first instantiate [`Shader`](@ref}, then use [`create_from_file!`](@ref) or [`create_from_string!`](@ref) to override the current fragment- or vertex-shader. We use `SHADER_TYPE_FRAGMENT` or `SHADER_TYPE_VERTEX` to specify which of these we are targeting.

```julia
shader = Shader()
create_from_string!(shader, SHADER_TYPE_FRAGMENT, """
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
""")

task = RenderTask(shape, shader)
add_render_task!(render_area, task)
```

![](../assets/shader_hello_world.png)

!!! details "How to generate this Image"
    ```julia
    using mousetrap
    main() do app::Application

        window = Window(app)
        set_title!(window, "mousetrap.jl")
        render_area = RenderArea()
        shape = Rectangle(Vector2f(-1, 1), Vector2f(2, 2))

        shader = Shader()
        create_from_string!(shader, SHADER_TYPE_FRAGMENT, """
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
        """)
        
        task = RenderTask(shape; shader = shader)
        add_render_task!(render_area, task)

        frame = AspectFrame(1.0, Frame(render_area))
        set_size_request!(frame, Vector2f(150, 150))
        set_margin!(frame, 10)
        set_child!(window, frame)
        present!(window)
    end
    ```

If we do not initialize the vertex- or fragment-shader, the **default shader program will be used**. It may be instructive to see how the default shaders are defined, as any user-defined shader should build upon them

### Default Vertex Shader

This is the default vertex shader used whenever we do not supply a custom vertex shader for `Shader`:

```glsl
#version 330

layout (location = 0) in vec3 _vertex_position_in;
layout (location = 1) in vec4 _vertex_color_in;
layout (location = 2) in vec2 _vertex_texture_coordinates_in;

uniform mat4 _transform;

out vec4 _vertex_color;
out vec3 _vertex_position;
out vec2 _texture_coordinates;

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

The output variables are `_vertex_color`, `_texture_coordinates` and `_vertex_position`, which should be assigned with results gained from within the vertex shader. The shader has furthermore access to the uniform `_transform`, which holds the `GLTransform` the current `RenderTask` associates with the current `Shape`. 

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

To set the value of `_color_rgba`, we use [`set_uniform_rgba!`](@ref), which is called on the **render task**, not the shader itself. This will make the render task store the value we give it, then automatically set it during rendering.

`set_uniform_rgba!` is of many `set_uniform_*!` functions, which allow us to bind Julia-side values to OpenGL Shader Uniforms:

The following types can be assigned this way:

| Julia Type      | `RenderTask` function   | GLSL Uniform Type |
|---------------|-------------------------|-------------------|
| `Cfloat`       | `set_uniform_float`     | `float`           |
| `Cint`     | `set_uniform_int`       | `int`             |
| `Cuint`    | `set_uniform_uint`      | `uint`            |
| `Vector2f`    | `set_uniform_vec2`      | `vec2`            |
| `Vector3f`    | `set_uniform_vec3`      | `vec3`            |
| `Vector4f`    | `set_uniform_vec4`      | `vec4`            |
| `GLTransform` | `set_uniform_transform` | `mat4x4`          |
| `RGBA`        | `set_uniform_rgba`      | `vec4`            |
| `HSVA`        | `set_uniform_hsva`      | `vec4`            |

Using this knowledge, we set the `_color_rgba` uniform value like so:

```julia
# create shader
shader = Shader()
create_from_string!(shader, SHADER_TYPE_FRAGMENT, """
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
""")

# create shape and task
shape = Shape()
task = RenderTask(shape; shader = shader) # shader bound to `shader` keyword argument

# set uniform
set_uniform_rgba!(task, "_color_rgba", RGBA(1, 0, 1, 1))
```

![](../assets/shader_rgba_uniform.png)

!!! details "How to generate this Image"
    ```julia
    using mousetrap
    main() do app::Application

        window = Window(app)
        set_title!(window, "mousetrap.jl")
        render_area = RenderArea()
        shape = Rectangle(Vector2f(-1, 1), Vector2f(2, 2))

        shader = Shader()
        create_from_string!(shader, SHADER_TYPE_FRAGMENT, """
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
        """)
        
        task = RenderTask(shape; shader = shader)
        set_uniform_rgba!(task, "_color_rgba", RGBA(1, 0, 1, 1))

        add_render_task!(render_area, task)

        frame = AspectFrame(1.0, Frame(render_area))
        set_size_request!(frame, Vector2f(150, 150))
        set_margin!(frame, 10)
        set_child!(window, frame)
        present!(window)
    end
    ```

With this, we have a convenient way to specify shader uniforms, without having to manually update the shader each time it is bound for rendering, `RenderTask` does this for us.

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







