#
# Author: C. Cords (mail@clemens-cords.com)
# GitHub: https://github.com/clemapfel/mousetrap.jl
# Documentation: https://clemens-cords.com/mousetrap
#
# Copyright © 2023, Licensed under lGPL-3.0
#

@document Action """
# Action <: SignalEmitter

Memory-managed object that wraps a function. Each action has a unique ID and is registered with 
the [`Application`](@ref). It can furthermore have any number of shortcut triggers.

Using `set_function!`, we can register a callback to bec alled when the action is activated in any way.
This function is required to have the signature:
```
(::Action, [::Data_t]) -> Nothing
```
Each action can be enabled or disabled. If an action is disabled, all associated widgets, keybindings 
and menu items will be disabled automatically.

See the manual chapter on actions for more information.

$(@type_constructors(
    Action(::ActionID, ::Application),
    Action(stateless_f, ::ActionID, ::Application)
))

$(@type_signals(Action, 
activated
))

$(@type_fields())

## Example
```julia
action = Action("example.action", app)
set_function!(action) do self::Action
    println(get_id(self) * " activated.")
end
activate!(action)
```
"""

@document Adjustment """
# Adjustment <: SignalEmitter

Object that represents a range of discrete values. Modifying the underlying adjustment 
of a widget, will modify the widget, and vice-versa. 

cf. [`get_adjustment`](@ref) to see which widgets are available to be controlled this way.

$(@type_constructors(
    Adjustment(value::Number, lower::Number, upper::Number, increment::Number)
))

$(@type_signals(Adjustment,
    value_changed,
    properties_changed
))

$(@type_fields())
"""

@document AlertDialog """
# AlertDialog <: SignalEmitter

Simple dialog with a message, detailed description, space for a single widget, and one or more labeled buttons. 

Using `on_selection!`, you can register a function with the signature
```
(::AlertDialog, button_index::Integer, [::Data_t]) -> Nothing
```
which is called when the user makes a selection or closes the dialog.

$(@type_constructors(
    AlertDialog(message::String, [detailed_message::String])
))

$(@type_signals(AlertDialog, 
))

$(@type_fields())

## Example
```julia
alert_dialog = AlertDialog("Is this is a dialog?")
add_button!(alert_dialog, "yes")
add_button!(alert_dialog, "no")
on_selection!(alert_dialog) do self::AlertDialog, button_index::Signed
    if button_index == 1
        println("User chose `Yes`")
    elseif button_index == 2
        println("User chose `No`")
    elseif button_index == 0
        println("User dismissed the dialog")
    end
end
present!(alert_dialog)
```
"""


@document ActionBar """
# ActionBar <: Widget

Horizontal bar, has an area for widgets at the start and end, along with a singular centered widget, set via `set_center_widget!`.
`ActionBar` can be hidden / shown using `set_is_revealed!`.

$(@type_constructors(
    ActionBar()
))

$(@type_signals(ActionBar, 
))

$(@type_fields())
"""

@document Angle """
# Angle

Represents an angle in a unit-agnostic way.

Use [`radians`](@ref) or [`degrees`](@ref) to construct
an object of this type.

[`as_radians`](@ref) and [`as_degrees`](@ref) allow for 
converting an angle to the respective unit.

$(@type_constructors())

$(@type_fields())
"""

@document Application """
# Application <: SignalEmitter

Used to register an application with the users OS.

The applications ID is required to contain at least one `.`, and it should be unique, meaning no
other application on the users operating system shares this ID.

Calling [`run!`](@ref) initializes the GTK4 and OpenGL back-end, after which 
signal `activate` wil be emitted. All widgets should only be created
**after** this point. In practice, this means that the entirety of
initializing for the entire app should happen inside the
signal handler of the `activate` signal. See [`main`](@ref) for an automated 
way of doing this, or the example below.

When all windows of an application are closed, or [`quit!`](@ref) is called,
the application exits. This can be prevented with [`hold!`](@ref), 
which has to be undone later by calling [`release!`](@ref). When exiting, the 
application will emit signal `shutdown`, which should be used to safely free resources.

When creating a new application, `allow_multiple_instances` governs whether resources are
shared between two instances with the same ID. If set to `false`, the most recently 
created instance will be the primary instance. If set to `true` (default) the instance 
created **first** will be the primary instance. See [here](https://docs.gtk.org/gio/class.Application.html)
for more information.

$(@type_constructors(
    Application(::ApplicationID ; [allow_multiple_instances::Bool = true])
))

$(@type_signals(Application, 
    activate,
    shutdown
))

$(@type_fields())

## Example
```julia
app = Application("example.app")
connect_signal_activate!(app) app::Application
    # all initialization has to happen here
end
connect_signal_shutdown!(app) app::Application
    # safely free all resources
end
run!(app)
```
"""

@document Animation """
# Animation <: SignalEmitter

Object that provides a timing function which is synched to a widgets render cycle. It can be used as the basis of implementing animations.

By default, the animations `value` will be in [0, 1], though this can be changed with `set_lower!` and `set_upper!`. The shape of the function 
interpolating the value over time can be set using `set_timing_function!`.

$(@type_constructors(
    Animation(target::Widget, duration::Time)
))

$(@type_signals(Application, 
))

$(@type_fields())

## Example
```julia
# animate a gradual fade-out
to_animate = Button()

animation = Animation(to_animate, seconds(1))
on_tick!(animation, to_animate) do self::Animation, value::AbstractFloat, target::Widget
    # value will be in [0, 1]
    set_opacity!(target, 1 - value)
end
on_done!(animation, to_animate) do self::Animation, target::Widget
    set_is_visible!(target, false)
end

# start animation when button is clicked
connect_signal_clicked!(to_animate, animation) do self::Button, animation::Animation
    play!(animation)
end
```
"""

@document AspectFrame """
# AspectFrame <: Widget

Container widget with a single child, makes sure that 
the size of its child will always be at the specified width-to-height ratio.

$(@type_constructors(
    AspectFrame(width_to_height::AbstractFloat; [child_x_alignment::AbstractFloat, child_y_alignment::AbstractFloat]),
    AspectFrame(Width_to_height::AbstractFloat, child::Widget)
))

$(@type_signals(AspectFrame, 
))

$(@type_fields())
"""

@document AxisAlignedRectangle """
# AxisAlignedRectangle

Axis-aligned bounding box. Defined by its top-left 
corner and size.

$(@type_constructors(
    AxisAlignedRectangle(top_left::Vector2f, size::Vector2f)
))

$(@type_fields(
    top_left::Vectorf,
    size::Vector2f
))
"""

@document Box """
# Box <: Widget

Widget that aligns its children in a row (or column), depending on orientation.

$(@type_constructors(
    Box(::Orientation)
))

$(@type_signals(Box, 
))

$(@type_fields())

## Example
```julia
box = Box(ORIENTATION_HORIZONTAL)
push_back!(box, Label("01"))
push_back!(box, Button())
push_back!(box, Label("03"))

# equivalent to
box = hbox(Label("01"), Button(), Label("02"))
```
"""

@document Button """
# Button <: Widget

Button with a label. Connect to signal `clicked` or specify an action via [`set_action!`](@ref)
in order to react to the user clicking the button.

$(@type_constructors(
    Button(),
    Button(label::Widget),
    Button(::Icon)
))

$(@type_signals(Button, 
    clicked
))

$(@type_fields())

## Example
```julia
button = Button()
set_child!(button, Label("Click Me"))
connect_signal_clicked!(button) do x::Button
    println("clicked!")
end
set_child!(window, button)
```
"""

