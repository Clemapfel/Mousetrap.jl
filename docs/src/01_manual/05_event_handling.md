# Chapter 5: Event Handling

In this chapter, we will learn:
+ What input focus is
+ What an event controller is
+ How to connect an event controller to any widget
+ How to react to any user input event

--- 

## Introduction: Event Model

So far, we have been able to react to a user interacting with the GUI through pre-made widgets. For example, if the user clicks a `Button`, that button will emit the signal `clicked`, which can trigger our custom behavior. While this mechanism works, it can also be fairly limiting. Pre-defined widgets will only have pre-defined ways of interacting with them. We cannot react to the user pressing the space bar with just `Button`. To do that, we will need an **event controller**. 

### What is an Event?

When the user interacts with a computer in the physical world, they will control some kind of device, for example a mouse, keyboard, touchpad, webcam, stylus, etc. Through a driver, the device will send data to the operating system, which then processes it into what is called an **event**. 

Pressing a keyboard key is an event; releasing the key is a new event. Moving the cursor by one unit is an event; pressing a stylus against a touchpad is an event, etc. Mousetrap is based on GTK4, which has very powerful and versatile event abstraction. We don't have to deal with OS-specific events directly, instead, the GTK backend will automatically transform and distribute events for us, regardless of the operating system or peripheral manufacturer.

To receive events, we need an [`EventController`](@ref). The `EventController` type is abstract, meaning we cannot use it directly. Instead, we deal with one or more of its subtypes. Each of which handles one conceptual type of event. 

**In order for an event controller to be able to capture events, it needs to be connected to a widget**. Once connected, if the widget holds **input focus**, events are forwarded to the event controller, whose signals we can then connect custom behavior to.

## Input Focus

