####### signal_components.jl

    struct SignalDescriptor
        id::Symbol
        signature::String
        emitted_when::String
    end

    const signal_descriptors = Dict{Symbol, SignalDescriptor}()
    function add_signal(id::Symbol, signature::String, description::String)
        signal_descriptors[id] = SignalDescriptor(id, signature, description)
    end

    void_signature = "[::Data_t]) -> Nothing"

    add_signal(:activate, void_signature, "`Widget::activate()` is called or the widget is otherwise activated")
    add_signal(:startup,  void_signature, "`Application` is in the process of initializing")
    add_signal(:shutdown, void_signature, "`Application` is done initializing and will now start the main render loop")
    add_signal(:update, void_signature, "once per frame, at the start of each render loop")
    add_signal(:paint, void_signature, "once per frame, right before the associated widget is drawn")
    add_signal(:realize, void_signature, "widget is fully initialized and about to be rendered for the first time")
    add_signal(:unrealize, void_signature, "widget was hidden and will seize being displayed")
    add_signal(:destroy, void_signature, "A widgets ref count reaches 0 and its finalizer is called")
    add_signal(:hide, void_signature, "`Widget::hide``is called or a widget becomes no longer visible otherwise")
    add_signal(:show, void_signature, "widget is rendered to the screen for the first time")
    add_signal(:map, void_signature, "widgets size allocation was assigned")
    add_signal(:unmap, void_signature, "widget or one of its parents is hidden")
    add_signal(:close_request, "[::Data_t]) -> allow_close::WindowCloseRequestResult", "mousetrap or the users operating system requests for a window to close")
    add_signal(:close, void_signature, "popover is closed")
    add_signal(:activate_default_widget, void_signature, "widget assigned via Window::set_default_widget is activated is activated")
    add_signal(:activate_focused_widget, void_signature, "widget that currently holds focus is activated")
    add_signal(:clicked, void_signature, "user activates the widget by clicking it with a mouse or touch-device")
    add_signal(:toggled, void_signature, "buttons internal state changes")
    add_signal(:text_changed, void_signature, "underlying text buffer is modified in any way")
    add_signal(:selection_changed, "position::Integer, n_items::Integer, [::Data_t]) -> Nothing", "number or index of selected elements changes")
    add_signal(:key_pressed, "code::KeyCode, modifiers::ModifierState, [::Data_t]) -> should_invoke_default_handlers::Bool", "user pressed a non-modifier key")
    add_signal(:key_released, "code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", "user releases a non-modifier key")
    add_signal(:modifiers_changed, "code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", "user presses or releases a modifier key")
    add_signal(:drag_begin, "start_x::AbstractFloat, start_y::AbstractFloat, [::Data_t]) -> Nothing", "first frame at which a drag gesture is recognized")
    add_signal(:drag, "x_offset::AbstractFloat, y_offset::AbstractFloat, [::Data_t]) -> Nothing", "once per frame while a drag gesture is active")
    add_signal(:drag_begin, "x_offset::AbstractFloat, y_offset::AbstractFloat, [::Data_t]) -> Nothing", "drag gesture seizes to be active")
    add_signal(:click_pressed, "n_presses::Integer, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", "User presses a mouse button or touch-device")
    add_signal(:click_released, "n_presses::Integer, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", "User releases a mouse button or touch-device")
    add_signal(:clip_stopped, void_signature, "once when a series of clicks ends")
    add_signal(:focus_gained, void_signature, "Widget acquires input focus")
    add_signal(:focus_lost, void_signature, "Widget looses input focus")
    add_signal(:pressed, "x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", "long-press gesture is recognized")
    add_signal(:press_cancelled, void_signature, "long-press gesture seizes to be active")
    add_signal(:motion_enter, "x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", "cursor enters allocated area of the widget for the first time")
    add_signal(:motion_enter, "x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", "once per frame while cursor is inside allocated area of the widget")
    add_signal(:motion_enter, void_signature, "cursor leaves allocated area of the widget")
    add_signal(:scale_changed, "scale::AbstractFloat, [::Data_t]) -> Nothing", "distance between two fingers recognized as a pinch-zoom-gesture changes")
    add_signal(:rotation_changed, "angle_absolute_radians::AbstractFloat, angle_delta_radians::AbstractFloat, [::Data_t]) -> Cvoid", "angle between two fingers recognized as a rotate-gesture changes")
    add_signal(:scroll_begin, void_signature, "user initiates a scroll gesture using the mouse scrollwheel or a touch-device")
    add_signal(:scroll, "x_delta::AbstractFloat, y_delta::AbstractFloat, [::Data_t]) -> also_invoke_default_handlers::Bool", "once per frame while scroll gesture is active")
    add_signal(:scroll_end, void_signature, "user seizes scrolling")
    add_signal(:kinetic_scroll_decelerate, "x_velocity::AbstractFloat, y_velocity::AbstractFloat, [::Data_t]) -> Cvoid", "widget is still scrolling due to scrolling \"inertia\"")
    add_signal(:stylus_down, "x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", "stylus makes physical contact with the touchpad")
    add_signal(:stylus_up, "x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", "stylus seizes to make contact with the touchpad")
    add_signal(:proximity, "x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", "stylus enters or leaves maximum distance recognized by the touchpad")
    add_signal(:swipe, "x_velocity::AbstractFloat, y_velocity::AbstractFloat, [::Data_t]) -> Cvoid", "swipe gesture is recognized")
    add_signal(:pan, "::PanDirection, offset::AbstractFloat, [::Data_t]) -> Cvoid", "pan gesture is recognized")
    add_signal(:value_changed, void_signature, "`value` property of underlying adjustment changes")
    add_signal(:properties_changed, void_signature, "any property other than `value` of underlying adjustment changes")
    add_signal(:wrapped, void_signature, "`SpinButton` for whom `is_wrapped` is enabled has its value increased or decreased past the given range")
    add_signal(:scroll_child, "::ScrollType, is_horizontal::Bool, [::Data_t]) -> Cvoid", "user triggers a scroll action")
    add_signal(:resize, "width::Integer, height::Integer, [::Data_t]) -> void", "allocated size of `RenderArea` changes while it is realized")
    add_signal(:activated, void_signature, "`Action` is activated")
    add_signal(:revealed, void_signature, "child is fully revealed (after the animation has finished)")
    add_signal(:page_reordered, "page_index::Integer, [::Data_t]) -> Cvoid", "page of `Notebook` changes position")
    add_signal(:page_added, "page_index::Integer, [::Data_t]) -> Cvoid", "number of pages increases while the widget is realized")
    add_signal(:page_reordered, "page_index::Integer, [::Data_t]) -> Cvoid", "number of pages decreases while the widget is realized")
    add_signal(:page_reordered, "page_index::Integer, [::Data_t]) -> Cvoid", "currently visible page changes")
    add_signal(:items_changed, "position::Integer, n_removed::Integer, n_added::Integet, [::Data_t]) -> Cvoid", "list of items is modified")

    function generate_signal_table(object_name::Symbol, signal_names::Symbol...) ::String
        out = "| Signal ID | Signature | Emitted when...|\n|---|---|---|\n"
        for signal_id in signal_names
            descriptor = signal_descriptors[signal_id]
            out *= "| `" * string(descriptor.id) * "` | `(instance::" * string(object_name) * ", " * descriptor.signature * "` | " * descriptor.emitted_when * "|\n"
        end
        return out;
    end

    macro document(object, string)
        out = Expr(:block)
        push!(out.args, :(@doc($string, $object)))
        return out
    end

    const CONSTRUCTORS = "## Constructors"
    const SIGNALS = "## Signals"
    const EXAMPLE = "## Example"
    const ARGUMENTS = "## Arguments"
    const METHODS = "## Methods"
    const ENUM_VALUES = "## Enum Values"
    const FIELDS = "## Public Fields"