@document CenterBox """
# CenterBox <: Widget

Widget that aligns exactly 3 widgets in a row (or column),
prioritizing keeping the middle widget centered at all
times.

$(@type_constructors(
    CenterBox(::Orientation),
    CenterBox(::Orientation, left::Widget, center::Widget, right::Widget)
))

$(@type_signals(CenterBox, 
))

$(@type_fields())

## Example
```julia
center_box = CenterBox(ORIENTATION_HORIZONTAL)
set_start_child!(center_box, Label("Left"))
set_center_child!(center_box, Button())
set_end_child!(center_box, Label("Right"))
```
"""

@document CheckButton """
# CheckButton <: Widget

Rectangle that displays a checkmark and an optional label. Connect to signal `toggled` to react to the user changing the `CheckButton`s state by clicking it.

$(@type_constructors(
    CheckButton()
))

$(@type_signals(CheckButton, 
    toggled
))

$(@type_fields())

## Example
```julia
check_button = CheckButton()
set_child!(check_button, Label("Click Me"))
connect_signal_toggled!(check_button) do self::CheckButton
    state = get_state(self)
    print("CheckButton is now: ") 
    if state == CHECK_BUTTON_STATE_ACTIVE
        println("active!")
    elseif state == CHECK_BUTTON_STATE_INACTIVE
        println("inactive")
    else # state == CHECK_BUTTON_STATE_INCONSISTENT
        println("inconsistent")
    end
end
set_child!(window, check_button)
```
"""

@document ClampFrame """
# ClampFrame <: Widget

Constrains its single child such that the childs width (or height, if vertically orientated) cannot
exceed the size set using `set_maximum_size!`. 

$(@type_constructors(
    ClampFrame(size_px::AbstractFloat, [::Orientation = ORIENTATION_HORIZONTAL])
))

$(@type_signals(ClampFrame))

$(@type_fields())
"""

@document ClickEventController """
# ClickEventController <: SingleClickGesture <: EventController

Event controller that reacts to a series of one or more mouse-button or touchscreen presses.

$(@type_constructors(
    ClickEventController()
))

$(@type_signals(ClickEventController, 
    click_pressed,
    click_released,
    click_stopped
))

$(@type_fields())

## Example
```julia
click_controller = ClickEventController()
connect_signal_click_pressed!(click_controller) do self::ClickEventController, n_presses::Integer, x::Float64, y::Float64
    if n_presses == 2
        println("double click registered at position (\$(Int64(x)), \$(Int64(y)))")
    end
end
add_controller!(window, click_controller)
```
"""

@document Clipboard """
# Clipboard <: SignalEmitter

Allows for accessing and overwriting the data in the users OS-wide clipboard.
Construct an instance of this type by calling [`get_clipboard`](@ref) on the
toplevel window.

If the clipboard contains an image, use [`get_image`](@ref) to access it,
any other kind of data needs to be accesses with [`get_string`](@ref).

$(@type_constructors(
))

$(@type_signals(Clipboard, 
))

$(@type_fields())

## Example
```julia
clipboard = get_clipboard(window)
get_string(clipboard) do self::Clipboard, value::String
    println("Value in clipboard: " * value)
end
```
"""

@document Clock """
# Clock <: SignalEmitter

Object used to keep track of time. Nanosecond precision.

$(@type_constructors(
    Clock()
))

$(@type_signals(Clock, 
))

$(@type_fields())

## Example
```julia
clock = Clock()
current = restart!(clock)
sleep(1)
now = elapsed(clock)
println("time delta: \$(as_seconds(now - current))")
```
"""

@document ColorChooser """
# ColorChooser <: SignalEmitter

Dialog that allows a user to choose a color.

$(@type_constructors(
    ColorChooser([title::String, modal::Bool])
))

$(@type_signals(ColorChooser, 
))

$(@type_fields())

## Example
```julia
color_chooser = ColorChooser()
on_accept!(color_chooser) do self::ColorChooser, color::RGBA
    println("Selected \$color")
end
on_cancel!(color_chooser) do self::ColorChooser
    println("color selection cancelled")
end
present!(color_chooser)
```
"""

@document ColumnView """
# ColumnView <: Widget

Selectable widget that arranges its children as a table with rows and columns.

$(@type_constructors(
    ColumnView([::SelectionMode])
))

$(@type_signals(ColumnView, 
    activate
))

$(@type_fields())

## Example
```julia
column_view = ColumnView(SELECTION_MODE_NONE)

for column_i in 1:4
    column = push_back_column!(column_view, "Column #\$column_i")
    for row_i in 1:3
        set_widget!(column_view, column, row_i, Label("\$row_i | \$column_i"))
    end
end

# or push an entire row at once
push_back_row!(column_view, Button(), CheckButton(), Entry(), Separator())        
set_child!(window, column_view)
```
"""

@document ColumnViewColumn """
# ColumnViewColumn <: SignalEmitter

Class representing a column of [`ColumnView`](@ref). Has a label, any number of children 
which represented that columns rows, and an optional header menu.

$(@type_constructors(
))

$(@type_signals(ColumnViewColumn, 
))

$(@type_fields())

## Example
```julia
# create a new column
column = push_back_column!(column_view)

# set widget in 4th row, automatically backfills rows 1 - 3
set_widget!(column, 4, Label("4"))
```
"""

@document DragEventController """
# DragEventController <: SingleClickGesture <: EventController

Event controller that recogizes drag-gestures by both a mouse or touch device.

$(@type_constructors(
    DragEventController()
))

$(@type_signals(DragEventController, 
    drag_begin, 
    drag,
    drag_end
))

$(@type_fields())

## Example
```julia
drag_controller = DragEventController()
connect_signal_drag!(drag_controller) do self::DragEventController, x_offset, y_offset
    start::Vector2f = get_start_position(self)
    current = start + Vector2f(x_offset, y_offset)
    println("Current cursor position: \$current")
end
add_controller!(window, drag_controller)
```
"""

@document DropDown """
# DropDown <: Widget

Presents the user with a collapsible list of items. If one of its items is clicked, that items callback will be invoked.

$(@type_constructors(
    DropDown()
))

$(@type_signals(DropDown, 
))

$(@type_fields())

## Example
```julia
drop_down = DropDown()
push_back!(drop_down, "Item 01") do x::DropDown
    println("Item 01 selected") 
end
push_back!(drop_down, "Item 02") do x::DropDown
    println("Item 02 selected") 
end
set_child!(window, drop_down)
```
"""

@document DropDownItemID """
# DropDownItemID

ID of a dropdown item, returned when adding a new item to the drop down.
Keep track of this in order to identify items in a position-independent manner.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document Entry """
# Entry <: Widget

Single-line text entry, supports "password mode", as well as inserted an icon to the left and/or right of the text area.

$(@type_constructors(
    Entry()
))

$(@type_signals(Entry, 
    activate, 
    text_changed
))

$(@type_fields())


## Example
```julia
entry = Entry()
set_text!(entry, "Write here")
connect_signal_text_changed!(entry) do self::Entry
    println("text is now: \$(get_text(self))")
end
```
"""

@document EventController abstract_type_docs(EventController, Any, """
# EventController <: SignalEmitter

