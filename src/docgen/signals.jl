#
# Author: C. Cords (mail@clemens-cords.com)
# GitHub: https://github.com/clemapfel/mousetrap.jl
# Documentation: https://clemens-cords.com/mousetrap
#
# Copyright © 2023, Licensed under lGPL-3.0
#

void_signature = "(::T, [::Data_t]) -> Nothing"
const signal_descriptors = Dict([

    :activate => (
        void_signature, 
        "Emitted when an activatable widget is activated by the user, usually by pressing the enter key."
    ),
    :activate_item => (
        "(::T, index::Integer, [::Data_t]) -> Nothing",
        "Emitted when the user presses the enter key while one or more items are selected."
    ),
    :startup => (
        void_signature, 
        "Emitted when an `Application` has initialzed the back-end and is about to start the main loop."
    ),
    :shutdown => (
        void_signature, 
        "Emitted when an `Application` is exiting the main loop and attempting to shut down."
    ),
    :update => (
        void_signature, 
        "Emitted exactly once per frame, when the widget associated with the `FrameClock` is about to be drawn."
    ),
    :paint => (
        void_signature, 
        "Emitted exactly once per frame, when the widget associated with the `FrameClock` is was drawn."
    ),
    :realize => (
        void_signature, 
        "Emitted when the widget is shown for the first time after being initialized."
    ),
    :unrealize => (
        void_signature, 
        "Emitted when the widget was hidden and no longer has an allocated area on screen."
    ),
    :destroy => (
        void_signature, 
        "Emitted when the widgets reference count reaches 0, it will be finalized and deleted permanently."
    ),
    :hide => (
        void_signature, 
        "Emitted when the widget is hidden, for example by calling `hide!`, being removed from its parent, or its parent being hidden."
    ),
    :show => (
        void_signature, 
        "Emitted when the widget is shown, for example by calling `show!` or its parent being shown."
    ),
    :map => (
        void_signature, 
        "Emitted when the widget has chosen its final size allocation and is assuming its size and position on screen."
    ),
    :unmap => (
        void_signature, 
        "Emitted when the widget looses its current size allocation, usually in the process of being hidden or destroyed."
    ),
    :close_request => (
        "(::T, [::Data_t]) -> WindowCloseRequestResult", 
        "Emitted when the window is requested to be closed, for example by the user pressing the close button. Depending on whether the return value of the signal handler is `WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE` or `WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE`, closing of the window will be permitted or prevented."
    ),
    :closed => (
        void_signature, 
        "Emitted when a popover-window is closed, for example by calling `popdown!`, or it loosing focus while `set_autohide!` is set to `true`."
    ),
    :activate_default_widget => (
        void_signature, 
        "Emitted when the child widget designated via `set_default_widget!` was activated."
    ),
    :activate_focused_widget => (
        void_signature, 
        "Emitted when the child widget that currently holds input focus is activated."
    ),
    :clicked => (
        void_signature, 
        "Emitted when the user clicks the widget using a mouse or touchscreen."
    ),
    :toggled => (
        void_signature, 
        "Emitted when the widgets internal state changes from active to inactive, or inactive to active."
    ),
    :text_changed => (
        void_signature, 
        "Emitted when underlying text buffer is modified in any way."
    ),
    :selection_changed => (
        "(::T, position::Integer, n_items::Integer, [::Data_t]) -> Nothing", 
        "The number or position of one or more selected items has changed, where `position` is the item index that was modified, `n_items` is the number of items currently selected."
    ),
    :key_pressed => (
        "(::T, code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", 
        "Emitted when the user presses a non-modifier key (which is currently not pressed), while the controllers associated widget holds input focus."
    ),
    :key_released => (
        "(::T, code::KeyCode, modifiers::ModifierState, [::Data_t]) -> Nothing", 
        "Emitted when the user releases a non-modifier key (which is currently pressed), while the controllers associated widget holds input focus."
    ),
    :modifiers_changed => (
        "(::T, modifiers::ModifierState, [::Data_t]) -> Nothing", 
        "Emitted when the user presses or releases a modifier key, while the controllers associated widget holds input focus."
    ),
    :drag_begin => (
        "(::T, start_x::AbstractFloat, start_y::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted exaclty once, on the first frame a drag gesture is recognized, where `start_y` and `start_x` are the initial position of the cursor, in pixels."
    ),
    :drag => (
        "(::T, x_offset::AbstractFloat, y_offset::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted once per frame while a drag gesture is active, where `x_offset` and `y_offset` are the distance between the current position of the cursor, and the position at the start of the gesture, in pixels."
    ),
    :drag_end => (
        "(::T, x_offset::AbstractFloat, y_offset::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted exactly once, when the drag gesture seizes to be active, where `x_offset` and `y_offset` are the distance between the current position of the cursor, and the position at the start of the gesture, in pixels."
    ),
    :click_pressed => (
        "(::T, n_presses::Integer, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "User presses a mouse button (which is currently not pressed), while the controllers associated widget holds input focus. Where `n_presses` are the current number of clicks in the sequence, `x`, `y` are the current cursor position, in pixels."
    ),
    :click_released => (
        "(::T, n_presses::Integer, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "User releases a mouse button (which is currently pressed), while the controllers associated widget holds input focus. Where `n_presses` are the current number of clicks in the sequence, `x`, `y` are the current cursor position, in pixels."
    ),
    :click_stopped => (
        void_signature, 
        "Emitted exactly once to signal that a series of clicks ended."
    ),
    :focus_gained => (
        void_signature, 
        "Emitted when the widget that is currently not focused becomes focus."
    ),
    :focus_lost => (
        void_signature, 
        "Emitted when the widget that is currently focused looses focus."
    ),
    :pressed => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted once when a long-press gesture is recognized, where `x` and `y` are the current position of the cursor, in pixels."
    ),
    :press_cancelled => (
        void_signature, 
        "Emitted once when the user releases the button of a long-press gesture."
    ),
    :motion_enter => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted once when the users cursor first enters the allocated area of the widget on screen, where `x` and `y` are the current position of the cursor, in pixels."
    ),
    :motion => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted once per frame, while the cursor is inside the allocated area of the widget, where `x` and `y` are the current cursor position, in pixels."
    ),
    :motion_leave => (
        void_signature, 
        "Emitted exactly once when the cursor leaves the allocated area of the widget."
    ),
    :scale_changed => (
        "(::T, scale::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted any time the distance between two fingers of a pinch-zoom-gesture changes, where `scale` is the factor of the current distance between the two fingers, compared to the distance at the start of the gesture."
    ),
    :rotation_changed => (
        "(::T, angle_absolute::AbstractFloat, angle_delta::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted when the angle between the two fingers of a rotate-gesture changes, where `angle_delta` is the offset, `angle_absolute` the current angle, in radians."
    ),
    :scroll_begin => (
        void_signature, 
        "Emitted once when a scroll gesture is first recognized."
    ),
    :scroll => (
        "(::T, x_delta::AbstractFloat, y_delta::AbstractFloat, [::Data_t]) -> Nothing", 
        "Emitted once per frame while a scroll gesture is active, where `x_delta` and `y_delta` are the offset along the horizontal and vertical axis, in pixels."
    ),
    :scroll_end => (
        void_signature, 
        "Emitted to signal the end of a scroll gesture."
    ),
    :kinetic_scroll_decelerate => (
        "(::T, x_velocity::AbstractFloat, y_velocity::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once per frame while kinetic scrolling is active, see the manual on `ScrollEventController` for more information."
    ),
    :stylus_down => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once when the stylus makes contact with the touchpad, where `x` and `y` are the cursor position, in pixels."
    ),
    :stylus_up => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once when the stylus seizes to make contact with the touchpad, where `x` and `y` is the cursor position, in pixels."
    ),
    :proximity => (
        "(::T, x::AbstractFloat, y::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted when the stylus enters or exits the proximity distance recognized by the touchpad. This will usually precede a `stylus_down` or `stylus_up` signal."
    ),
    :swipe => (
        "(::T, x_velocity::AbstractFloat, y_velocity::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once per frame while a swipe gesture is active, where `x_velocity` and `y_velocity` are the current velocity of the swipe, in pixels."
    ),
    :pan => (
        "(::T, ::PanDirection, offset::AbstractFloat, [::Data_t]) -> Cvoid", 
        "Emitted once per frame while a pan gesture is active, where `offset` is the horizontal (or vertical) distance between the current position of the cursor, and the position at the start of the gesture, in pixels."
    ),
    :value_changed => (
        void_signature, 
        "Emitted when the `value` property of the `Adjustment` changes."
    ),
    :properties_changed => (
        void_signature, 
        "Emitted when any property of the `Adjustment` other than `value` changes."
    ),
    :wrapped => (
        void_signature,
        "Emitted when a `SpinButton`s value wraps from the minimum to the maximum, or vice-versa, while `set_should_wrap!` was set to `true`." 
    ),
    :scroll_child => (
        "(::T, scroll_type::ScrollType, is_horizontal::Bool, [::Data_t]) -> Cvoid", 
        "Emitted any time a user triggers a scroll action that moves one or both of the `Viewport`s scroll bars, where `scroll_type` identifies the type of action that triggered the scrolling, while `is_horizontal` determines along which axis the scrolling took place."
    ),
    :render => (
        "(::T, gdk_gl_context::Ptr{Cvoid}, [::Data_t]) -> Bool", 
        "Emitted once per frame before the GL framebuffer is flushed to the screen. The `gdk_gl_context` argument is for internal use only and can be ignored."
    ),
    :resize => (
        "(::T, width::Integer, height::Integer, [::Data_t]) -> Cvoid", 
        "Emitted whenver the allocated area of a `RenderArea` changes, where `width` and `height` are the new size, in pixels."
    ),
    :activated => (
        void_signature, 
        "Emitted when `activate!` is called, or the `Action` is otherwise activated."
    ),
    :revealed => (
        void_signature, 
        "Emitted once when a `Revealer`s child goes from hidden to shown (or shown to hidden) and the corresponding animation has finished playing."
    ),
    :switched => (
        void_signature,
        "Emitted whenever the internal state of a `Switch` changes, for example by `set_is_active!`, or by the user operating the `Switch`."
    ),
    :page_reordered => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "Emitted when a page changes position, where `page_index` is the new position of the page."
    ),
    :page_added => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "Emitted when the total number of pages increases, where `page_index` is the position of the page that was inserted."
    ),
    :page_removed => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "Emitted when a page is removed, where `page_index` is the old index of the page that was removed."
    ),
    :page_selection_changed => (
        "(::T, page_index::Integer, [::Data_t]) -> Cvoid", 
        "Emitted when the currently active page changes by any means, where `page_index` is the index of the now visible page." 
    ),
    :items_changed => (
        "(::T, position::Integer, n_removed::Integer, n_added::Integer, [::Data_t]) -> Cvoid", 
        "Emitted when the number of menu items, or any of their properties, changes."
    ),
    :dismissed => (
        "(::T, [::Data_t]) -> Cvoid", 
        "Emitted when the user clicks the close button of the `PopupMessage`"
    ),
    :button_clicked => (
        "(::T, [::Data_t]) -> Cvoid", 
        "Emitted when the user clicks the button of a `PopupMessage`. Note that the button is only visible if `set_button_label!` was set to anything but `\"\"`"
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

        push!(descriptions, signal_descriptors[signal_id][2])
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