####### types.jl

    @document SignalEmitter """
    ## SignalEmitter
    
    Object that can emit signals. All signal emitters are managed externally, they will stay allocated
    until their internal reference count reaches 0. This means whether an objects finalizer will be called
    is independent of whether the Julia-side object stays in memory or not.
    """

    @document Widget """
    ## Widget <: SignalEmitter  

    Object that can be rendered on screen. All widgets share a number of signals:

    $SIGNALS
    $(generate_signal_table(:T, 
        :realize, 
        :unrealize, 
        :destroy, 
        :hide, 
        :show, 
        :map, 
        :unmap
    ))

    Where `T` is the type subtyping `Widget`. 

    $EXAMPLE
    ```julia
    label = Label("Labels are Widgets")
    connect_signal_realize!(label) do x::Label
        println("Label was realized")
    end
    ```
    """

    @document EventController """
    ## EventController <: SignalEmitter

    Supertype of all event controllers. 
    """

####### log.jl

    @document LogDomain """
    Identifier of a log domain. Should only contain roman letters, numbers, `.`, `_` and/or `-`

    $EXAMPLE
    ```julia
    const FOO_DOMAIN = "foo-application"
    @log_info FOO_DOMAIN "Log domain succesfully assigned"
    ```
    """

    @document log_debug """
    `@log_debug(::LogDomain, ::String)`

    Send a message with log-level "debug". Debug message will not be 
    shown unless `set_surpress_debug` for the given log domain was set to `false`
    """

    @document log_info """
    `@log_info(::LogDomain, ::String)`

    Send a message with log-level "info". Info message will not be 
    shown unless `set_surpress_info` for the given log domain was set to `false`
    """

    @document log_warning """
    `@log_wraning(::LogDomain, ::String)`

    Send a message with log-level "warning". Warnings should be reserved to situations that cannot 
    cause crahes or undefined behavior, but are still severe enough that the user needs to be notified.
    """

    @document log_critical """
    `@log_critical(::LogDomain, ::String)`

    Send a message with log-level "critical". Critical messages should be reserved to severe issues that 
    would usually cause undefined behavior, but where prevented from doing so by the developer. Critical 
    situations should be incapable of ending runtime in any way.
    """

    @document log_fatal """
    `@log_fatal(::LogDomain, ::String)`

    Send a message with log-level "fatal" and **immediately end runtime**. This should only be used if 
    an unrecoverable and severe error occurred.
    """

    @document set_surpress_debug """
    `set_surpress_debug(::LogDomain:, ::Bool) -> Cvoid`

    If `true`, allow printing of log messages with level "debug" for the given log domain. Defaults to `false`.
    """

    @document get_surpress_debug """
    `get_surpress_debug(::LogDomain) -> Bool`

    Get whether log message with level "debug" are surpressed for the given log domain.
    """

    @document set_surpress_info """
    `set_surpress_info(::LogDomain:, ::Bool) -> Cvoid`

    If `true`, allow printing of log messages with level "info" for the given log domain. Defaults to `false`.
    """

    @document get_surpress_info """
    `get_surpress_info(::LogDomain) -> Bool`

    Get whether log message with level "info" are surpressed for the given log domain.
    """

    @document set_log_file """
    `set_log_file(path::String) -> Bool`

    Set file to which all log message should be forward to. If the file does not yet exist, it is created. If it does exist, 
    log message are appended, no previous information will be overwritten.

    Return `true` if the file was succesfully opened, `false` otherwise

    $EXAMPLE
    ```julia
    const path = "/absolute/path/to/log_file.log"
    if !set_log_file(path)
        @log_critical MY_LOG_DOMAIN "In set_log_file: Unable to open file at $path for logging"
    end
    ```
    """

###### vector.jl

    @document Vector2 """
    ## Vector2{T <: Number}

    2-dimensional vector

    $CONSTRUCTORS
    + `Vector2{T}(x::T, y::T)`
    + `Vector2{T}(all::T)`

    $FIELDS
    + `x::T`
    + `y::T`
    """

    @document Vector3 """
    ## Vector3{T <: Number}

    3-dimensional vector

    $CONSTRUCTORS
    + `Vector3{T}(x::T, y::T, z::T)`
    + `Vector3{T}(all::T)`

    $FIELDS
    + `x::T`
    + `y::T`
    + `z::T`
    """

    @document Vector4 """
    ## Vector4{T <: Number}

    4-dimensional vector

    $CONSTRUCTORS
    + `Vector4{T}(x::T, y::T, z::T, w::T)`
    + `Vector4{T}(all::T)`

    $FIELDS
    + `x::T`
    + `y::T`
    + `z::T`
    + `w::T`
    """

####### geometry.jl

    @document Rectangle """
    ## Rectangle

    Axis-aligned rectangle, defined by a top-left point and its width and height.

    $FIELDS
    + `top_left::Vector2f`
    + `size::Vector2f`

    $CONSTRUCTORS
    `Rectangle(top_left::Vector2f, size::Vector2f)`
    """

####### time.jl

    @document Time """
    ## Time

    Duration of time, nanosecond precision.

    $FIELDS
    (no public fields)

    $CONSTRUCTORS
    (no public constructors)
    """

    @document minutes """
    `minutes(::AbstracFloat) -> Time`

    Construct time as number of minutes.
    """

    @document seconds """
    `seconds(::AbstracFloat) -> Time`

    Construct time as number of seconds.
    """

    @document milliseconds """
    `milliseconds(::AbstracFloat) -> Time`

    Construct time as number of milliseconds.
    """

    @document microseconds """
    `microseconds(::AbstracFloat) -> Time`

    Construct time as number of microseconds.
    """

    @document nanoseconds """
    `nanoseconds(::Int64) -> Time`

    Construct time as number of nanoseconds.
    """

    @document as_seconds """
    `as_seconds(::Time) -> Float64`

    Convert time to number of seconds.
    """

    @document as_milliseconds """
    `as_milliseconds(::Time) -> Float64`

    Convert time to number of milliseconds.
    """

    @document as_microseconds """
    `as_microseconds(::Time) -> Float64`

    Convert time to number of microseconds.
    """

    @document as_nanoseconds """
    `as_nanoseconds(::Time) -> Int64`

    Convert time to number of nanoseconds.
    """

    @document Clock """
    ## Clock

    Object able to measure time, nanosecond-precision.

    $CONSTRUCTORS
    `Clock()`
    """

    @document restart! """
    `restart!(::Clock) -> Time`

    Return currently elapsed time, then restart the clock.
    """

    @document elapsed! """
    `elapsed(::Clock) -> Time`

    Get currently elapsed time.
    """

