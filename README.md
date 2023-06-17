# Mousetrap

> Mousetrap is under active development. While it can already be guaranteed that all future versions will be backwards-compatible, stability and portability may be affected. Consider participating in the development by [opening an issue](https://github.com/clemapfel/mousetrap.jl) when you encounter an error.

Mousetrap is a GUI library for `Julia`. It is based on the [C++-component of the same name](https://github.com/clemapfel/mousetrap) which fully wraps the [GTK4](https://docs.gtk.org/gtk4/), *vastly* simplyfing its interface without sacrificing perfomance or flexibility.

---

## Features
+ Create complex GUI application for Linux, Windows and MacOS
+ Over 40 different kinds of widgets for every occasion
+ Powerful image processing facilities, well-suited for image manipulation programs
+ Supports mice, keyboards, touchscreens, touchpads, and styluses
+ Automatic memory management independent of Julia, reducing the likelyhood of crashes and errors
+ Fully abstracted OpenGL interface, allowing high-performance, hardware-accelerated rendering
+ Verbose logging and error propagation, aids in debugging
+ hand-written manual introducing newcomers to GUI programming and signal architecture
+ every exported symbol is documented

## Planned Features
(in order of priority, highest first)
+ Simplify installation process to `] add mousetrap`
+ Enable CI for C++- and Julia-components
+ Allow bundling of the Julia runtime and all necessary binary dependencies into a portable C++ executable
+ Add an `EventController` to capture controller / joystick events
+ 3D native rendering

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

#### Creating a Selectable List of Widgets

```julia
list = ListView()
push_back!(list_view, Button())
push_back!(list_view, Entry())
push_back!(list_view, ListView())
```
![](todo)

---

### Opening a File Explorer Dialog

```julia
file_chooser = FileChooser(FILE_CHOOSER_ACTION_SELECT_FILE)
on_accept!(file_chooser) do self::FileChooser, files::Vector{FileDescriptor}
    println("selected file $(files[1])")
end
present!(file_chooser)
```
![](todo)

---

### Rendering a Rectangle with OpenGL

```julia
render_area = RenderArea()
rectangle = Rectangle(Vector2f(-0.5, -0.5), Vector2f(1, 1))
add_render_task!(render_area, RenderTask(rectangle))
set_child!(window, render_area)
```
![](todo)

---

#### Reacting to Mouse / Touchscreen Presses

```julia
function on_click(controller::ClickEventController, x_position, y_position)
    println("Click registered at ($x_position, $y_position)")
end

click_controller = ClickEventController()
connect_signal_clicked!(on_click, click_controller)
add_controller!(window, click_controller)
```
---

## Documentation

Documentation is available [here](https://clemens-cords.com/mousetrap_jl). This includes a tutorial on how to install mousetrap, a user manual, as well as an index of all exported symbols.

--- 

## Credits

The Julia- and C++-component of mousetrap were designed and implement by [C.Cords](https://clemens-cords.com).

---

## License

Mousetrap is distributed under [lgpl-3.0](https://www.gnu.org/licenses/lgpl-3.0.en.html). This means it can be freely used in both free open-source, as well as commercial, closed-source projects.






