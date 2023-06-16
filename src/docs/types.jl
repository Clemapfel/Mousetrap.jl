const _generate_type_docs = quote
    
    for name in sort(union(
        mousetrap.types, 
        mousetrap.signal_emitters, 
        mousetrap.widgets, 
        mousetrap.event_controllers, 
        mousetrap.abstract_types))

        if name in mousetrap.types
            println("""
            @document $name \"\"\"
                ## $name

                TODO

                \$(@type_constructors(
                ))

                \$(@type_fields(
                ))
            \"\"\"
            """)
        elseif name in mousetrap.abstract_types
            println("""
            @document $name abstract_type_docs($name, Any, \"\"\"
                TODO
            \"\"\")
            """)            
        else
            super = ""

            if name in mousetrap.event_controllers
                super = "EventController"
            elseif name in mousetrap.widgets
                super = "Widget"
            elseif name in mousetrap.signal_emitters
                super = "SignalEmitter"
            else
                continue
            end
            
            println("""
            @document $name \"\"\"
                ## $name <: $super

                TODO

                \$(@type_constructors(
                ))

                \$(@type_signals($name, 
                ))

                \$(@type_fields())
            \"\"\"
            """)
        end
    end
end

@document Action """
    ## Action <: SignalEmitter

    Memory-managed object that wraps a function, registered with an `Application`.

    Depending on whether `set_function!` or `set_stateful_function!`
    was used to register a callback, an action may have an internal
    boolean state.

    Actions can be enabled and disabled using `set_enabled!`. Disabling 
    an action also disables all connected buttons and menu items.

    $(@type_constructors(
        Action(::ActionID, ::Application))
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
    ## Adjustment <: SignalEmitter

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
    ## Angle

    Represents an angle. Use `as_radians` and `as_degrees` to convert
    it to a number.

    $(@type_constructors(
        radians(::AbstractFloat) -> Angle,
        degrees(::AbstractFloat) -> Angle
    ))

    $(@type_fields(
    ))
"""

@document Application """
    ## Application <: SignalEmitter

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
    ## AspectFrame <: Widget

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
    ## AxisAlignedRectangle

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
    ## Box <: Widget

    Widget that aligns its children in a row (or column).

    $(@type_constructors(
        Box(::Orientation)
    ))

    $(@type_signals(Box, 
    ))

    $(@type_fields())
"""

@document Button """
    ## Button <: Widget

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
    ## CenterBox <: Widget

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
    ## CheckButton <: Widget

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
    ## ClickEventController <: EventController

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
    ## Clipboard <: SignalEmitter

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
    ## Clock <: SignalEmitter

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
    ## ColumnView <: Widget

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
    ## ColumnViewColumn <: SignalEmitter

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
    ## DragEventController <: EventController

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
    ## DropDown <: Widget

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
    push_back!(drop_down, Label("Item 01 List Label"), Label("Item 01")) do x::DropDown
       println("Item 01 selected") 
    end

    push_back!(drop_down, Label("Item 02 List Label"), Label("Item 02")) do x::DropDown
        println("Item 02 selected") 
    end
    
    set_child!(window, drop_down)
    ```
"""

@document DropDownItemID """
    ## DropDownItemID

    ID of a dropdown item, keep track of this in order to 
    identify items in an position-independent manner

    $(@type_constructors()
    ))

    $(@type_fields(
    ))
"""

@document Entry """
    ## Entry <: Widget

    Single-line text entry. Activated when the user 
    presses the entre key while the cursor is inside 
    text input area.

    $(@type_constructors(
        Entry()
    ))

    $(@type_signals(Entry, 
        :activate, 
        :text_changed
    ))

    $(@type_fields())
"""

@document EventController abstract_type_docs(EventController, Any, """
    Superclass of all event controllers. Use `add_controller(::Widget, ::EventController)`
    to connect an event controller to any widget, in order for it
    to start receiving events while the widget holds input focus.
""")

@document Expander """
    ## Expander <: Widget

    Collapsible item, has a label- and child-widget.

    $(@type_constructors(
        Expander()
    ))

    $(@type_signals(Expander, 
        :activate
    ))

    $(@type_fields())
"""

