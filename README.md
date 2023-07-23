 ## **NOTE**: This repo is under active development and should not be interacted with by the public. I will make an announcement in all the relevant channels when it is ready to be used by third parties

# Mousetrap

![](docs/src/assets/banner.png)

Mousetrap is a GUI library for Julia. It, and its [stand-alone C++-component of the same name](https://github.com/clemapfel/mousetrap), fully wrap [GTK4](https://docs.gtk.org/gtk4/) (which is written in C), *vastly* simplifying its interface to improve ease-of-use without sacrificing flexibility.

It aims to give developers of all skill levels the tools to start creating complex GUI applications with little effort or study.

> **Note**: Mousetrap is under active development. While backwards-compatibility for all future releases can already be guaranteed, stability and portability may be affected. Consider participating in the development by [opening an issue](https://github.com/clemapfel/mousetrap.jl) when you encounter an error or bug (which - as of now - will most likely happen), or by [proposing / implementing a feature](https://github.com/users/Clemapfel/projects/2).

---

## Features
+ Create complex GUI application for Linux, Windows, and MacOS*
+ Choose from over 40 different kinds of pre-made widgets, or create your own
+ Supports mice, keyboards, touchscreens, touchpads, and stylus devices
+ Image processing facilities, well-suited for image manipulation programs
+ Fully abstracted OpenGL interface, allows for high-performance, hardware-accelerated rendering of custom shapes / shaders
+ [Hand-written manual and extensive documentation](todo): every exported symbol is documented

---

## Supported Platforms

`✓ ` Available<br>
`✕ ` Will never be available<br>
`✕*` Will be available with future updates<br>

| Platform         | Basic GUI Component | Native Rendering Component |
|------------------|---------------------|-----------------------------|
| Linux (64-bit)   | `✓`                | `✓`                        |
| Linux (32-bit)   | `✓`                | `✓`                        |
| Windows (64-bit) | `✓`                | `✓`                        |
| Windows (32-bit) | `✓`                | `✕`                        |
| FreeBSD          | `✓`                | `✕*`                       | 
| MacOS            | `✕*`               | `✕`                        |

---

## Planned Features

(in order of priority, highest first)

+ Simplify installation process to `] add mousetrap`
+ Add support for global and per-widget custom themes by exposing the CSS interface
+ Implement installation of .desktop files on end-user computers
+ Add a toggle to `RenderTexture` that allows rendering to a MSAA buffer
+ Allow bundling of mousetrap apps, their resources, and all their dependencies into a portable C-executable
+ Implement drag & drop for files, images, and widgets
+ Allow retrieving a widget from its container, for this to be possible the widgets type has to be stored C-side
+ Allow filtering and searching of selectable widget containers such as `ListView` and `ColumnView`
+ Allow adding custom signals that use the GLib marshalling system
+ Fully polish interactive use from within the REPL
+ Make all functions that modify the global state thread-safe
+ Add an event controller to capture video game controller / joystick events
+ Allow binding textures to fragment shader uniforms at texture unit 1 or higher, currently, only texture unit 0 is supported
+ Add 3D shapes and geometry shaders to the OpenGL component

---

## Showcase

#### Hello World

```julia
using mousetrap
main() do app::Application
    window = Window(app)
    set_child!(window, Label("Hello World!"))
    present!(window)
end
```
![](todo)

---

#### Creating a Selectable List of Widgets

```julia
list = ListView()
push_back!(list, Button())
push_back!(list, Label("Label")) 
push_back!(list, Entry())
```
![](todo)

---

#### Opening a File Explorer Dialog

```julia
file_chooser = FileChooser()
on_accept!(file_chooser) do self::FileChooser, files
    println("selected file $(files[1])")
end
present!(file_chooser)
```
![](todo)

---

#### Reacting to Mouse / Touchscreen Presses

```julia
function on_click(::ClickEventController, x_position, y_position)
    println("Click registered at ($x_position, $y_position)")
end

click_controller = ClickEventController()
connect_signal_clicked!(on_click, click_controller)
add_controller!(window, click_controller)
```

---

#### Rendering a Rectangle with OpenGL

```julia
render_area = RenderArea()
rectangle = Rectangle(Vector2f(-0.5, -0.5), Vector2f(1, 1))
add_render_task!(render_area, RenderTask(rectangle))
```
![](todo)

---

## Documentation

Documentation is available [here](https://clemens-cords.com/mousetrap). This includes a tutorial on how to install mousetrap, a user manual introducing users to mousetrap and GUI programming in general, as well as an index of all classes, enums, and functions.

---

## Installation

Regardless of the operating system, to install mousetrap, in the Julia REPL, press the `]` key to enter `Pkg` mode, then:

```julia
add https://github.com/Clemapfel/mousetrap_windows_jll
add https://github.com/Clemapfel/mousetrap_linux_jll
add https://github.com/Clemapfel/mousetrap.jl
test mousetrap
```

Installation may take a long time. Once it's done, loading mousetrap for future development will only take a few seconds.

--- 

## Credits

The Julia and C++ component of mousetrap were designed and implemented by [C.Cords](https://clemens-cords.com).

Consider donating to support the continued development of this library [here](TODO).

The goal is for mousetrap to be 100% stable and flawless when Julia [static compilation](https://github.com/JuliaLang/PackageCompiler.jl) finishes development. Static compilation and the lack of [fully featured, easy-to-use](https://github.com/JuliaGraphics/Gtk.jl/issues) GUI libraries are currently the largest factors as to why Julia is ill-suited for front-end development. Mousetrap aims to address this.

## Contributors

(there are currently no 3rd party contributors)

---

## License

The current and all past version of mousetrap, including any text or assets of the mousetrap documentation, are licensed under [GNU Lesser General Public License (Version 3.0)](https://www.gnu.org/licenses/lgpl-3.0.en.html). This means it can be used in both free, open-source, as well as commercial, closed-source software.

---

## Citation

If you are using mousetrap for research or work, please cite it as follows:
```
TODO
```             
