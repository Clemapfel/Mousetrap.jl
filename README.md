 ## **NOTE**: This repo is under active development and should not be interacted with by the public. I will make an announcement in all the relevant channels when it is ready to be used by third parties

# Mousetrap

![](docs/src/assets/banner.png)

Mousetrap is a GUI library for Julia. It, and its [stand-alone C++-component of the same name](https://github.com/clemapfel/mousetrap), fully wrap [GTK4](https://docs.gtk.org/gtk4/) (which is written in C), *vastly* simplifying its interface to improve ease-of-use without sacrificing flexibility.

It aims to give developers of all skill levels the tools to start creating complex GUI applications with little time and effort.

> **Note**: Mousetrap is under active development. While backwards-compatibility for all future releases can already be guaranteed, stability, portability, the quality of the documentation may be affected. <br>
Consider participating in the development by [opening an issue](https://github.com/clemapfel/mousetrap.jl) when you encounter an error or bug (which - as of now - will most likely happen).

---

## Table of Contents
0. [Introduction](https://github.com/Clemapfel/mousetrap.jl)<br>
1. [Features](#features)<br>
2. [Planned Features](#planned-features)<br>
3. [Showcase](#showcase)<br>
3.1 [Hello World](#hello-world)<br>
3.2 [Opening a File Explorer Dialog](#opening-a-file-explorer-dialog)<br>
3.3 [Reacting to Mouse / Touchscreen Events](#reacting-to-mouse--touchscreen-presses)<br>
3.4 [Rendering a Rectangle using OpenGL](#rendering-a-rectangle-with-opengl)<br>
4. [Supported Platforms](#supported-platforms)<br>
5. [Installation](#installation)<br>
6. [Documentation](#documentation)<br>
7. [Credits & Donations](#credits--donations)<br>
8. [Contributing](#contributing)<br>
9. [License](#license)<br>
10. [Citation](#citation)<br>

---

## Features
+ Create complex GUI application for Linux, Windows, ~~and MacOS~~*
+ Choose from over 40 different kinds of pre-made widgets, or create your own
+ Supports mice, keyboards, touchscreens, touchpads, and stylus devices
+ Image processing facilities, well-suited for image manipulation programs
+ Fully abstracted OpenGL interface, allows for high-performance, hardware-accelerated rendering of custom shapes / shaders
+ [Hand-written manual and extensive documentation](https://clemens-cords.com/mousetrap): every exported symbol is documented

---

## Planned Features

Inn order of priority, highest first:

+ Simplify installation process to `] add mousetrap`
+ [Add support for global and per-widget custom themes by exposing the CSS interface](https://github.com/users/Clemapfel/projects/2/views/1?pane=issue&itemId=33978016)
+ [Implement installation of .desktop files on end-user computers](https://github.com/users/Clemapfel/projects/2/views/1?pane=issue&itemId=33978007)
+ [Add a toggle to `RenderTexture` that allows rendering to a MSAA buffer](https://github.com/users/Clemapfel/projects/2/views/1?pane=issue&itemId=33978073)
+ [Allow bundling of mousetrap apps, their resources, and all their dependencies into a portable C-executable](https://github.com/users/Clemapfel/projects/2?pane=issue&itemId=33978204)
+ [Implement drag-and-drop for files, images, and widgets](https://github.com/users/Clemapfel/projects/2/views/1?pane=issue&itemId=33978042)
+ [Allow retrieving a widget from its container, for this to be possible the widgets type has to be stored C-side](https://github.com/users/Clemapfel/projects/2/views/1?pane=issue&itemId=33978134)
+ [Allow filtering and searching of selectable widget containers such as `ListView` and `ColumnView`](https://github.com/users/Clemapfel/projects/2/views/1?pane=issue&itemId=33978048)
+ Allow adding custom signals that use the GLib marshalling system
+ Fully polish interactive use from within the REPL
+ Make all functions that modify the global state thread-safe
+ Add an event controller to capture video game controller / joystick events
+ Expose the full `GtkTextView` and `GtkSourceView` interface, making `TextView` a fully feature editor
+ Allow binding textures to fragment shader uniforms at texture unit 1 or higher, currently, only texture unit 0 is supported
+ Add 3D shapes and geometry shaders

---

## Showcase

### Hello World

```julia
using mousetrap
main() do app::Application
    window = Window(app)
    set_child!(window, Label("Hello World!"))
    present!(window)
end
```
![](docs/src/assets/readme_hello_world.png)

---

### Opening a File Explorer Dialog

```julia
file_chooser = FileChooser()
on_accept!(file_chooser) do self::FileChooser, files
    println("selected file $(files[1])")
end
present!(file_chooser)
```
![](docs/src/assets/readme_file_chooser.png)

---

### Rendering a Rectangle with OpenGL

```julia
render_area = RenderArea()
rectangle = Rectangle(Vector2f(-0.5, -0.5), Vector2f(1, 1))
add_render_task!(render_area, RenderTask(rectangle))
```
![](docs/src/assets/readme_opengl_rectangle.png)

---

### Reacting to Mouse / Touchscreen Presses

```julia
function on_click(::ClickEventController, x_position, y_position)
    println("Click registered at ($x_position, $y_position)") # in pixels
end

click_controller = ClickEventController()
connect_signal_clicked!(on_click, click_controller)
add_controller!(window, click_controller)
```
```
Click registered at (367.5, 289.0)
```

---

## Supported Platforms

| Platform         | Basic GUI Component | Native Rendering Component |
|------------------|---------------------|-----------------------------|
| Linux (64-bit)   | `✓`                | `✓`                        |
| Linux (32-bit)   | `✓`                | `✓`                        |
| Windows (64-bit) | `✓`                | `✓`                        |
| Windows (32-bit) | `✕`                | `✕`                        |
| FreeBSD          | `✓`                | `✓`                       | 
| MacOS            | `✓`                | `✕`                        |

---


## Installation

In the Julia REPL, press the `]` key to enter `Pkg` mode, then:

```julia
add https://github.com/Clemapfel/mousetrap_windows_jll
add https://github.com/Clemapfel/mousetrap_linux_jll
add https://github.com/Clemapfel/mousetrap.jl
test mousetrap
```

Where all three packages need to be installed, regardless of the operating system.

Installation may take a long time. Once it's done, loading mousetrap for future development will only take a few seconds each time.

---

## Documentation

Documentation is available [here](https://clemens-cords.com/mousetrap). This includes a tutorial on how to install mousetrap, a user manual introducing users to mousetrap and GUI programming in general, as well as an index of all classes, enums, and functions.

--- 

## Credits & Donations

The Julia and C++ component of mousetrap were designed and implemented by [C.Cords](https://clemens-cords.com).

Consider donating to support the continued development of this library [here](TODO).

The goal is for mousetrap to be 100% stable and flawless when Julia [static compilation](https://github.com/JuliaLang/PackageCompiler.jl) finishes development. Static compilation and the lack of [fully featured, easy-to-use](https://github.com/JuliaGraphics/Gtk.jl/issues) GUI libraries are currently the largest factors as to why Julia is ill-suited for front-end development. Mousetrap aims to address the latter factor.

---

## Contributing

Consider contributing by taking on one of these bounty projects:

+ [Native Rendering on MacOS](https://github.com/users/Clemapfel/projects/2/views/1?pane=issue&itemId=33978341)
+ [Cross-Platform App Bundler](https://github.com/users/Clemapfel/projects/2?pane=issue&itemId=33978204)

I am unable to offer any monetary reward, but I'd be happy to credit you as a co-author of mousetrap in the [GitHub Readme](https://github.com/Clemapfel/mousetrap.jl#credits), [citation](https://github.com/Clemapfel/mousetrap.jl#citation), and [as a Julia package author](https://github.com/Clemapfel/mousetrap.jl/blob/main/Project.toml#L3) if your work contributes significantly to the implementation of these bounty projects.

~~You can also submit your own custom CSS theme or icon set. These may be added to the defaults with a name of your choice! See the manual section on theming for more information.~~

Thank you for your consideration.<br>
C.

---

## License

The current and all past version of mousetrap, including any text or assets of the mousetrap documentation, are licensed under [GNU Lesser General Public License (Version 3.0)](https://www.gnu.org/licenses/lgpl-3.0.en.html). This means it can be used in both free, open-source, as well as commercial, closed-source software.

---

## Citation

If you are using mousetrap for research or work, please cite it as follows:
```
TODO
```             
