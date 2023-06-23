# Chapter 5: Event Handling

In this chapter, we will learn:
+ How to manually handle user interaction
+ What an event controller is
+ How to connect an event controller to any widget

--- 

## Introduction: Event Model

So far, we were able to react to a user interacting with the GUI through widgets. For example, if the user pressed the left mouse button while hovering over a `Button`, that button will emit the signal `clicked`, which can trigger our custom behavior. While this mechanism works, it can also be fairly limiting. Pre-defined widgets will only have pre-defined way of interacting with them. We cannot react to the user pressing a keyboard key using just `Button`. To do that, we will need an **event controller**. 

### What is an Event?

When the user interacts with a computer in the physical world, they will control some kind of device, for example a mouse, keyboard, touchpad, webcam, stylus, etc. Through a driver, the device will react to user behavior and send data to the operating system, which then processes the data into what is called an **event**. 

Pressing a keyboard key is an event, releasing the key is a new event. Moving the cursor by one unit is an event, pressing a stylus against a touchpad is an event, etc. Mousetrap is based on GTK4, which has very powerful and versatile event abstraction. We don't have to deal with OS-specific events directly, instead, the GTK backend will automatically transform and distribute events for us, regardless of the operating system or peripheral.

To receive events, we need an [`EventController`](@ref). The `EventController` type is abstract, meaning we cannot use it directly. Instead, we deal with one or more of its subtypes. Each child class handles one one conceptual type of event. 

**In order for an event controller to be able to capture events, it needs to be connected to a widget**. Once connected, if the widget holds **input focus**, events are forwarded to the event controller, whose signals we can then connect custom behavior to.

## Input Focus