@document FileChooser """
    ## FileChooser <: SignalEmitter

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
    ## FileDescriptor <: SignalEmitter

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
    ## FileFilter <: SignalEmitter

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
    ## FileMonitor <: SignalEmitter

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
    ## Fixed <: Widget

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
    ## FocusEventController <: EventController

    Emits its signals when the controlled widget gains or 
    looses input focus.

    $(@type_constructors(
        FocusEventController()
    ))

    $(@type_signals(FocusEventController, 
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
    ## Frame <: Widget

    Widget that draws a black outline with rounded corners around
    its singular child.

    $(@type_constructors(
    ))

    $(@type_signals(Frame, 
        Frame()
    ))

    $(@type_fields())
"""

@document FrameClock """
    ## FrameClock <: SignalEmitter

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
    ## GLTransform <: SignalEmitter

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
    ## Grid <: Widget

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
    ## GridView <: Widget

    Selectable container that arranges its children in an uniform 
    grid.

    $(@type_constructors(
        GridView(::Orientation, [::SelectionMode])
    ))

    $(@type_signals(GridView, 
        :activate
    ))

    $(@type_fields())
"""

@document GroupID """
    ## GroupID

    ID of a group inside a `KeyFile`. Use `.`
    to deliminate nested groups, as each key-value
    pair in a `KeyFile` has to be inside exactly 
    1 group.

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document HSVA """
    ## HSVA

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
    ## HeaderBar <: Widget

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
"""

@document Icon """
    ## Icon

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document IconID """
    ## IconID

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document IconTheme """
    ## IconTheme

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Image """
    ## Image

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document ImageDisplay """
    ## ImageDisplay <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(ImageDisplay, 
    ))

    $(@type_fields())
"""

@document KeyCode """
    ## KeyCode

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document KeyEventController """
    ## KeyEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(KeyEventController, 
    ))

    $(@type_fields())
"""

@document KeyFile """
    ## KeyFile <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(KeyFile, 
    ))

    $(@type_fields())
"""

@document KeyID """
    ## KeyID

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Label """
    ## Label <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Label, 
    ))

    $(@type_fields())
"""

@document LevelBar """
    ## LevelBar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(LevelBar, 
    ))

    $(@type_fields())
"""

@document ListView """
    ## ListView <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(ListView, 
    ))

    $(@type_fields())
"""

@document ListViewIterator """
    ## ListViewIterator

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document LogDomain """
    ## LogDomain

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document LongPressEventController """
    ## LongPressEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(LongPressEventController, 
    ))

    $(@type_fields())
"""

@document MenuBar """
    ## MenuBar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(MenuBar, 
    ))

    $(@type_fields())
"""

@document MenuModel """
    ## MenuModel <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(MenuModel, 
    ))

    $(@type_fields())
"""

@document ModifierState """
    ## ModifierState

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document MotionEventController """
    ## MotionEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(MotionEventController, 
    ))

    $(@type_fields())
"""

@document Notebook """
    ## Notebook <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Notebook, 
    ))

    $(@type_fields())
"""

@document Overlay """
    ## Overlay <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Overlay, 
    ))

    $(@type_fields())
"""

@document PanEventController """
    ## PanEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(PanEventController, 
    ))

    $(@type_fields())
"""

@document Paned """
    ## Paned <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Paned, 
    ))

    $(@type_fields())
"""

@document PinchZoomEventController """
    ## PinchZoomEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(PinchZoomEventController, 
    ))

    $(@type_fields())
"""

@document Popover """
    ## Popover <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Popover, 
    ))

    $(@type_fields())
"""

@document PopoverButton """
    ## PopoverButton <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(PopoverButton, 
    ))

    $(@type_fields())
"""

@document PopoverMenu """
    ## PopoverMenu <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(PopoverMenu, 
    ))

    $(@type_fields())
"""

@document ProgressBar """
    ## ProgressBar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(ProgressBar, 
    ))

    $(@type_fields())
"""