####### angle.jl

    @document Angle """
    ## Angle

    Object measuring an angle, unit-agnostic.

    $CONSTRUCTORS
    (no public consturctors)

    $FIEDS
    (no public fields)
    """

    @document degrees """
    `degrees(::Number) -> Angle`

    Get angle as number of degrees. Automatically clamped to [0°, 360°]
    """

    @document radians """
    `radians(::Number) -> Angle`

    Get angle as number of radians
    """

    @document as_degrees """
    `as_degrees(::Angle) -> Float64`

    Convert angle to degrees
    """

    @document as_radians """
    `as_radians(::Angle) -> Float64`

    Convert angle to radians
    """

####### application.jl

    @document Application """
    ## Application <: SignalEmitter

    Maintains a global state of all application-related objects and information.
    Signal `activate` is emitted once the application has initialized the environment,
    no mousetrap function should be called before this signal is emitted.

    $CONSTRUCTORS
    + `Application(valid_signal_id::String)``

    $SIGNALS
    $(generate_signal_table(:Application, 
        :activate, 
        :shutdown
    ))

    $EXAMPLE
    ```julia
    app = Application(\"example.app\")

    connect_signal_activate!(app) do x::Application
        # initialization here
    end

    # start the application
    run(app);
    ```
    """

    @document run! """
    `run!(::Application) -> Cint`

    Request application to initialize and start the main render loop
    """

    @document quit! """
    `quit!(::Application) -> Cvoid`

    Request application to quit immediately
    """

    @document hold! """
    `hold!(::Application) -> Cvoid`

    Mark the application as held. A held application cannot exit until `release!` is called
    """

    @document release! """
    `release!(::Application) -> Cvoid`
    
    Release a held application. If `hold!` was not called previously, this function does nothing
    """

    @document mark_as_busy! """
    `mark_as_busy!(::Application) -> Cvoid`

    Signal to the users operating system that the application is currently busy. All windows 
    of a busy application are marked as non-interactable until `unmark_as_busy!` is called.
    """

    @document unmark_as_busy! """
    `unmark_as_busy(::Application) -> Cvoid`

    No longer designate application as busy. If `mark_as_busy!` was not called previously, 
    this function does nothing.
    """

    @document get_id """
    ``` 
    get_id(::Application) -> String
    get_id(::Action) -> String
    ```

    Access ID of an `Application` or `Action`
    """

    @document add_action! """
    `add_action!(::Application, ::Action) -> Cvoid`

    Register an action with the application. This is usually done automaticall during `Action::set_function!`.
    """

    @document get_action """
    `get_action(::Application, action_id::String) -> Action`
    
    Access a registered action by its ID.
    """

    @document remove_action! """
    `remove_action!(::Application, action_id::String) -> Cvoid`

    Unregister an action so it is no longer available, this may cause the actions finalizer to be called.
    """
    
    @document has_action """
    `has_action(::Application, action_id::String) -> Bool`

    Check whether an action with the given ID was registered.
    """

    @document main """
    `main(f; [application_id::String]) -> Int64`

    Register a function to be called as the main loop. This will automatically create an application, 
    call the given function when it is initialized, then start the main render loop.

    $ARGUMENTS
    + `f`: Object invocable as function with signature `(::Application) -> Cvoid`
    + `application_id`: ID of the application

    $EXAMPLE
    ```julia
    mousetrap.main(; application_id = "example.app") do app::Application
        window = Window(app)

        # setup app and widgets here

        present!(window)
    end
    ```
    """

####### window.jl

    @document Window """
    ## Window <: Widget

    Top-level window, has exactly one child.

    $CONSTRUCTORS
    + `Window(::Application)`

    $SIGNALS
    $(generate_signal_table(:Window,
        :close_request, 
        :activate_default_widget, 
        :activate_focused_widget, 
        #widget_signals...
    ))

    $EXAMPLE
    ```julia
    window = Window(app)
    set_child!(window, Label("Hello Window"))
    present!(window)
    ```
    """

    @document WindowCloseRequestResult """
    
    Return type of signal `close_request` of `Window`

    $ENUM_VALUES
    + `WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE`
    + `WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE`
    """

    @document WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE """
    Permit the window hander to close the window.
    """
    
    @document WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE """
    Prevent closing of the window.
    """

    @document set_application! """
    `set_application!(::Window, ::Application) -> Cvoid`

    Link a window to an application, this is usually done automatically
    """

    @document set_fullscreen! """
    `set_fullscreen!(::Window) -> Cvoid`

    Request for the users window manager to make the window enter fullscreen mode
    """

    @document present! """
    `present!(::Window) -> Cvoid`

    Request for the window to realize and be shown to the user
    """

    @document set_hide_on_close! """
    `set_hide_on_close!(::Window, ::Bool) -> Cvoid`
    
    If `true``, window will hide when it is closed in anyway. If `false`, the windows finalizer will be called instead.
    """

    @document close! """
    `close!(::Window) -> Cvoid`

    Request for the window to close.
    """

    @document set_child!(::Window, ::Widget) """
    `set_child!(::Window, ::Widget) -> Cvoid`

    Set the singular child of the window.
    """

    @document remove_child!(::Window) """
    `remove_child!(::Window, ::Widget) -> Cvoid`

    Remove the singular child of the window.
    """

    @document set_transient_for! """
    `set_transient_for!(self::Window, parent::Window) -> Cvoid`

    Choose another window as the transient parent of this window.
    """

    @document set_destroy_with_parent! """
    `set_destroy_with_parent!(::Window, ::Bool) -> Cvoid`

    If `true` and this window is transient for another window, if the other windows finalizer is called, this window will also finalize.
    """

    @document get_destroy_with_parent """
    `get_destroy_with_parent(::Window, ::Bool) -> Bool`

    Get whether the windows finalizer should be called when its transient parent finalizes.
    """ 

    @document set_title! """
    `set_title!(::Window, ::String) -> Cvoid`

    Set the windows title, if the window has a custom headerbar widget set via `Windo::set_titlebar_widget!`, that widgets title will be use instead.
    """

    @document get_title """
    `get_title(::Window) -> String`

    Get the title used by windows titlebar 
    """

    @document set_titlebar_widget! """
    `set_titlebar_widget(::Window, ::Widget) -> Cvoid`

    Choose the widget user by the window as a titlebar. This will usually be a `HeaderBar`.
    """

    @document remove_titlebar_widget! """
    `remove_titlebar_widget!(::Window) -> Cvoid`

    Reset the windows titlebar widget, such that the default titlebar layout will be used again.
    """

    @document set_is_modal! """
    `set_is_modal(::Window, ::Bool) -> Cvoid`

    Set whether the window should pause its parent window while it is shown.
    """

    @document get_is_modal """
    `get_is_modal(::Window) -> Bool`

    Get whether the window should pause its parent window while it is shown.
    """

    @document set_is_decorated! """
    `set_is_decorated(::Window, ::Bool) -> Cvoid`

    If `false`, the windows titlebar will be hidden. If `true, the windows titlebar along with its titlebar widget will be visible.`
    """

    @document set_has_close_button! """
    `set_has_close_button(::Window, ::Bool) -> Cvoid`

    Set whether the `X` button allowing the user to close a window is visible.
    """

    @document get_has_close_button """
    `get_has_close_button(::Window) -> Bool`

    Get whether the windows close button is visible.
    """

    @document set_startup_notification! """
    `set_startup_notification!(::Window, ::String) -> Cvoid`

    Set the startup notification id that will be displayed when the window is shown for the first time. 
    There is no guarantee that this notification will be respected and presented to the user by the users operating system.
    """

    @document set_focus_visible! """
    `set_focus_visible!(::Window, ::Bool) -> Cvoid`

    If `true`, the currently focused widget will be highlighted, usually using a faint border around the widgets allocated area.
    """

    @document get_focus_visible """
    `get_focus_visible(::Window) -> Bool`

    Get whether the currently focused widget will be highlighted.
    """

    @document set_default_widget! """
    `set_default_widget!(::Window, widget::Widget) -> Cvoid`

    Designate a widget that is a direct or indirect child of the window as the default widget. 
    If the user activates the window, this widget will be activated and `activate_default_widget` will be emitted
    """