Superclass of all event controllers. Use [`add_controller!`](@ref)
to connect an event controller to any widget, after which it starts receiving input events.
Connect to the unique signals of each event controller in order to react to these events.
""")

@document Expander """
# Expander <: Widget

Collapsible item which has a label and child. If the label is clicked, 
the child is shown (or hidden, if it is already shown).

!!! note
    This widget should not be used to create collapsible lists, 
    use [`ListView`](@ref) for this purpose instead.

$(@type_constructors(
    Expander(),
    Expander(child::Widget, label::Widget)
))

$(@type_signals(Expander, 
    activate
))

$(@type_fields())
"""

@document FileChooser """
# FileChooser <: SignalEmitter

Pre-made dialog that allows users to pick a file or folder on the 
local disk. 

Connect a function with the signature
```
(::FileChooser, files::Vector{FileDescriptor}, [::Data_t]) -> Nothing
```
using [`on_accept!`](@ref). When the user makes a selection, this function 
will be invoked and `files` will contain one or more selected files.

The file choosers layout depends on the [`FileChooserAction`](@ref) specified on construction.

$(@type_constructors(
    FileChooser(::FileChooserAction, [title::String])
))

$(@type_signals(FileChooser, 
))

$(@type_fields())

## Example
```julia
file_chooser = FileChooser(FILE_CHOOSER_ACTION_OPEN_FILE)

on_accept!(file_chooser) do x::FileChooser, files::Vector{FileDescriptor}
    if !isempty(files)
        println("Selected file at ", get_path(files[1]))
    end
end

on_cancel!(file_chooser) do x::FileChooser
    println("Canceled.")
end

present!(file_chooser)
```
"""

@document FileDescriptor """
# FileDescriptor <: SignalEmitter

Read-only object that points a specific location on disk. There is no
guaruantee that this location contains a valid file or folder.

$(@type_constructors(
    FileDescriptor(path::String)
))

$(@type_signals(FileDescriptor, 
))

$(@type_fields())

## Example
```julia
current_dir = FileDescriptor(".")
for file in get_children(current_dir)
    println(get_name(file) * ":\t" * get_content_type(file))
end
```
"""

@document FileFilter """
# FileFilter <: SignalEmitter

Filter used by [`FileChooser`](@ref). Only files that 
pass the filter will be available to be selected when the file chooser is active.

If multiple filters are supplied, the user can 
select between them using a dropdown that is automatically 
added to the `FileChooser` dialog.

$(@type_constructors(
    FileFilter()
))

$(@type_signals(FileFilter, 
))

$(@type_fields())

## Example
```julia
filter = FileFilter()
add_allowed_suffix!(filter, "jl") # without the `.`
````
"""

@document FileMonitor """
# FileMonitor <: SignalEmitter

Object that monitors a location on disk. If 
anything about the object at that location changes, it will call the function registered using [`on_file_changed!`](@ref),
which requires a function with signature
```
(::FileMonitor, event::FileMonitorEvent, self::FileDescriptor, other::FileDescriptor, [::Data_t]) -> Nothing
```

Where `event` classifies the type of change, `self` is the file being monitored.

$(@type_constructors(
))

$(@type_signals(FileMonitor, 
))

$(@type_fields())

## Example
```julia
file = FileDescriptor("path/to/file.jl")
@assert(exists(file))
monitor = create_monitor(file)
on_file_changed!(monitor) do x::FileMonitor, event_type::FileMonitorEvent, self::FileDescriptor, other::FileDescriptor
    if event_type == FILE_MONITOR_EVENT_CHANGED
        println("File at " * get_path(self) * " was modified.")
    end
end
```
"""

@document Fixed """
# Fixed <: Widget

Container widget that places its children at a specified pixel position relative to the `Fixed`s top-left corner.

Use of this widget is usually discouraged, it does not allow for automatic expansion or alignment.

$(@type_constructors(
    Fixed()
))

$(@type_signals(Fixed, 
))

$(@type_fields())
"""

@document FlowBox """
# FlowBox <: Widget

`Box`-like widget that dynamically rearranges its children into multiple rows (or columns), as the widgets width (or height) changes.

$(@type_constructors(
    FlowBox(Orientation)
))

$(@type_signals(Fixed, 
))

$(@type_fields())
"""

@document FocusEventController """
# FocusEventController <: EventController

Reacts to a widget gaining or loosing input focus.

$(@type_constructors(
    FocusEventController()
))

$(@type_signals(FocusEventController, 
    focus_gained,
    focus_lost
))

$(@type_fields())

## Example
```julia
focus_controller = FocusEventController()
connect_signal_focus_gained!(focus_controller) do self::FocusController
    println("Gained Focus")
end
add_controller!(widget, focus_controller)
```
"""

@document Frame """
# Frame <: Widget

Widget that draws a black outline with rounded corners around
its singular child.

$(@type_constructors(
    Frame(),
    Frame(child::Widget)
))

$(@type_signals(Frame, 
))

$(@type_fields())
"""

@document FrameClock """
# FrameClock <: SignalEmitter

Clock that is synched with a widgets render cycle. Connect to its signals to trigger behavior once per frame.

$(@type_constructors(
))

$(@type_signals(FrameClock, 
))

$(@type_fields())

## Example
```julia
frame_clock = get_frame_clock(widget)
connect_signal_paint!(frame_clock) do x::FrameClock
    println("Widget was drawn.")
end
```
"""

@document GLTransform """
# GLTransform <: SignalEmitter

Transform in 3D spaces. Uses OpenGL coordinates, it should 
therefore only be used to modify vertices of a [`Shape`](@ref).

Can be indexed and modified as a 4x4 matrix of `Float32`.

$(@type_constructors(
    GLTransform()
))

$(@type_signals(GLTransform, 
))

$(@type_fields(
))
"""

@document Grid """
# Grid <: Widget

Selectable container that arranges its children in a non-uniform grid. 
Each child has a row- and column-index, as well as a width and height, measured in number of cells.

$(@type_constructors(
    Grid()  
))

$(@type_signals(Grid, 
))

$(@type_fields())

## Example
```julia
grid = Grid()
insert_at!(grid, Label("Label"), 1, 1, 1, 1)
insert_at!(grid, Button(), 1, 2, 1, 1)
insert_at!(grid, Separator, 2, 1, 2, 1)
```
"""

@document GridView """
# GridView <: Widget

Selectable widget container that arranges its children in a uniform 
grid.

$(@type_constructors(
    GridView(::Orientation, [::SelectionMode])
))

$(@type_signals(GridView, 
    activate_item
))

$(@type_fields())
"""

@document GroupID """
# GroupID

ID of a group inside a `KeyFile`. May not start with a number, 
and can only roman letters, 0-9, `_`, `-`, and `.`.

Use `.` to deliminate nested groups, as each key-value pair has to 
belong to exactly one group.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document HSVA """
# HSVA

Color in hsva format, all components are `Float32` in `[0, 1]`.

$(@type_constructors(
    HSVA(::AbstractFloat, ::AbstractFloat, ::AbstractFloat, ::AbstractFloat)
))

$(@type_fields(
    h::Float32,
    s::Float32,
    v::Float32,
    a::Float32
))
"""

@document HeaderBar """
# HeaderBar <: Widget

Widget that usually used as the title bar of a window. It contains a title, 
close-, maximize-, minimize buttons, as well as an area for widgets on both sides of the title.

$(@type_constructors(
    HeaderBar(),
    HeaderBar(layout::String)
))

$(@type_signals(HeaderBar, 
))

$(@type_fields())

## Example
```julia
header_bar = HeaderBar("close:title,minimize,maximize")
push_front!(header_bar, Button())
set_titlebar_widget!(window, header_bar)
```
"""

@document Icon """
# Icon

Allows loading of icons from a image file or icon theme.

$(@type_constructors(
    Icon(),
    Icon(path::String),
    Icon(theme::IconTheme, id::IconID, square_resolution::Integer)
))

$(@type_fields(
))
"""

@document IconID """
# IconID

ID of an icon, used by [`IconTheme`](@ref) to refer to icons in 
a file-agnostic way.

$(@type_constructors(
))

$(@type_fields()))
"""

@document IconTheme """
# IconTheme <: Any

Allows loading of items from a folder if that folder strictly adheres to 
the [freedesktop icon theme specifications](https://specifications.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html). 

A [`Window`](@ref) is required to construct the icon theme, at which point the default icons for that windows display are also loaded.

$(@type_constructors(
IconTheme(::Window)
))

$(@type_fields())

## Example
```julia
theme = IconTheme()
add_resource_path!(theme, "/path/to/freedesktop_icon_theme_directory")

