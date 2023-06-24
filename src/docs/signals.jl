void_signature = "(::T, [::Data_t]) -> Nothing"
const signal_descriptors = Dict([

    :activate => (
        void_signature, 
        "`Widget::activate()` is called or the widget is otherwise activated"
    ),
    :startup => (
        void_signature, 
        "`Application` is in the process of initializing"
    ),
    :shutdown => (
        void_signature, 
        "`Application` is done initializing and will now start the main render loop"
    ),
    :update => (
        void_signature, 
        "once per frame, at the start of each render loop"
    ),
    :paint => (
        void_signature, 
        "once per frame, right before the associated widget is drawn"
    ),
    :realize => (
        void_signature, 
        "widget is fully initialized and about to be rendered for the first time"
    ),
    :unrealize => (
        void_signature, 
        "widget was hidden and will seize being displayed"
    ),
    :destroy => (
        void_signature, 
        "A widgets ref count reaches 0 and its finalizer is called"
    ),
    :hide => (
        void_signature, 
        "`Widget::hide``is called or a widget becomes no longer visible otherwise"
    ),
    :show => (
        void_signature, 
        "widget is rendered to the screen for the first time"
    ),
    :map => (
        void_signature, 
        "widgets size allocation was assigned"
    ),
    :unmap => (
        void_signature, 
        "widget or one of its parents is hidden"
    ),
    :close_request => (
        "[::Data_t]) -> allow_close::WindowCloseRequestResult", 
        "mousetrap or the users operating system requests for a window to close"
    ),
    :closed => (
        void_signature, 
        "popover is closed"
    ),
    :activate_default_widget => (
        void_signature, 
        "widget assigned via Window::set_default_widget is activated is activated"
    ),
    :activate_focused_widget => (
        void_signature, 
        "widget that currently holds focus is activated"
    ),
    :clicked => (
        void_signature, 
        "user activates the widget by clicking it with a mouse or touch-device"
    ),
    :toggled => (
        void_signature, 
        "buttons internal state changes"
    ),
    :text_changed => (
        void_signature, 
        "underlying text buffer is modified in any way"
    ),
    :selection_changed => (
        "(::T, position::Integer, n_items::Integer, [::Data_t]) -> Nothing", 
        "number or index of selected elements changes"
    ),
    :key_pressed => (
        "(::T, code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", 
        "user pressed a non-modifier key"
    ),
    :key_released => (
        "(::T, code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", 
        "user releases a non-modifier key"
    ),
    :modifiers_changed => (
        "(::T, code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", 
        "user presses or releases a modifier key"
    ),
    :drag_begin => (
        "(::T, start_x::AbstractFloat, start_y::AbstractFloat, [::Data_t]) -> Nothing", 
        "first frame at which a drag gesture is recognized"
    ),
    :drag => (
        "(::T, x_offset::AbstractFloat, y_offset::AbstractFloat, [::Data_t]) -> Nothing", 
        "once per frame while a drag gesture is active"
    ),
    :drag_begin => (
        "(::T, x_offset::AbstractFloat, y_offset::AbstractFloat, [::Data_t]) -> Nothing", 
        "drag gesture seizes to be active"
    ),
    :click_pressed => (
        "(::T, n_presses::Integer, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "User presses a mouse button or touch-device"
    ),
    :click_released => (
        "(::T, n_presses::Integer, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "User releases a mouse button or touch-device"
    ),
    :click_stopped => (
        void_signature, 
        "once when a series of clicks ends"
    ),
    :focus_gained => (
        void_signature, 
        "Widget acquires input focus"
    ),
    :focus_lost => (
        void_signature, 
        "Widget looses input focus"
    ),
    :pressed => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "long-press gesture is recognized"
    ),
    :press_cancelled => (
        void_signature, 
        "long-press gesture seizes to be active"
    ),
    :motion_enter => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "cursor enters allocated area of the widget for the first time"
    ),
    :motion => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "once per frame while cursor is inside allocated area of the widget"
    ),
    :motion_leave => (
        void_signature, 
        "cursor leaves allocated area of the widget"
    ),
    :scale_changed => (
        "(::T, scale::AbstractFloat, [::Data_t]) -> Nothing", 
        "distance between two fingers recognized as a pinch-zoom-gesture changes"
    ),
    :rotation_changed => (
        "(::T, angle_absolute::AbstractFloat, angle_delta::AbstractFloat, [::Data_t]) -> Cvoid", 
        "angle between two fingers recognized as a rotate-gesture changes"
    ),
    :scroll_begin => (
        void_signature, 
        "user initiates a scroll gesture using the mouse scrollwheel or a touch-device"
    ),
    :scroll => (
        "(::T, x_delta::AbstractFloat, y_delta::AbstractFloat, [::Data_t]) -> also_invoke_default_handlers::Bool", 
        "once per frame while scroll gesture is active"
    ),
    :scroll_end => (
        void_signature, 
        "user seizes scrolling"
    ),
    :kinetic_scroll_decelerate => (
        "(::T, x_velocity::AbstractFloat, y_velocity::AbstractFloat, [::Data_t]) -> Cvoid", 
        "widget is still scrolling due to scrolling \"inertia\""
    ),
    :stylus_down => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", 
        "stylus makes physical contact with the touchpad"
    ),
    :stylus_up => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", 
        "stylus seizes to make contact with the touchpad"
    ),
    :proximity => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", 
        "stylus enters or leaves maximum distance recognized by the touchpad"
    ),
    :swipe => (
        "(::T, x_velocity::AbstractFloat, y_velocity::AbstractFloat, [::Data_t]) -> Cvoid", 
        "swipe gesture is recognized"
    ),
    :pan => (
        "(::T, ::PanDirection, offset::AbstractFloat, [::Data_t]) -> Cvoid", 
        "pan gesture is recognized"
    ),
    :value_changed => (
        void_signature, 
        "`value` property of underlying adjustment changes"
    ),
    :properties_changed => (
        void_signature, 
        "any property other than `value` of underlying adjustment changes"
    ),
    :wrapped => (
        void_signature, 
        "`SpinButton` for whom `is_wrapped` is enabled has its value increased or decreased past the given range"
    ),
    :scroll_child => (
        "(::T, ::ScrollType, is_horizontal::Bool, [::Data_t]) -> Cvoid", 
        "user triggers a scroll action"
    ),
    :render => (
        void_signature, 
        "`RenderArea` is requested to draw the the screens framebuffer"
    ),
    :resize => (
        "(::T, width::Integer, height::Integer, [::Data_t]) -> void", 
        "allocated size of `RenderArea` changes while it is realized"
    ),
    :activated => (
        void_signature, 
        "`Action` is activated"
    ),
    :revealed => (
        void_signature, 
        "child is fully revealed (after the animation has finished)"
    ),
    :page_reordered => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "page of `Notebook` changes position"
    ),
    :page_added => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "number of pages increases while the widget is realized"
    ),
    :page_removed => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "number of pages decreases while the widget is realized"
    ),
    :page_selection_changed => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "currently visible page changes"
    ),
    :items_changed => (
        "(::T, position::Integer, n_removed::Integer, n_added::Integet, [::Data_t]) -> Cvoid", 
        "list of items is modified"
    )
])

macro signal_table(T, signals...)

    ids = ["ID"]
    signatures = ["Signature"]
    descriptions = ["Description"]

    for signal_id in signals
        push!(ids, string(signal_id))

        signature = signal_descriptors[signal_id][1]
        push!(signatures, replace(signature, "T" => string(T)))

        push!(descriptions, signal_descriptors[signal_id][2])
    end

    return mdtable(ids, signatures, descriptions; latex=false)
end

macro type_signals(T)
   return """
   ## Signals
   (no unique signals)
   """ 
end

macro type_signals(T, signals...)

    out = String["## Signals\n"]
    n_signals = length(signals)
    for i in 1:n_signals

        id = signals[i]
        signature = replace(signal_descriptors[id][1], "T" => string(T))
        description = signal_descriptors[id][2]

        if i == n_signals
            push!(out, """
            > **$id**
            > > ```
            > > $signature
            > > ```
            > $description
            """)
        else
            push!(out, """
            > **$id**
            > > ```
            > > $signature
            > > ```
            > $description
            ---
            """)
        end
    end
    return join(out)
end