####### action.jl

    @document Action """
    ## Action <: SignalEmitter

    Object representing a globally registered function. Actions can be bound to `Button` or `MenuModel`
    in order for these objects to trigger behavior. The lifetime of an action is managed automatically,
    all actions are registered with their application and can be retrieved at any point.

    An action for whom `set_function!` was called is considered *stateless*, its function has the 
    signature `(::Action, [::Data_t]) -> Cvoid`.

    An action for whom `set_stateful_function!` was called is considered *stateful*. It maintains an internal
    boolean variable, the signature of its function is `(::Action, ::Bool, [::Data_t]) -> Bool`.

    If an action is stateful, a `MenuModel` menu item linked to it will appear as a check button that automatically 
    switches the actions state.

    $CONSTRUCTORS
    + `Action(it::String, ::Application)`

    $SIGNALS
    $(generate_signal_table(:Action, 
        :activated 
    ))

    $EXAMPLE
    ```julia
    action = Action("example.action", app)
    set_function!(action) do x::Action
        println("action triggered")
    end

    activate(action)
    ```
    ```
    action triggered
    ```
    """

    @document get_id(::Action) """
    `get_id(::Action) -> String`

    Retrieve the ID of an action.
    """

    @document activate """
    `activate(::Action) -> Cvoid`

    Manually trigger the actions function, this will also emit signal `activated`
    """

    @document add_shortcut! """
    `add_shortcut!(::Action, ::ShotcutTrigger) -> Cvoid`

    Add a shortcut trigger to the action. Shortcut triggers follow the syntax outlined in the chapter on event handling.
    """

    @document get_shortcuts """
    `get_shortcuts(::Action) -> Vector{ShortcutTrigger}`

    Access all registered shortcut triggers. The return vector may be empty.
    """

    @document clear_shortcuts! """
    `clear_shortcuts!(::Action) -> Cvoid`

    Clear all registered shortcut triggers.
    """

    @document set_enabled! """
    `set_enabled!(::Action, ::Bool) -> Cvoid`

    Set whether the action is enabled. A disabled action cannot be activated and all objects linked, such as `Button`s or `MenuModel`s will be disabled.
    """

    @document get_enabled """
    `get_enabled(::Action) -> Bool`

    Get whether the action is enabled
    """

    @document set_function! """
    `set_function!(f, ::Action, [::Data_t]) -> Cvoid`

    Register a function. After this call, the action is considered *stateless*.

    $ARGUMENTS
    + `f`: object invocable as function with signature `(::Action, [::Data_t]) -> Cvoid`
    + `action`: action to be modified

    $EXAMPLE
    ```julia
    action = Action("example.action", app)
    set_function!(action) do x::Action
        println("stateless action triggered")
    end
    ```
    """

    @document set_stateful_function! """
    `set_stateful_function!(f, ::Action, [::Data_t]) -> Cvoid`

    Register a function. After this call, the action is considered *stateful*.

    $ARGUMENTS
    + `f`: object invocable as function with signature `(::Action, ::Bool, [::Data_t]) -> Bool`
    + `action`: action to be modified

    $EXAMPLE
    ```julia
    action = Action("example.action", app)
    set_stateful_function!(action) do x::Action, current_state::Bool
        println("stateful action triggered")
        next_state = !current_state
        return next_state
    end
    ```
    """

    @document get_is_stateful """
    `get_is_stateful(::Action) -> Bool`

    Returns `true` if `set_stateful_function!` was called to set the actions behavior, returns `false`` otherwise.
    """ 

    @document set_state!(::Action, ::Bool) """
    `set_state!(::Action, state::Bool) -> Cvoid`

    If the action is stateful , set its internal state.
    """

    @document get_state(::Action) """
    `get_state(::Action) -> Bool`

    If the action is stateful, return its internal state, otherwise return `false`
    """