icon = Icon()
create_from_theme!(icon, theme, "custom-icon-id", 64)
```
"""

@document Image """
# Image <: Any

2D image data, in RGBA.

$(@type_constructors(
    Image(),
    Image(path::String),
    Image(width::Integer, height::Integer, [::RGBA])
))

$(@type_fields())
"""

@document ImageDisplay """
# ImageDisplay <: Widget

Widget that displays an [`Image`](@ref), [`Icon`](@ref), or image file.

$(@type_constructors(
    ImageDisplay(path::String),
    ImageDisplay(::Image),
    ImageDisplay(::Icon)
))

$(@type_signals(ImageDisplay, 
))

$(@type_fields())
"""

@document KeyCode """
# KeyCode

Identifier of a key. Used for [`ShortcutTrigger`](@ref) syntax.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document KeyEventController """
# KeyEventController <: EventController

Event controller that recognizes keyboard key strokes.

$(@type_constructors(
    KeyEventController()
))

$(@type_signals(KeyEventController, 
    key_pressed,
    key_released,
    modifiers_changed
))

$(@type_fields())

## Example
```julia
key_controller = KeyEventController()
connect_signal_key_pressed!(key_controller) do self::KeyEventController, key::KeyCode, modifier::ModifierState
    if key == KEY_space
        println("space bar pressed")
    end
end
add_controller!(window, key_controller)
```
"""

@document KeyFile """
# KeyFile <: SignalEmitter

GLib keyfile, ordered into groups with key-value pairs. 

Allows (de-)serializing of the following types:
+ `Bool`, `Vector{Bool}`
+ `AbstractFloat`, `Vector{AbstractFloat}`
+ `Signed`, `Vector{Signed}`
+ `Unsigned`, `Vector{Unsigned}`
+ `String`, `Vector{String}`
+ `RGBA`
+ `HSVA`
+ `Image`

All key-values pairs have to be in exactly one group.

$(@type_constructors(
    KeyFile(),
    KeyFile(path::String)
))

$(@type_signals(KeyFile, 
))

$(@type_fields())

## Example
```julia
key_file = KeyFile()
set_value!(key_file, "group_id", "key_id", [123, 456, 789])
set_comment_above!(key_file, "group_id", "key_id", "An example key-value pair")
println(as_string(key_file))
```
```
[group_id]
# An example key-value pair
key_id=123;456;789;
````
"""

@document KeyID """
# KeyID

ID of [`KeyFile`](@ref) key-value-pair. Contains only roman letters, 0-9, and '_'.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document Label """
# Label <: Widget

Static text, multi- or single-line. Use [`set_ellipsize_mode!`](@ref),
[`set_wrap_mode!`](@ref), and [`set_justify_mode!`](@ref) to influence how text 
is displayed.

Supports [pango markup](https://docs.gtk.org/Pango/pango_markup.html), see 
the manual section on labels for more information.

$(@type_constructors(
    Label(),
    Label(markup_string::String)
))

$(@type_signals(Label, 
))

$(@type_fields())
"""

@document LevelBar """
# LevelBar <: Widget

Non-interactive widget that displays the value of a range as a fraction.

$(@type_constructors(
    LevelBar(min::AbstractFloat, max::AbstractFloat)
))

$(@type_signals(LevelBar, 
))

$(@type_fields())
"""

@document ListView """
# ListView <: Widget

Selectable widget container that arranges its children in a (nested) list.

$(@type_constructors(
    ListView(::Orientation, [::SelectionMode])
))

$(@type_signals(ListView, 
    activate_item
))

$(@type_fields())

## Example
```julia
list_view = ListView(ORIENTATION_VERTICAL)

item_01_iterator = push_back!(list_view, Label("Item 01"))
push_back!(list_view, Label("Item 02"))
push_back!(list_view, Label("Imte 03"))

push_back!(list_view, Label("Nested Item 01"), item_01_iterator)
push_back!(list_view, Label("Nested Item 02"), item_01_iterator)

set_child!(window, list_view)
```
"""

@document ListViewIterator """
# ListViewIterator

Iterator returned when inserting an item into a [`ListView`](@ref). Use this
iterator as an additional argument to `push_back!`, `push_front!`, or `insert`, in order 
to create a nested list at that item position.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document LogDomain """
# LogDomain

Domain of log messages, this will be used to associate log 
message with a specific application or library. May only contain roman letters, `_`, `.` and `-`.

$(@type_constructors(
    LogDomain(::String)
))

$(@type_fields(
))
"""

@document LongPressEventController """
# LongPressEventController <: SingleClickGesture <: EventController

Event controller that recognizes long-press-gestures from a mouse or touch device.

$(@type_constructors(
    LongPressEventController()
))

$(@type_signals(LongPressEventController, 
    pressed,
    press_cancelled
))

$(@type_fields())

## Example
```julia
long_press_controller = LongPressEventController()
connect_signal_pressed!(long_press_controller) do self::LongPressEventController, x::AbstractFloat, y::AbstractFloat 
    println("long press recognized at (\$x, \$y)")
end
add_controller!(window, long_press_controller)
```
"""

@document MenuBar """
# MenuBar <: Widget

View that displays a [`MenuModel`](@ref) as a horizontal bar. 

The `MenuModel` has to have the following structure:
+ all top-level items have to be "submenu"-type items
+ no submenu or section of another submenu may have a "widget"-type item

$(@type_constructors(
    HeaderBar(::MenuModel)
))

$(@type_signals(MenuBar, 
))

$(@type_fields())

## Example
```julia
action = Action("example.action", app)
set_function!(action) do action::Action
    println(get_id(action), " activate.")
end

outer_model = MenuModel()
inner_model = MenuModel()
add_action!(inner_model, "Trigger Action", action)
add_submenu!(outer_model, "Submenu", inner_model)

menu_bar = MenuBar(outer_model)
set_child!(window, menu_bar)
```
"""

@document MenuModel """
# MenuModel <: SignalEmitter

Model that holds information about how to 
construct a menu. 

Use [`MenuBar`](@ref) or [`PopoverMenu`](@ref) to display the
menu to the user.

The following types of menu items are available