The concept of [**input focus**](https://en.wikipedia.org/wiki/Focus_(computing)) is important to understand. In Mousetrap (and GUIs in general), each widget has a hidden property that indicates whether the widget currently **holds focus**. If a widget holds focus, all its children hold focus as well. For example, if the focused widget is a `Box`, all widgets inside that box also hold focus, while the widget the box is contained within does not.

**Only a widget holding focus can receive input events**. Which widget acquires focus is controlled by a somewhat complex heuristic, usually using things like which window is on top and where the user last interacted with the GUI. For most situations, this mechanism works very well and we don't have to worry about it much, in the rare cases we do, we can control the focus directly.

### Preventing Focus

Only `focusable` widgets can hold focus. We can make a widget focusable by calling [`set_is_focusable!`](@ref). Not all widgets are focusable by default. To know which are and are not focusable, we can use [`get_is_focusable`](@ref), or common sense: Any widget that has a way of interacting with it (such as a `Button`, `Entry`, `Scale`, `SpinButton`, etc.) will be focusable by default. Widgets that have no native way of interacting with them are not focusable, unless we specifically request them to be. This includes widgets like `Label`, `ImageDisplay`, `Separator`, etc.

If a container widget has at least one focusable child, it itself is focusable.

To prevent a widget from being able to gain focus, we can either disable the widget entirely by setting [`set_can_respond_to_input!`](@ref) to `false`, or we can declare it as not focusable using [`set_is_focusable!`](@ref).

### Requesting Focus

[`grab_focus!`](@ref) will make a widget attempt to gain input focus, stealing it from whatever other widget is currently focused. If this is not possible, for example, because the widget is disabled, not yet shown, or is not focusable, nothing will happen. We can check if a widget currently has focus by calling [`get_has_focus`](@ref).

Many widgets will automatically grab focus if interacted with. For example, if the user places the text cursor inside an `Entry`, that entry will grab focus. Pressing enter now activates the entry, even if another widget held focus before. If a `SpinButton` is clicked, it will usually grab focus. We can make any widget, even those that do not require interaction, grab focus when clicked by setting [`set_focus_on_click!`](@ref) to `true` after they have been made focusable.

The user can also decide which widget should hold focus, usually by pressing the tab key. If [`set_focus_visible!`](@ref) was set to `true` for the top-level window, the focused widget will be highlighted using a transparent border.

---

## Event Controllers

### Connecting a Controller

Using our newly gained knowledge about focus, we'll create our first event controller: [`FocusEventController`](@ref). This controller reacts to a widget gaining or losing input focus.

After creating an event controller, it will not yet react to any events. We need to **add the controller to a widget**. For this chapter, we will assume that this widget is the top-level window, called `window` in the code snippets henceforth.

We create and connect a `FocusEventController` like so:

```julia
focus_controller = FocusEventController()
add_controller!(window, focus_controller)
```

While the controller will now receive events, nothing else will happen. We need to connect to one or more of its signals, using the familiar signal handler mechanism.

## Gaining / Loosing Focus: FocusEventController

`FocusEventController` has two signals:

```@eval
using Mousetrap
return Mousetrap.@signal_table(FocusEventController,
    focus_gained,
    focus_lost
)
```

After connecting to these signals:

```julia
function on_focus_gained(self::FocusEventController) ::Nothing
    println("focus gained")
end

function on_focus_lost(self::FocusEventController) ::Nothing
    println("focus lost")
end

focus_controller = FocusEventController()
connect_signal_focus_gained!(on_focus_gained, focus_controller)
connect_signal_focus_gained!(on_focus_lost, focus_controller)
add_controller!(window, focus_controller)
```

We have successfully created our first event controller. Now, whenever `window` gains focus, a message will be printed.

---

## Keyboard Keys: KeyEventController

Monitoring focus is rarely necessary, for something much more commonly used, we turn to keyboard keystrokes. Events of this type are emitted whenever a key on a keyboard goes from not-pressed to pressed (down), or pressed to not-pressed (up). We capture events of this type using  [`KeyEventController`](@ref). 

### Key Identification

From the [chapter on actions](./03_actions.md) we recall that keyboard keys are split into two groups, **modifiers** and **non-modifiers**. Like with shortcut triggers, these are handled separately.

Each non-modifier key has a key-code, which will be a constant defined by `Mousetrap`. A full list of constants is available [here](https://github.com/Clemapfel/mousetrap.jl/blob/main/src/key_codes.jl), or as the global `Mousetrap.key_codes`, which provides a human-readable way to identify keys. 

For example, to refer to the space key, Mousetrap uses a hard-coded integer internally. We as developers do not need to remember this value, instead, we use the `KEY_space` constant:

```@repl
using Mousetrap
KEY_space
```

### KeyEventController Signals

Now that we know how to identify keys, we can instance `KeyEventController`, which has 3 signals:

```@eval
using Mousetrap
return Mousetrap.@signal_table(KeyEventController,
    key_pressed,
    key_released,
    modifiers_changed
)
```

We see that pressing and releasing a non-modifier key are handled in separate signals. These can be used to track whether a key is currently up or down. Lastly, pressing or releasing any modifier key (such as control, alt, shift, etc.) is handled by the `modifiers_changed` signal. Note that for `KeyEventController`, the left and right mouse button are also considered modifiers.

The signal handler for any of the three signals is handed two arguments, a `KeyCode`, which is the key code constant of the keyboard key that triggered the signals, as well as `ModifierState`. This is an object that holds information about which modifiers are currently pressed. To query it, we use [`control_pressed`](@ref), [`shift_pressed](@ref), and [`alt_pressed`](@ref), [`mouse_button_01_pressed`](@ref), and [`mouse_button_02_pressed`](@ref), which return `true` or `false` depending on whether the modifier is currently down.

For example, to test whether the user pressed the space key while shift is held, we could do:

```julia
function on_key_pressed(self::KeyEventController, code::KeyCode, modifier_state::ModifierState) ::Nothing
    if code == KEY_space && shift_pressed(modifier_state)
        println("shift + space pressed")
    end
end

key_controller = KeyEventController()

connect_signal_key_pressed!(on_key_pressed, key_controller)
add_controller!(window, key_controller)
```

While we would connect to the `KeyEventController`s other signals like so:

```julia
function on_key_released(self::KeyEventController, code::KeyCode, modifier_state::ModifierState) ::Nothing
    # handle key here
end

function on_modifiers_changed(self::KeyEventController, modifier_state::ModifierState) ::Nothing
    # handle modifiers here
end

connect_signal_key_released!(on_key_released, key_controller)
connect_signal_modifiers_changed!(on_modifiers_changed, key_controller)
```

`KeyEventController` should be used if we have to monitor both pressing **and releasing** a key or key combination. If all we want to do is trigger behavior when the user presses a combination once, we should use `ShortcutEventController` instead.

## Detecting Key Bindings: ShortcutEventController

Recall that in the [chapter on actions](./03_actions.md), we learned that a shortcut trigger, or keybinding, is made up of any number of modifier keys, along with exactly one non-modifier. 

To react to the user pressing such a shortcut, we should use [`ShortcutEventController`](@ref), which has an easier-to-use and more flexible interface than `KeyEventController`. 

We first need an `Action`, which we associate a shortcut trigger with:

```julia
action = Action("shortcut_controller.example", app) do self::Action
    println("shift + space pressed")
end
add_shortcut!(action, "<Shift>space")
```

Where `app` is an `Application` instance.

We can then create a `ShortcutEventController` instance and call `add_action!`, after which it will listen for the associated keybinding of that action. Any number of actions can be added to a `ShortcutEventController`, and they can be removed at any time using [`remove_action!`](@ref).

In order for the shortcut controller to start receiving events, we also need to connect it to a widget:

```julia
shortcut_controller = ShortcutEventController()
add_action!(shortcut_controller, action)
add_controller!(window, shortcut_controller)
```

Where `window` is the top-level window. Note that `ShortcutEventController` does not have any signals to connect to it. Instead, it automatically listens for shortcuts depending on which `Action` we added.

This mechanism is far more automated than having to manually check from within a `KeyEventController` signal handler if the current combination of buttons should trigger a shortcut action. This is why `ShortcutEventController` should be preferred in situations where we do not care about individual key strokes.

---

## Cursor Motion: MotionEventController

Now that we know how to handle keyboard events, we will turn our attention to mouse-based events. There are two types
of events a mouse can emit, **cursor motion**  and **mouse button presses**. These are handled by two different controllers.

For cursor motion, the event controller is called [`MotionEventController`](@ref), which has 3 signals:

```@eval
using Mousetrap
return Mousetrap.@signal_table(MotionEventController,
    motion_enter,
    motion,
    motion_leave
)
```

`motion_enter` is emitted once when the cursor enters the widget area, then, once per frame, `motion` is emitted to update us about the current cursor position. Lastly, when the cursor leaves the widget's allocated area, `motion_leave` is emitted exactly once.

`motion_enter` and `motion` supply us with the current cursor position, which is relative to the current widget's origin, in pixels. That is, for a widget whose top-left corner (its origin) is at position `(widget_position_x, widget_position_y)`,  if the coordinate supplied by the signals is `(x, y)`, then the cursor is at position `(widget_position_x + x, widget_position_y + y)`, in pixels. 

Shown here is an example of how to connect to these signals, where we forwarded `window`, the host widget of the controller, as the `data` argument of signal `motion`, in order to calculate the absolute position of the cursor on screen.

```julia
function on_motion(::MotionEventController, x::AbstractFloat, y::AbstractFloat, data::Widget) ::Nothing
    widget_position = get_position(data)
    cursor_position = Vector2f(x, y)

    println("Absolute Cursor Position: $(widget_position + cursor_position)")
end

window = Window(app)
motion_controller = MotionEventController()

connect_signal_motion!(on_motion, motion_controller, window)
add_controller!(window, motion_controller)
```

While we would connect to `MotionEventController`s other signals like so:

```julia
function on_motion_enter(::MotionEventController, x::AbstractFloat, y::AbstractFloat) ::Nothing
    # handle cursor enter
end

function on_motion_leave(::MotionEventController) ::Nothing
    # handle cursor leave
end

connect_signal_motion_enter!(on_motion_enter, motion_controller, window)
connect_signal_motion_leave!(on_motion_leave, motion_controller, window)
```

---

## Mouse Button Presses: ClickEventController

With cursor movement taken care of, we now turn our attention to handling the other type of mouse event: button presses.

A mouse button is... any button on a mouse, which is less intuitive than it sounds. Mice are hugely varied, with some having exactly one button, while some mice have six or more buttons. If the user uses no mouse at all, for example, when choosing to control the app with a trackpad, trackball, or touchscreen, touchscreen "taps" will be registered as if the left mouse button was pressed.

We track mouse button presses with [`ClickEventController`](@ref) which has 3 signals:

```@eval
using Mousetrap
return Mousetrap.@signal_table(ClickEventController,
    click_pressed,
    click_released,
    click_stopped
)
```

Much like with `MotionEventController`, the signals provide the handler with `x` and `y`, the position of the cursor at the time the click happened, relative to the host widget's origin, in pixels.

The first argument for two of the signals `click_pressed` and `click_released`, `n_presses`, is the number of presses in the current click sequence. For example, `n_presses = 2` means that this is the second time a mouse button was pressed in sequence, `click_stopped` is emitted when that sequence of clicks has ended. It may be helpful to consider an example:

Let's say the user clicks the left mouse button two times total, then stops clicking. This will emit the following events in this order:

| Order | Signal ID | `n_pressed` value |
|--------|-----------|------------------|
| 1 | `click_pressed` | 1 |
| 2 | `click_released` | 1 |
| 3 | `click_pressed` | 2 |
| 4 | `click_released` | 2 |
| 5 | `click_stopped`| (none) |

Thanks to the `n_pressed` argument, we can easily handle double-clicks without any external function keeping track of how often the user has clicked so far. The delay after which a click sequence stops is system-dependent and usually decided by the user's operating system, not Mousetrap.

### Differentiating Mouse Buttons

`ClickEventController` is one of a few event controllers that are also a subytpe of [`SingleClickGesture`](@ref). This interface provides functionality that lets us distinguish between different mouse buttons. Mousetrap supports up to 9 different mouse buttons, identified by the enum [`ButtonID`](@ref):

+ `BUTTON_ID_BUTTON_01` is usually the left mouse button (or a touchpad tap)
+ `BUTTON_ID_BUTTON_02` is usually the right mouse button
+ `BUTTON_ID_ANY` is used as a catch-all for all possible mouse buttons
+ `BUTTON_ID_BUTTON_03 - BUTTON_ID_BUTTON_09` are additional mouse-model-specific buttons
+ `BUTTON_ID_NONE` is none of the above

To check which mouse button was pressed, we use [`get_current_button`](@ref) on the event controller instance from within the signal handler, which returns an ID as stated above.

If we only want signals to be emitted for certain buttons, we can use [`set_only_listens_to_button!`](@ref) to restrict the choice of button. [`set_touch_only!`](@ref) filters all click events except those coming from touch devices.

As an example, if we want to check if the user pressed the left mouse button twice, we can do the following:

```julia
function on_click_pressed(self::ClickEventController, n_presses::Integer, x::AbstractFloat, y::AbstractFloat) ::Nothing
    if n_presses == 2 && get_current_button(self) == BUTTON_ID_BUTTON_01
        println("double click registered at ($x, $y)")
    end
end

click_controller = ClickEventController()
connect_signal_click_pressed!(on_click_pressed, click_controller)  
add_controller!(window, click_controller)
```

While we would connect to `ClickEventController`s other signals like so:

```julia
function on_click_released(self::ClickEventController, n_presses::Integer, x::AbstractFloat, y::AbstractFloat) ::Nothing
    # handle button up
end

function on_click_stopped(self::ClickEventController) ::Nothing
    # handle end of a series of clicks
end

connect_signal_click_released!(on_click_released, click_controller)
connect_signal_click_stopped!(on_click_stopped, click_controller)
```

While `ClickEventController` gives us full control over one or more clicks, there is a more specialized
controller for a similar, but slightly different gesture: *long presses*.

---

## Long-Presses: LongPressEventController

[`LongPressEventController`](@ref) reacts to a specific sequence of events, called a **long press** gesture. This gesture is recognized when the user presses a mouse button, then keeps that button depressed without moving the cursor. After enough time has passed, `LongPressEventController` will emit its signals:

```@eval
using Mousetrap
return Mousetrap.@signal_table(LongPressEventController,
    pressed,
    press_cancelled
)
```

Where `pressed` is emitted the first frame, the long press is recognized. If the user releases the button before this time threshold is met, `press_cancelled` is emitted instead.

Similar to `clicked`, `LongPressEventController` provides us with the location of the cursor, relative to the host widget's origin.

`LongPressEventController`, like `ClickEventController`, subtypes `SingleClickGesture`, which allows us to differentiate between different mouse buttons or a touchscreen, just as before.

```julia
function on_pressed(self::LongPressEventController, x::AbstractFloat, y::AbstractFloat) ::Nothing
    println("long press registered at ($x, $y)")
end

function on_press_cancelled(self::LongPressEventController) ::Nothing
    println("long press aborted")
end

long_press_controller = LongPressEventController()
connect_signal_pressed!(on_pressed, long_press_controller)
connect_signal_press_cancelled!(on_press_cancelled, long_press_controller)
add_controller!(window, long_press_controller)
```

---

## Click-Dragging: DragEventController

A long press is a gesture in which a user clicks a mouse button, does not move the cursor, then **holds that position** for an amount of time. In contrast, **click-dragging** is slightly different: the user clicks a mouse button, holds it, but **does move the cursor**. This is often used to "drag and drop" an UI element, such as dragging a file icon from one location to another, or dragging the knob of a `Scale`-like widget.

Click-dragging gestures are automatically recognized by [`DragEventController`](@ref), which has three signals:

```@eval
using Mousetrap
return Mousetrap.@signal_table(DragEventController,
    drag_begin,
    drag,
    drag_end
)
```

When a click-drag is first recognized, `drag_begin` is emitted. Each frame the drag is taking place, `drag` is emitted once per frame to update us about the cursor position. Once the gesture ends, `drag_end` is emitted exactly once. 

All three signals supply two additional arguments with signal-specific meaning:

+ `scroll_begin` supplies the cursor location, relative to the host widget's origin, in pixels
+ `scroll` and `scroll_end` supply the **offset** between the current cursor position, and the position at the start of the gesture, in pixels

To get the current position of the cursor, we have to add the offset from `scroll` or `scroll_end` to the initial position. We can get the initial position either in `scroll_begin`, or by calling [`get_start_position`](@ref).

To track the cursor position during a drag gesture, we can connect to `DragEventController`s signals like so:

```julia
function on_drag_begin(self::DragEventController, start_x::AbstractFloat, start_y::AbstractFloat) ::Nothing
    println("drag start: ($start_x, $start_y)")
end

function on_drag(self::DragEventController, x_offset::AbstractFloat, y_offset::AbstractFloat) ::Nothing
    start = get_start_position(self)
    println("drag update: ($(start.x + x_offset), $(start.y + y_offset)))")
end

function on_drag_end(self::DragEventController, x_offset::AbstractFloat, y_offset::AbstractFloat) ::Nothing
    start = get_start_position(self)
    println("drag end: ($(start.x + x_offset), $(start.y + y_offset)))")
end

drag_controller = DragEventController();
connect_signal_drag_begin!(on_drag_begin, drag_controller)
connect_signal_drag!(on_drag, drag_controller)
connect_signal_drag_end!(on_drag_end, drag_controller)

add_controller!(window, drag_controller)
```
---

## Panning: PanEventController

**Panning**  is similar to dragging, in that the user presses the mouse button (or touchscreen), then holds the button while moving the cursor to a different location. The difference between panning and click-dragging is that **panning can only occur along exactly one of the two axes**: left-right (the x-axis) or top-bottom (the y-axis). This is commonly used in touchscreen UIs, for example, the user may scroll horizontally by using a pan gesture as opposed to a scroll wheel or 2-finger swipe.

Panning is handled by the appropriately named [`PanEventController`](@ref), which is the first controller in this chapter that takes an argument to its constructor. We supply an [`Orientation`](@ref), which decides along which axis the controller should listen to panning for, `ORIENTATION_HORIZONTAL` for the x-axis, `ORIENTATION_VERTICAL` for the y-axis.

A pan controller cannot listen to both axes at once, though we can connect two controllers, one for each axis, to the same widget to emulate this behavior.

`PanEventController` only has one signal:

```@eval
using Mousetrap
return Mousetrap.@signal_table(PanEventController,
    pan
)
```

Which is emitted once per frame while the gesture is active.

[`PanDirection`](@ref) is an enum with four values: `PAN_DIRECTION_LEFT`, `PAN_DIRECTION_RIGHT`, `PAN_DIRECTION_UP` and `PAN_DIRECTION_DOWN`. If the orientation was set to `ORIENTATION_HORIZONTAL`, only `PAN_DIRECTION_LEFT` and `PAN_DIRECTION_RIGHT` can occur, and vice-versa for `ORIENTATION_VERTICAL`.

The second argument is the current offset, that is, the distance between the current position of the cursor and the position at which the gesture was first recognized, relative to the host widget's origin, in pixels.

```julia
function on_pan(self::PanEventController, direction::PanDirection, offset::AbstractFloat) ::Nothing
    if direction == PAN_DIRECTION_LEFT
        println("panning left by $offset")
    elseif direction == PAN_DIRECTION_RIGHT
        println("panning right by $offset")
    end
end

pan_controller = PanEventController(ORIENTATION_HORIZONTAL)
connect_signal_pan!(on_pan, pan_controller)
add_controller!(window, pan_controller)
```

---

## Mousewheel-Scrolling: ScrollEventController

Other than clicking and cursor movement, many mice have a third function: scrolling. This is usually done with a designated wheel, though some operating systems also recognize scroll gestures using a trackpad or touchscreen. Either way, scroll events are registered by [`ScrollEventController`](@ref), which has four signals:

```@eval
using Mousetrap
return Mousetrap.@signal_table(ScrollEventController,
    scroll_begin,
    scroll,
    scroll_end,
    kinetic_scroll_decelerate
)
```

Three of these are fairly straighforward, when the user starts scrolling, `scroll_begin` is emitted once. As the user keeps scrolling, `scroll` is emitted every frame, updating us about the current position of the scroll wheel. The two additional arguments to the `scroll` signal handler, `delta_x` and `delta_y` are the vertical and horizontal offset, relative to the cursor position at which the scroll gesture was first recognized. 

Many systems support both vertical and horizontal scrolling (usually by clicking the mouse scroll wheel), which is why we get two offsets. 

When the user stops scrolling, `scroll_end` is emitted once.

If we want to keep track of how far the user has scrolled a widget that had a `ScrollEventController` connect, we do the following:

```julia
# variable to keep track of distance scrolled
distance_scrolled = Ref{Vector2f}(Vector2f(0, 0))

# at the start of scroll, set sum to 0
function on_scroll_begin(self::ScrollEventController) ::Nothing
    global distance_scrolled[] = Vector2f(0, 0)
    println("scroll start")
end

# each frame, increase distance scrolled
function on_scroll(self::ScrollEventController, x_delta::AbstractFloat, y_delta::AbstractFloat) ::Nothing
    global distance_scrolled[] += Vector2f(x_delta, y_delta)
    return nothing
end

# at the end of scroll, print distance
function on_scroll_end(self::ScrollEventController) ::Nothing
    println("scrolled ($(distance_scrolled[].x), $(distance_scrolled[].y))")
end

# instance controller and connect signals
scroll_controller = ScrollEventController()
connect_signal_scroll_begin!(on_scroll_begin, scroll_controller)
connect_signal_scroll!(on_scroll, scroll_controller)
connect_signal_scroll_end!(on_scroll_end, scroll_controller)

add_controller!(window, scroll_controller)
```

Where we used a global [`Ref`](https://docs.julialang.org/en/v1/base/c/#Core.Ref) to safely reference the value of `distance_scrolled` from within the signal handlers.

### Kinetic Scrolling

`ScrollEventController` has a fourth signal that reacts to **kinetic scrolling**. Kinetic scrolling is a feature of modern UI, where the scroll movement simulates inertia. When the user triggers scrolling, the widget will continue scrolling even when the user is no longer touching the screen. The "friction" of the scrolling widget will slowly reduce the scroll velocity, until it comes to a stop. `kinetic_scroll_decelerate` is emitted during this period, after the user has stopped touching the screen, but before the widget has a scroll velocity of 0. Its additional arguments `x_velocity` and `y_velocity` inform us of the velocity the widget should currently be scrolling at.

To allow for kinetic scrolling, we need to enable it using [`set_kinetic_scrolling_enabled!`](@ref), the connect to the appropriate signal:

```julia
# enable kinetic scrolling
set_kinetic_scrolling_enabled!(scroll_controller, true)

# signal handler
function on_kinetic_scroll_decelerate(::ScrollEventController, x_velocity::AbstractFloat, y_velocity::AbstractFloat) ::Nothing
    println("kinetically scrolling with velocity of ($x_velocity, $y_velocity)")
end

# connect handler
connect_signal_kinetic_scroll_decelerate!(on_kinetic_scroll_decelerate, scroll_controller)
```

---

## Pinch-Zoom: PinchZoomEventController

While `MotionEventController`, `ClickEventController`, etc. recognize both events from a mouse and touchscreen, Mousetrap offers some touch-only gestures, though many trackpads also support them. These are usually gestures performed using two fingers, the first of which is **pinch-zoom**. Pinch-zoom is when the user places two fingers on the touchscreen, then moves either, such that the distance between the fingers changes. This gesture is commonly used to zoom a view in or out. 

It is recognized by [`PinchZoomEventController`](@ref), which only has one signal:

```@eval
using Mousetrap
return Mousetrap.@signal_table(PinchZoomEventController,
    scale_changed
)
```

The argument `scale` is a *relative* scale, where `1` means no change between the distance of the fingers when compared to the distance at the start of the gesture, `0.5` means the distance halved, `2` means the distance doubled.

`scale_changed` is usually emitted once per frame after the gesture is first recognized. Applications should react to every tick, as opposed to only the last. This will make the application feel more responsive and create a better user experience.

To detect whether a user is currently zooming out (pinching) or zooming in, we could do the following:

```julia
function on_scale_changed(self::PinchZoomEventController, scale::AbstractFloat) ::Nothing
    if scale < 1
        println("zooming in")
    elseif scale > 1
        pintln("zooming out")
    end
end

zoom_controller = PinchZoomEventController()
connect_signal_scale_changed!(on_scale_changed, zoom_controller)
add_controller!(window, zoom_controller)
```

---

## 2-Finger Rotate: RotateEventController

Another touch-only gesture is the **two-finger-rotate**. With this gesture, the user places two fingers on the touchscreen, then rotates them around a constant point in-between the two fingers. This is commonly used to change the angle of something.

This gesture is handled by [`RotateEventController`](@ref), which has one signal:

```@eval
using Mousetrap
return Mousetrap.@signal_table(RotateEventController,
    rotation_changed
)
```

It takes two arguments: `angle_absolute` and `angle_delta`. `angle_absolute` provides the current angle between the two fingers. `angle_delta` is the difference between the current angle and the angle at the start of the gesture.  Both `angle_absolute` and `angle_delta` are provided in radians, to convert them we can use [`Mousetrap.Angle`](@ref):

```julia
function on_rotation_changed(self::RotateEventController, angle_delta, angle_absolute) ::Nothing
    # convert to unit-agnostic Mousetrap.Angle
    absolute = radians(angle_absolute)
    delta = radians(angle_delta)

    println("Current Angle: $(as_degrees(absolute))°")
end

rotation_controller = RotateEventController()
connect_signal_rotation_changed!(on_rotation_changed, rotation_controller)
add_controller!(window, rotation_controller)
```

---

## Swipe: SwipeEventController

The last touch-only gesture is **swiping**, which is very similar to click-dragging, except with two fingers. Swiping is often used to "flick" through pages, for example, those of a `Stack`.

Swiping is recognized by [`SwipeEventController`](@ref), which also only has one signal:

```@eval
using Mousetrap
return Mousetrap.@signal_table(SwipeEventController,
    swipe
)
```

The signal handler provides two arguments, `x_velocity` and `y_velocity`, which describe the velocity along both the x- and y-axis. 

To illustrate how to deduce the direction of the swipe, consider this example:

```julia
function on_swipe(self::SwipeEventController, x_velocity::AbstractFloat, y_velocity::AbstractFloat) ::Nothing
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

swipe_controller = SwipeEventController()
connect_signal_swipe!(on_swipe, swipe_controller)  
add_controller!(window, swipe_controller)
```

UIs should react to both the direction and magnitude of the vector, even though the latter is ignored in this example.

---

## Touchpad & Stylus: StylusEventController

Lastly, we have a highly specialized event controller. Common in illustration and animation, the **touchpad stylus** is usually a pen-like device that is used along with a **touchpad**, which may or may not be the screen of the device. 

Like with mice, there is a huge variety of stylus models. Shared among all models is a detection mechanism for whether the pen is **currently touching**, **not touching**, or **about to touch** the touchpad, along with a way to determine the position of the tip of the stylus.

Additional features such as pressure or angle detection are manufacturer-specific. Many of these additional features are also recognized by [`StylusEventController`](@ref), the event controller used to handle these kinds of devices.

`StylusEventController` has four signals:

```@eval
using Mousetrap
return Mousetrap.@signal_table(StylusEventController,
    stylus_up,
    stylus_down,
    proximity,
    motion
)
```

We recognize signal `motion` from `MotionEventController`. It behaves [exactly the same](#cursor-motion-motioneventcontroller), where `x` and `y` are the cursor position, in widget space. 

The three other signals are used to react to the physical distance between the stylus and touchpad. `stylus_down` is emitted when the pen's tip makes contact with the touchpad, `stylus_up` is emitted when this contact is broken, `proximity` is emitted when the stylus is about to touch the touchpad, or just left the touchpad.

```julia
function on_stylus_up(self::StylusEventController, x::AbstractFloat, y::AbstractFloat) ::Nothing
    println("stylus is no longer touching touchpad, position: ($x, $y)")
end

function on_stylus_down(self::StylusEventController, x::AbstractFloat, y::AbstractFloat) ::Nothing
    println("stylus is ow touching touchpad, position: ($x, $y)")
end

function on_proximity(self::StylusEventController, x::AbstractFloat, y::AbstractFloat) ::Nothing
    println("stylus entered proximity range, position: ($x, $y)")
end

function on_motion(self::StylusEventController, x::AbstractFloat, y::AbstractFloat) ::Nothing
    println("stylus position: ($x, $y)")
end

stylus_controller = StylusEventController()
connect_signal_stylus_up!(on_stylus_up, stylus_controller)
connect_signal_stylus_down!(on_stylus_down, stylus_controller)
connect_signal_proximity!(on_proximity, stylus_controller)
connect_signal_motion!(on_motion, stylus_controller)

add_controller!(window, stylus_controller)
```

### Stylus Axis

None of the above-mentioned signals provide information about additional stylus sensors. Because not all devices share these features, the mechanism for querying these are different. Each sensor provides a floating point value within a given range. This range is called a **device axis**. Axes are described by the enum [`DeviceAxis`](@ref), whose values identify all types of axes recognized by Mousetrap.

We can query the value of each axis using [`get_axis_value`](@ref). This function will return 0 if the axis is not present. If it is, it will return the device-supplied axis-specific value. 

To check whether a device has a specific axis, we use [`has_axis`](@ref).

Mousetrap recognizes the following axes:

| `DeviceAxis` value | Meaning                                                           | 
|--------------------|-------------------------------------------------------------------|
| `DEVICE_AXIS_X`                | x-position of the pen                                          |
| `DEVICE_AXIS_Y`                | y-position of the pen                                          |
| `DEVICE_AXIS_DELTA_X`          | delta of horizontal scrolling                                     |
| `DEVICE_AXIS_DELTA_Y`          | delta of vertical scrolling                                       |
| `DEVICE_AXIS_PRESSURE`         | pressure sensor of the stylus' tip                                 |
| `DEVICE_AXIS_X_TILT`           | angle relative to the screen, x-axis                                            | 
| `DEVICE_AXIS_Y_TILT`           | angle relative to the screen, y-axis                                            |
| `DEVICE_AXIS_WHEEL`            | state of the stylus' wheel (if present)                           | 
| `DEVICE_AXIS_DISTANCE`         | current distance between the touchpad surface and the stylus' tip |
| `DEVICE_AXIS_ROTATION`         | angle of the pen around the normal                                |
| `DEVICE_AXIS_SLIDER`           | value of the pen's slider (if present)                             |

### Stylus Mode

Some styluses have a "mode" function, where the user can choose between different pen modes. This is driver specific, and not all devices support this feature. For those that do, we can use [`get_tool_type`](@ref) to check which mode is currently selected. The recognized modes are:

| `ToolType` value | Meaning                   | 
|--------------------|---------------------------|
| `TOOL_TYPE_PEN`              | basic drawing tip         |
| `TOOL_TYPE_ERASER`           | eraser                    |
| `TOOL_TYPE_BRUSH`            | variable-width drawing tip |
| `TOOL_TYPE_PENCIL`           | fixed-width drawing tip   |
| `TOOL_TYPE_AIRBRUSH`         | airbrush tip              |
| `TOOL_TYPE_LENS`             | zoom tool                 | 
| `TOOL_TYPE_MOUSE`            | cursor tool               |
| `TOOL_TYPE_UNKNOWN`          | none of the above         |

If the stylus does not support modes, `TOOL_TYPE_UNKNOWN` will be returned.