####### adjustment.jl

    @document Adjustment """
    ## Adjustment <: SignalEmitter

    Object representing a range of numbers. If a widget has an underlying `Adjustment`,
    if the widgets value changes, the adjustments values changes, and vice-versa. We can 
    therefore modify or monitor a widgets value by modifying or monitoring the underlying adjustment.

    $CONSTRUCTORS
    `Adjustment(value::Number, lower::Number, upper::Number, step_increment::Number)`

    $SIGNALS
    $(generate_signal_table(:Adjustment, 
        :value_changed
        :properties_changed
    ))

    $EXAMPLE
    ```julia
    widget = SpinButton(0, 1, 0.01)
    range = get_adjustment(widget)
    connect_signal_value_changed!(range) do x::Adjustment
        println("SpinButton value is now: ", get_value(x))
    end
    ```
    """

    @document get_lower """
    `get_lower(::Adjustment) -> Float32`

    Get the lower bound of the represented range.
    """

    @document set_lower! """
    `set_lower(::Adjustment, ::Number) -> Cvoid`

    Set the lower bound of the represented range.
    """

    @document get_upper """
    `get_upper(::Adjustment) -> Float32`

    Get the upper bound of the represented range.
    """

    @document set_upper! """
    `set_upper(::Adjustment, ::Number) -> Cvoid`

    Set the upper bound of the represented range.
    """

    @document get_value """
    `get_value(::Adjustment) -> Float32`

    Get the currently selected value of the range.
    """

    @document set_value """
    `set_value(::Adjustment, ::Number) -> Cvoid`

    Set the currently selected value of the range
    """

    @document get_increment """
    `get_increment(::Adjustment) -> Float32`

    Get the step increment of the range.
    """

    @document set_increment """
    `set_increment(::Adjustment, ::Number) -> Cvoid`

    Set the step increment of the range 
    """

####### alignment.jl

    @document Alignment """
    
    Alignment of a widget along the horizontal or vertical axis.

    $ENUM_VALUES
    + `ALIGNMENT_START`
    + `ALIGNMENT_CENTER`
    + `ALIGNMENT_END`
    """

    @document ALIGNMENT_START """
    If horizontal, widget is aligned left, if vertical, widget is aligned top.
    """

    @document ALIGNMENT_END """
    If horizontal, widget is aligned right, if vertical, widget is aligned bottom.
    """

    @document ALIGNMENT_CENTER """
    Widget is aligned center, regardless of orientation.
    """

####### orientation.jl

    @document Orientation """

    Orientation of a widget

    $ENUM_VALUES
    + `ORIENTATION_HORIZONTAL`
    + `ORIENTATION_VERTICAL`
    """

    @document ORIENTATION_HORIZONTAL """
    Widget is aligned along the x-axis.
    """

    @document ORIENTATION_VERTICAL """
    Widget is aligned along the y-axis.
    """

####### cursor_type.jl

    @document CursorType """

    Determines shape of the cursor while it is within the corresponding widgets allocated area.

    $ENUM_VALUES
    + `CURSOR_TYPE_NONE`
    + `CURSOR_TYPE_DEFAULT`
    + `CURSOR_TYPE_HELP`
    + `CURSOR_TYPE_POINTER`
    + `CURSOR_TYPE_CONTEXT_MENU`
    + `CURSOR_TYPE_PROGRESS`
    + `CURSOR_TYPE_WAIT`
    + `CURSOR_TYPE_CELL`
    + `CURSOR_TYPE_CROSSHAIR`
    + `CURSOR_TYPE_TEXT`
    + `CURSOR_TYPE_MOVE`
    + `CURSOR_TYPE_NOT_ALLOWED`
    + `CURSOR_TYPE_GRAB`
    + `CURSOR_TYPE_GRABBING`
    + `CURSOR_TYPE_ALL_SCROLL`
    + `CURSOR_TYPE_ZOOM_IN`
    + `CURSOR_TYPE_ZOOM_OUT`
    + `CURSOR_TYPE_COLUMN_RESIZE`
    + `CURSOR_TYPE_ROW_RESIZE`
    + `CURSOR_TYPE_NORTH_RESIZE`
    + `CURSOR_TYPE_NORTH_EAST_RESIZE`
    + `CURSOR_TYPE_EAST_RESIZE`
    + `CURSOR_TYPE_SOUTH_EAST_RESIZE`
    + `CURSOR_TYPE_SOUTH_RESIZE`
    + `CURSOR_TYPE_SOUTH_WEST_RESIZE`
    + `CURSOR_TYPE_WEST_RESIZE`
    + `CURSOR_TYPE_NORTH_WEST_RESIZE`
    """

    @document CURSOR_TYPE_NONE """
    No visible cursor.
    """

    @document CURSOR_TYPE_DEFAULT """
    Small arrow, default cursor for most widgets.
    """

    @document CURSOR_TYPE_POINTER """
    Hand, indicates that the current widget is clickable.
    """

    @document CURSOR_TYPE_HELP """
    Questionmark, usually opens a help dialog.
    """

    @document CURSOR_TYPE_CONTEXT_MENU """
    Pointer with `...`, informs the user that clicking will open a context menu.
    """

    @document CURSOR_TYPE_PROGRESS """
    Pointer with small "currently loading" icon.
    """

    @document CURSOR_TYPE_WAIT """
    Instructs user to wait for an action to finish.
    """

    @document CURSOR_TYPE_CELL """
    Cursor used when interacting with tables.
    """

    @document CURSOR_TYPE_CROSSHAIR """
    Crosshair-shaped cursor, used for precise selections.
    """

    @document CURSOR_TYPE_TEXT """
    Text caret.
    """

    @document CURSOR_TYPE_MOVE """
    Four-pointer arrow, indicates that the selected object can be moved freely.
    """

    @document CURSOR_TYPE_GRAB """
    Open hand, not yet grabbing.
    """

    @document CURSOR_TYPE_GRABBING """
    Close hand, currently grabbing.
    """

    @document CURSOR_TYPE_ALL_SCROLL """
    Four-directional scrolling.
    """

    @document CURSOR_TYPE_ZOOM_IN """
    Lens, usually with a plus icon.
    """

    @document CURSOR_TYPE_ZOOM_OUT """
    Lens, usually with a minus icon.
    """

    @document CURSOR_TYPE_COLUMN_RESIZE """
    Left-right arrow.
    """

    @document CURSOR_TYPE_ROW_RESIZE """
    Up-down arrow.
    """

    @document CURSOR_TYPE_NORTH_RESIZE """
    Up arrow
    """

    @document CURSOR_TYPE_NORTH_EAST_RESIZE """
    Up-right arrow
    """

    @document CURSOR_TYPE_EAST_RESIZE """
    Right arrow
    """

    @document CURSOR_TYPE_SOUTH_EAST_RESIZE """
    Bottom-right arrow
    """

    @document CURSOR_TYPE_SOUTH_RESIZE """
    Down arrow
    """

    @document CURSOR_TYPE_SOUTH_WEST_RESIZE """
    Down-left arrow
    """

    @document CURSOR_TYPE_WEST_RESIZE """
    Left arrow
    """

    @document CURSOR_TYPE_NORTH_WEST_RESIZE """
    Up-left arrow
    """