| Type      | Function |
|-----------|-------------|
| "action"  | [`add_action!(::MenuModel, label::String, ::Action)`](@ref) |
| "icon"    | [`add_icon!(::MenuModel, ::Icon, ::Action)`](@ref) |
| "submenu" | [`add_submenu!(::MenuModel, label::String, other::MenuModel)`](@ref) |
| "section" | [`add_section!(::MenuModel, label::String, other::MenuModel)`](@ref) |
| "widget"  | [`add_widget!(::MenuModel, ::Widget)`](@ref) |

See the manual section on menus for more information.

$(@type_constructors(
    MenuModel()
))

$(@type_signals(MenuModel, 
    items_changed
))

$(@type_fields())
"""

@document ModifierState """
# ModifierState

Holds information about which modifier are currently pressed

See also:
+ [`control_pressed`](@ref)
+ [`alt_pressed`](@ref)
+ [`shift_pressed`](@ref)
+ [`mouse_button_01_pressed`](@ref)
+ [`mouse_button_02_pressed`](@ref)

$(@type_constructors(
))

$(@type_fields(
))

## Example
```julia
key_controller = KeyEventController()
connect_signal_modifiers_changed!(key_controller) do self::KeyEventController, modifiers::ModifierState
    if shift_pressed(modifiers)
        println("Shift was pressed")
    end
end
add_controller!(window, key_controller)
```
"""

@document MotionEventController """
# MotionEventController <: EventController

Captures cursor motion events while the cursor is inside the allocated area of the associated widget.

$(@type_constructors(
    MotionEventController()
))

$(@type_signals(MotionEventController, 
    motion_enter,
    motion,
    motion_leave
))

$(@type_fields())

## Example
```julia
motion_controller = MotionEventController()
connect_signal_motion!(motion_controller) do self::MotionEventController, x::AbstractFloat, y::AbstractFloat
    println("recognized motion at (\$(Int64(round(x))), \$(Int64(round(y))))")
end
add_controller!(window, motion_controller)
```
"""

@document Notebook """
# Notebook <: Widget

Widget that arranges its children as a list of pages. Each page
has exactly one child widget, as well as an optional label widget. Pages
can be freely reordered by the user if [`set_tabs_reorderable!`](@ref) is
set to true. It furthermore supports a quick-change menu, in which 
the user can quickly jump to another tab. To enable this, `set_quick_change_menu_enabled!`
needs to be set to `true`.

$(@type_constructors(
    Notebook()
))

$(@type_signals(Notebook, 
    page_added,
    page_removed,
    page_reordered,
    page_selection_changed
))

$(@type_fields())

## Example
```julia
notebook = Notebook()
push_back!(notebook, Separator(), Label("Page 01"))
push_back!(notebook, Separator(), Label("Page 02"))

connect_signal_page_selection_changed!(notebook) do x::Notebook, index::Integer
    println("Page #\$index is now selected")
end

set_child!(window, notebook)
```
"""

@document Overlay """
# Overlay <: Widget

Widget that has exaclty one "base" child, and any number of "overlay" children. If 
two interactable widgets overlap, only the top-most widget will be interactable. 

$(@type_constructors(
    Overlay(),
    Overlay(base::Widget, overlays::Widget...)
))

$(@type_signals(Overlay, 
))

$(@type_fields())

## Example
```julia
overlay = Overlay()
set_child!(overlay, Separator())
add_overlay!(overlay, Label("On Top"))    
set_child!(window, overlay)
```
"""

@document PanEventController """
# PanEventController <: SingleClickGesture <: EventController

Recognizes pan gestures along exactly one axis.

$(@type_constructors(
    PanEventController(axis::Orientation)
))

$(@type_signals(PanEventController, 
    pan
))

$(@type_fields())

## Example
```julia
connect_signal_pan!(pan_controller) do self::PanEventController, direction::PanDirection, offset::AbstractFloat
    if direction == PAN_DIRECTION_LEFT
        println("panning left")
    elseif direction == PAN_DIRECTION_RIGHT
        println("panning right")
    end
    println("x-offset from start position: \$offset")
end
add_controller!(window, pan_controller)
```
"""

@document Paned """
# Paned <: Widget

Widget with exactly two children. Draws a solid border between the two, which the user can drag to 
one side or the other to control the size of both widgets at the same time.

$(@type_constructors(
    Paned(orientation::Orientation),
    Paned(orientation::Orientation, start_child::Widget, end_child::Widget)
))

$(@type_signals(Paned, 
))

$(@type_fields())

## Example
```julia
paned = Paned(ORIENTATION_HORIZONTAL)
set_start_child!(paned, Label("Left"))
set_end_child!(paned, Label("Right"))
```
"""

@document PinchZoomEventController """
# PinchZoomEventController <: EventController

Controller recognizing 2-finger pinch-zoom gestures (touch-only).

$(@type_constructors(
    PinchZoomEventController()
))

$(@type_signals(PinchZoomEventController, 
    scale_changed
))

$(@type_fields())

## Example
```julia
pinch_zoom_controller = PinchZoomEventController()
connect_signal_scale_changed!(pinch_zoom_controller) do self::PinchZoomEventController, scale::AbstractFloat
    println("current scale: \$scale")
end
add_controller!(window, pinch_zoom_controller)
```
"""

@document PopupMessage """
# PopupMessage <: SignalEmitter

Popup message, always has a title and a close button. Additionally, a singular optional button can be placed next to the title. 
When clicked, the `PopupMessage` emits signal `button_clicked`, or calls the `Action` connected to the button using `set_button_action!`.

Use `PopupMessageOverlay` to display the message above a widget.

$(@type_constructors(
    PopupMessage(title::String),
    PopupMessage(title::String, button_label::String)
))

$(@type_signals(PopupMessage, 
    dismissed,
    button_clicked
))

$(@type_fields())

## Example
```julia
overlay = PopupMessageOverlay()
set_child!(overlay, widget)

message = PopupMessage("This example works!", "ok")
connect_signal_button_clicked!(message) do self::PopupMessage
    println("button clicked")
end
connect_signal_dismissed!(message) do self::PopupMessage
    println("message closed")
end

show_message!(overlay, message)
```
"""

@document PopupMessageOverlay """
# PopupMessageOverlay <: SignalEmitter

Widget that can display a `PopupMessage` above the `PopupMessageOverlay`s singular child. Only one message can be shown at a time.

$(@type_constructors(
    PopupMessageOverlay()
))

$(@type_signals(PopupMessageOverlay, 
))

$(@type_fields())

## Example
```julia
overlay = PopupMessageOverlay()
set_child!(overlay, widget)

message = PopupMessage("This example works!", "ok")
connect_signal_button_clicked!(message) do self::PopupMessage
    println("button clicked")
end
connect_signal_dismissed!(message) do self::PopupMessage
    println("message closed")
end

show_message!(overlay, message)
```
"""

@document Popover """
# Popover <: Widget

Window-type widget with exactly one child, has to be attached to another widget to be visible.
Use [`PopoverButton`](@ref) to automatically show / hide the popover.

$(@type_constructors(
    Popover()
))

$(@type_signals(Popover, 
    closed
))

$(@type_fields())

## Example
```julia
popover = Popover()
set_child!(popover, Label("Popover!"))

popover_button = PopoverButton()
set_popover!(popover_button, popover)

set_child!(window, popover_button)
```
"""

@document PopoverButton """
# PopoverButton <: Widget