@document RGBA """
    ## RGBA

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document RenderArea """
    ## RenderArea <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(RenderArea, 
    ))

    $(@type_fields())
"""

@document RenderTask """
    ## RenderTask <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(RenderTask, 
    ))

    $(@type_fields())
"""

@document RenderTexture """
    ## RenderTexture <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(RenderTexture, 
    ))

    $(@type_fields())
"""

@document Revealer """
    ## Revealer <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Revealer, 
    ))

    $(@type_fields())
"""

@document RotateEventController """
    ## RotateEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(RotateEventController, 
    ))

    $(@type_fields())
"""

@document Scale """
    ## Scale <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Scale, 
    ))

    $(@type_fields())
"""

@document ScrollEventController """
    ## ScrollEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(ScrollEventController, 
    ))

    $(@type_fields())
"""

@document Scrollbar """
    ## Scrollbar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Scrollbar, 
    ))

    $(@type_fields())
"""

@document SelectionModel """
    ## SelectionModel <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(SelectionModel, 
    ))

    $(@type_fields())
"""

@document Separator """
    ## Separator <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Separator, 
    ))

    $(@type_fields())
"""

@document Shader """
    ## Shader <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Shader, 
    ))

    $(@type_fields())
"""

@document Shape """
    ## Shape <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Shape, 
    ))

    $(@type_fields())
"""

@document ShortcutEventController """
    ## ShortcutEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(ShortcutEventController, 
    ))

    $(@type_fields())
"""

@document ShortcutTrigger """
    ## ShortcutTrigger

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document SignalEmitter abstract_type_docs(SignalEmitter, Any, """
    TODO
""")

@document SingleClickGesture abstract_type_docs(SingleClickGesture, Any, """
    TODO
""")

@document SpinButton """
    ## SpinButton <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(SpinButton, 
    ))

    $(@type_fields())
"""

@document Spinner """
    ## Spinner <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Spinner, 
    ))

    $(@type_fields())
"""

@document Stack """
    ## Stack <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Stack, 
    ))

    $(@type_fields())
"""

@document StackID """
    ## StackID

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document StackSidebar """
    ## StackSidebar <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(StackSidebar, 
    ))

    $(@type_fields())
"""

@document StackSwitcher """
    ## StackSwitcher <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(StackSwitcher, 
    ))

    $(@type_fields())
"""

@document StylusEventController """
    ## StylusEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(StylusEventController, 
    ))

    $(@type_fields())
"""

@document SwipeEventController """
    ## SwipeEventController <: EventController

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(SwipeEventController, 
    ))

    $(@type_fields())
"""

@document Switch """
    ## Switch <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Switch, 
    ))

    $(@type_fields())
"""

@document TextView """
    ## TextView <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(TextView, 
    ))

    $(@type_fields())
"""

@document Texture """
    ## Texture <: SignalEmitter

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Texture, 
    ))

    $(@type_fields())
"""

@document Time """
    ## Time

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document ToggleButton """
    ## ToggleButton <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(ToggleButton, 
    ))

    $(@type_fields())
"""

@document TypedFunction """
    ## TypedFunction

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
    ## Vector2

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector2f """
    ## Vector2f

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector2i """
    ## Vector2i

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector2ui """
    ## Vector2ui

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector3 """
    ## Vector3

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector3f """
    ## Vector3f

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector3i """
    ## Vector3i

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector3ui """
    ## Vector3ui

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector4 """
    ## Vector4

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector4f """
    ## Vector4f

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector4i """
    ## Vector4i

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Vector4ui """
    ## Vector4ui

    TODO

    $(@type_constructors(
    ))

    $(@type_fields(
    ))
"""

@document Viewport """
    ## Viewport <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Viewport, 
    ))

    $(@type_fields())
"""

@document Widget abstract_type_docs(Widget, Any, """
    TODO
""")

@document Window """
    ## Window <: Widget

    TODO

    $(@type_constructors(
    ))

    $(@type_signals(Window, 
    ))

    $(@type_fields())
"""