####### aspect_frame.jl

    @document AspectFrame """
    ## AspectFrame <: Widget

    Container widget with a singular child. Will make sure that the size allocation of its child
    follows the given aspect ratio at all times.

    $CONSTRUCTORS
    `AspectFrame(ratio::AbstractFloat; [child_x_alignment::Abstract_float, child_y_alignment::AbstractFloat])`

    $EXAMPLE
    ```julia
    # make sure image stay square
    image = ImageDisplay()
    aspect_frame = AspectFrame(1.0)
    set_child!(aspect_frame, image)
    ````
    """

    @document set_ratio! """
    `set_ratio!(x::AspectFrame, ratio::AbstractFloat) -> Cvoid`

    Set ratio of aspect frame.

    $ARGUMENTS
    + `x`: instance
    + `ratio`: Float > 0
    """

    @document get_ratio """
    `get_ratio(::AspectFrame) -> Float32`

    Get ratio of aspect frame.
    """

    @document set_child_x_alignment! """
    `set_child_x_alignment(instance::AspectFrame, alignment::AbstractFloat) -> Cvoid`

    $ARGUMENTS
    + `instance`:  aspect frame
    + `alignment`: Float in [0, 1]
    """

    @document get_child_x_alignment """
    `get_child_x_alignment(::AspectFrame) -> Float32`

    Access x-alignment of aspect frame child.
    """

    @document set_child_y_alignment! """
    `set_child_y_alignment(instance::AspectFrame, alignment::AbstractFloat) -> Cvoid`

    $ARGUMENTS
    + `instance`: aspect frame
    + `alignment`: Float in [0, 1]
    """

    @document get_child_y_alignment """
    `get_child_y_alignment(::AspectFrame) -> Float32`

    Access y-alignment of aspect frame child.
    """

    @document set_child! """
    `set_child!(::AspectFrame, ::Widget) -> Cvoid`

    Set aspect frames singular child.
    """

    @document remove_child! """
    `remove_child!(::AspectFrame) -> Cvoid`

    Remove aspect frames singular child.
    """

####### box.jl

    @document Box """
    Widget container that arranges its children in a row (or column, if vertically oriented).

    $CONSTRUCTORS
    `Box(::Orientation)`

    $EXAMPLE
    ```julia
    box = Box(ORIENTATION_HORIZONTAL)
    push_back!(box, Label("first child"))
    push_back!(box, Label("second child"))
    ```
    """

    @document push_back!(::Box, ::Widget) """
    `push_back!(::Box, ::Widget) -> Cvoid`

    Add widget to the end of the box.
    """

    @document push_front!(::Box, ::Widget) """
    `push_front!(::Box, ::Widget) -> Cvoid`

    Add widget to the start of the box.
    """

    @document insert_after! """
    `insert_after!(::Box, to_append::Widget, after::Widget)`

    Insert widget right after another widget that is already inside the box.
    """

    @document remove!(::Box, ::Widget) """
    `remove!(::Box) -> Cvoid`

    Remove a widget from the box.
    """

    @document clear!(::Box) """
    `clear!(::Box) -> Cvoid`

    Remove all children from box.
    """

    @document set_homogeneous! """
    `set_homogeneous!(::Box, ::Bool) -> Cvoid`

    If `true`, box will attempt to allocate the same amount of space for each of its children.
    """

    @document get_homogeneous """
    `get_homogeneous(::Box) -> Bool`

    Get whether box will attempt to allocate the same amount of space for each of its children.
    """

    @document set_spacing! """
    `set_spacing!(::Box, ::Number) -> Cvoid`

    Set spacing, which will insert empty space between any two pair of children inside the box.

    $ARGUMENTS
    + `::Box`: instance
    + `::Number`: spacing, floating point value > 0, in pixels
    """

    @document get_spacing """
    `get_spacing(::Box) -> Float32`

    Get spacing of box, or 0 if not specified.
    """

    @document set_orientation!(::Box, ::Orientation) """
    `set_orientation!(::Box, ::Orientation) -> Cvoid`

    Set whether box should align its children vertically or horizontally.
    """

    @document get_orientation(::Box) """
    `get_orientation(::Box) -> Orientation`

    Get whether the box will align its children vertically or horizontally
    """

####### button.jl

    @document Button """
    ## Button <: Widget

    Widget that when clicked, either activates an action set via `set_action!`, and/or invokes 
    the signal handler connect so signal `clicked`. Has a singular child used as its label.

    $CONSTRUCTORS
    `Button()`

    $SIGNALS
    $(generate_signal_table(:T, 
        :clicked
        :activate
    ))

    $EXAMPLE
    ```julia
    button = Button
    set_child!(button, Label("Click Me"))
    connect_signal_clicked!(button) do x::Button
        println("Button Clicked")
    end
    ```
    """

    @document set_action!(::Button, ::Action) """
    `set_action!(::Button, ::Action) -> Cvoid`

    Link an action to a button. When the button is clicked, the action is activated. If the action 
    is disabled or otherwise made non-activatable, the button will be disabled automatically. 
    """

    @document set_has_frame!(::Button, ::Bool) """
    `set_has_frame!(::Button, ::Bool) -> Cvoid`

    If `false`, button will have no visual element but retains all other properties, 
    such as its allocated area and child.
    """

    @document get_has_frame(::Button) """
    `get_has_frame(::Button) -> Bool`

    Get whether the buttons own visual elements are displayed.
    """

    @document set_is_circular(::Button, ::Bool) """
    `set_is_circular(::Button, ::Bool) -> Cvoid`

    If `true`, button is displayed as a circle. If `false`, button is displayed as a rectangle.
    """

    @document get_is_circular(::Button) """
    `get_is_circular(::Button) -> Bool`

    Get whether button is displayed as a circle.
    """

    @document set_child!(::Button) """
    `set_child!(::Button) -> Cvoid`

    Set the buttons child.
    """

    @document remove_child!(::Button) """
    `remove_child!(::Button) -> Cvoid`

    Clear buttons child.
    """

####### center_box.jl

    @document CenterBox """
    ## CenterBox <: Widget

    Widget container that has exactly 3 children. They are arranged such that the center child
    stays center at all time. This is useful to enforce symmetry.

    $CONSTRUCTORS
    `CenterBox(::Orientation)`
    """

    @document set_start_child!(::CenterBox, ::Widget) """
    `set_start_child!(::CenterBox, ::Widget) -> Cvoid`

    If center box is horizontal, set left-most child, if vertical, set top-most child.
    """

    @document set_end_child!(::CenterBox, ::Widget) """
    `set_end_child!(::CenterBox, ::Widget) -> Cvoid`

    If center box is horizontal, set right-most child, if vertical, set bottom-most child.
    """

    @document set_center_child!(::CenterBox, ::Widget) """
    `set_center_child!(::CenterBox, ::Widget) -> Cvoid`

    Set middle child.
    """

    @document remove_start_child!(::CenterBox, ::Widget) """
    `remove_start_child!(::CenterBox, ::Widget) -> Cvoid`

    If center box is horizontal, remove left-most child, if vertical, remove top-most child.
    """

    @document remove_end_child!(::CenterBox, ::Widget) """
    `remove_end_child!(::CenterBox, ::Widget) -> Cvoid`

    If center box is horizontal, remove right-most child, if vertical, remove bottom-most child.
    """

    @document remove_center_child!(::CenterBox, ::Widget) """
    `remove_center_child!(::CenterBox, ::Widget) -> Cvoid`

    remove middle child.
    """

    @document set_orientation!(::CenterBox, ::Orientation) """
    `set_orientation(::CenterBox, ::Orientation) -> Cvoid`

    Set whether center box will align its children horizontally or vertically.
    """

    @document get_orientation(::CenterBox, ::Orientation) """
    `get_orientation(::CenterBox) -> Orientation`

    Get whether center box will align its children horizontally or vertically.
    """