Button that has automatically shows or hides its associated [`Popover`](@ref) or [`PopoverMenu`](@ref)
when clicked.

$(@type_constructors(
    PopoverButton(::Popover),
    PopoverButton(::PopoverMenu)
))

$(@type_signals(PopoverButton, 
))

$(@type_fields())

## Example
```julia
popover = Popover()
set_child!(popover, Label("Popover!"))

popover_button = PopoverButton()
set_popover!(popover_button, popover)

set_child!(window, popover_button)
```
"""

@document PopoverMenu """
# PopoverMenu <: Widget

Menu view that display a [`MenuModel`](@ref) in a popover window. 
Use [`PopoverButton`](@ref) to automatically show / hide the popover.

$(@type_constructors(
    PopoverMenu(::MenuModel)
))

$(@type_signals(PopoverMenu, 
    closed
))

$(@type_fields())

## Example
```julia
action = Action("example.action", app)
set_function!(action) do x::Action
    println("Action activated")
end

model = MenuModel()
add_action!(model, "Trigger Example", action)

popover_menu = PopoverMenu(model)
popover_button = PopoverButton()
set_popover_menu!(popover_button, popover_menu)

set_child!(window, popover_button)
```
"""

@document ProgressBar """
# ProgressBar <: Widget

Bar that displays a fraction in `[0, 1]`. Use `set_fraction!` to change the current value.

$(@type_constructors(
    ProgressBar()
))

$(@type_signals(ProgressBar, 
))

$(@type_fields())
"""

@document RGBA """
# RGBA

Color representation in rgba. All components 
are `Float32` in [0, 1].

$(@type_constructors(
    RGBA(r::AbstractFloat, g::AbstractFloat, b::AbstractFloat, a::AbstractFloat)
))

$(@type_fields(
    r::Float32,
    g::Float32,
    b::Float32,
    a::Flota32
))
"""

@document RenderArea """
# RenderArea <: Widget

Canvas for rendering custom shapes.

See the manual chapter on native rendering for more
information.

$(@type_constructors(
    RenderArea([AntiAliasingQuality = ANTI_ALIASING_QUALITY_OFF])
))

$(@type_signals(RenderArea,
    #render,
    resize 
))

$(@type_fields())

## Example
```julia
render_area = RenderArea()
rectangle = Rectangle(Vector2f(-0.5, -0.5), Vector2f(1, 1))
add_render_task!(render_area, RenderTask(rectangle))
set_size_request!(render_area, Vector2f(150, 150))
set_child!(window, render_area)
```
"""

@document RenderTask """
# RenderTask <: SignalEmitter

Task that groups a [`Shape`](@ref), [`Shader`](@ref), [`GLTransform`]@ref, and [`BlendMode`](@ref),
allowing them to be bound for rendering. 
    
If no shader, transform, and/or blend mode is specified, 
the default shader, identity transform, and [`BLEND_MODE_NORMAL`](@ref) will 
be used, respectively.

See the manual chapter on native rendering for more
information.

$(@type_constructors(
    RenderTask(::Shape ; [shader::Union{Shader, Nothing}, transform::Union{GLTransform, Nothing}, blend_mode::BlendMode])
))

$(@type_signals(RenderTask, 
))

$(@type_fields())

## Example
```julia
shape = Rectangle(Vector2f(-0.5, -0.5), Vector2f(1, 1))
task = RenderTask(shape)

# euivalent to

task = RenderTask(shape;
    shader = nothing,
    transform = nothing,
    blend_mode = BLEND_MODE_NORMAL
)
```
"""

@document RenderTexture """
# RenderTexture <: TextureObject <: SignalEmitter

Texture that can be bound as a render target. 

See the manual chapter on native rendering for more
information.

$(@type_constructors(
    RenderTexture()
))

$(@type_signals(RenderTexture, 
))

$(@type_fields())

## Example
```julia
# TODO THIS DOES NOT CURRENTLY WORK

using Mousetrap
main() do app::Application

    window = Window(app)

    render_area = RenderArea()
    set_size_request!(render_area, Vector2f(150, 150))

    # stuff we want to render to the texture

    shape = Circle(Vector2f(0, 0), 1.0, 16)
    shape_task = RenderTask(shape)

    # all objects necessary to render the render texture itself, so we can see its contents

    render_texture = RenderTexture()
    render_texture_shape = Rectangle(Vector2f(-1, -1), Vector2f(2, 2))
    set_texture!(render_texture_shape, render_texture)
    render_texture_task = RenderTask(render_texture_shape)

    connect_signal_resize!(render_area, render_texture) do self::RenderArea, width::Integer, height::Integer, texture
        create!(texture, width, height)
        queue_render(self)
    end

    connect_signal_render!(render_area) do self::RenderArea

        # render to exture

        #bind_as_render_target(render_texture)

        clear(self)
        render(shape_task)
        flush(self)

        #unbind_as_render_target(render_texture)

        # now render entire texture to screen

        #clear(self)
        #render(render_texture_task)
        #flush(self)
    end

    set_child!(window, render_area)
    present!(window)
end
```
"""

@document Revealer """
# Revealer <: Widget

Container that plays an animation to reveal or hide its singular child.

$(@type_constructors(
    Revealer([::RevealerTransitionType]),
    Revealer(child::Widget, [::RevealerTransitionType])
))

$(@type_signals(Revealer, 
    revealed
))

$(@type_fields())
"""

@document RotateEventController """
# RotateEventController <: EventController

Recognizes 2-finger rotate gestures (touch-only).

$(@type_constructors(
    RotateEventController()
))

$(@type_signals(RotateEventController, 
    rotation_changed
))

$(@type_fields())

## Example
```julia
rotate_controller = RotateEventController()
connect_signal_rotation_changed!(rotate_controller) do self::RotateEventController, angle_absolute::AbstractFloat, angle_dela::AbstractFloat
    println("angle is now: " * as_degrees(radians(angle_absolute)) * "°")
end
add_controller!(window, rotate_controller)
```
"""

@document Scale """
# Scale <: Widget

Allows users to select a value from a range.

$(@type_constructors(
    Scale(lower::AbstractFloat, upper::AbstractFloat, step_increment::AbstractFloat, [::Orientation])
))

$(@type_signals(Scale, 
    value_changed
))

$(@type_fields())

## Example
```julia
scale = Scale(0, 1, 0.01)
connect_signal_value_changed!(scale) self::Scale
    println("Current value: \$(get_value(scale))")
end
```
"""

@document Scrollbar """
# Scrollbar <: Widget

GUI element typically used to scroll another widget. Connect to the signals of the
underlying adjustment to react to the user scrolling.

$(@type_constructors(
    Scrollbar(::Orientation, ::Adjustment)
))

$(@type_signals(Scrollbar,
))

$(@type_fields())

## Example
```julia
scrollbar = Scrollbar(ORIENTATION_HORIZONTAL, Adjustment(0, 0, 1, 0.01))
connect_signal_value_changed!(get_adjustment(scrollbar)) do self::Adjustment
    println("value is now \$(get_value(self))")
end
"""

@document ScrollEventController """
# ScrollEventController <: EventController

Controller recognizing scrolling gestures by a mouse scrollwheel or touch device.

$(@type_constructors(
    ScrollEventController([kinetic_scrolling_enabled::Bool = false])
))

$(@type_signals(ScrollEventController, 
    scroll_begin,
    scroll,
    scroll_end,
    kinetic_scroll_decelerate
))

$(@type_fields())

## Example
```julia
scroll_controller = ScrollEventController()
connect_signal_scroll!(scroll_controller) do self::ScrollEventController, delta_x::AbstractFloat, delta_y::AbstractFloat
    println("current scroll offset: (\$delta_x, \$delta_y)")
