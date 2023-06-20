# Mousetrap

Mousetrap is a GUI library for `Julia`. It, and its [C++-component of the same name](https://github.com/clemapfel/mousetrap), fully wrap the [GTK4](https://docs.gtk.org/gtk4/) GUI library, *vastly* simplyfing its interface to improve ease-of-use without sacrificing flexibility.

It aims to give developers of any skill level the tools to start creating complex applications 
with as little time and effort as possible.

> Mousetrap is under active development. While backwards-compatibility for all future releases can already be guaranteed, stability and portability may be affected. Consider participating in the development by[opening an issue](https://github.com/clemapfel/mousetrap.jl) when you encounter an error (which - as of now - will most likely happen)

---

## Features
+ Create complex GUI application for Linux, Windows and MacOS
+ Choose from over 40 different kinds of widgets for every occasion
+ Powerful image processing facilities, well-suited for image manipulation programs
+ Supports mice, keyboards, touchscreens, touchpad, and stylus devices
+ Fully abstracted OpenGL interface, allows for high-performance, hardware-accelerated rendering
+ Hand-written manual & extensive documentation: every exported symbol is documented

---

## Design Goals

#### A wholistic View is not necessary

Mousetrap provides over 1000 exported symbols, which can be very daunting, especially to people without GUI experience (and/or multiple days to study).

To address this, mousetrap was designed with a "plug & play" approach. **Users will
only have to be aware of a tiny fraction of mouesetraps functionalities in order to
start creating applications**. After acquiring this basic knowledge, they are free to learn
about more widgets, advanced techniques, or entire other modules at their own pace - or not at all.

#### Runtime Errors cannot crash the Application

In many languages (including Julia and C++), if the *developer* causes an error by doing something wrong, that error will often cause the program to exit. Mousetrap aims to avoid this as much as possible. If a developer uses the library wrong, they should get a soft warning or be notified during compilation - as opposed to causing a fatal error during runtime.

Over all else, stability is the top priority.

---

## Planned Features

(in order of priority, highest first)
+ Simplify installation process to `] add mousetrap` for all operating systems
+ Add support for loading custom themes
+ Allow bundling of the Julia runtime and all necessary binary dependencies into a portable executable
+ Implement CI for C++ and Julia components
+ Allow for audio playback & manipulating audio data
+ Add an event controller to capture video game controller / joystick events
+ Allow [other OpenGL-based libraries](https://github.com/MakieOrg/Makie.jl) to render to `RenderArea`

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
push_back!(list_view, Button())
push_back!(list_view, Label("Label")) 
push_back!(list_view, Entry())
```
![](todo)

---

#### Opening a File Explorer Dialog

```julia
file_chooser = FileChooser()
on_accept!(file_chooser) do self::FileChooser, files::Vector{FileDescriptor}
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

Documentation is available [here](https://clemens-cords.com/mousetrap_jl). This includes a tutorial on how to install mousetrap, a user manual introducing users to mousetrap and GUI programming in general, as well as an index of all functions and classes.

--- 

## Credits

The Julia- and C++-component of mousetrap were designed and implement by [C.Cords](https://clemens-cords.com).

Consider donating to supports the continued development of this library [here](TODO). The goal is for 
mousetrap to be fully featured and completely stable when Julia [static compilation](https://github.com/JuliaLang/PackageCompiler.jl) finishes development. Static compilation and the lack of [stable, easy-to-use](https://github.com/JuliaGraphics/Gtk.jl/issues)
GUI libraries are currently the largest factors as to why Julia is ill-suited for front-end development.

---

## License

Mousetrap is distributed under [LGPL-3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html). This means it can be used in both free, open-source, as well as commercial, closed-source software.