####### check_button.jl

    @document CheckButton """
    ## CheckButton <: Widget

    Button that can be toggled, if toggled, it displays a checkmark.

    $CONSTRUCTORS
    `CheckButton()`

    $SIGNALS
    $(generate_signal_table(:CheckButton
        :toggled,
        :activate
    ))

    $EXAMPLE
    ```julia
    button = CheckButton()
    connect_signal_toggled(button) do x::CheckButton
        println("check button state is now: " * string(get_is_active(x)))
    end
    ```
    """

    @document CheckButtonState """
    Internal state of `CheckButton`

    $ENUM_VALUES
    + `CHECK_BUTTON_STATE_ACTIVE`
    + `CHECK_BUTTON_STATE_INCONSISTENT`
    + `CHECK_BUTTON_STATE_INACTIVE`
    """

    @document CHECK_BUTTON_STATE_ACTIVE """
    Active, usually displayed as a check mark
    """

    @document CHECK_BUTTON_STATE_INACTIVE """
    Inactive, usually displayed with no check mark
    """

    @document CHECK_BUTTON_STATE_INCONSISTENT """
    Neither active nor inactive
    """

    @document set_state!(::CheckButton, ::CheckButtonState) """
    `set_state!(::CheckButton, ::CheckButtonState) -> Cvoid`

    Set internal state of the check button.
    """

    @document get_state(::CheckButton) """
    `get_state(::CheckButton) -> CheckButtonState`

    Get internal state of the check button.
    """

    @document get_is_active!(::CheckButton) """
    `get_is_active!(::CheckButton) -> Bool`

    Returns `true` if check button state is `CHECK_BUTTON_STATE_ACTIVE`, false otherwise.
    """

    if mousetrap.detail.GTK_MINOR_VERSION >= 8
        @document set_child!(::CheckButton) """
        `set_child!(::CheckButton, ::Widget) -> Cvoid`

        Set child of check button.

        (This function is only available with GTK4.8+)
        """

        @document remove_child!(::CheckButton) """
        `remove_child!(::CheckButton) -> Cvoid`

        Clear check buttons child.

        (This function is only available with GTK4.8+)
        """
    end

####### switch.jl

    @document Switch """
    ## Switch <: Widget

    Lightswitch-like widget that is either on or off.

    $CONSTRUCTORS
    `Switch()`

    $SIGNALS
    $(generate_signal_table(:Switch
        :activate
    ))

    $EXAMPLE
    ```julia
    switch = Switch()
    connect_signal_activate(switch) do x::Switch
        println("Switch is now: " * string(get_is_active(x)))
    end
    """

    @document get_is_active(::Switch) """
    `get_is_active(::Switch) -> Bool`

    Get whether the switch is currently in the "on" position.
    """

    @document set_is_active!(::Swtich, ::Bool) """
    `set_is_active!(::Switch) -> Bool`

    Set whether switch is currently in the "on" position.
    """

####### toggle_button.jl

    @document ToggleButton """
    ## ToggleButton <: Widget

    Button that stays depressed to indicate a boolean state.

    $CONSTRUCTORS
    `ToggleButton()`

    $SIGNALS
    $(generate_signal_table(:ToggleButton,
        :activate,
        :toggled, 
        :clicked
    ))

    $EXAMPLE
    ```julia
    toggle_button = ToggleButton()
    connect_signal_toggled(toggle_button) do x::ToggleButton
        println("ToggleButton is now: " * string(get_is_active(x)))
    end
    ```
    """

    @document set_is_active!(::ToggleButton, ::Bool) """
    `set_is_active!(::ToggleButton, ::Bool) -> Cvoid`

    Set whether the toggle button is currently depressed.
    """

    @document get_is_active(::ToggleButton) """
    `get_is_active(::ToggleButton) -> Bool`

    Get whether the toggle button is currently depressed.
    """

