
@document Action """
# Action <: SignalEmitter

Memory-managed object that wraps a function, registered with an `Application`.

Depending on whether `set_function!` or `set_stateful_function!`
was used to register a callback, an action may have an internal
boolean state.

Actions can be enabled and disabled using `set_enabled!`. Disabling 
an action also disables all connected buttons and menu items.

$(@type_constructors(
Action(::ActionID, ::Application),
Action(stateless_function, ::ActionID, ::Application)
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
activate(action)
```
"""

@document Adjustment """
# Adjustment <: SignalEmitter

Object that represents a range of values. Changing the value or 
property of the `Adjusment` will change the value or property of the
corresponding widget, and vice-versa.

$(@type_constructors(
    Adjustment(value::Number, lower::Number, upper::Number, increment::Number)
))

$(@type_signals(Adjusment, 
    value_changed,
    properties_changed
))

$(@type_fields())
"""

@document Angle """
# Angle

Represents an angle. 

Use [`radians`](@ref) or [`degrees`](@ref) to construct
an object of this type.

[`as_radians`](@ref) and [`as_degrees`](@ref) allow for 
converting an angle to the respective unit.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document Application """
# Application <: SignalEmitter

Used to register an application with the users OS. When all 
windows of an application are close, the application exits.

Note that side effects can occur when two applications with the
same ID are registered on the machine at the same time, as both
instances may share resources.