end
add_controller!(window, scroll_controller)
```
"""

@document SelectionModel """
# SelectionModel <: SignalEmitter

Model that governs the current selection of a selectable widget,
such as [`GridView`](@ref), [`ListView`](@ref), or [`Stack`](@ref).

Only if the selection mode is set to anything other than [`SELECTION_MODE_NONE`](@ref)
will the selection model emit its signals.

Use [`get_selection_model`](@ref) to retrieve the model from a selectable widget.

$(@type_constructors(
))

$(@type_signals(SelectionModel, 
    selection_changed
))

$(@type_fields())

## Example
```julia
grid_view = GridView(SELECTION_MODE_SINGLE)
for i in 1:4
    push_back!(grid_view, Label("0\$i"))
end

selection_model = get_selection_model(grid_view)
connect_signal_selection_changed!(selection_model) do x::SelectionModel, position::Integer, n_items::Integer
    println("selected item is now: \$position")
end
set_child!(window, grid_view)
```
"""

@document Separator """
# Separator <: Widget

Simple spacer, fills its allocated area with a solid color.

$(@type_constructors(
    Separator([::Orientation, opacity::AbstractFloat = 1.0])
))

$(@type_signals(Separator, 
))

$(@type_fields())
"""

@document Shader """
# Shader <: SignalEmitter

OpenGL shader program, contains a fragment and vertex shader.

See the manual chapter on native rendering for more
information.

$(@type_constructors(
    Shader()
))

$(@type_signals(Shader, 
))

$(@type_fields())
"""

@document Shape """
# Shape <: SignalEmitter

OpenGL vertex buffer, pre-initialized as one of various shape types.

See the manual chapter on native rendering for more
information.

$(@type_constructors(
    Shape(),
    Point(::Vector2f),
    Points(::Vector{Vector2f}),
    Triangle(::Vector2f, ::Vector2f, ::Vector2f),
    Rectangle(top_left::Vecto2f, size::Vector2f),
    Circle(center::Vector2f, radius::AbstractFloat, n_outer_vertices::Integer),
    Ellipse(center::Vector2f, x_radius::AbstractFloat, y_radius::AbstractFloat, n_outer_vertices),
    Line(::Vector2f, ::Vector2f),
    Lines(::Vector{Pair{Vector2f, Vector2f}}),
    LineStrip(::Vector2{Vector2f}),
    Polygon(::Vector{Vector2f}),
    RectangularFrame(top_left::Vector2f, outer_size::Vector2f, x_width::AbstractFloat, y_width::AbstractFloat),
    CircularRing(center::Vector2f, outer_radius::AbstractFloat, thickness::AbstractFloat, n_outer_vertices::Integer),
    EllipticalRing(center::Vector2f, outer_x_radius::AbstractFloat, outer_y_radius::AbstractFloat, x_thickness::AbstractFloat, y_thickness::AbstractFloat, n_outer_vertices::Unsigned),
    Wireframe(::Vector{Vector2f}),
    Outline(other_shape::Shape)
))

$(@type_signals(Shape, 
))

$(@type_fields())
"""

@document ShortcutEventController """
# ShortcutEventController <: EventController

Triggers actions if their associate shortcuts are recognized. 
Call [`add_action!`](@ref) to specify which actions the controller should manage.

$(@type_constructors(
    ShortcutEventController()
))

$(@type_signals(ShortcutEventController, 
))

$(@type_fields())

## Example
```julia
action = Action("example.action", app)
set_function!(action) do x::Action
    println("example.action activated")
end

add_shortcut!(action, "<Control>space")
# activate action when the user presses Control + Space

shortcut_controller = ShortcutEventController()
add_action!(shortcut_controller, action)

add_controller!(window, shortcut_controller)
```
"""

@document ShortcutTrigger """
# ShortcutTrigger

String expressing a combination of zero or more modifier 
keys, enclosed in `<>`, followed by exactly one non-modifier 
key. 

See the section on `ShortctuEventController` in the manual
chapter on event handling for more information.

$(@type_constructors(
    ShortcutTrigger(::String)
))

$(@type_fields(
))
"""

@document SignalEmitter abstract_type_docs(SignalEmitter, Any, """
# SignalEmitter <: Any

Object that can emit signals.

Any signal emitter is memory-managed independently of Julia, once its
internal reference counter reaches zero, it is safely deallocated. Julia
users do not have to worry about keeping any signal emitters in scope, it
is done automatically.
""")

@document SingleClickGesture abstract_type_docs(SingleClickGesture, Any, """
# SingleClickGesture <: EventController

Specialized type of `EventController` that provides the following functions:

+ [`get_current_button`](@ref)
+ [`get_only_listens_to_button`](@ref)
+ [`set_only_listens_to_button!`](@ref)
+ [`set_touch_only!`](@ref)
""")

@document SpinButton """
# SpinButton <: Widget

Widget with a value-entry and two buttons.

$(@type_constructors(
    SpinButton(lower::Number, upper::Number, step_increment::Number, [orientation::Orientation])
))

$(@type_signals(SpinButton, 
    value_changed
))

$(@type_fields())
"""

@document Spinner """
# Spinner <: Widget

Graphical widget that signifies that a process is busy. Set 
[`set_is_spinning!`](@ref)  to `true` to start the spinning animation.

$(@type_constructors(
    Spinner()
))

$(@type_signals(Spinner, 
))

$(@type_fields())
"""

@document Stack """
# Stack <: Widget

Selectable widget that always shows exactly one of its children. 
Use [`StackSwitcher`](@ref) or [`StackSidebar`](@ref) to provide a
way for users to choose the page of the stack.

Connect to the signals of the [`SelectionModel`](@ref) provided by [`get_selection_model`](@ref)
to track which stack page is currently selected.

$(@type_constructors(
    Stack()
))

$(@type_signals(Stack, 
))

$(@type_fields())

## Example
```julia
stack = Stack()

add_child!(stack, Label("Page 01"), "Page 01")
add_child!(stack, Label("Page 02"), "Page 02")
add_child!(stack, Label("Page 03"), "Page 03")

stack_switcher = StackSwitcher(stack)

box = Box(ORIENTATION_VERTICAL)
push_back!(box, stack)
push_back!(box, stack_switcher)
set_child!(window, box)
```
"""

@document StackID """
# StackID

ID that uniquely identifies a page of a [`Stack`](@ref). Will be used as the page title for [`StackSwitcher`](@ref) and [`StackSidebar`](@ref).

$(@type_constructors(
))

$(@type_fields(
))
"""

@document StackSidebar """
# StackSidebar <: Widget

Widget that allows users to select a page of a [`Stack`](@ref).

$(@type_constructors(
    StackSidebar(::Stack)
))

$(@type_signals(StackSidebar, 
))

$(@type_fields())
"""

@document StackSwitcher """
# StackSwitcher <: Widget

Widget that allows users to select a page of a [`Stack`](@ref).

$(@type_constructors(
    StackSwitcher(::Stack)
))

$(@type_signals(StackSwitcher, 
))

$(@type_fields())
"""

@document StylusEventController """
# StylusEventController <: SingleClickGesture <: EventController

Controller handling events from a stylus devices, such as drawing tablets.

Has access to many manufacturer specific sensors, see the section on `StylusEventController`
in the manual chapter on event handling for more information.

$(@type_constructors(
    StylusEventController()
))

$(@type_signals(StylusEventController, 
    stylus_up,
    stylus_down,
    proximity,
    motion
))

$(@type_fields())

## Example
```julia
stylus_controller = StylusEventController()
connect_signal_motion!(stylus_controller) do self::StylusEventController, x::AbstractFloat, y::AbstractFloat
    println("stylus position detected at (\$x, \$y)")