####### viewport.jl

    @document ScrollbarVisibilityPolicy """
    Determines if and when scroll bars of a `Viewport` are shown

    $ENUM_VALUES
    + `SCROLLBAR_VISIBILITY_POLICY_NEVER`
    + `SCROLLBAR_VISIBILITY_POLICY_ALWAYS`
    + `SCROLLBAR_VISIBILITY_POLICY_AUTOMATIC`
    """

    @document SCROLLBAR_VISIBILITY_POLICY_NEVER """
    Scrollbar is hidden at all times.
    """

    @document SCROLLBAR_VISIBILITY_POLICY_ALWAYS """
    Scrollbar is visible at all times.
    """

    @document SCROLLBAR_VISIBILIT_POLICY_AUTOMATIC """
    When the users cursor enters or exists the `Viewport`, an animation will play that reveals or hides the scrollbar
    """

    @document CornerPlacement """
    Determines location of both scrollbars of a `Viewport`

    $ENUM_VALUES
    + `CORNER_PLACEMENT_TOP_LEFT`
    + `CORNER_PLACEMENT_TOP_RIGHT`
    + `CORNER_PLACEMENT_BOTTOM_LEFT`
    + `CORNER_PLACEMENT_BOTTOM_RIGHT`
    """

    @document CORNER_PLACEMENT_TOP_LEFT """
    Horizontal scrollbar will be at the top, vertical scrollbar will be on the left.
    """

    @document CORNER_PLACEMENT_TOP_RIGHT """
    Horizontal scrollbar will be at the top, vertical scrollbar will be on the right.
    """

    @document CORNER_PLACEMENT_BOTTOM_LEFT """
    Horizontal scrollbar will be at the bottom, vertical scrollbar will be on the left.
    """

    @document CORNER_PLACEMENT_BOTTOM_RIGHT """
    Horizontal scrollbar will be at the bottom, vertical scrollbar will be on the right.
    """

    @document ScrollType """
    Determines type of scroll-action triggered by the user.

    $ENUM_VALUES
    + `SCROLL_TYPE_NONE`
    + `SCROLL_TYPE_JUMP`
    + `SCROLL_TYPE_STEP_BACKWARD`
    + `SCROLL_TYPE_STEP_FORWARD`
    + `SCROLL_TYPE_STEP_UP`
    + `SCROLL_TYPE_STEP_DOWN`
    + `SCROLL_TYPE_STEP_RIGHT`
    + `SCROLL_TYPE_STEP_LEFT`
    + `SCROLL_TYPE_PAGE_BACKWARD`
    + `SCROLL_TYPE_PAGE_FORWARD`
    + `SCROLL_TYPE_PAGE_UP`
    + `SCROLL_TYPE_PAGE_DOWN`
    + `SCROLL_TYPE_PAGE_LEFT`
    + `SCROLL_TYPE_PAGE_RIGHT`
    + `SCROLL_TYPE_SCROLL_START`
    + `SCROLL_TYPE_SCROLL_END`
    """

    @document Viewport """
    ## Viewport <: Widget

    Widget with exactly one child. The size allocation of the viewport is independent of that
    of its child. If the child allocates an area larger than that of the viewport, the child
    is clipped and only part of it is shown. The user can scroll horizontally or vertically 
    to reveal a different part of the child.

    $CONSTUCTORS
    `Viewport()`

    $SIGNALS
    $(generate_signal_table(:Viewport,
        :scroll_child
    ))
    """

    @document set_propagate_natural_height! """
    `set_propagate_natural_height!(::Viewport, ::Bool) -> Cvoid`

    If `true`, viewport will assume the height of its child at all times.
    """

    @document get_propagate_natural_height """
    `set_propagate_natural_height!(::Viewport) -> Bool`

    Get whether viewport should assume height of its child.
    """

    @document set_propagate_natural_width! """
    `set_propagate_natural_wdith!(::Viewport, ::Bool) -> Cvoid`

    If `true`, viewport will assume the width of its child at all times.
    """

    @document get_propagate_natural_width """
    `get_propagate_natural_wdith!(::Viewport) -> Bool`

    Get whether viewport should assume width of its child.
    """

    @document set_horizontal_scrollbar_policy! """
    `set_horizontal_scrollbar_policy(::Viewport, ::ScrollbarPolicy) -> Cvoid`

    Set how the horizontal scrollbar should behave.
    """

    @document get_horizontal_scrollbar_policy """
    `get_horizontal_scrollbar_policy(::Viewport) -> ScrollbarPolicy`

    Get how the horizontal scrollbar behaves.
    """

    @document set_vertical_scrollbar_policy! """
    `set_vertical_scrollbar_policy(::Viewport, ::ScrollbarPolicy) -> Cvoid`

    Set how the vertical scrollbar should behave.
    """

    @document get_vertical_scrollbar_policy """
    `get_vertical_scrollbar_policy(::Viewport) -> ScrollbarPolicy`

    Get how the vertical scrollbar behaves.
    """

    @document set_scrollbar_placement """
    `set_scrollbar_placement(::Viewport, ::CornerPlacement) -> Cvoid`

    Set relative location of both scrollbars.
    """

    @document get_scrollbar_placement """
    `get_scrollbar_placement(::Viewport) -> CornerPlacement`

    Get relative location of both scrollbars.
    """

    @document set_has_frame!(::Viewport, ::Bool) """
    `set_has_frame!(::Viewport, ::Bool) -> Cvoid`

    Set whether the viewport should have an outline and rounded corners.
    """

    @document get_has_frame(::Viewport) """
    `get_has_frame(::Viewport) -> Bool`

    Get whether the viewport has an outline and rounded corners.
    """

    @document set_kinetic_scrolling_enabled! """
    `set_kinetic_scrolling_enabled!(::Viewport, ::Bool) -> Cvoid`

    Set whether kinetic scroll is possible when scrolling the viewport. 
    When enabled, a scroll action will not seizes once the user stops operating the scrollbars,
    instead, the child will keep scrolling as if it had "inertia". 
    """

    @document get_kinetic_scrolling_enabled """
    `get_kinetic_scrolling_enabled(::Viewport) -> Bool`

    Get whether kinetic scrolling is possible for this viewport.
    """

    @document get_horizontal_adjustment(::Viewport) """
    `get_horizontal_adjustment(::Viewport) -> Adjustment`

    Access the underling adjustment of the horizontal scrollbar.
    """

    @document get_vertical_adjustment(::Viewport) """
    `get_vertical_adjustment(::Viewport) -> Adjustment`

    Access the underling adjustment of the vertical scrollbar.
    """
    
    @document set_child!(::Viewport, ::Widget) """
    `set_child!(::Viewport) -> Cvoid`

    Set singular child of the viewport
    """

    @document remove_child!(::Viewport) """
    `remove_child!(::Viewport) -> Cvoid`

    Clear viewports child.
    """

####### color.jl

    @document Color """
    Color representation
    """

    @document RBGA """
    ## RGBA <: Color

    Color representation in RGBA format

    $FIELDS
    + `r`: red component, 32-bit float in [0, 1]
    + `g`: green component, 32-bit float in [0, 1]
    + `b`: blue component, 32-bit float in [0, 1]
    + `a`: opacity (alpha), 32-bit float in [0, 1]

    $CONSTRUCTORS
    `RGBA(r::AbstractFloat, g::AbstractFloat, b::AbstractFloat, a::AbstractFloat)`
    """

    @document HSVA """
    ## HSVA <: Color

    Color representation in HSVA format

    $FIELDS
    + `h`: hue component, 32-bit float in [0, 1]
    + `s`: saturation component, 32-bit float in [0, 1]
    + `v`: value component, 32-bit float in [0, 1]
    + `a`: opacity (alpha), 32-bit float in [0, 1]

    $CONSTRUCTORS
    `HSVA(h::AbstractFloat, s::AbstractFloat, b::AbstractFloat, a::AbstractFloat)`
    """

    @document rgba_to_hsva """
    `rgba_to_hsva(::RGBA) -> HSVA`

    Convert RGBA to HSVA
    """

    @document hsva_to_rgba """
    `hsva_to_rgba(::HSVA) -> RGBA`

    Convert HSVA to RGBA
    """

    @document is_valid_html_code """
    `is_valid_html_code(::String) -> Bool`

    Check whether identifier can be parsed with `rgba_to_html_code`.
    """

    @document rgba_to_html_code """
    `rgba_to_html_code(::RGBA) -> String`

    Convet RGBA to a string of the form "#RRGGBB` where each component is translated into [0, 255], 
    then converted into hexadecimal. The opacity component is ignored.

    $EXAMPLE
    ```julia
    rgba = RGBA(1, 0, 1, 0.5)
    as_html_code = rgba_to_html_code(rgba)
    println(as_html_code)
    ```
    ```
    #FF00FF
    ```
    """

    @document html_code_to_rgba(code::String) """
    `html_code_to_rgba(::String) -> RGBA`

    Convert html code of the form "#RRGGBB" or "#RRGGBBAA", where each component is in [0, 255], hexadecimal,  to RGBA
    $EXAMPLE
    ```julia
    code::String = #...
    if is_valid_html_code(code)
        return RBGA(html_code_to_rgba(code))
    else
        # handle error
    end
    ```
    """



    


    


    