$(@type_constructors(
    Appication(::ApplicationID)
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
    window = Window(app)
    present!(window)
end
run!(app)
```
"""

@document AspectFrame """
# AspectFrame <: Widget

Container widget with a single child, regulates 
its childs size such that it always adheres to the given 
aspect ratio.

$(@type_constructors(
    AspectFrame(width_to_height::AbstractFloat)
))

$(@type_signals(AspectFrame, 
))

$(@type_fields())
"""

@document AxisAlignedRectangle """
# AxisAlignedRectangle

Axis aligned bounding box. Defined by its top-left 
corner and its size.

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

Widget that aligns its children in a row (or column).

$(@type_constructors(
    Box(::Orientation)
))

$(@type_signals(Box, 
))

$(@type_fields())
"""

@document Button """
# Button <: Widget

Widget that, when clicked, invokes its connected 
`Action` and/or signal handler. Has exactly one child,
which is its label.

$(@type_constructors(
    Button()
))

$(@type_signals(Button, 
    activate,
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
    CenterBox()
))

$(@type_signals(CenterBox, 
))

$(@type_fields())
"""

@document CheckButton """
# CheckButton <: Widget

Widget that contains an elemne the user can check or uncheck.
For GTK4.8 or later, `CheckButton` furthermore has an optional
child, which is displayed next to the check mark element.

$(@type_constructors(
    CheckButton()
))

$(@type_signals(CheckButton, 
    toggled,
    activated
))

$(@type_fields())

## Example
```julia
check_button = CheckButton()
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

@document ClickEventController """
# ClickEventController <: SingleClickGesture <: EventController

Handles one or more mouse-button or touchpad presses in series. 

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

Object that allows accessing of the data currently inside the users clipboard. 
`Clipboard` supports retreavel as a `String` or as an `Image`.

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

Object used to keep track of time. Nanosecond precision

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

@document ColumnView """
# ColumnView <: Widget

Widget that arranges its children as a table with a variable number of columns 
and rows.

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

    # fill each column with labels
    for row_i in 1:3
        set_widget!(column_view, column, row_i, Label("\$row_i | \$column_i"))
    end
end

# or push an entire row at once
# any widget can be put into any cell
push_back_row!(column_view, Button(), CheckButton(), Entry(), Separator())        
set_child!(window, column_view)
```
"""

@document ColumnViewColumn """
# ColumnViewColumn <: SignalEmitter

Class representing a column of `ColumnView`. Has a label, any number of children 
which represent all rows in this column (1-indexed), and an optional header menu, 
which can be accessed by clicking the columns title.

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

Recongizes drag gesture, a gesture where the user click a 
point inside the allocated area of the widget holding this controller,
then, while keeping the mouse button depressed, moves the cursor.

$(@type_constructors(
    DragEventController()
))

$(@type_signals(DragEventController, 
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

Widget that, when click, presents a vertical list of buttons. If a button 
is clicked, its corresponding callback function will be invoked, and the
dropdown will selected on that button.

Each button has two associated widgets, the **list widget** is displayed while the
list of buttons is open, the **label widget** is displayed while the 
button is currently selected.

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

ID of a dropdown item, keep track of this in order to 
identify items in an position-independent manner.

$(@type_constructors()
))

$(@type_fields(
))
"""

@document Entry """
# Entry <: Widget

Single-line text entry. Activated when the user 
presses the enter key while the cursor is inside 
text input area.

$(@type_constructors(
    Entry()
))

$(@type_signals(Entry, 
    activate, 
    text_changed
))

$(@type_fields())
"""

@document EventController abstract_type_docs(EventController, Any, """
# EventController <: SignalEmitter

Superclass of all event controllers. Use `add_controller(::Widget, ::EventController)`
to connect an event controller to any widget, in order for it
to start receiving events while the widget holds input focus.
""")

@document Expander """
# Expander <: Widget

Collapsible item, has a label- and child-widget.

$(@type_constructors(
    Expander()
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
(::FileChooser, files::Vector{FileDescriptor}, [::Data_t]) -> Cvoid
```
using `on_accept!`. When the user makes a selection, this function 
will be invoked and `files` will contain one or more selected files.

The file choosers layout and which items the user can select
depends on the `FileChooserAction` specified on construction.

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

Read-only object that points to a file or folder 
at a specific location on disk. Note that there is no 
guarantee that file or folder exists.

$(@type_constructors(
    FileDescriptor(path::String)
))

$(@type_signals(FileDescriptor, 
))

$(@type_fields())

## Example
```julia
# list file types of all files in current directory
current_dir = FileDescriptor(".")
for file in get_children(current_dir)
    println(get_name(file) * ":\t" * get_content_type(file))
end
```
"""

@document FileFilter """
# FileFilter <: SignalEmitter

File used for `FileChooser`. Only files that 
pass the filter will be available to be selected.
If multiple filters are supplied, the user can 
select from a list of them using a dropdown in 
the `FileChooser` dialog.

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

Object that monitors a file location on disk. If 
anything about that location changes, for example if
the content of the file is modified, `FileMonitor` 
will invoke the registered callback. We can differentiate
between event types using the `FileMonitorEvent` supplied
to the callback.

The callback is registered using `on_file_changed!` and is
required to have the following signature:

```
(::FileMonitor, ::FileMonitorEvent, self::FileDescriptor, other::FileDescriptor, [::Data_t]) -> Cvoid
```

See the chapter on files for more information.

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

Container widget that places its children at a specified position. 
Use of this widget is usually discouraged because it does not allow
for automatic resizing or alignment.

$(@type_constructors(
    Fixed()
))

$(@type_signals(Fixed, 
))

$(@type_fields())
"""

@document FocusEventController """
# FocusEventController <: EventController

Emits its signals when the controlled widget gains or 
looses input focus.

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
connect_signal_focus_gained(focus_controller) do self::FocusController
    println("Gained Focus")
end
add_controller(widget, focus_controller)
```
"""

@document Frame """
# Frame <: Widget

Widget that draws a black outline with rounded corners around
its singular child.

$(@type_constructors(
    Frame()
))

$(@type_signals(Frame, 
))

$(@type_fields())
"""

@document FrameClock """
# FrameClock <: SignalEmitter

Signal emitter that emits its signals in a way that 
is synchronized with the render cycle of each frame
the widget is drawn.

$(@type_constructors(
))

$(@type_signals(FrameClock, 
))

$(@type_fields())

## Example
```julia
frame_clock = get_frame_clock(widget)
connect_signal_paint(frame_clock) do x::FrameClock
    println("Widget was drawn.")
end
```
"""

@document GLTransform """
# GLTransform <: SignalEmitter

Transform in 3D spaces. Uses OpenGL coordinates, it should 
therefore only be used to modify vertices of `Shape`.

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

Container that arranges its children in a non-uniform grid. 
Each child widget has a cell position (1-indexed), a width 
and height, measured in number of cells.

$(@type_constructors(
    Grid()  
))

$(@type_signals(Grid, 
))

$(@type_fields())

## Example
```julia
grid = Grid()
insert!(grid, Label("Label"), 1, 1, 1, 1)
insert!(grid, Button(), 1, 2, 1, 1)
insert!(grid, Separator, 2, 1, 2, 1)
```
"""

@document GridView """
# GridView <: Widget

Selectable container that arranges its children in an uniform 
grid.

$(@type_constructors(
    GridView(::Orientation, [::SelectionMode])
))

$(@type_signals(GridView, 
    activate
))

$(@type_fields())
"""

@document GroupID """
# GroupID

ID of a group inside a `KeyFile`. May not start with a number, 
only roman letter, 0-9, `_`, `-`, and `.` may be used.

Use `.` to deliminate nested groups, as each key-value pair can
only belong to exactly one group.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document HSVA """
# HSVA

Color in hsva format.

$(@type_constructors(
    HSAV(::AbstractFloat, ::AbstractFloat, ::AbstractFloat, ::AbstractFloat)
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

Widget usually used as the titlebar widget of a `Window`.
Has a centered title, the window control buttons, along with 
any number of widgets at the start and at the end of the bar.

$(@type_constructors(
    HeaderBar(),
    HeaderBar(layout::String)
))

$(@type_signals(HeaderBar, 
))

$(@type_fields())

## Example
```julia
# Layout syntax
# any element left of `:` is displayed left of the the title
# only `close`, `minimize`, `maximize` are valid layout elements

header_bar = HeaderBar("close:title,minimize,maximize")
push_front!(header_bar, Button())
set_titlebar_widget!(window, header_bar)
```
"""

@document Icon """
# Icon

Object managing an image file on disk that can be used 
as an icon. Usually, these should be a vector graphics 
or .ico file, though any image file can be loaded.

$(@type_constructors(
    Icon()
))

$(@type_fields(
))
"""

@document IconID """
# IconID

ID of an icon, used by `IconTheme` to refer to icons in 
a file-agnostic way.

$(@type_constructors(
))

$(@type_fields()))
"""

@document IconTheme """
# IconTheme

Manages a folder that strictly adheres to the [freedesktop icon theme specifications](https://specifications.freedesktop.org/icon-theme-spec/icon-theme-spec-latest.html).

$(@type_constructors(
))

$(@type_fields())
"""

@document Image """
# Image

2D image data. Pixel-index are 1-based.

$(@type_constructors(
    Image(),
    Image(path::String),
    Image(width::Integer, height::Integer, [::RGBA])
))

$(@type_fields())
"""

@document ImageDisplay """
# ImageDisplay <: Widget

Widget that displays an `Image`, `Icon`, or image file. Once
constructed, the image data is deep-copied.

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

Identifier of a key. Used for `ShortcutTrigger` syntax 
and when recognizing keys using `KeyEventController`.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document KeyEventController """
# KeyEventController <: EventController

Recognizes keyboard key strokes.

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

GLiba keyfile, allows storing various types
by serializing them.

The following types can be (de)serialized this way:
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

ID of `KeyFile` key-value-pair. My not start with a number, and only 
roman letter, 0-9, and '_' may be used.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document Label """
# Label <: Widget

Static text, multi-or single line. Using `set_ellipsize_mode!`,
`set_wrap_mode!`, and `set_justify_mode!` to influence how text 
is displayed.

Supports [pango markup](https://docs.gtk.org/Pango/pango_markup.html)

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

Bar displaying fraction of a range. If the fraction reaches 75%,
the color of the bar changes. 

$(@type_constructors(
    LevelBar(min::AbstractFloat, max::AbstractFloat)
))

$(@type_signals(LevelBar, 
))

$(@type_fields())
"""

@document ListView """
# ListView <: Widget

Selectable widget that arranges its children in a (possibly nested) list.

$(@type_constructors(
    ListView(::Orientation, [::SelectionMode])
))

$(@type_signals(ListView, 
    selection_changed
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

Iterator returned when inserting an item into a `ListView`. Use this
iterator as an additional argument to insert any item in a nested list
which is a child of the initial top-level item.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document LogDomain """
# LogDomain

Domain of log messages, this will be used to associate log 
message with a specific application or library.

$(@type_constructors(
    LogDomain(::String)
))

$(@type_fields(
))
"""

@document LongPressEventController """
# LongPressEventController <: SingleClickGesture <: EventController

Recognizes long-press gestures, in which the users 
presses a mouse button or touchscreen, then holds that 
press without moving the cursor.

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

View that displays a `MenuModel` as a horizontal bar. 
The `MenuModel` has to have the following structure:
+ all top-level items have to be of type "submenu"

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

Use `MenuBar` or `PopoverMenu` to display the
menu to the user.

The type of menu item is determined by which function
is called to add the item. See the manual chapter on menus
for more information.

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

Holds information about which modifier keys (Control, Alt, Shift)
are currently pressed.

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

Captures cursor motion events.

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
has exactly one child widget and an optional label widget. Pages
can be freely reordered by the user, and one page can be drag-and-dropped
from one `Notebook` instace to another.

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

Widget that has exaclty one "base" child, set via `set_child!`, 
and any number of "overlay" children, added via `add_overlay!`,
which are rendered on top.

If two interactable widgets overlap, only the top-most widget can
receive input events. Using `set_can_respond_to_input!` to disable 
the upper widget, at which point the lower widget underneath can
be interacted with.

$(@type_constructors(
    Overlay()
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

Recognizes pan gestures, in which the user drags 
the cursor of a mouse or touchscreen alonge either horizontal
or vertical axis.

$(@type_constructors(
    PanEventController(::Orientation)
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

Widget with exactly two children, set with `set_start_child!` and `set_end_child!`. 
Draws a solid border between the two, which the user can drag to 
one side or the other to resize both widgets at the same time.

$(@type_constructors(
    Paned()
))

$(@type_signals(Paned, 
))

$(@type_fields())
"""

@document PinchZoomEventController """
# PinchZoomEventController <: EventController

Controller recognizing touch-screen only 2-finger pinch-zoom gestures.

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

@document Popover """
# Popover <: Widget

Specialized type of window with exactly on child. It needs to be 
attach to a different widget, at which point `popup!` and `popdown!`
can be called to present or hide the popover from the user.

`PopoverButton` provides an automated way of showing/hiding the popover.

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

Button that has a pre-build way of revealing a `Popover` or `PopoverMenu`
when clicked. 

$(@type_constructors(
    PopoverButton()
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

Menu view that display its model in a popover window. Use `PopoverButton`
for an automated way of revealing the popover.

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

Loading bar, using `set_fraction!`, which accepts a float in `[0, 1]`
to set the current percentage.

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

OpenGL canvas. See the manual chapter on native rendering for more
information.

$(@type_constructors(
    RenderArea()
))

$(@type_signals(RenderArea,
    render,
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

Task that groups a `Shape`, `Shader`, `GLTransform`, and `BlendMode`,
allowing them to be bound for rendering. 
    
If no shader, transform, and/or blend mode is specified, 
the default shader, identity transform and `BLEND_MODE_NORMAL` will 
be used, respectively.

Use `add_render_task!` to add the task to a `RenderArea`, 
after which it will be automatically be rendered every frame 
the `RenderArea` is visible.

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
# RenderTexture <: SignalEmitter

Texture that can be bound as a render target. See the 
manual chapter on native rendering for more information.

$(@type_constructors(
    RenderTexture()
))

$(@type_signals(RenderTexture, 
))

$(@type_fields())

## Example
```julia
# TODO THIS DOES NOT CURRENTLY WORK

using mousetrap
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

Container that plays an animation reveal or hide its singular child.

$(@type_constructors(
    Revealer(::RevealerTransitionType)
))

$(@type_signals(Revealer, 
    revealed
))

$(@type_fields())
"""

@document RotateEventController """
# RotateEventController <: EventController

Controller recognizing touch-only 2-finger rotate gestures.

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

Widget that allows users to select a value from a range by 
sliding a scale.

$(@type_constructors(
    Scale(lower::AbstractFloat, upper::AbstractFloat, step_increment::AbstractFloat, [::Orientation])
))

$(@type_signals(Scale, 
    value_changed
))

$(@type_fields())
"""

@document ScrollEventController """
# ScrollEventController <: EventController

Controller recognizing mouse-scroll-wheel and 2-finger touchscreen scrolling events.

$(@type_constructors(
    ScrollEventController(; [emit_vertical::Bool = true, emit_horizontal::Bool = true])
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
    return false # do not prevent default handlers from being invoked
end
add_controller!(window, scroll_controller)
```
"""

@document Scrollbar """
# Scrollbar <: Widget

Widget usually used to scroll a window or view. Connect to 
the signals of the `Adjusment` obtained using `get_adjustment`
to react to the user changing the position of the scrollbar

$(@type_constructors(
    Scrollbar()
))

$(@type_signals(Scrollbar, 
))

$(@type_fields())
"""

@document SelectionModel """
# SelectionModel <: SignalEmitter

Model that governs the current selection of a selectable widget,
such as `GridView`, `ListView`, or `Stack`.

Only if the selection mode is set to anything other than `SELECTION_MODE_NONE`
will the selection model emit signals.

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

Represent an OpenGL shader program, which has a bound
vertex and fragment shader. If a shader is not specified 
for one or more of these, the default shader will be used.

To use a shader, it needs to be bound to a `RenderTask` along with 
a shape. Then, when the task is rendered, the shader will be applied
to all vertices / fragments of the shape.

See the manual section on native rendering for more information.

$(@type_constructors(
    Shader()
))

$(@type_signals(Shader, 
))

$(@type_fields())
"""

@document Shape """
# Shape <: SignalEmitter

Represents an OpenGL vertex buffer. A wide variety of 
pre-made shapes are available.

Shapes use the GL coordinate system and need to be bound
to a `RenderTask` in order to be displayed. 

See the manual section on native rendering for more information.

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

Eventcontroller that listens for shortcut key combinations. If one 
is recognized, the corresponding action will be invoked.

It emits no signals, instead, `add_action!` will register and
`Action` with the controller, at which point the controller 
will listen to any shortcuts of the action specified with 
`add_shortcut!(::Action, ::ShortcutTrigger`.

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
keys, enclosed in `<>`, follow by exactly one non-modifier 
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

Object that can emit signals, though it may not necessarily do so.

Additionally, any `SignalEmitter` sub-class is memory-managed completely independently 
of Julia. The Julia-side class is only a thin wrapper that allows us to 
interact with the underlying internal object. This underlying object 
is only finalized when its internal reference count reaches zero.

Because of this, users don't have to worry about keeping track of widgets
or other signal emitters, their life-time is managed automatically.
""")

@document SingleClickGesture abstract_type_docs(SingleClickGesture, Any, """
# SingleClickGesture <: EventController

Specialized type of `EventController` that allows uses to check 
or determine, which mouse button or touchscreen triggered the 1-finger event.
""")

@document SpinButton """
# SpinButton <: Widget

Widget that contains a number entry and two buttons, which 
allows users to pick an exact value from a range.

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

Graphical widget that signifies that a process is busy by 
playing a spinning animation. Use `set_is_spinning!` to 
start or stop the animation.

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
Use `StackSwitcher` or `StackSidebar` to provide a user interface 
for `Stack`. Each stack page has a unique title, which will be 
used to allow the user to pick on of the pages.

Connect to the signals of the `SelectionModel` provided by `get_selection_model!`
to track which stack page is currently selected.

Whenever the stack switches from one page to another, an animation is 
plays. A huge number of animations are available, cf. `StackTransitionType`
for more information.

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

ID of a `Stack` page. Will be used for `StackSwitcher` and `StackSidebar`, 
and when referring to a page in a position-independent manner.

$(@type_constructors(
))

$(@type_fields(
))
"""

@document StackSidebar """
# StackSidebar <: Widget

Widget that allows users to select a page of a `Stack`.

$(@type_constructors(
    StackSidebar(::Stack)
))

$(@type_signals(StackSidebar, 
))

$(@type_fields())
"""

@document StackSwitcher """
# StackSwitcher <: Widget

Widget that allows users to select a page of a `Stack`.

$(@type_constructors(
    StackSwitcher(::Stack)
))

$(@type_signals(StackSwitcher, 
))

$(@type_fields())
"""

@document StylusEventController """
# StylusEventController <: SingleClickGesture <: EventController

Controller handling events from a stylus device, such as a touchpad 
pen.

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

Controller capable of recognizing swipe touchscreen events

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

Ligthswitch-like widget indicating a boolean state. When the switch 
is toggled, signal `activate` is emitted.

$(@type_constructors(
    Switch()
))

$(@type_signals(Switch, 
    activate
))

$(@type_fields())
"""

@document TextView """
# TextView <: Widget

Multi-line text entry. Unlike `Entry`, this 
widget cannot emit signal `activate`. Pressing enter
will create a newline.

Additional, basic text-editor features such as text justification 
and undo/redo are supported.

$(@type_constructors(
    TextVew()
))

$(@type_signals(TextView, 
    text_changed
))

$(@type_fields())
"""

@document Texture """
# Texture <: SignalEmitter

OpenGL Texture. Needs to be bound to a shape 
in order to be rendered.

Textures support a wrap- and scale-mode, see the 
manual section on native rendering for more information.

$(@type_constructors(
    Texture()
))

$(@type_signals(Texture, 
))

$(@type_fields())
"""

@document TextureObject """
# TextureObject

Object that can be bound as a texture. Use `set_texture!(::Shape, ::TextureObject)` to associate 
it with a shape, then the texture can be rendered using `RenderArea`.
"""

@document Time """
# Time

Object representing a duration in time, nanoseconds precision.

$(@type_constructors(
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

Button that will stay toggled when clicked, emitting the 
`toggled` signals.

Like `Button`, it has exactly one child and can optionally
be made circular.

$(@type_constructors(
    ToggleButton()
))

$(@type_signals(ToggleButton, 
))

$(@type_fields())

## Example
```julia
toggle_button = ToggleButton()
connect_signal_toggled!(toggle_button) do self::ToggleButton
    println("state is now: " get_is_activate(self))
end
set_child!(window, toggle_button)
```
"""

@document TypedFunction """
# TypedFunction

Object used to invoke an arbitrary function using the given signature. This wrapper
will automatically convert any arguments and return values to the given types
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

Vector with 2 components.

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

Vector with 3 components.

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

Vector with 4 components.

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
`ScrollbarPolicy` for one or both of the scrollbars.

`Viewport` can be forced to obey the width and/or height 
of its child by setting `set_propagate_natural_width!` and/or
`set_propagate_natural_height!` to `true`.

The placement of both scrollbars can be set by calling `set_scrollbar_placement!`,
which takes a `CornerPlacement`.

Connect to the `value_changed` signal of each of the scrollbars `Adjustment`
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

Superclass of all renderable entities in mousetrap. Like all
`SignalEmitter`s, a widgets lifetime is managed automatically.

Widgets have a large number of properties that influence their 
size and position on screen. See the manual chapter on widgets 
for more information.

All widgets share the following signals, where `T` is the subclass 
of `Widget`. For example, signal `realize` of class `Label` has the 
signature `(::Label, [::Data_t]) -> Cvoid`.

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

Top-level window, associated with an `Application`. If all windows
of an application are closed, it will request to exit.

`Window` is the only widget that does not have a parent.

Windows have a singular child, and an optional titlebar widget, 
which will be inserted into the area in the header bar. This will 
usually be a `HeaderBar`, though any widget can be put there.

When the users window manager requests for a `Window` to close,
signal `close_request` will be emitted, whose return value will
either be `WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE` or `WINDOW_CLOSE_REQUEST_RESULT_DISALLOW_CLOSE`,
the latter of which will prevent the window from closing.

Each window can have a designated default widget, set via `set_default_widget!`.
This widget will be activated when the user activates the window itself. This 
can be useful when constructing dialogs, the "ok" button can be designated 
as the default widget, then, when the dialog is presented to the user,
the user can press enter to immedaitely trigger that button.

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