end
add_controller!(window, stylus_controller)
```
"""

@document SwipeEventController """
# SwipeEventController <: SingleClickGesture <: EventController

Recognizes swipe gestures (touch-only).

$(@type_constructors(
    SwipeEventController())
))

$(@type_signals(SwipeEventController, 
    swipe
))

$(@type_fields())

## Example
```julia
swipe_controller = SwipeEventController()
connect_signal_swipe!(swipe_controller) do self::SwipeEventController, x_velocity::AbstractFloat, y_velocity::AbstractFloat
    print("swiping ")
    
    if (y_velocity < 0)
        print("up ")
    elseif (y_velocity > 0)
        print("down ")
    end
    
    if (x_velocity < 0)
        println("left")
    elseif (x_velocity > 0)
        println("right")
    end
end
add_controller!(window, swipe_controller)
```
"""

@document Switch """
# Switch <: Widget

Widget with a binary state, emits signal `active` when triggered.

$(@type_constructors(
    Switch()
))

$(@type_signals(Switch, 
    switched
))

$(@type_fields())
"""

@document TextView """
# TextView <: Widget

Multi-line text entry. 

$(@type_constructors(
    TextVew()
))

$(@type_signals(TextView, 
    text_changed
))

$(@type_fields())

## Example
```julia
text_view = TextView()
set_text!(text_view, "Write here")
connect_signal_text_changed!(text_view) do self::TextView
    println("text is now: \$(get_text(self))")
end
```
"""

@document Texture """
# Texture <: TextureObject <: SignalEmitter

OpenGL Texture. 

See the manual chapter on native rendering for more
information.

$(@type_constructors(
    Texture()
))

$(@type_signals(Texture, 
))

$(@type_fields())
"""

@document TextureObject """
# TextureObject

Object that can be bound as a texture. Use [`set_texture!`](@ref) to associate 
it with a [`Shape`](@ref).

See the manual chapter on native rendering for more
information.
"""

@document Time """
# Time

Object representing a duration, nanoseconds precision, may be negative.

$(@type_constructors(
    nanoseconds(::Int64),
    microseconds(::Number),
    milliseconds(::Number),
    seconds(::Number),
    minutes(::Number)
))

$(@type_fields(
))

## Example
```julia
# convert seconds to microseconds
println(as_microseconds(seconds(3.14159)))
```
"""

@document ToggleButton """
# ToggleButton <: Widget

Button with a boolean state. Emits signal `toggled` when its state changes.

$(@type_constructors(
    ToggleButton(),
    ToggleButton(label::Widget),
    ToggleButton(::Icon)
))

$(@type_signals(ToggleButton, 
    toggled,
    clicked
))

$(@type_fields())

## Example
```julia
toggle_button = ToggleButton()
connect_signal_toggled!(toggle_button) do self::ToggleButton
    println("state is now: " get_is_active(self))
end
set_child!(window, toggle_button)
```
"""

@document TypedFunction """
# TypedFunction

Object used to invoke an arbitrary function using the given signature. This wrapper
will automatically convert any arguments and return values to the types specified as the signature,
unless impossible, at which point an assertion error will be thrown on instantiation.

In this way, it can be used to assert a functions signature at compile time.

$(@type_constructors(
))

$(@type_fields(
))

## Example

```julia
as_typed = TypedFunction(Int64, (Integer,)) do(x::Integer)
    return string(x)
end
as_typed(12) # returns 12, because "12" will be converted to given return type, Int64
```
"""

@document Vector2 """
# Vector2{T}

Vector with 2 components, all operations are component-wise, which mimicks GLSL.

$(@type_constructors(
    Vector2{T}(::T, ::T),
    Vector2{T}(both::T)
))

$(@type_fields(
    x::T,
    y::T
))
"""

@document Vector3 """
# Vector3{T}

Vector with 4 components, all operations are component-wise, which mimicks GLSL.

$(@type_constructors(
    Vector3{T}(::T, ::T, ::T),
    Vector3{T}(all::T)
))

$(@type_fields(
    x::T,
    y::T,
    z::T
))
"""

@document Vector4 """
# Vector4{T}

Vector with 4 components, all operations are component-wise, which mimicks GLSL.

$(@type_constructors(
    Vector4{T}(::T, ::T, ::T, ::T),
    Vector4{T}(all::T)
))

$(@type_fields(
    x::T,
    y::T,
    z::T,
    w::T
))
"""

@document Viewport """
# Viewport <: Widget

Container that displays part of its singular child. The 
allocated size of the `Viewport` is independent of that
of its child. 

The user can control which part is shown 
by operating two scrollbars. These  will automatically hide 
or show themself when the users cursor enters the viewport.
This behavior can be influenced by setting the 
[`ScrollbarVisibilityPolicy`](@ref) for one or both of the scrollbars.

`Viewport` can be forced to obey the width and/or height 
of its child by setting [`set_propagate_natural_width!`](@ref) and / or
[`set_propagate_natural_height!`](@ref) to `true`.

The placement of both scrollbars at the same time can be set with [`set_scrollbar_placement!`](@ref).

Connect to the `value_changed` signal of each of the scrollbars [`Adjustment`](@ref)
in order to react to the user scrolling the `Viewport`.

$(@type_constructors(
    Viewport()
))

$(@type_signals(Viewport, 
    scroll_child
))

$(@type_fields())
"""

@document Widget abstract_type_docs(Widget, Any, """
# Widget <: SignalEmitter

Superclass of all renderable entities in Mousetrap. Like all
[`SignalEmitter`](@ref)s, a widgets lifetime is managed automatically.

Widgets have a large number of properties that influence their 
size and position on screen. See the manual chapter on widgets 
for more information.

In order for an object to be treated as a widget, it needs to subtype 
this abstract type and define [`Mousetrap.get_top_level_widget`](@ref). See the 
manual section on compound widgets in the chapter on widgets for more information.

All widgets share the following signals, where `T` is the subclass 
of `Widget`. For example, signal `realize` of class `Label` has the 
signature `(::Label, [::Data_t]) -> Nothing`:

$(@type_signals(T,
    realize,
    unrealize,
    destroy,
    hide,
    show,
    map,
    unmap
))
""")

@document Window """
# Window <: Widget

Top-level window, associated with an [`Application`](@ref). Has exactly one child, 
as well as a titlebar widget, which will usually be a [`HeaderBar`](@ref).

When the users window manager requests for a window to close,
signal `close_request` will be emitted, whose return value can 
prevent the window from closing.

$(@type_constructors(
    Window(app::Application)
))

$(@type_signals(Window, 
    close_request,
    activate_default_widget,
    activate_focused_widget
))

$(@type_fields())

## Example
```julia
main() do app::Application
    window = Window(app)
    present!(window)
end
```
"""
