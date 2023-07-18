#
# Author: C. Cords (mail@clemens-cords.com)
# https://github.com/clemapfel/mousetrap.jl
#
# Copyright © 2023, Licensed under lGPL3-0
#

void_signature = "(::T, [::Data_t]) -> Nothing"
const signal_descriptors = Dict([

    :activate => (
        void_signature, 
        "Emitted when [`activate!`](@ref) is called or an activatble widget is otherwise activated, for example by the user clicking the widget or pressing enter while the widget has keyboard focus."
    ),
    :activate_item => (
        "(::T, index::Integer, [::Data_t]) -> Nothing",
        "Emitted when the user activates a selected item of the view."
    ),
    :startup => (
        void_signature, 
        "Emitted when an [`Application`](@ref) instance has initialized the backend."
    ),
    :shutdown => (
        void_signature, 
        "Emitted when an [`Application`](@ref) is exiting the main loop and attempting to shut down."
    ),
    :update => (
        void_signature, 
        "Emitted exactly once per frame, when the widget the `FrameClock` is associated with updates its properties at the start of the frame."
    ),
    :paint => (
        void_signature, 
        "Emitted exactly once per frame, when the widget the `FrameClock` is associated with is drawn."
    ),
    :realize => (
        void_signature, 
        "Emitted when a widget is done initializing and is shown for the first time."
    ),
    :unrealize => (
        void_signature, 
        "Emitted when a widget is hidden or otherwise made inactive, at which point it will free associated objects and free it's allocated area."
    ),
    :destroy => (
        void_signature, 
        "Emitted when a widgets reference count reaches 0 and it should be finalized and deleted."
    ),
    :hide => (
        void_signature, 
        "Emitted when [`hide!`](@ref) is called or a widget is otherwise hidden from view, at which point it will no longer allocate any area on screen."
    ),
    :show => (
        void_signature, 
        "Emitted when [`show!`](@ref) is called or a widget is otherwise made visible for the first time."
    ),
    :map => (
        void_signature, 
        "Emitted when a widget has chosen its final size allocation and is assuming its size and position on screen."
    ),
    :unmap => (
        void_signature, 
        "Emitted when a widget looses its current size allocation, usually in the process of being hidden or destroyed."
    ),
    :close_request => (
        "(::T, [::Data_t]) -> WindowCloseRequestResult", 
        "The window or the users operating system requests the window to close. Return [`WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE`](@ref) or [`WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE`](@ref) to control whether this is permitted"
    ),
    :closed => (
        void_signature, 
        "A [`Popover`](@ref) window is closed, either by automatcally closing or when [`popdown!`](@ref) was called."
    ),
    :activate_default_widget => (
        void_signature, 
        "The widget assigned via [`set_default_widget!`](@ref) emits its `activate` signal."
    ),
    :activate_focused_widget => (
        void_signature, 
        "Widget that is a direct or indirect child of this window and holds input focus emits its `activate` signal."
    ),
    :clicked => (
        void_signature, 
        "The widget is clicked by the user, either with a mouse or touch-device"
    ),
    :toggled => (
        void_signature, 
        "The buttons internal state goes from active to inactive or vice-versa."
    ),
    :text_changed => (
        void_signature, 
        "The underlying text buffer is modified in any way."
    ),
    :selection_changed => (
        "(::T, position::Integer, n_items::Integer, [::Data_t]) -> Nothing", 
        "The number or position of one or more selected items has changed, where `position` is the item index that was modifier, and `n_items` is the number of items currently selected."
    ),
    :key_pressed => (
        "(::T, code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", 
        "The user presses a non-modifier key that is currently not pressed."
    ),
    :key_released => (
        "(::T, code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", 
        "The user releaes a non-modifier key that is currently pressed."
    ),
    :modifiers_changed => (
        "(::T, code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", 
        "The set of depresses modifier keys changes in any way."
    ),
    :drag_begin => (
        "(::T, start_x::AbstractFloat, start_y::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted exaclty once, on the first frame a drag gesture is recognized. `start_y` and `start_x` are intial position of the cursor, in pixels."
    ),
    :drag => (
        "(::T, x_offset::AbstractFloat, y_offset::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted once per frame while a drag gesture is active, where `x_offset` and `y_offset` are the distance form the current position to the cursor to the position at the start of the drag gesture."
    ),
    :drag_end => (
        "(::T, x_offset::AbstractFloat, y_offset::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted exactly once, when the drag gesture seizes to be active, where where `x_offset` and `y_offset` are the distance form the current position to the cursor to the position at the start of the drag gesture."
    ),
    :click_pressed => (
        "(::T, n_presses::Integer, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "User presses a mouse button that is currently up, or presses a touch device, where `n_presses` is the number of clicks in the current sequence, `x` and `y` are the current cursor position."
    ),
    :click_released => (
        "(::T, n_presses::Integer, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "User releaes a mouse button that is currently down, or seizes to press a touch device, where `n_presses` is the number of clicks in the current sequence, `x` and `y` are the current cursor position."
    ),
    :click_stopped => (
        void_signature, 
        "Emitted exactly once to signal that a series of clicks ended."
    ),
    :focus_gained => (
        void_signature, 
        "Emitted once when a widget grabs input focus."
    ),
    :focus_lost => (
        void_signature, 
        "Emitted once when a widget looses input focus."
    ),
    :pressed => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted once when a long-press gesture is recognized, where `x` and `y` are the current position of the cursor."
    ),
    :press_cancelled => (
        void_signature, 
        "Emitted once a long-press gesture seizes, usually when the users stops keeping the button or touchscreen depressed."
    ),
    :motion_enter => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted exactly once when the users cursor first enters the allocated area of the widget, where `x` and `y` are the current position of the cursor."
    ),
    :motion => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted once per frame, while the cursor is inside the allocated area of the widget, where `x` and `y` are the current cursor position"
    ),
    :motion_leave => (
        void_signature, 
        "Emitted exactly once when the cursor leaves the allocated area of the widget."
    ),
    :scale_changed => (
        "(::T, scale::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted anytime the distance between the two fingers of the pinch-zoom-gesture changes, where `scale` is factor by which the current scale is different than the distance between the two fingers at the start of the gesture."
    ),
    :rotation_changed => (
        "(::T, angle_absolute::AbstractFloat, angle_delta::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted when the angle between the two finger sof a rotate-gesture changes, where `angle_delta` is the offset and `angle_absolute` the current angle, both in radians."
    ),
    :scroll_begin => (
        void_signature, 
        "Emitted exaclty once when a scroll gesture is first recognized."
    ),
    :scroll => (
        "(::T, x_delta::AbstractFloat, y_delta::AbstractFloat, [::Data_t]) -> also_invoke_default_handlers::Bool", 
        "Emitted once per frame while a scroll gesture is active, where `x_delta` and `y_delta` are the offset along the horizontal and vertical axis, in pixels."
    ),
    :scroll_end => (
        void_signature, 
        "Emitted exactly once when a scroll gesture ends."
    ),
    :kinetic_scroll_decelerate => (
        "(::T, x_velocity::AbstractFloat, y_velocity::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once per frame while kinetic scrolling is active, see the manual on `ScrollEventController` for more information."
    ),
    :stylus_down => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once when the stylus first makes contact with the touchpad, where `x` and `y` is the cursor position in widget-space."
    ),
    :stylus_up => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once when the stylus seizes to be in physical contact with the touchpad, where `x` and `y` is the cursor position in widget-space."
    ),
    :proximity => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted anytime the stylus enters or exits the distance recognized by the touchpad. This will usually precede a `stylus_down` signal and follow a `stylus_up` signal."
    ),
    :swipe => (
        "(::T, x_velocity::AbstractFloat, y_velocity::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once per frame while a swipe gesture is active, where `x_velocity` and `y_velocity` are the current velocity of the swipe, in pixels."
    ),
    :pan => (
        "(::T, ::PanDirection, offset::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once per frame while a pan gesture is active, where `offset` is the distance between the current position of the cursor and the position at the start of the gesture."
    ),
    :value_changed => (
        void_signature, 
        "Emitted when the `value` property of the [`Adjustment`](@ref) changes."
    ),
    :properties_changed => (
        void_signature, 
        "Emitted when any property of the [`Adjustment`](@ref) other than `value` changes."
    ),
    :wrapped => (
        void_signature,
        "Emitted when a `SpinButton`s value wraps from the minimum to the maximum or vice-versa. For this signal to be emitted, [`set_should_wrap!`](@ref) needs to be set to `true` first." 
    ),
    :scroll_child => (
        "(::T, scroll_type::ScrollType, is_horizontal::Bool, [::Data_t]) -> Cvoid", 
        "Emitted anytime a user triggers a scroll action that moves one or both of the [`Viewport`]s scrollbars. `scroll_type` identifies the type of action that triggered the scrolling, while `is_horizontal` can be determined whether the horizontal or vertical scrollbar was operated."
    ),
    :render => (
        void_signature, 
        "Emitted once per frame, right before [`RenderArea`](@ref) pushes the current frame buffer to the monitor."
    ),
    :resize => (
        "(::T, width::Integer, height::Integer, [::Data_t]) -> void", 
        "Emitted whenver the allocated area of a [`RenderArea`](@ref) changes, where `width` and `height` are the new size, in pixels. Emission of this signal usually means the OpenGL viewport size changed as well."
    ),
    :activated => (
        void_signature, 
        "Emitted when [`activate!`](@ref) is called or the [`Action`](@ref) is otherwise activated."
    ),
    :revealed => (
        void_signature, 
        "Emitted once when a [`Revealer`](@ref)s child goes from hidden to shown or shown to hidden, and the corresponding animation has finished playing."
    ),
    :page_reordered => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "Emitted when a page of a [`Notebook`](@ref) changes position, where `page_index` is the new position of the page."
    ),
    :page_added => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "Emitted when the total number of pages of a [`Notebook`](@ref) increases, where `page_index` is the position of the page that was inserted."
    ),
    :page_removed => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "Emitted when a page is removed from the [`Notebook`](@ref), where `page_index` is the old index of the page that was removed."
    ),
    :page_selection_changed => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "Emitted when the currently active page changes by any means, where `page_index is the index of the now-visible page." 
    ),
    :items_changed => (
        "(::T, position::Integer, n_removed::Integer, n_added::Integer, [::Data_t]) -> Cvoid", 
        "The number of menu items or any property of any menu item already inside the [`MenuModel`](@ref) is modified."
    )
])

import Latexify

macro signal_table(T, signals...)

    ids = ["ID"]
    signatures = ["Signature"]
    descriptions = ["Description"]

    for signal_id in signals
        push!(ids, string(signal_id))

        signature = signal_descriptors[signal_id][1]
        push!(signatures, replace(signature, "T" => string(T)))

        push!(descriptions, "**Emitted when: **" * signal_descriptors[signal_id][2])
    end

    return Latexify.mdtable(ids, signatures, descriptions; latex=false)
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
        signature = replace(signal_descriptors[id][1], "::T" => "::" * string(T))
        description = signal_descriptors[id][2]

        push!(out, """
        > #### `$id`
        > > ```
        > > $signature
        > > ```
        > $description

        """)
    end
    return join(out)
end