The concept of [**input focus**](https://en.wikipedia.org/wiki/Focus_(computing)) is important to understand. In mousetrap (and GUIs in general), each widget has a hidden property that indicates whether the widget currently **holds focus**. If a widget holds focus, all its children hold focus as well. For example, if the focused widget is a `Box`, all widgets inside that box also hold focus.

**Only a widget holding focus can receive input events**. Which widget acquires focus is controlled by a somewhat complex heuristic, usually using things like which window is on top and where the user last interacted with the GUI. For most situations, this mechanism works very well and we don't have to worry about it much, in the rare cases we do, we can control the focus directly.

### Preventing Focus

Only `focusable` widgets can hold focus. We can make a widget focusable by calling [`set_is_focusable!`](@ref). Not all widgets are focusable by default. To know which are and are not focusable, we can use common sense: Any widget that has a way of interacting with it (such as a `Button`, `Entry`, `Scale`, `SpinButton` etc.) will be focusable by default. Widgets that have no native way of interacting with them are not focusable unless we specifically request them to be. This includes widget like `Label`, `ImageDisplay`, `Separator`, etc.

If a container widget has at least one focusable child, it itself is focusable.

To prevent a widget from being able to gain focus, we can either disable it entirely by setting [`set_can_respond_to_input!`](@ref) to `false`, or we can delcare it as not focusable 
using `set_is_focusable!`.

### Requesting Focus

[`grab_focus!`](@ref) will make a widget attempt to gain input focus, stealing it from whatever other widget is currently focused. If this is impossible, for example because the widget is disabled, not yet shown, or is not focusable, nothing will happen. We can check if a widget currently has focus by calling [`get_has_focus`](@ref).

Many widgets will automatically grab focus if interacted with, for example, if the user places the text cursor inside an `Entry`, that entry will grab focus. Pressing enter now activates the entry, even if another widget held focus before. If a `Button` is clicked, it will usually grab focus. We can make any widget, even those that do not require interaction, grab focus when clicked by setting [`set_focus_on_click!`](@ref) to `true`.

The user can also decide which widget should hold focus, usually by pressing the tab key. If [`set_focus_visible!`](@ref) was set to `true` for the toplevel window, the focused widget 
will be highlighted using a transparent border.

## Event Controllers

### Connecting a Controller

Using our newly gained knowledge about focus, we'll create our first event controller: `FocusEventController`. This controller reacts to a widget gaining or loosing input focus.

After creating an event controller, it will not yet react to any events. We need to **add the controller to a widget**. For this chapter, we will assume that this widget is the top-level window, called `window` in the code snippets in this chapter.

We create and connect a `FocusEventController` like so:

```julia
focus_controller = FocusEventController()
add_controller!(window, focus_controller)
```

While the controller will now receive events, nothing else will happen. We need to connect to one of more of its signals, using the familiar signal handler callback mechanism.

## Gaining / Loosing Focus: FocusEventController

`FocusEventController` has two signals:

```@eval
include("signals.jl")
return @type_signals(FocusEventController,
    focus_gained,
    focus_lost
)
```
After connecting to these signals:

```julia
focus_controller = FocusEventController()
connect_signal_focus_gained!(focus_controller) do self::FocusController
    println("focus gained")
end
add_controller(window, focus_controller)
```

we have succesfully created our first event controller and can now react to input focus. 

---

## Keyboard Keys: KeyEventController

Monitoring focus is rarely necessary, for something much more commonly used, we turn to keyboard key strokes, which is whenever a button on keyboard goes from not-pressed to pressed (down), or pressed to not-pressed (up). We capture events of this type using  `KeyEventController`. 

Before we can talk about the controller itself, we need to talk about keyboard keys:

### Key Identification

From the [chapter on actions](./03_actions.md) we recall that keyboard keys are split into two groups, **modifiers** and **non-modifiers**. Like with shortcut triggers,
these are handled separately.

Each non-modifier key has a key-code, which will be a constant defined by `mousetrap`. A full list of constants is available [here](https://github.com/Clemapfel/mousetrap.jl/blob/main/src/key_codes.jl). They provide a nice, human-readable way to identify keys. To refer to the space key, mousetrap uses a hard-coded integer, but for us humans all way have to remember is the name of the constant: `KEY_space`.

### KeyEventController Signals

Now that we know how to identify keys, we can instance `KeyEventController`, which has 3 signals:

```@eval
include("signals.jl")
return @type_signals(KeyEventController,
    key_pressed,
    key_released,
    modifiers_changed
)
```

We see that pressing and releasing a non-modifier key are handled in separate signals. These can be used to track whether a key is currently up or down. Lastly, pressing or releasing any modifier key (such as control, alt, shift, etc.) is handled by the `modifiers_changed` signal.

The signal handler for any of the three signals is handed to arguments, a `KeyCode`, which is the key code constant of the keyboard key that triggered the signals, as well as `ModifierState`. This is an object that holds information about which modifiers are currently pressed. To query it, we use [`control_pressed`](@ref), [`shift_pressed](@ref), and [`alt_pressed`](@ref), which return `true` or `false` depending on whether the modifier key is currently down.

For example, to test whether the user pressed the space key while shift is held, we would do:

```julia
key_controller = KeyEventController()
connect_signal_key_pressed(key_controller) do self::KeyController, code::KeyCode, modifier_state::ModifierState
    if code == KEY_space && shift_pressed(modifier_state)
        println("shift + space pressed")
    end
end
```

`KeyEventController` should be used if we have to monitor both pressing and releasing a key or key combination. If all we want to do is trigger behavior when the user presses a key or key combination once, we should use `ShortcutEventController` instead:

## Detecting Key Bindings: ShortcutEventController

Recall that in the [chapter on actions](./03_actions.md), we learned that a shortcut trigger, or keybinding, is made up of any number of modifier keys, along with exactly one non-modifier. 

To react to the user pressing such a shortcut, we should use `ShortcutEventController`, which has an easier-to-use and more flexibl interface as compared to `KeyEventController`. 

We first need an `Action`, which we assign a shortcut trigger;

```julia
action = Action("shortcut_controller.example", app) do self::Action
    println("shift + space pressed")
end
add_shortcut!(action, "<Shift>space")
```

Where `app` is an `Application` instance.

We can then create a `ShortcutEventController` instance, and call `add_action!`, after which it will listen for the associated keybinding of that action. Any number of actions can be added to a `ShortcutEventController`, and it's common to have a global one that simply monitors keyboard key events.

In order for it to start receiving these events, we - just like before - need to connect it to a widget:

```julia
shortcut_controller = ShortcutEventController()
add_action!(shortcut_controller, action)
add_controller!(window, shortcut_controller)
```
Where `window` is the top-level window.

This mechanism is far more automated than having to manually check from within a `KeyEventController` signal handler if the current combination of buttons should trigger a shortcut action, which is why `ShortcutEventController` should be preferred in situations where we do not care about individual key strokes.

---

## Cursor Motion: MotionEventController

Now that we know how to handle keyboard events, we will turn our attention to mouse-based events. There are two types
of events a mouse can emit, **cursor motion**  and **mouse button presses**. These are handled by two different controllers.

For cursor motion, the event controller is [`MotionEventController`](@ref), which has 3 signals:

```@eval
include("signals.jl")
return @type_signals(MotionEventController,
    motion_enter,
    motion,
    motion_leave
)
```

`motion_enter` is emitted once when the cursor enters the widgets are, then, once per frame, `motion` is emitted to update us about the current cursor position. Lastly, when the cursor leaves the widgets allocated area, `motion_leave` is emitted exactly once.

`motion_enter` and `motion` supply us with the current cursor position, which is relative to the current widgets origin, in pixels.

That is, for a widget whose top-left corner (it's origin) is at position `(widget_position_x, widget_position_y)`,  if the coordinate supplied by the signals is `(x, y)`, then the cursor is at position `(widget_position_x + x, widget_position_y + y)`, in pixels. 

Printed here is an example of how to connect to these signals, where we forwarded `window`, the host widget of the controller, as the `data` argument of signal `motion`, in order to calculate the absolute position of the cursor on screen.

```julia
function on_motion(self::MotionEventController, x::AbstractFloat, y::AbstractFloat, instance::Widget)
    widget_position = get_position(instance)
    cursor_position = Vector2f(x, y)

    println("Absolute Cursor Position: $(widget_position + cursor_position)")
end

window = Window(app)
motion_controller = MotionEventController()
connect_signal_motion!(on_motion, motion_controller, window)
add_controller!(window, motion_controller)
```

---

## Mouse Button Presses: ClickEventController

With cursor movement taken care of, we now turn our attention to handling the other type of mouse event: button presses.

A mouse button is... any button on a mouse. Mice are hugely varied, with some having exactly one button, while some mice have 6 or more buttons. If the user uses no mouse at all, for example when choosing to control the app with a trackpad or touchscreen, touchscreen "taps" will be registered as if the left mouse button was pressed.

We track mouse button presses with \a{ClickEventController} which has 3 signals:

\signals
\signal_click_pressed{ClickEventController}
\signal_click_released{ClickEventController}
\signal_click_stopped{ClickEventController}

Much like with `MotionEventController`, the signals provides the handler with `x` and `y`, the absolute position of the cursor at the time the click happened, in widget-space.

The first argument for two of the signals `click_pressed` and `click_released`, `n_presses`, is the number of presses in the current click sequence. For example, `n_presses = 2` means that this is the second time a mouse button was pressed in sequence, `click_stopped` signals that a sequence of clicks has ended. It may be helpful to consider an example:

Let's say the user clicks the left mouse button 2 times total, then stops clicking. This will emit the following events in this order:
1) `click_pressed` (n_pressed = 1)
2) `click_released` (n_pressed = 1)
3) `click_pressed` (n_pressed = 2)
4) `click_released` (n_pressed = 2)
5) `click_stopped`

This allows us to easily handle double-clicks without any external function keeping track of them. The delay after which a click sequence stops is system-dependent and usually decided by the users operating system, not mousetrap.

### Differentiating Mouse Buttons

`ClickEventController` is one of a few event controllers that inherit from \a{SingleClickGesture}. \link mousetrap::SingleClickGesture This interface\endlink provides functionality that lets us distinguish between different mouse buttons. Mousetrap supports up to 9 different mouse buttons, identified by `mousetrap::ButtonID`:

+ ButtonID::BUTTON_01 is usually the left mouse button (or a touchpad tap)
+ ButtonID::BUTTON_02 is usually the right mouse button
+ ButtonID::ANY is used as a catch-all for all possible mouse buttons
+ ButtonID::BUTTON_03 - BUTTON_09 are additional mouse-model-specific buttons
+ ButtonID::NONE is none of the above

To check which mouse button was pressed, we use `ClickEventController::get_current_button` from within the signal handler, which returns an ID as stated above.

If we only want signals to be emitted for certain buttons, we can use `ClickEventController::set_only_listens_to_button` to restrict the choice of button. `ClickEventController::set_touch_only` filters all click events except those coming from touch devices.

If we want to activate an action when a widget `some_widget`, is clicked twice with the left mouse button specifically, we can do the following:

```cpp
auto click_controller = ClickEventController();
click_controller.connect_signal_click_pressed([](ClickEventController& controller, int32_t n_presses, double x, double y){
    if (n_pressed == 2 and controller->get_current_button() == ButtonID::BUTTON_01)
        std::cout << "double click registered at: " << x << " " << y << std::endl;
});
some_widget.add_controller(click_controller);
```

While `ClickEventController` gives us full control over one or multiple clicks, there is a more specialized
controller for a similar, but different purpose: *long presses*.

---

## Long-Presses: LongPressEventController

\a{LongPressEventController} reacts to a specific sequence of events, called a **long press**. A long press happens when the users presses a mouse button, then keeps that button depressed without moving the cursor. After enough time has passed, `LongPressEventController` will emit its signals:

\signals
\signal_pressed{LongPressEventController}
\signal_press_cancelled{LongPressEventController}

Where `pressed` is emitted the first frame the long press is recognized, `press_cancelled` is emitted once the user releases the mouse button.

Similar to `clicked`, `LongPressEventController` provides us with the location of the cursor in widget-space coordinates.

`LongPressEventController`, like `ClickEventController`, inherits from `SingleClickGesture`, which allows us to differentiate between different mouse buttons or a touchscreen, just as before.

We would check whether the user has held down the left mouse button like so:

```cpp
auto long_press = LongPressEventController();
long_press.connect_signal_pressed([](LongPressEventController& controller, double x, double y){
if (controller->get_current_button() == ButtonID::BUTTON_01)
    std::cout << "long press registered at " << x << " " << y << std::endl;
});
window.add_controller(long_press);
```

---

## Click-Dragging: DragEventController

We recall that a long press is a gesture in which a user clicks a mouse button, does not move the cursor, then **holds that position** for an amount of time. In contrast, **click-dragging** is very similar, the user clicks a mouse button, holds it, but **does move the cursor**. This is often used to "drag and drop" an UI element, such as dragging a file icon from one location to another, or dragging the knob of a `Scale`.

Click-dragging is automatically recognized by \a{DragEventController}, which has three signals:

\signals
\signal_drag_begin{DragEventController}
\signal_drag{DragEventController}
\signal_drag_end{DragEventController}

When a click-drag is first recognized, `drag_begin` is emitted. Each frame the drag is taking place, `drag` is emitted once per frame to update us about the cursor position. Once the gesture ends, `drag_end` is emitted. All three signals supply two additional arguments with signal-specific meaning:

+ `scroll_begin` supplies the absolute widget-space coordinate of the cursor location
+ `scroll` and `scroll_end` supply the **offset** between the current cursor position and the start

To get the current position of the cursor, we have to add the offset from `scroll` or `scroll_end` to the initial position. We can get the initial position either in `scroll_begin` or through the member function `ScrollEventController::get_start_position`:

```cpp
auto drag_controller = DragEventController();
drag_controller.connect_signal_drag([](DragEventController* instance, double x_offset, double y_offset){
    
    float cursor_position_x = instance->get_start_position().x + x_offset; 
    float cursor_position_y = instance->get_start_position().y + y_offset;
    
    std::cout << "Current cursor position: " << cursor_position_x << " " << cursor_position_y << std::endl;
});
window.add_controller(drag_controller);
```
---

## Panning: PanEventController

**Panning**  is similar to dragging, in that the user presses the mouse button (or touchscreen), then holds it down while moving the cursor to a different location. The difference between panning and click-dragging is that panning can only occur along exactly one of the two axis: left-right (the x-axis) or top-bottom (the y-axis). This is commonly seen in touchscreen UIs, for example, the user may scroll horizontally by using the pan gesture as opposed to a scroll wheel.

Panning is handled by the appropriately named \a{PanEventController}, which is the first controller in this chapter that takes an argument to its constructor. We supply a `mousetrap::Orientation`, which decides along which axis the controller should listen to panning for, `HORIZONTAL` for the x-axis, `VERTICAL` for the y-axis.

A controller cannot listen to both axis at once, though we can connect two controllers, one for each axis, to the same widget to emulate this behavior.

This controller only has one signal:

\signals
\signal_pan{PanEventController}

Where `PanDirection` is an enum with four values: `LEFT`, `RIGHT`, `UP` and `DOWN`. If the orientation was set to `HORIZONTAL`, only `LEFT` and  `RIGHT` can occur, and vice-versa for `VERTICAL`.

```cpp
auto pan = PanEventController(Orientation::HORIZONTAL);
pan.connect_signal_pan([](PanEventController*, PanDirection direction, double offset){
    if (direction == PanDirection::LEFT)
        // move widget left
    else if (direction == PanDirection::RIGHT)
        // move widget right
});
```
---

## Mousewheel-Scrolling: ScrollEventController

Other than clicking and cursor movement, many mice have a third function: scrolling. This is usually done with a designated wheel, though some operating systems also recognize scroll gestures using a trackpad or touchscreen. Either way, scroll events are registered by \a{ScrollEventController}, which has four signals:

\signals
\signal_scroll_begin{ScrollEventController}
\signal_scroll{ScrollEventController}
\signal_scroll_end{ScrollEventController}
\signal_kinetic_scroll_decelerate{ScrollEventController}

Three of these are fairly straighforward, when the user starts scrolling, `scroll_begin` is emitted. As the user keeps scrolling, `scroll` is emitted every frame, updating us about current position of the scroll wheel. The two additional arguments to the `scroll` signal handler, `delta_x` and `delta_y`, inform us about the distance of the scroll. Many systems support both vertical and horizontal scrolling (usually by clicking the mouse scroll wheel). When the user stops scrolling, `scroll_end` is emitted once.

### Kinetic Scrolling

`ScrollEventController` has a fourth signal which reacts to **kinetic scrolling**. Kinetic scrolling is a feature of modern UI, where the scroll movement simulates inertia. When the user triggers scrolling, usually through a swipe on a touchscreen, the widget being scrolled will continue scrolling even when the user is no longer touching the screen. The "friction" of the scrolling widget will slowly reduce the scroll speed, until it comes to a stop. `kinetic_scroll_decelerate` is emitted during this period, after the user has stopped touching the screen, but before the widget has a scroll speed of 0. Its additional arguments `x_velocity` and `y_velocity` are equal to the conceptual speed the widget currently should be scrolling at.

If we want to keep track of how far the user has scrolled a widget that had a `ScrollEventController` connect, we do the following:

```cpp
static Vector2f distance_scrolled = 0;

auto scroll = ScrollEventController();
scroll.connect_signal_scroll([](ScrollEventController*, double delta_x, double delta_y)-> bool {
    distance_scrolled.x += delta_x;
    distance_scrolled.y += delta_y;
    return false;
});
window.add_controller(scroll);
```
Where the return value `false` means the default handlers connected to signal `scroll` should not be surpressed, that is, any widget in `window` should still scroll graphically, just as if no event controller is connected at all. If we want to control the connect widget manually, returning `true` will prevent any default behavior from occurring.

---

## Pinch-Zoom: PinchZoomEventController

While `MotionEventController`, `ClickEventController`, etc. recognize both a mouse and touchscreen, mousetrap offers some touch-only gestures, though many trackpads also support them. These are usually gestures performed using two fingers, the first of which is **pinch-zoom**. Pinch-zoom is when the user places two fingers on the touchscreen, then moves either, such that the distance between the fingers changes. This gesture is commonly used to zoom a view in or out. It is recognized by `PinchZoomEventController`, which only has one signal:

\signals
\signal_scale_changed{PinchZoomEventController}

The argument `scale` is a *relative* scale, where `1` means no change between the distance of the fingers when compared to the distance at the start of the gesture, `0.5` means the distance halved, `2` means the distance doubled.

`scale_changed` is usually emitted one time per frame once the gesture starts. Applications should react to every tick, as opposed to only the last. This will make the application feel more responsive and create a better user experience.

To detect whether a user is currently zooming out (pinching) or zooming in, we do the following:

```cpp
auto zoom_controller = PinchZoomController();
zoom_controller.connect_signal_scale_changed([](PinchZoomController&, double scale){
    if (scale < 1)
        std::cout << "zooming in" << std::endl;
    else if (scale > 1)
        std::cout << "zooming out" << std::endl;
});
window.add_controller(zoom_controller);
```
---

## 2-Finger Rotate: RotateEventController

Another touch-only gesture is the **two-finger-rotate**. With this gesture, the user places both fingers on the touchscreen, then rotates them around a constant point in between the two fingers. This gesture is commonly used to rotate a view, for example an in an image editor.

This gesture is handled by `RotateEventController`, which has one signal:

\signals
\signal_rotation_changed{RotateEventController}

It takes two arguments: `angle_absolute` and `angle_delta`. `angle_absolute` provides the current angle between the two fingers. `angle_delta` is the difference between the current angle and the angle at the start of the gesture.  Both `angle_absolute` and `angle_delta` are provided in radians, to convert them we can use \a{Angle}:

```cpp
auto rotation_controller = RotationEventController();
rotation_controller.connect_signal_rotation_changed([](RotationEventController&, double angle_absolute_rad, double angle_delta_rad){
    
    Angle absolute = mousetrap::radians(angle_absolute_rad);
    Angle delta = mousetrap::radians(angle_delta_rad);
    
    std::cout << "Current Angle: " << absolute.as_degrees() << "°" << std::endl;
});
window.add_controller(rotation_controller);
```
---

## Swipe: SwipeEventController

The last touch-only gesture is **swiping**, which is very similar to a click-dragging, only with two fingers. Swiping is often used to "flick" through pages, for example those of a `Stack`.

Swiping is recognized by `SwipeEventController`, which also only has one signal:

\signals
\signal_swipe{SwipeEventController}

The signal handler provides two arguments `x_velocity` and `y_velocity`, which describe the velocity along both the x and y axis. The vector `(x_velocity, y_velocity)` describes the direction of the swipe in 2D widget space.

To illustrate how to deduce the direction of the swipe, consider this example:

```cpp
auto swipe_controller = SwipeEventController();
swipe_controller.connect_signal_swipe([](SwipeEventController*, double x_velocity, double y_velocity){
    
    // determine direction
    std::string x_direction = "";
    std::string y_direction = "";
    
    if (x_velocity < 0) 
        x_direction = "LEFT";
    else if (x_velocity > 0) // if velocity is == 0, string stays empy
        x_direction = "RIGHT";
    
    if (y_velocity < 0) 
        y_direction = "UP";
    else if (y_velocity > 0)
        y_direction = "DOWN";
        
    std::cout << "swiping " << y_direction << " " << x_direction < std::endl;
});
window.add(swipe_controller);
```

UIs should react to both the direction and magnitude of the vector, as the latter makes for a smoother user experience.

---

## Touchpad & Stylus: StylusEventController

Lastly, we have a highly specialized event controller. Common in illustration/animation, the **touchpad stylus** is usually a pen-like device which is used along with a **touchpad**, which may or may not be the screen of the device. 

Like with mice, there is a huge variety of stylus models. Shared among all models is a detection mechanism for whether the pen is **currently touching**, **not touching**, or **about to touch** the touchpad. 

A dditional features such as pressure- or angle-detected are manufacturer-specific. Many of these additional features are also recognized by \a{StylusEventController}, the event controller used to handle these kind of devices.

`StylusEventController` has four signals:

\signals
\signal_stylus_up{StylusEventController}
\signal_stylus_down{StylusEventController}
\signal_proximity{StylusEventController}
\signal_motion{StylusEventController}

We recognize signal `motion` from `MotionEventController`. It behaves [exactly the same](#cursor-motion--motioneventcontroller), where `x` and `y` are the cursor position in absolute widget space. 

The three other signals should be used to react to the physical distance between the stylus and touchpad. `stylus_down` is emitted when the pens tip makes contact with the touchpad, `stylus_up` is emitted when this contact is broken, `proximity` is emitted when the stylus about to touch the touchpad, or just left the touchpad.

### Stylus Axis

None of the above mentioned signals provide information about additionals stylus sensors. Because not all devices share these features, the mechanism for querying these is different. Each sensor provides a floating point value inside a given range. This is called a **device axis**. Axes are identified by the enum `DeviceAxis`, which has a value for all sensor types recognized by mousetrap.

We can query the value of each axis using `mousetrap::StylusEventController::get_axis_value`. This function will return 0 if the axis is not present, otherwise it will return the device-supplied axis-specific value. To check whether a device has a specific axis we use `mousetrap::StylusEventController::has_axis`.

Mousetrap recognizes the following axes:

| `DeviceAxis` value | Meaning                                                           | 
|--------------------|-------------------------------------------------------------------|
| `X`                | x-position of the cursor                                          |
| `Y`                | y-position of the cursor                                          |
| `DELTA_X`          | delta of horizontal scrolling                                     |
| `DELTA_Y`          | delta of vertical scrolling                                       |
| `PRESSURE`         | pressure sensor of the styus' tip                                 |
| `X_TILT`           | angle along the x-axis                                            | 
| `Y_TILT`           | angle along the y-axis                                            |
| `WHEEL`            | state of the stylus' wheel (if present)                           | 
| `DISTANCE`         | current distance between the touchpad surface and the stylus' tip |
 | `ROTATION`         | angle of the pen around the normal                                |
| `SLIDER` | value of the pens slider (if present)                             |

### Stylus Mode

Some stylus' have a "mode" function, where the user can choose between differen pen modes. This is driver specific, and not all devices support this feature. For those that do, we can use `StylusEventController::get_device_type` to check which mode is currently selected. The recognized modes are:

| `DeviceAxis` value | Meaning                   | 
|--------------------|---------------------------|
| `PEN`              | basic drawing tip         |
| `ERASER`           | eraser                    |
| `BRUSH`            | variable-width drawing tip |
| `PENCIL`           | fixed-width drawing tip   |
| `AIRBRUSH`         | airbrush tip              |
| `LENS`             | zoom tool                 | 
| `MOUSE`            | cursor tool               |
| `UNKNOWN`          | none of the above         |

If the stylus does not support brush shapes, `ToolType::UNKNOWN` will be returned.

---
