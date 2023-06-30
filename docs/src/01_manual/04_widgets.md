# Chapter 4: Widgets

In this chapter, we will learn:
+ What a widget is
+ Properties that all widgets share
+ What widgets are available and how to use them
+ How to create compound widgets

---

!!! note "Running snippets from this section"
    To run any partial code snippet from this section, use the following `.jl` file:
    ```julia
    using mousetrap
    main() do app::Application
        window = Window(app)

        # snippet here, creates widget `x` and adds it to `window'

        present!(window)
    end
    ```
---

## What is a widget?

Widgets are the central element to any and all GUI applications. In general, a widget is anything that can be rendered on screen. Often, wigdets are **interactable**, which means that the user can trigger behavior by interacting with the widget 
using a device such as a mouse, keyboard or touchcsreen.

For example, to interact with the widget [`Button`](@ref) from the previous chapter, the user has to move the mouse cursor
over the area of the button on screen, then press the left mouse button. This will trigger an animation where the button 
changes its appearance to look "pressed in", emit its signal `clicked` to trigger custom behavior, then return to its previous state. Having used computers for many years, most of us never thing about how things work in this gradual of a manner, and `Button` specifically makes it so we don't have to, all those actions are already implemented for us, all we have to do is place the button and connect a signal.

## Widget Signals

In mousetrap, [`Widget`](@ref) is an abstract type that all widgets subtype. `Widget` is a subtype of `SignalEmitter`, meaning
all widgets are signal emitters, but not all signal emitters are widgets. 

All widgets **share a number of signals**. These signals are accessible for every subtype of widget:

| Signal ID  | Signature                     |
|------------|-------------------------------|
| `realize`  | `(::T, [::Data_t]) -> Cvoid`  |
| `destroy`  | `(::T, [::Data_t]) -> Cvoid`  | 
| `show`     | `(::T, [::Data_t]) -> Cvoid`  | 
| `hide`     | `(::T, [::Data_t]) -> Cvoid`  |
| `map`      | `(::T, [::Data_t]) -> Cvoid`  | 
| `unmap`    | `(::T, [::Data_t]) -> Cvoid`  | 

Where `T` is the subtype. For example, since `Button` is a widget, the signature of `Button`s signal `realize` is `(::Button, [::Data_t]) -> Cvoid`.

By the end of this chapter, we will have learned when exactly all these signals are emitted and what they mean. For now, we will just note that all widgets share these signals. For any widget in this chapter or in the docs, these signals are available. As such, they will not be listed for every `Widget` subtype.

---

## Widget Properties

When displayed on screen, a widgets size and location will be chosen dynamically. Resizing the window may or may not resize all widgets inside such that they fill the entire window. Multiple properties govern this behavior, and a somewhat complex heuristic determines the exact position and size. We can influence this process using multiple widget properties, which we will learn about in this chapter.

Each widget will choose a position and size on screen. We call this area, an axis-aligned rectangle, the widgets **allocated area**.

### Parent and Children

Widgets can be inside another widget. A widget that can contain other widgets is called a **container** widget. Each widget inside this container is called the **child** of the container.
Whether a widget can contain any children and how many depends on the type of widgets, some may contain no children, exactly one child, exactly two, or any number of children. Shared for all widgets, however, is that each widget has exactly one **parent**. This is the widget it is contained within.

Because a widget can only have exactly one parent, we cannot put the same widget instance into two containers. If we want two identical buttons on two different positions on screen, 
we have to create two button instances.

### Size Request

Moving onto the properties that determines the widgets size, we have its **size request**. This is a [`Vector2f`](@ref) which governs the minimum width and height of the widget, in pixels. Once set with [`set_size_request!`](@ref), no matter what, that widget will always allocate at least that amount of space. 

By default, all widgets size request is `Vector2f(0, 0)`. Setting the width and/or height of a widgets size request to `0` will tell the size manager, the algorithm determining the widgets final size on screen, that the widget has not made a request for a minimum size.

Manipulating the size request to influence a widgets minimum size is also called **size-hinting**.

### Accessing Widget Size

We can query information about a widgets current and target size using multiple functions, some of which only are available after a widget is **realized**. Realization means that the widget is initialized, has chosen it's final size on screen, and it ready to be displayed. When these conditions are met, widget will emit signal `realize`. 

Once realized, [`get_allocated_size`](@ref) and [`get_position`](@ref) return the current size and position of a widget, in pixels.

This size may or may not be equal to what we size-hinted the widget to, as size-hinting only determines the widgets minimum size. The layout manager is free to allocate a size larger than that.

Lastly, [`get_natural_size`](@ref) will access the size preferred by the layout manager. This size will always be equal to or larger than the size request. When trying to predict the size a widget will have, `get_natural_size` will give use the best measurement. Once the widget is realized, `get_allocated_size` and `get_position`  will gives us the exact value.

Layout management is very complex and the algorithm behind managing the size of the totality of all widgets is highly sophisiticated. Users of mousetrap are not required to understand this exact mechanism, only how to influence it.

On top of a widgets size request, a widgets target final allocated size depends on a number of other variables:

### Margin

Any widget has four margins: `start`, `end`, `top` and `bottom`. Usually, these correspond to empty space left, right, above, and below the widget, respectively. Margins are simply added to the corresponding side of the widget. In this way, they work similar to the [css properties of the same name](https://www.w3schools.com/css/css_margin.asp), though in mousetrap, margins may not be negative.

We use `set_margin_start`, `set_margin_end`, `set_margin_top` and `set_margin_bottom` to control each individual margin.

```julia
widget = # ...
set_margin_start!(widget, 10)
set_margin_end!(widget, 10)
set_margin_top!(widget, 10)
set_margin_bottom!(widget, 10)

# equivalent to
set_margin_horizontal(widget, 10)
set_margin_vertical(widget, 10)

# equivalent to
set_margin(widget, 10)
```

Where `set_margin_horizontal`, `set_margin_vertical` set two of the margins at the same time, while `set_margin` sets all four margins at once.

Margins are used extensively in UI design. They make an application look more professional and aesthetically pleasing. A good rule of thumb is that for a 1920x1080 display, the **margin unit** should be 10 pixels. That is, all margins should be a multiple of 10. If the display has a higher or lower resolution, the margin unit should be adjusted.

### Expansion

If the size of the parent of a widget changes, for example when resizing the window a `Button` is contained in, the widget may or may not **expand**. Expansion governs if a widget should
fill out the entire space available to it. We set expansion along the x- and y-axis separately using `set_expand_horizontally!` and `set_expand_vertically!`. If set to false, a widget will usually not grow past its natural size.

`set_expand!` is a convenience function that sets expansiong along both axes simultaneously.

```julia
widget = # ...
set_expand_horizontally(widget, false)
set_expand_vertically(widget, true)
```

### Alignment

Widget **alignment** governs how one or more widgets behave when grouped together, usually because they are all children of the same parent.

An example: a `Button` size-hinted to 100x100 pixels has expansion disabled (`set_expand!` was set to `false`). It has a margin of 0 and is placed inside a `Window`. When we scale the window, the button will not change size. Alignment, then, governs **where in the window the button is positioned**.

We set alignment for the horizontal and vertical axis separately, using `set_horizontal_alignment!` and `set_vertical_alignment!`, which both take value of the enum [`Alignment`](@ref). This enum has three possible values, whose meaning depends on whether we use this value for the horizontal or vertical alignment:

+ `ALIGNMENT_START`: left if horizontal, top if vertical
+ `ALIGNMENT_END`: right if horizontal, bottom if vertical
+ `ALIGNMENT_CENTER`: center of axis, regardless of orientation

For our example, the button would take on these locations based on which enum value we chose for each alignment axis:

| Vertical Alignment | Horizontal Alignment | Resulting Position  |
|--------------------|----------------------|---------------------|
| `ALIGNMENT_START`  | `ALIGNMENT_START`    | top left corner     |
| `ALIGNMENT_START`  | `ALIGNMENT_CENTER`   | top center          |
| `ALIGNMENT_START`  | `ALIGNMENT_END`      | top right corner    |
| `ALIGNMENT_CENTER` | `ALIGNMENT_START`    | center left         |
| `ALIGNMENT_CENTER` | `ALIGNMENT_CENTER`   | center              |
| `ALIGNMENT_CENTER` | `ALIGNMENT_END`      | center right        |
| `ALIGNMENT_END`    | `ALIGNMENT_START`    | bottom left corner  |
| `ALIGNMENT_END`    | `ALIGNMENT_CENTER`   | bottom center       |
| `ALIGNMENT_END`    | `ALIGNMENT_END`      | bottom right corner |

```julia
widget = # ...
set_horizontal_alignment!(widget, ALIGNMENT_START)
set_vertical_alignment!(widget, ALIGNMENT_START)

# equivalent to
set_alignment!(widget, ALIGNMENT_START)
```

Where `set_alignment!` sets both properties at the same time.

Using alignment, size-hinting, and expansion, we can fully control where and at what size a widget will appear on screen.

---

### Visibility & Opacity

Once a widget is realized and we call `present!` on the window it is contained in, it is **shown**, meaning it appears on screen and it emits signal `show`. If the widget leaves the screen, for example because it is removed from a container or its window is closed, it is **hidden**, emitting signal `hide`.

Another way to hide a shown widget or show a hidden widget is `set_is_visible!`:

```julia
# hide a button when it is clicked
button = Button()
connect_signal_clicked!(button) do self::Button
    set_is_visible!(self, false)
end
set_child!(window, button)
```

Here we hide a button when it is clicked. This means the button cannot be clicked again, as its interactivity is only available while it is shown. 

If we instead just want to make the button invisible, but still have it be clickable, we need use `set_opacity!`, which takes a float in `[0, 1]`, where `0` is fully transparent, `1` is fully opaque:

```julia
# make a button invisibile if it is visible, or visible if it is invisible
button = Button()
connect_signal_clicked!(button) do self::Button
    current = get_opacity(self)
    if current < 1.0
        set_opacity!(button, 1.0)
    else
        set_opacity!(button, 0.0)
    end
end
set_child!(window, button)
```

Setting opacity does emit the `hide` or `show` signals.

---

### Cursor Type

Each widget has a property governing what the user's cursor will look like while it is inside the widgets allocated area. By default, the cursor is a simple arrow. A widget intended for text-entry would want the cursor to be a [caret](https://en.wikipedia.org/wiki/Cursor_(user_interface)), while a clickable widget would likely want a [pointer](https://en.wikipedia.org/wiki/Cursor_(user_interface)#Pointer).

Some widgets already set the cursor to an appropriate shape automatically, but we can control the cursor shape for each individual widget manually using `set_cursor!`, which takes 
a value of the enum [`CursorType`](@ref):

| `CursorType` value            | Appearance                                                                                          |
|-------------------------------|-----------------------------------------------------------------------------------------------------|
| CURSOR_TYPE_NONE              | Invisible cursor                                                                                    |
| CURSOR_TYPE_DEFAULT           | Default arrow pointer                                                                               |
| CURSOR_TYPE_POINTER           | Hand pointing                                                                                       |
| CURSOR_TYPE_TEXT              | Caret                                                                                               |
| CURSOR_TYPE_GRAB              | Hand, not yet grabbing                                                                              |
| CURSOR_TYPE_GRABBING          | Hand, currently grabbing                                                                            |
| CURSOR_TYPE_CELL              | Cross, used for selecting cells from a table                                                        |
| CURSOR_TYPE_CROSSHAIR         | Crosshair, used for making pixel-perfect selections                                                 |
| CURSOR_TYPE_HELP              | Questionmark, instructs the user that clicking or hovering above this element will open a help menu |
| CURSOR_TYPE_CONTEXT_MENU      | Questionmark, instructs the user that clicking will open a context menu                             |
| CURSOR_TYPE_NOT_ALLOWED       | Instructs the user that this action is currently disabled                                           |
| CURSOR_TYPE_PROGRESS          | Spinning animation, signifies that the object is currently busy                                     |
| CURSOR_TYPE_WAIT              | Loading animation, Instructs the user that an action will become available soon                     |
| CURSOR_TYPE_ZOOM_IN           | Lens, usually with a plus icon                                                                      |
| CURSOR_TYPE_ALL_SCROLL        | Omni-directional scrolling                                                                          |
| CURSOR_TYPE_MOVE              | 4-directional arrow                                                                                 |
| CURSOR_TYPE_NORTH_RESIZE      | Up-arrow                                                                                            |
| CURSOR_TYPE_NORTH_EAST_RESIZE | Up-left arrow                                                                                       |
| CURSOR_TYPE_EAST_RESIZE       | Left arrow                                                                                          |
| CURSOR_TYPE_SOUTH_EAST_RESIZE | Down-left arrow                                                                                     |
| CURSOR_TYPE_SOUTH_RESIZE      | Down arrow                                                                                          |
| CURSOR_TYPE_SOUTH_WEST_RESIZE | Down-right arrow                                                                                    |
| CURSOR_TYPE_WEST_RESIZE       | Right arrow                                                                                         |
| CURSOR_TYPE_NORTH_WEST_RESIZE | Up-right arrow                                                                                      |
| CURSOR_TYPE_ROW_RESIZE        | Up-down arrow                                                                                       |
| CURSOR_TYPE_COLUMN_RESIZE     | Left-right arrow                                                                                    |


`Button`s default cursor is `CURSOR_TYPE_DEFAULT`. If we want to indicate to the user that the button should be clicked, we can instead set it to be a pointer:

```julia
button = Button()
set_cursor!(button, CURSOR_TYPE_POINTER)
```

The exact look of each cursor type depends on the users operating system and UI configuration. To choose a fully custom cursor, we use `set_cursor_from_image!`, which takes an `Image`. We will learn more about `Image` in the [chapter dedicated to it](./06_image_and_sound.md). Until then, this is how we set a cursor from a `.png` file on disk:

```julia
widget = # ...
set_cursor_from_image!(widget, Image("/path/to/image.png"))
```

---

### Tooltip

Each widget can optionally have a **tooltip**. This is a little window that opens when the cursor hovers over a widgets allocated area for enough time. The exact duration is decided by the users OS, we do not have control over it. 

Tooltips are usually a simple text message. For a case like this, we can set the text directly using `set_tooltip_text!`:

```cpp
button = Button()
set_tooltip_text!(button, "Click to Open");
```
\image html widget_tooltip_text.png

If we want to use something more complex than just simple text, we can register an arbitrarily complex widget as a tooltip by calling `set_tooltip_widget!`. As a matter of style, this widget should not be intractable, though there is no mechanism in place to enforce this.

---

## Window

For our first widget, we have \a{Window}. Windows are central to any application, as such, `Window` and `Application` are inherently connected. We cannot create a `Window` without an application. If all windows are closed, the underlying application usually exists, though we can prevent this using \a{Application::hold}.

While windows are widget, they occupy somewhat of a special place. A `Window` cannot be the child of any other widget, it is **top-level**.

This means that any and all widgets are direct or indirect children of a `Window`. `Window` can only have one direct child, which we set using `Window::set_child`.

`Window` has three signals (on top of those inherited from `Widget`):

\signals
\signal_close_request{Window}
\signal_activate_default_widget{Window}
\signal_activate_focused_widget{Window}

`activate_default_widget` is emitted when the default widge,  designated as such via `Window::set_default_widget`, emits its `activate` signal. Users can trigger the default widget by pressing enter while the widget is shown. This is useful for small message dialogs that have, for example, an "ok" and "cancel" button. By making the "ok" button the default widget, the user can simply press enter to confirm, making it so they do not have to operate the mouse.

Another of `Window`s signals,  `activate_focused_widget` is emitted when the widget that currently *holds input focus* is activated. We will about input focus [chapter on event handling](05_events.md), for now, we simply note that this signal exists.

Lastly, we have signal `close_request`:

### Close Request

When the window manager, which is the part of the user's operating system that deals with window layout and lifetime, request a window to close, the window does not immediately close. Instead, `Window` emits `close_request`, which we can connect to. This signal can be conceptualized as the window asking "should I really close right now?". If no signal handler is connected, the window closes immediately. This is the default behavior. If we do connect a signal handler, we can trigger custom behavior and prevent the window from closing.

We recall that the signature of `close_request` is `(Window&, (Data_t)) -> WindowCloseRequestResult`. This return type, \a{WindowCloseRequestResult} is an enum with two values `ALLOW_CLOSE` and `PREVENT_CLOSE`. Depending on which of the two is returned, the window does or does close when requested.

For example, to prevent a `Window` instance from closing until a global flag is set, we can do the following:

```cpp
auto window = Window(// ...

static bool should_close = false;
window.connect_signal_close_request([](Window&){

    std::cout << "Window is attempting to close" << std::endl;
    
    if (should_close)
        return WindowCloseRequestResult::ALLOW_CLOSE;
    else
        return WindowCloseRequestResult::PREVENT_CLOSE;
});
```

### Opening / Closing a Window

When we create a `Window` instance, it will be initially hidden. None of its widgets will be realized or shown, and the user has no way to know that the window exists. A `Window`s lifetime only begins once we call `Window::present`. This opens the window and shows it to the user. We've seen this in our previous `main.cpp`:

```cpp
app.connect_signal_activate([](Application& app)
{
    // main window
    auto window = Window(*app);

    // initialization here

    // make main window actually visible
    window.present();
});
```

Conversely, if we want a window to go back to its initial state, where it is hidden from the user, we call `Window::hide`. If we want to close the window permanently, unrealizing all widgets inside it, we use `Window::close`.

### Window Properties

Other than the signals, we can change s properties of any `Window`:

#### Title

`Window::set_title` sets the name displayed in the window's header bar. By default, this name will be the name of the application. We can choose to hide the title by simply calling `window.set_title("")`.

#### Modality & Transience

When dealing with multiple windows, we can influence the way two windows interact with each other. Two of these interactions are determined by whether a window is **modal** and whether it is **transient** for another window.

By setting `Window::set_modal` to true, if the window is revealed, **all other windows of the application will be deactivated**, preventing user interaction with them. This also freezes animations, it essentially pauses all other windows. The most common use-case for this is for dialogs, for example if the user requests to close the application, it is common to open a small dialog requesting the user to confirm exiting the application. While this dialog is shown, the main window should be paused until the user chooses an action.

Using `Window::set_transient_for`, we can make sure a window will always be shown in front of another. `A.set_transient_for(B)` will make it so, while `A` overlaps `B` on the user's desktop, `A` will be shown in front of `B`. 

#### HeaderBar

The part on top of a window is called the **header bar**. By default, it will show the window title and a minimize-, maximize- and close-button. We can completely hide the header bar using `Window::set_is_decorated`.

All `Window`s have space for one more widget (other than its child), which we insert using `Window::set_titlebar_widget`. This will usually be a \a{HeaderBar}, though any widget can be inserted this way.

`HeaderBar` is a widget that has three areas where other widgets can be inserted, at the front (left of the title), at the end (right of the title), or as the title. 

An alternative way of formatting the `HeaderBar` is with **header bar layouts**, which is a string supplied to `HeaderBar::set_layout`.

This is a list of button IDs. Valid IDs are restricted to:

+ `maximize`: Maximize Button
+ `minimize`: Minimize Button
+ `close`: Close Button

We choose which buttons are allocated on which side of the title by using `:`. Buttons before `:` are shown left of the title, buttons after `:` are shown right of the title. A list of buttons is delineated with `,`.

Some examples, where we used the alternative constructor for `HeaderBar` which takes the layout string directly:

```cpp
window.set_title("mousetrap");
window.set_titlebar_widget(HeaderBar("close:minimize,maximize"));
```

\image html headerbar_close_minimize_maximize.png

```cpp
window.set_title("");
window.set_titlebar_widget(HeaderBar("close:"));
```

\image html headerbar_close_no_title.png


```cpp
window.set_title("mousetrap");
window.set_titlebar_widget(HeaderBar(":close"));
```

\image html headerbar_title_close.png

---

---

## Label

In contention for being *the* most used widget, `Label`s are important to understand. A `Label` displays static text, which is not interactable. It is initialized as one would expect:

```cpp
auto label = Label("text");
```

To change a `Label`s text after initialization, we use `Label::set_text`. Most of the time, this will be a signle line of text or a word. If we supply multiple lines of text for `Label`, we can choose from some additional formatting options:

### Justify Mode

[Justification](https://en.wikipedia.org/wiki/Typographic_alignment) determines how words are distributed along the horizontal axis. There are 5 modes in total, all of which are part of the enum \a{JustifyMode}:

\image html text_justify_left.png "JustifyMode::LEFT"<br>
\image html text_justify_center.png "JustifyMode::CENTER"<br>
\image html text_justify_right.png "JustifyMode::RIGHT"<br>
\image html text_justify_fill.png "JustifyMode::FILL"<br>

Where the fifth mode is `JustifyMode::NONE` which arranges all text in exactly one line.

### Wrapping

Wrapping determines where a line break is inserted if the text's width exceeds that of the `Label`s parent widget. For wrapping to happen at all, the `JustifyMode` has to be set to anything **other** than `JustifyMode::NONE`.

Wrapping mode are values of the enum \a{LabelWrapMode}:

| `LabelWrapMode` value  | Meaning                                                 | Example                 |
|------------------------|---------------------------------------------------------|-------------------------|
| `NONE`                 | no wrapping                                             | `"humane mousetrap"`    |
| `ONLY_ON_WORD`         | line will only be split between two words               | `"humane\nmousetrap"`   |
| `ONLY_ON_CHAR`         | line will only be split between syllables, adding a `-` | `"hu-\nmane mousetrap"` |
| `WORD_OR_CHAR`         | line will be split between words and/or syllables       | see above               |

Where `\n` is the newline character.

### Ellipsize Mode

If a line is too long for the available space and wrapping is disabled, **ellipsizing** will take place. The corresponding enum `EllipsizeMode` has four possible value:

| `EllipsizeMode` value | Meaning                                                  | Example                     |
|-----------------------|----------------------------------------------------------|-----------------------------|
| `NONE`                | text will not be ellipsized                              | `"Humane mousetrap engineer"` |
| `START`               | starts with `...`, showing only the last few words       | `"...engineer"`               |
| `END`                 | ends with `...`, showing only the first few words        | `"Humane mousetrap..."`       |
| `MIDDLE`              | `...` in the center, shows start and beginning           | `"Humane...engineer"`         |

### Markup

Labels support **markup**, which allows users to change properties about individual words or characters in a way very similar to text formatting html. Markup in mousetrap uses [Pango attributes](https://docs.gtk.org/Pango/pango_markup.html), which allows for styles including the following:

| Tag          | Example                  | Result                  |
|--------------|--------------------------|-------------------------|
| `b`          | `<b>bold</b>`            | <b>bold</b>             |
| `i`          | `<i>italic</i>`          | <i>italic</i>           |
| `u`          | `<u>underline</u>`       | <u>underline</u>        |
| `s`          | `<s>strikethrough</s>`   | <s>strike-through</s>    |
| `tt`         | `<tt>inline_code</tt>`   | <tt>inline_code</tt>    |
| `small`      | `<small>small</small>`   | <small>small</small>    |
| `big`        | `<big>big</big>`         | <h3>big</h3>            |
| `sub`        | `x<sub>subscript</sub>`  | x<sub>subscript</sub>   |
| `sup`        | `x<sup>superscript</sup>` | x<sup>superscript</sup> |
| `&#` and `;` | `&#129700;`              | 🪤                      | 

Where in the last row, we used the [decimal html code](https://www.compart.com/en/unicode/U+1FAA4) for the mousetrap emoji provided by unicode.

\note Pango only accepts the **decimal** code, not hexadecimal. For example, the mousetrap emoji has the decimal code `129700`, while its hexadecimal code is `x1FAA4`. To use this emote in text, we thus use `&#129700;`, **not** `&#x1FAA4;`. The latter will not work.

\note All `<`, `>` will be parsed as style tags, regardless of whether they are escaped. To display them as characters, we us `&lt;` (less-than) and `&gt;` (greater-than) instead of `<` and `>`. For example, we would `x < y` as `"x &lt; y"`.

Pango also supports colors, different fonts, text direction, and more. For these, we can [consult the Pango documentation](https://docs.gtk.org/Pango/pango_markup.html) directly.

---

---

## Box

\a{Box} is a multi-widget container, which aligns its children horizontally or vertically, depending on whether we pass \a{Orientation::HORIZONTAL} or \a{Orientation::VERTICAL} to its constructor. We can change the orientation of a box after construction using `set_orientation`.

TO add widgets to the start or end of the box, we use `Box::push_front`, `Box::push_back`, respectively, which take a `Widget&`. 

```cpp
auto box = Box(Orientation::HORIZONTAL);

auto start = Label("|start");
auto end = Label("end|");
auto center = Label("|middle|");

// add to start of box
box.push_front(start);

// add to end of box
box.push_back(end);

// add right after start
box.insert_after(center, start);
```

\image html box_start_center_end.png

Between any two children, an optional space will be inserted once we set `Box::set_spacing`. By default, this spacing is `0`.

---

## CenterBox

\a{CenterBox} is a container that has exactly three children. `CenterBox` prioritizes keeping the designated center child centered at all costs, making it a good choice when symmetry is desired.

We use `CenterBox::set_start_child`, `CenterBox::set_center_child`, and `CenterBox::set_end_child` to specify the corresponding child widget.

```cpp
auto center_box = CenterBox(Orientation::HORIZONTAL);
center_box.set_center_child(Button());
center_box.set_start_child(Label("start"));
center_box.set_end_child(Label("end"));
```

\image html center_box.png

`CenterBox` is orientable, meaning it also supplies `set_orientation` , just like `Box`.

---

## Separator

Perhaps the simplest widget is `Separator`. It simply fills its allocated area with a solid color:

```cpp
auto separator = Separator();
separator.set_margin(20);
separator.set_expand(true);
window.set_child(separator);
```

\image html separator_example.png

This widget is often used as a background to another widget, to fill empty space, or as en element visually separating two sections. Often, we want to have the separator be a specific thickness. This can be accomplished using size-hinting. For example, to draw a horizontal line similar to the `<hr>` tag in HTML, we would do the following:

```cpp
auto hr = Separator();
separator.set_expand_horizontally(true);
separator.set_expand_vertically(false);
separator.set_size_request({
    0,  // width: any 
    3   // height: exactly 3 px
});
```

This will render as a line that has a height of `3` px at all times, but will expand horizontally.

---

## ImageDisplay

\a{ImageDisplay} is used to display static images.

Assuming we have an image at the absolute path `/resources/image.png`, we can create an `ImageDisplay` like so:

```cpp
auto display = ImageDisplay();
display.create_from_file("/resources/image.png");
```

The following image formats are supported by `ImageDisplay`:

| Format Name             | File Extensions |
|-------------------------|-----------------|
| PNG                     | `.png`  |
| JPEG                    | `.jpeg` `.jpe` `.jpg`  |
| JPEG XL image           | `.jxl`  |
| Windows Metafile        | `.wmf` `.apm`  |
| Windows animated cursor | `.ani`  |
| BMP                     | `.bmp`  |
| GIF                     | `.gif`  |
| MacOS X icon            | `.icns`  |
| Windows icon            | `.ico` `.cur`  |
| PNM/PBM/PGM/PPM         | `.pnm` `.pbm` `.pgm` `.ppm`  |
| QuickTime               | `.qtif` `.qif`  |
| Scalable Vector Graphics | `.svg` `.svgz` `.svg.gz`  |
| Targa                   | `.tga` `.targa`  |
| TIFF                    | `.tiff` `.tif`  |
| WebP                    | `.webp`  |
| XBM                     | `.xbm`  |
| XPM                     | `.xpm`  |

After realization, we cannot change the contents of `ImageDisplay` directly. If the file on disk changes, `ImageDisplay` remains unchanged. If we want to update `ImageDisplay`, we need to call `create_from_file` manually again.

By default, `ImageDisplay` behaves just like any other widget, in that it scales freely. If the underlying image was [raster-based](https://en.wikipedia.org/wiki/Raster_graphics), it may be blurred or distorted. To prevent this, we can call `display.set_expand(false)` which prevents expansion of the widget, then size-hint it:

```cpp
display.set_expand(false);
display.set_size_request(display.get_size());
```

Where `ImageDisplay::get_size` returns the original resolution of the image it was created from. For example, for a `.png` file of size 75x35 px, `display` would always be exactly 75x35 pixels on screen, meaning the image is displayed at 1:1 resolution.

---

## Button

Familiar from previous chapters, \a{Button} is commonly used to trigger behavior.

It has the following signals:

\signals
\signal_activate{Button}
\signal_clicked{Button}

Where physically clicking the button both emits `activate` and `clicked`, while calling `Widget::activate` only emits `activate`, not `clicked`.

To change the label of a button, we use `Button::set_child`. This will usually be a `Label` or `ImageDisplay`, though any arbitrary widget can be used as a child.

Other than the child widget, we can customize the look of a button further. `Button::set_has_frame` will change whether the button has a texture and outline to it, while `Button::set_is_circular` changes the button to a fully rounded appearance:

\image html button_types.png

\how_to_generate_this_image_begin
```cpp
auto normal = Button();
normal.set_child(Label("01"));

auto no_frame = Button();
no_frame.set_has_frame(false);
no_frame.set_child(Label("02"));

auto circular = Button();
circular.set_is_circular(true);
circular.set_child(Label("03"));

auto box = CenterBox(Orientation::HORIZONTAL);;
box.set_start_child(normal);
box.set_center_child(no_frame);
box.set_end_child(circular);

box.set_margin(75);
window.set_child(box);
```
\how_to_generate_this_image_end

Where the above shown buttons have the following properties:

| Button | set_has_frame | set_is_circular |
|--------|---------------|-----------------|
| 01  | true | false |
| 02 | false | false |
| 03 | true | true |

---

## ToggleButton

`ToggleButton` is a specialized form of `Button`. It supports most of `Button`s methods / signals, including `set_child`, `set_has_frame`, `set_is_circular` and signal `clicked`.

Unique to `ToggleButton` is that, if clicked, the button will **remain pressed**. When clicked again, it returns to being unpressed. Anytime the state of the `ToggleButton` changes, `toggled` will be emitted. In this way, `ToggleButton` can be used to track a boolean state.

\signals
\signal_toggled{ToggleButton}
\signal_activate{ToggleButton}
\signal_clicked{ToggleButton}

To check whether the button is currently toggled, we use `ToggleButton::get_is_active`, which returns `true` if the button is currently pressed, `false` otherwise.

```cpp
auto toggle_button = ToggleButton();
toggle_button.connect_signal_clicked([](ToggleButton& instance) -> void {
    if (instance.get_is_active())
        std::cout << "pressed" << std::endl;
    else
        std::cout << "released" << std::endl;
});
```

---

## CheckButton

\{CheckButton} is almost identical to `ToggleButton` in function -  but not appearance. `CheckButton` is an empty box in which a checkmark appears when it is toggled. Just like before, we query whether it is pressed by calling `CheckButton::get_is_active`.

\signals
\signal_activate{CheckButton}
\signal_toggled{CheckButton}

`CheckButton` can be in one of **three** states, which are represented by the enum \a{CheckButtonState}. The button can either be `ACTIVE`, `INACTIVE`, or `INCONSISTENT`. This changes the appearance of the button:

\image html check_button_states.png

\how_to_generate_this_image_begin
```cpp
auto active = CheckButton();
active.set_state(CheckButtonState::ACTIVE);
auto active_box = Box(Orientation::VERTICAL);
active_box.push_back(active);
active_box.push_back(Label("active"));

auto inconsistent = CheckButton();
inconsistent.set_state(CheckButtonState::INCONSISTENT);
auto inconsistent_box = Box(Orientation::VERTICAL);
inconsistent_box.push_back(inconsistent);
inconsistent_box.push_back(Label("inconsistent"));

auto inactive = CheckButton();
inactive.set_state(CheckButtonState::INACTIVE);
auto inactive_box = Box(Orientation::VERTICAL);
inactive_box.push_back(inactive);
inactive_box.push_back(Label("inactive"));

for (auto* button : {
   &active,
   &inconsistent,
   &inactive
})
   button->set_horizontal_alignment(Alignment::CENTER);

auto box = CenterBox(Orientation::HORIZONTAL);;
box.set_start_child(active_box);
box.set_center_child(inconsistent_box);
box.set_end_child(inactive_box);

box.set_margin(75);
window.set_child(box);
```
\how_to_generate_this_image_end

Note that `CheckButton::get_is_active` will only return `true` if the current state is specifically `CheckButtonState::ACTIVE`. `toggled` is emitted whenever the state changes, regardless of which state the `CheckButton` was in.

---

## Switch

As the last widget intended to convey a boolean state to the user, we have \a{Switch}, which has the appearance similar to a light switch. `Switch` does not emit `toggled`, instead, we connect to the `activate` signal, which is emitted anytime the switch is operated.

\signals
\signals_activate{Switch}

\image html switch_states.png

\how_to_generate_this_image_begin
```cpp
auto active = Switch();
active.set_active(true);
auto active_box = Box(Orientation::VERTICAL);
active_box.push_back(active);
active_box.push_back(Label("active"));

auto inactive = Switch();
inactive.set_active(false);
auto inactive_box = Box(Orientation::VERTICAL);
inactive_box.push_back(inactive);
inactive_box.push_back(Label("inactive"));

for (auto* s : {&active, &inactive})
{
    s->set_horizontal_alignment(Alignment::CENTER);
    s->set_margin(10);
}

auto box = CenterBox(Orientation::HORIZONTAL);;
box.set_start_child(active_box);
box.set_end_child(inactive_box);

box.set_margin(75);
state->main_window.set_child(box);
```
\how_to_generate_this_image_end

---

---

## Adjustment

From widgets conveying a boolean state, we will now move on to widgets conveying a discrete number. These let the user choose a value from a **range**, which, in mousetrap, is represented by a signal emitter called \a{Adjustment}.

In general, a range has a lower and upper value. For example, the range `[0, 2]` has the `lower` of `0` and `upper` of `2`. A second property is the **step increment**, which is the minimum difference between two adjacent values in the range. For example, if the range is `[0, 2]` and the step increment is `0.5`, then the user can choose from the numbers `{0, 0.5, 1, 1.5, 2}`. If the step increment is `0.01`, `[0,2]` includes the numbers  `{0, 0.01, 0.02, ..., 1.98, 2.00}`.

Turning to the actual `Adjustment` class, it has four properties

+ `lower`: lower bound of the range
+ `upper`: upper bound of the range
+ `increment`: step increment
+ `value`: current value, in `[lower, upper]`

For example, expressing the previous range like so:

```cpp
auto adjustment = Adjustment(
    1,      // value
    0,      // lower
    2,      // upper
    0.5     // increment    
);
```

Which will have the value of `1` on initialization.

We usually do not need to create our own `Adjustment`, rather, it is provided by a number of widgets. Notable about this is that the widget and its adjustment linked internally. If we change any property of the `Adjustment`, the widget will change its appearance accordingly.

Adjustment has two signals:

\signals
\signal_value_changed{Adjustment}
\signal_properties_changed{Adjustment}

We can connect to `value_changed` to monitor the value property of an `Adjustment` (and thus whatever widget is controlled by it), while `properties_changed` is emitted when one of `upper`, `lower` or `step increment` changes.

---

## SpinButton

\image html spin_button.png

\how_to_generate_this_image_begin
```cpp
auto horizontal = SpinButton(0, 2, 0.5);
horizontal.set_orientation(Orientation::HORIZONTAL);
horizontal.set_value(1);

// pad horizontal spin button with invisible separators above and below
auto horizontal_buffer = CenterBox(Orientation::VERTICAL);
horizontal_buffer.set_start_child(Separator(0));
horizontal_buffer.set_center_child(horizontal);
horizontal_buffer.set_end_child(Separator(0));

auto vertical = SpinButton(0, 2, 0.5);
vertical.set_orientation(Orientation::VERTICAL);
vertical.set_value(1);

auto box = CenterBox(Orientation::HORIZONTAL);;
box.set_start_child(horizontal_buffer);
box.set_end_child(vertical);

box.set_margin_horizontal(75);
box.set_margin_vertical(40);
window.set_child(box);
```
\how_to_generate_this_image_end

`SpinButton` is used to pick an exact value from a range. The user can click the rectangular area and manually enter a value using the keyboard, or they can increase or decrease the current value by the step increment of the `SpinButton`s adjustment by pressing the plus or minus button.

We supply the properties of the range underlying the `SpinButton` to its constructor:

```cpp
// create SpinButton with range [0, 2] and increment 0.5
auto spin_button = SpinButton(0, 2, 0.5)
```

If we want to check any of the properties of the  `SpinButton`s range, we can either query the `Adjustment*` returned by `SpinButton::get_adjustment`, or we can get the values directly using `SpinButton::get_value`, `SpinButton::get_lower`, etc. This is just for the sake of convenience, both ways have identical behavior.

`SpinButton` has two signals:

\signals
\signal_value_changed{SpinButton}
\signal_wrapped{SpinButton}

Only the latter of which needs explanation, as we recognize `value_changed` from `Adjustment`.

When the user reaches one end of the `SpinButton`s range, which, for a range of `[0, 2]` would be either the value `0` or `2`, if the user attempts to increase or decrease the value further, nothing will happen. However, if we set `SpinButton::set_can_wrap` to `true`, the value will wrap around to the opposite side of the range. For example, trying to increase the value while it is `2`, it would jump to `0`, and vice-versa.

---

## Scale

\image html scale_no_value.png
\how_to_generate_this_image_begin
```cpp
auto horizontal = Scale(0, 2, 0.5);
horizontal.set_orientation(Orientation::HORIZONTAL);
horizontal.set_value(1);
horizontal.set_size_request({200, 0});

auto vertical = Scale(0, 2, 0.5);
vertical.set_orientation(Orientation::VERTICAL);
vertical.set_value(1);
vertical.set_size_request({0, 200});

auto box = CenterBox(Orientation::HORIZONTAL);;
box.set_start_child(horizontal);
box.set_end_child(vertical);

box.set_margin_horizontal(75);
box.set_margin_vertical(40);
state->main_window.set_child(box);
```
\how_to_generate_this_image_end

\a{Scale}, just like `SpinButton`, is a widget that allows a user to choose a value from the underlying `Adjustment`. This is done by click-dragging the knob of the scale, or clicking anywhere on its rail. In this way, it is usually harder to pick an exact decimal value on a `Scale` as opposed to a `SpinButton`. We can aid in this task by displaying the exact value next to the scale, which is enabled with `Scale::set_should_draw_value`:

\image html scale_with_value.png
\how_to_generate_this_image_begin
```cpp
auto horizontal = Scale(0, 2, 0.5);
horizontal.set_orientation(Orientation::HORIZONTAL);
horizontal.set_value(1);
horizontal.set_size_request({200, 0});
horizontal.set_should_draw_value(true);

auto vertical = Scale(0, 2, 0.5);
vertical.set_orientation(Orientation::VERTICAL);
vertical.set_value(1);
vertical.set_size_request({0, 200});
vertical.set_should_draw_value(true);

auto box = CenterBox(Orientation::HORIZONTAL);;
box.set_start_child(horizontal);
box.set_end_child(vertical);

box.set_margin_horizontal(75);
box.set_margin_vertical(40);
state->main_window.set_child(box);
```
\how_to_generate_this_image_end


`Scale`supports most of `SpinButton`s functions, including querying information about its underlying range and settings the orientation.

---           

## ScrollBar

Similar to `Scale`, \a{ScrollBar} is used to pick a value from an adjustment. It is often used as a way to choose which part of a widget should be shown on screen. For an already automated way of doing this, see `Viewport`.

---

## LevelBar

\a{LevelBar} is used to display a fraction to indicate the level of something, for example the volume of a playback device.

To create a `LevelBar`, we need to specify the minimum and maximum value of the range we wish to display. We can then set the current value using `LevelBar::set_value`. The resulting fraction is computed automatically, based on the upper and lower limit we supplied to the constructor:

```cpp
// create level for range [0, 2]
auto level_bar = LevelBar(0, 2);
level_bar.set_value(1.0); // set to 50%
```

The bar will be oriented horizontally by default, but we can call `set_orientation` to change this.

Once the bar reaches 75%, it changes color:

\image html level_bar.png

\how_to_generate_this_image_begin
```cpp
auto box = Box(Orientation::VERTICAL);
box.set_spacing(10);
box.set_margin(10);

size_t n_bars = 5;
for (size_t i = 0; i < n_bars+1; ++i)
{
    float fraction = 1.f / n_bars;

    auto label = Label(std::to_string(int(fraction * 100)) + "%");
    label.set_size_request({50, 0});

    auto bar = LevelBar(0, 1);
    bar.set_value(fraction);
    bar.set_expand_horizontally(true);

    auto local_box = Box(Orientation::HORIZONTAL);
    local_box.push_back(label);
    local_box.push_back(bar);
    box.push_back(local_box);
}

window.set_child(box);
```
\how_to_generate_this_image_end

The bar can also be used to display a value from a range only consisting of integers, in which case the bar will be shown segmented. We can set the `LevelBar`s mode using `LevelBar::set_mode`, which takes either `LevelBarMode::CONTINUOUS` or `LevelBarMode::DISCRETE` as its argument.

---

## ProgressBar

A specialized case of indicating a continuous value is that of a **progress bar**. A progress bar is used to show how much of a task is currently complete. This is most commonly used during a multi-second loading animation, for example during the startup phase of an application. As more and more resources are loaded, the progress bar fills, which communicates to the user how long they will have to wait, and that progress is being made.

\a{ProgressBar} is built for this exact purpose. It does not have an upper or lower bound, as its range is fixed to `[0, 1]`. We can set the current fraction using `ProgressBar::set_fraction`. 

`ProgressBar` has a special animation trigger, which makes the bar "pulse", which is usually done everytime the fraction changes. We have to manually trigger this pulse animation using `ProgressBar::pulse`. Note that this does not change the currently displayed fraction of the progress bar, it only plays an animation.

\image html progress_bar.png

\how_to_generate_this_image_begin
```cpp
auto progress_bar = ProgressBar();
progress_bar.set_fraction(0.47);
progress_bar.set_vertical_alignment(Alignment::CENTER);
progress_bar.set_expand(true);

auto label = Label("47%");
label.set_margin_end(10);

auto box = Box(Orientation::HORIZONTAL);
box.set_homogeneous(false);
box.push_back(label);
box.push_back(progress_bar);
box.set_margin(10);

window.set_child(box);
```
\how_to_generate_this_image_end

---

## Spinner

To signal progress while we do not have an exact fraction, we can use the \a{Spinner} widget. It simply displays an animated spinning icon. Using `Spinner::set_is_spinning`, we can control whether the animation is currently playing.

\image html spinner.png

\how_to_generate_this_image_begin
```cpp
auto spinner = Spinner();
spinner.set_is_spinning(true);
window.set_child(spinner);
```
\how_to_generate_this_image_end

---

---

## Entry

Text entry is central to many application. Mousetrap offers two widgets that allow the user to type freely. \a{Entry} is the widget of choice for **single-line text entry**.

`Entry` is an area that, when clicked, allows the user to type freely. The currently displayed text is stored in an internal text buffer. We can access or modify the buffers content with `Entry::get_text` and `Entry::set_text`, respectively.

While we could control the size of an `Entry` using size-hinting, a better way is `Entry::set_max_length`, which takes an integer representing the number of characters that the prompts should make space for. For example, `entry.set_max_length(15)` will resize the entry such that it is wide enough to show 15 characters at the current font size.

`Entry` supports "password mode", which is when each character typed is replaced with a dot. This is to prevent a third party looking at a user screen and seeing what they typed. To enter password mode, we set `Entry::set_text_visible` to `false`.

\image html entry_password_mode.png

\how_to_generate_this_image_begin
```cpp
auto clear = Entry();
clear.set_text("text");

auto password = Entry();
password.set_text("text");
password.set_text_visible(false);

auto box = Box(Orientation::VERTICAL);
box.set_spacing(10);
box.push_back(clear);
box.push_back(password);

box.set_margin_horizontal(75);
box.set_margin_vertical(40);
window.set_child(box);
```
\how_to_generate_this_image_end

Lastly, `Entry` is **activatable**. Users usually do this by pressing the enter key while the cursor is inside the `Entry`. This does not cause any behavior initially, but we can connect to the `activate` signal of `Entry` to choose a custom function to be called.

Other than `activate`, `Entry` has one more signal, `text_changed`, which is emitted whenever the internal buffer changes.

\signals
\signal_activate{Entry}
\signal_text_changed{Entry}

Note that the user cannot insert a newline character using the enter key. `Entry` should exclusively be used for text prompts which have no line breaks. For multi-line text entry, we should use the next widget instead.

---

## TextView

While we can technically input a newline character into `Entry` by copy pasting the corresponding control character, it is not possible to display two lines at the same time. For this purpose, we use \a{TextView}. It supports a number of basic text-editor features, including **undo / redo**, which are triggered by the user pressing Control + Z or Control + Y respectively. We as developers can also trigger this behavior manually with `TextView::undo` / `TextView::redo`.

Much like `Label`, we can set how the text aligns horizontally using `TextView::set_justify_mode`. To further customize how text is displayed, we can choose the **internal margin**, which is the distance between the frame of the `TextView` and the text inside of it. `TextView::set_left_margin`, `TextView::set_right_margin`, `TextView::set_top_margin` and `TextView::set_bottom_margin` allow us to choose these values freely.

`TextView` does **not** have the `activate` signal, pressing enter while the cursor is inside the widget will simply create a new line. Instead, it has the following signals, where `text_changed` behaves exactly like it does with `Entry`:

\signals
\signal_text_changed{TextView}
\signal_undo{TextView}
\signal_redo{TextView}

---

---

## Dropdown

We sometimes want users to be able to pick a value from a **set list of values**, which may or may not be numeric. \a{DropDown} allows for this.

When the `DropDown` is clicked, a window presents the user with a list of items. The user can click on any of these, at which point the dropdown will invoke the corresponding function for that item, which is set during \a{DropDown::push_back}. This function takes three arguments:

+ **list label**: widget displayed inside the dropdown window
+ **selected label**: widget displayed once one of the items is selected
+ **callback**: function with signature `(DropDown&, (Data_t)) -> void`, which is invoked when a selection is made

We usually want both labels to be an actual `Label`, though any widget can be used as the list or selected label.

```cpp
auto dropdown = DropDown();
dropdown.push_back(
    Label("List Label"), // list label
    Label("Selected Label"), // selected label
    [](DropDown&) { std::cout << "selected" << std::endl; } // callback
);
```

\image dropdown_hello_world.png

Here, we created a dropdown and added a single item. The item has the list label `"List Label"`, and the selected label `"Selected Label"`. When this item is selected, the lambda will be invoked, which here simply prints `selected` to the console.

In praxis, we would want the callback to mutate some global property to keep track of which item is selected. Alternatively, we can query which item is currently selected by calling `DropDown::get_selected`. This function returns an **item ID**, which is obtained when we call `DropDown::push_back`:

```cpp
auto dropdown = DropDown();
auto id_01 = dropdown.push_back(Label("01"), Label("Option 01"), [](DropDown&){});
auto id_02 = dropdown.push_back(Label("02"), Label("Option 02"), [](DropDown&){});

// check if selected item is 01
bool item_01_selected = dropdown.get_selected() == id_01;
```

Where `[](DropDown&){}` is a lambda that simply does nothing (but still conforms to the `(DropDown&, (Data_t)) -> void` signature).

---

---

## Frame

\a{Frame} is a purely cosmetic widget that displays whatever child we choose using `Frame::set_child` in a frame with a small border and rounded corners:

\image html frame_no_frame.png

\how_to_generate_this_image_begin
```cpp
auto left = Separator();
auto right = Separator();

auto frame = Frame();
frame.set_child(right);

for (auto* separator : {&left, &right})
{
    separator->set_size_request({50, 50});
    separator->set_expand(false);
}

auto box = CenterBox(Orientation::HORIZONTAL);
box.set_start_child(left);
box.set_end_child(frame);

box.set_margin_horizontal(75);
box.set_margin_vertical(40);
window.set_child(box);
```
\how_to_generate_this_image_end

Using `Frame::set_label_widget`, we can furthermore choose a widget to be displayed above the child widget of the frame. This will usually be a `Label`, though `set_label_widget` accepts any kind of widget.

`Frame` is rarely necessary, but will make GUIs seem more aesthetically pleasing and polished.

---

## AspectFrame

Not to be confused with `Frame`, \a{AspectFrame} adds no graphical element to its singular child. Instead, the widget added with `AspectFrame::set_child` will be forced to allocate a size that conforms to a specific **aspect ratio**. That is, its width-to-height ratio will stay constant.

We choose the aspect ratio in `AspectFrame`s constructor, though we can later adjust it using `AspectFrame::set_ratio`. Both of these functions accept a floating point ratio calculated as `width / height`. For example, if we want to force a widget to keep an aspect ratio of 4:3, we would do:

```cpp
auto child_widget = // ...
auto aspect_frame = AspectFrame(4.f / 3) // 4:3 aspect ratio
aspect_frame.set_child(child_widget);
```

Where we wrote `4.f / 3` instead of `4 / 3` because in C++, the latter would trigger [integer division](https://en.wikipedia.org/wiki/Division_(mathematics)#Of_integers) resulting in a ratio of `1` (instead of the intended `1.333...`).

---

## Revealer

While not technically necessary, animations can improve user experience drastically. Not only do they add visual style, they can hide abrupt transitions or small loading times. As such, they should be in any advanced GUI designer's repertoire.

One of the most common applications for animations is that of hiding or showing a widget. So far, when we called `Widget::hide` or `Widget::show`, the widget appears instantly, one frame after the function was called. This works, but when showing a large widget, other widgets around it will want to change their size allocation, which may drastically change the entire window's layout instantly.

To address this, mousetrap offers \a{Revealer}, which plays an animation to reveal or hide a widget.
`Revealer` always has exactly one child, set with `Revealer::set_child`. `Revealer` itself has no graphical element, it acts just like a `Box` with a single child.

To trigger the `Revealer`s animation and change whether the child widget is currently visible, we call `Revealer::set_revealed` which takes a boolean as its argument. If the widget goes from hidden to shown or shown to hidden, the animation will play.

Once the animation is done, signal `revealed` will be emitted:

\signals
\signal_revealed{Revealer}

Using this, we can trigger our own behavior, for example to update a widgets display or trigger additional animations.

### Transition Animation

We have control over the kind and speed of the transition animation. By calling `Revealer::set_transition_duration`, we can set the exact amount of time an animation should take. For example, to set the animation duration to 1 second:

```cpp
auto revealer = Revealer();
revealer.set_child(// ...
revealer.set_transition_duration(seconds(1));
```

Where `seconds` returns a \a{Time}.

Apart from the speed, we also have a choice of animation **type**, represented by the enum \a{RevealerTransitionType}. Animations include a simple cross-fade, sliding, swinging, or `NONE`, which instantly shows or hides the widget. For more information on the look of the animation, see the \link mousetrap::RevealerTransitionType related documentation page\endlink.

---

## Expander

\a{Expander} is similar to `Revealer`, in that it also has exactly one child widget, and it shows / hides the widget. Unlike `Revealer`, there is no animation attached to `Expander`. Instead, it hides the widget behind a collapsible label:

\image html expander.png

\how_to_generate_this_image_begin
```cpp
auto child = Label("[expanded child]");
child.set_horizontal_alignment(Alignment::START);
child.set_margin(5);
child.set_margin_start(15);

auto expander = Expander();
expander.set_child(child);
expander.set_label_widget(Label("Expander"));

auto frame = Frame();
frame.set_child(expander);
frame.set_margin(50);
window.set_child(frame);
``` 
\how_to_generate_this_image_end

We set the `Expander`s child widget with `Expander::set_child`. We will furthermore want to specify a label widget, which is the widget shown next to the small arrow.  Set with`Expander::set_label_widget`, this widget will usually be a `Label`, though, again, any arbitrarily complex widget can be used.

Note that `Expander` should not be used for the purpose of large nested list, for example those displaying a file system tree. A purpose-built widget for this already exists, it is called `ListView` and we will learn how to use it later in this chapter.

---

## Overlay

So far, all widget containers have aligned their children such that they do not overlap. In cases where we do want overlapping to happen, we have to use \a{Overlay}.

`Overlay` has one "base" widget, which is at the conceptual bottom of the overlay. We set this widget using `Overlay::set_child`. We can then add any number of widgets on top of the base widget using `Overlay::add_overlay`:

\image html overlay_two_buttons.png

\how_to_generate_this_image_begin
```cpp
 auto lower = Button();
lower.set_horizontal_alignment(Alignment::START);
lower.set_vertical_alignment(Alignment::START);

auto upper = Button();
upper.set_horizontal_alignment(Alignment::END);
upper.set_vertical_alignment(Alignment::END);

for (auto* button : {&lower, &upper})
    button->set_size_request({50, 50});

auto overlay = Overlay();
overlay.set_child(Separator());
overlay.add_overlay(lower);
overlay.add_overlay(upper);

auto aspect_frame = AspectFrame(1);
aspect_frame.set_child(overlay);

aspect_frame.set_margin(10);
window.set_child(aspect_frame);
```
\how_to_generate_this_image_end

Where the position and size of overlayed widgets depend on their expansion and alignment properties.

By default, `Overlay` will allocate exactly as much space as the base widget (set with `Overlay::set_child`) does. If one of the overlaid widgets takes up more space than the base widget, it will be truncated. We can avoid this by supplying a second argument to `Overlay::add_overlay`, which is a boolean indicated whether the overlay widget should be included in the entire container's size allocation. That is, if the overlaid widget is larger than the base widget, the `Overlay` will resize itself such that the entire overlaid widget is visible.

```cpp
overlay.add_overlay(overlay_widget, true); 
// resize if overlay_widget allocates more space than child
``` 

When one interactable widget is shown partially overlapping another, only the top-most widget can be interacted with by the user. If we want the user to be able to access a lower layer, we need to make any widget on top non-interactable, either by calling `Widget::hide` or `Widget::set_can_respond_to_input(false)`.

---

## Paned

\a{Paned} is a widget that always has exactly two children. Between the two children, a visual barrier is drawn. The user can click on this barrier and drag it horizontally or vertically, depending on the orientation of the `Paned`. This gives the user the option to resize how much of a shared space one of the two widgets allocates.

\image html paned_centered.png

\how_to_generate_this_image_begin
```cpp
auto left = Overlay();
left.set_child(Separator());
left.add_overlay(Label("left"));

auto right = Overlay();
right.set_child(Separator());
right.add_overlay(Label("right"));

for (auto* child : {&left, &right})
    child->set_margin(10);

auto paned = Paned(Orientation::HORIZONTAL);
paned.set_start_child(left);
paned.set_end_child(right);

state->main_window.set_child(paned);
```
\how_to_generate_this_image_end

Assuming the `Paned`s orientation is `Orientation::HORIZONTAL`, we can set the child on the left using `Paned::set_start_child` and the child on the right with `Paned::set_end_child`. Both children have to be set to valid widgets in order for the user to have the option of interacting with the `Paned`. If we, for some reason, do not have two widgets but would still like to use a `Paned`, we should add a `Separator` as the other child.

`Paned` has two per-child properties: whether a child is **resizable** and whether it is **shrinkable**.

Resizable means that if the `Paned` changes size, the child should change size with it.

Shrinkable sets whether the side of the `Paned` can be made smaller than the allocated size of that side's child widget. If set to `true`, the user can drag the `Paned`s barrier, such that one of the widgets is partially or completely hidden:

\image html paned_shrinkable.png

\how_to_generate_this_image_begin
```cpp
auto left = Overlay();
left.set_child(Separator());
left.add_overlay(Label("left"));

auto right = Overlay();
right.set_child(Separator());
right.add_overlay(Label("right"));

for (auto* child : {&left, &right})
    child->set_margin(10);

auto paned = Paned(Orientation::HORIZONTAL);
paned.set_start_child(left);
paned.set_end_child(right);

paned.set_start_child_shrinkable(true);
paned.set_end_child_shrinkable(true);

state->main_window.set_child(paned);
```
\how_to_generate_this_image_end

`Paned::set_end_child_shrinkable(true)` made it possible to move the barrier such that the left child is partially covered.

---

## Viewport

By default, most containers will allocate a size that is equal to or exceeds the largest natural size of its children. For example, if we create a widget that has a natural size of 5000x1000 px and use it as the child of a `Window`, the `Window` will attempt to allocate 5000x1000 pixels on screen, making the window far larger than most screens can display. In situations like these, we should instead use a \a{Viewport}, which allows users to only view part of a larger widget:

```cpp
auto child = Separator();
child.set_size_request({5000, 5000});

auto viewport = Viewport();
viewport.set_child(child);

state->main_window.set_child(viewport
```
\image html viewport.png

Without the `Viewport`, the `Separator` child widget would force the outer `Window` to allocate 5000x5000 pixels, as we size-hinted it to be that size. By using `Viewport`, the `Window` is free to allocate any size, retaining resizability. The end-user can influence which area of the larger widget is currently visible by operating the scrollbars inherent to `Viewport`.

### Size Propagation

By default, `Viewport` will disregard the size of its child and simply allocate an area based on the `Viewport`s properties only. We can override this behavior by forcing `Viewport` to **propagate** the width or height of its child.

By calling `Viewport::set_propagate_natural_width(true)`, `Viewport` will assume the width of its child. Conversely, calling `Viewport::set_propagate_natural_width(true)` forces the window to allocate space equal to the height of its child. A viewport that has both of these set to true will behave exaclty like a box with a single child.

### Scrollbar Policy

`Viewport` has two scrollbars, controlling the horizontal and vertical position. If we want to trigger behavior in addition to changing which part of the child widget `Viewport` displays, we can access each scrollbars `Adjustment` using `Viewport::get_horizontal_adjustment` and `Viewport::get_vertical_adjustment` respectively, then connect to the `Adjustment`s signals.

By default, once the cursor enters `Viewport`, both scrollbars will reveal themselves. If the cursor moves outside the `Viewport`, the scrollbars will hide again.

This behavior is controlled by the viewports **scrollbar policy**, represented by the \a{ScrollbarVisibilityPolicy} enum:

+ `NEVER`: scrollbar is hidden permanently
+ `ALWAYS`: scrollbar is always shown, does not hide itself
+ `AUTOMATIC`: default behavior, see above

We can set the policy for each scrollbar individually using `Viewport::set_horizontal_scrollbar_policy` and `Viewport::set_vertical_scrollbar_policy`.

### Scrollbar Position

Lastly, we can customize the location of both scrollbars at the same time using `Viewport::set_scrollbar_placement`, which takes one of the following values:

+ `CornerPlacement::TOP_LEFT`: horizontal scrollbar at the top, vertical scrollbar on the left
+ `CornerPlacement::TOP_RIGHT`: horizontal at the top, vertical on the right
+ `CornerPlacement::BOTTOM_LEFT`: horizontal at the bottom, vertical on the left
+ `CornerPlacement::BOTTOM_RIGHT`: horizontal at the bottom, vertical on the right

With this, scrollbar policy, size propagation, and being able to access the adjustment of each scrollbar individually, we have full control over every aspect of `Viewport`.

---

## Popovers

A \a{Popover} is a special kind of window. It is always [modal](#modality--transience). Rather than having the normal window decoration with a close button and title, `Popover` closes dynamically (or when requested by the application). 

Showing the popover is called **popup**, closing the popover is called **popdown**, `Popover` correspondingly has `Popover::popup` and `Popover::popdown` to trigger this behavior.

\image html popover.png

\how_to_generate_this_image_begin
```cpp
auto popover = Popover();
auto child = Separator();
child.set_size_request({150, 200});
popover.set_child(child);

auto popover_button = PopoverButton();
popover_button.set_popover(popover);
popover_button.set_expand(false);
popover_button.set_margin(50);

auto aspect_frame = AspectFrame(1);
aspect_frame.set_child(popover_button);
window.set_child(aspect_frame);
```
\how_to_generate_this_image_end

Popovers can only be shown while they are **attached** to another widget. We use `Popover::attach_to` to specify this widget, while `Popover::set_child` chooses which widget to display inside the popover. Like `Window`, `Popover` always has exactly one child.

Manually calling `popup` or `popdown` to show / hide the `Popover` can be finnicky. To address this, mousetrap offers a widget that fully automates this process for us.

## PopoverButton

Like `Button`, `PopoverButton` has a single child, can be circular, and has the `activate` signals. Instead of triggering behavior, `PopoverButton`s purpose is to reveal and hide a `Popover`.

We first create the `Popover`, then connect it to the button using `PopoverButton::set_popover`.

```cpp
auto popover = Popover();
popover.set_child(// ...
auto popover_button = PopoverButton();
popover_button.set_popover(popover);
```

\image html popover.png

\how_to_generate_this_image_begin
```cpp
auto popover = Popover();
auto child = Separator();
child.set_size_request({150, 200});
popover.set_child(child);

auto popover_button = PopoverButton();
popover_button.set_popover(popover);
popover_button.set_expand(false);
popover_button.set_margin(50);

auto aspect_frame = AspectFrame(1);
aspect_frame.set_child(popover_button);
window.set_child(aspect_frame);
```
\how_to_generate_this_image_end

For 90% of cases, this is the way to go when we want to use a `Popover`. It is easy to set up and we don't have to manually control the popover position or when to show / hide it. 

The arrow character next to the `PopoverButton`s child indicates to the user that clicking it will reveal a popover. We can hide this arrow by setting `PopoverButton::set_always_show_arrow` to `false`.

We will see one more use of `PopoverButton` in the [chapter on menus](06_menus.md), where we use it to control `PopoverMenu`, a specialized form of `Popover` that shows a menu instead of an arbitrary widget.

---

---

## Selectable Widgets: SelectionModel

We will now move on to **selectable widgets**, which tend to be the most complex and powerful widgets in mousetrap.

All selectable widgets have some things in common: They a) are widget containers supporting multiple children and b) provide `get_selection_model`, which returns a \a{SelectioModel}. This model contains information about which of the widgets children is currently selected.

`SelectionModel` is not a widget, but it is a signal emitter. Similar to `Adjustment`, it is internally linked with its corresponding selectable widget. Changing the widget updates the `SelectionModel`, changing the `SelectionModel` updates the widget. We usually do not construct `SelectionModel` directly, instead, we access the underlying `SelectionModel` once we instanced a selectable widget.

`SelectionModel` provides signal `selection_changed`, which is emitted whenever the internal state of the `SelectionModel` changes.

\signals
\signal_selection_changed{SelectionModel}

The signal provides two arguments, `position`, which is the position newly selected item, and `n_items`, which is the new number of currently selected items.

The latter is necessary because `SelectionModel`s can have one of three internal **selection modes**, represented by the enum \a{SelectionMode}:

+ `NONE`: Exactly 0 items are selected at all times
+ `SINGLE`: Exactly 1 item is selected at all times
+ `MULTIPLE`: 0 or more items can be selected

To show how `SelectionModel` is used, we first need to create our first selectable widget.

## ListView

\a{ListView} is a widget that arranges its children in a row (or column if its orientation is `VERTICAL`) in a way similar to `Box`. Unlike `Box`, `ListView` is *selectable*.

\image html list_view_single_selection.png

\how_to_generate_this_image_begin
```cpp
auto list_view = ListView(Orientation::HORIZONTAL, SelectionMode::SINGLE);

auto child = [](size_t id)
{
    auto overlay = Overlay();
    overlay.set_child(Separator());

    auto label = Label((id < 10 ? "0" : "") + std::to_string(id));
    label.set_alignment(Alignment::CENTER);
    overlay.add_overlay(label);

    auto frame = Frame();
    frame.set_child(overlay);
    frame.set_size_request({50, 50});

    auto aspect_frame = AspectFrame(1);
    aspect_frame.set_child(frame);

    return aspect_frame;
};

for (size_t i = 0; i < 7; ++i)
    list_view.push_back(child(i));

window.set_child(list_view);
```
\how_to_generate_this_image_end

Where the blue border indicates that the 4th element (with label `"03"`) is currently selected.

When creating the `ListView`, the first argument to its constructor is the \a{Orientation}, while the second is the underlying `SelectionModel`s mode. If left unspecified, `SelectionMode::NONE` is used.

Much like `Box`, `ListView` supports `ListView::push_back`, `ListView::push_front`, along with `ListView::insert` to insert any widget at the specified position.

`ListView` can be requested to automatically show separators in-between two items by calling `ListView::set_show_separators(true)`.

### Nested Trees

By default, `ListView` displays its children in a linear list, either horizontally or vertically. `ListView` also supports **nested lists**, sometimes called a **tree view**:

\image html list_view_nested.png

\how_to_generate_this_image_begin
```cpp
auto list_view = ListView(Orientation::VERTICAL);
auto child = [](const std::string& string)
{
    auto overlay = Overlay();
    overlay.set_child(Separator());

    auto label = Label(string);
    label.set_alignment(Alignment::CENTER);
    label.set_margin(5);
    overlay.add_overlay(label);

    auto frame = Frame();
    frame.set_child(overlay);

    return frame;
};

list_view.push_back(child("outer item #01"));
auto it = list_view.push_back(child("outer item #02"));
list_view.push_back(child("inner item #01"), it);
it = list_view.push_back(child("inner item #02"), it);
list_view.push_back(child("inner inner item #01"), it);
list_view.push_back(child("outer item #03"));

auto frame = Frame();
frame.set_child(list_view);
list_view.set_margin(50);
window.set_child(frame);
```
\how_to_generate_this_image_end

Here, we have a triple nested list. The outer list has the items `outer item #01`, `outer item #02` and `outer item #03`. `outer item #02` is itself a list, with two children `inner item #01` and `inner item #02`, the latter of which is also a list with a single item.

When `ListView::push_back` is called, it returns an **iterator**. When we supply this iterator as the second argument to any of the widget-inserting functions, such as `ListView::push_back`, the new child will be inserted as a child to the item the iterator points to. If no iterator is specified, the item will be inserted in the top-level list.

```cpp
auto it_01 = list_view.push_back(/* outer item #01 */);
auto it_02 = list_view.push_back(/* outer item #02 */);

  auto inner_it_01 = list_view.push_back(/* inner item #01 */, it_02);
  auto inner_it_02 = list_view.push_back(/* inner item #02 */, it_02);
   
    auto inner_inner_it_01 = list_view.push_back(/* inner inner item #01 */, inner_it_02);
    
auto it_03 = list_view.push_back(/* outer item #03 */);
```

This means, if we only want to show items in a simple, non-nested list, we can ignore the iterator return value completely.

### Reacting to Selection

In order to react to the user selecting a new item in our `ListView` (if its selection mode is anything other than `NONE`), we should connect to the lists `SelectionModel` like so:

```cpp
auto list_view = ListView(Orientation::HORIZONTAL, SelectionMode::SINGLE);

list_view.get_selection_model()->connect_signal_selection_changed(
    [](SelectionModel&, int32_t item_i, int32_t n_items){
        std::cout << "selected: " << item_i << std::endl;
    }
);
```

This way of accessing the `SelectionModel`, then connecting to one of its signals to monitor the underlying widget will be the same for any of the selectable widgets, as all of them provide `get_selection_model`, which returns a `SelectionModel*`.

---

## GridView

\a{GridView} supports many of the same functions as `ListView`. Instead of displaying its children in a nested list, it shows them in a grid:

\image html grid_view.png

\how_to_generate_this_image_begin
```cpp
auto grid_view = GridView(Orientation::HORIZONTAL, SelectionMode::SINGLE);
grid_view.set_max_n_columns(4);

auto child = [](size_t id)
{
    auto overlay = Overlay();
    overlay.set_child(Separator());

    auto label = Label((id < 10 ? "0" : "") + std::to_string(id));
    label.set_alignment(Alignment::CENTER);
    overlay.add_overlay(label);

    auto frame = Frame();
    frame.set_child(overlay);
    frame.set_size_request({50, 50});

    auto aspect_frame = AspectFrame(1);
    aspect_frame.set_child(frame);

    return aspect_frame;
};

for (size_t i = 0; i < 7; ++i)
    grid_view.push_back(child(i));

window.set_child(grid_view);
```
\how_to_generate_this_image_end

Items are dynamically allocated to rows and columns based on the space available to the `GridView` and the number of children.

We can use `GridView::set_min_n_columns` and `GridView::set_max_n_columns` to force one of either row or columns (depending on `Orientation`) to adhere to the given limit, which gives us more control over how the children are arranged.

Other than this, `GridView` supports the same functions as `ListView`, including `push_front`, `push_back`, `insert`, `get_selection_model`, `set_show_separators`, etc.

---

## Column View

\a{ColumnView} is used to display widgets as a table, which is split into rows and columns. Each column has a title.

To fill our `ColumnView`, we first instance it, then allocate a number of columns:

```cpp
auto column_view = ColumnView(SelectionMode::SINGLE);
column_view.push_back_column("Column 01");
column_view.push_back_column("Column 02");
column_view.push_back_column("Column 03");
```

To add a column at a later point, either to the start, end, or at a specific position, we use `ColumnView::push_front_column`, `ColumnView::push_back_column`, or `ColumnView::insert_column`, respectively. Each of these functions takes as their argument the title used for the column.

Once we have all our columns set up, we can add child widgets either by using \a{ColumnView::set_widget} or the convenience function `push_back_row`, which adds a row of widgets to the end of the table:

```cpp
column_view.push_back_row(Label("1 | 1"), Label("1 | 2"), Label("1 | 3"));
column_view.push_back_row(Label("2 | 1"), Label("2 | 2"), Label("2 | 3"));
column_view.push_back_row(Label("3 | 1"), Label("3 | 2"), Label("3 | 3"));
```

\image html column_view_hello_world.png

\how_to_generate_this_image_begin
```cpp
auto column_view = ColumnView(SelectionMode::SINGLE);
auto col1 = column_view.push_back_column("Column 01");
auto col2 = column_view.push_back_column("Column 02");
auto col3 = column_view.push_back_column("Column 03");

column_view.push_back_row(Label("1 | 1"), Label("1 | 2"), Label("1 | 3"));
column_view.push_back_row(Label("2 | 1"), Label("2 | 2"), Label("2 | 3"));
column_view.push_back_row(Label("3 | 1"), Label("3 | 2"), Label("3 | 3"));

column_view.set_show_row_separators(true);
column_view.set_show_column_separators(true);
column_view.set_expand(true);

for (auto* column : {&col1, &col2, &col3})
    column->set_is_resizable(true);

window.set_child(column_view);
```
\how_to_generate_this_image_end

Here, we use `Label`s as items in the `ColumnView`, but any arbitrarily complex widget can be used. Rows or columns do not require one specific widget type, we can put any type of widget at whatever position we want.

---

## Grid

Not to be confused with `GridView`, \a{Grid} arranges its children in a **non-uniform** grid:

\image html grid.png

\how_to_generate_this_image_begin
```cpp
auto grid = Grid();

auto add_child = [&](size_t x, size_t y, size_t width, size_t height)
{
    auto overlay = Overlay();
    overlay.set_child(Separator());
    static size_t i = 0;
    auto label = Label((i < 9 ? "0" : "") + std::to_string(i++));
    label.set_alignment(Alignment::CENTER);
    overlay.add_overlay(label);

    auto frame = Frame();
    frame.set_child(overlay);
    frame.set_size_request({50, 50});

    auto box = Box();
    box.push_back(frame);

    grid.insert(box, {x, y}, width, height);
    return box;
};

add_child(0, 0, 1, 1);
add_child(0, 1, 2, 1);
add_child(0, 2, 1, 1);
add_child(1, 0, 2, 1);
add_child(2, 1, 1, 2);
add_child(1, 2, 1, 1);
add_child(3, 0, 1, 3);

grid.set_row_spacing(5);
grid.set_column_spacing(5);
grid.set_columns_homogenous(true);

grid.set_expand(true);
grid.set_margin(5);
window.set_child(grid);
```
\how_to_generate_this_image_end

Each widget on the grid has four properties, it's **x-index**, **y-index**, **width** and **height**. These are not in pixels, rather they are the conceptional position or number of cells in the grid.

For example, in the above figure, the widget labeled `00` has x- and y-index `0` and a width and height of `1`. The widget next to it, labeled `03` has an x-index `1`, y-index of `0`, a width of `2` and a height of `1`.

To add a widget to a grid, we need to provide the widget along with its desired position and size in the grid:

```cpp
grid.insert(
    /* child widget */
    {1, 0},  // x, y
    2,       // width
    1        // height
);
```

Where `width` and `height` are optional, with `1` being the default value for both arguments.

When a widget is added to a column or row not yet present in the grid, it is added automatically. Valid x- and y-indices are 0-based (`{0, 1, 2, ...}`), while width and height have to be a multiple of 1 (`{1, 2, ...}`).

Note that it is our responsibility to make sure a widgets position and size do not overlap with that of another widget. If carelessly inserted, one widget may obscure another, though in some cases this behavior may also be desirable.

`Grid::set_columns_homogenous` and `Grid::set_rows_homogenous` specifies whether the `Grid` should allocate the exact same width for all columns, or height for all rows, respectively.

Lastly, we can choose the spacing between each cell using `Grid::set_row_spacing` and `Grid::set_column_spacing`.

`Grid` can be seen as a more flexible version of `GridView`. It also arranges arbitrary widgets in columns and rows, but, unlike with `GridView`, in `Grid` a widget can occupy more than one row / column, and we have to manually specify the position and size of each of its children.

---

## Stack

\a{Stack} is a selectable widget that can only ever display exactly one child at a time, though we register any number of widgets first. All widget except the selected on will be hidden, while the selected widget will occupy the entire allocated space of the `Stack`:

```cpp
auto stack = Stack();
auto page_01 = // widget
auto page_02 = // widget

auto page_01_id = stack.add_child(page_01, "Page 01");
auto page_02_id = stack.add_child(page_02, "Page 02");

// make page_01 currently displayed widget
stack.set_visible_child(page_01_id);
```

Adding a widget with `Stack::add_child` will return the **ID** of that page. To make a specific widget be the currently shown widget, we use `Stack::set_visible_child`, which takes this ID.

We see above that `Stack::add_child` takes a second argument, which is the **page title**. This title is not used in the stack itself, rather, it is used by two widgets made exclusively to interact with a `Stack`. These widgets facilitate the user being able to choose which stack page to display, as `Stack` itself has no way of user interaction.

### StackSwitcher

\a{StackSwitcher} presents the user with a row of buttons, each of which use the corresponding stack pages title:

```cpp
auto stack = Stack();
stack.add_child(/* child #01 */, "Page 01");
stack.add_child(/* child #02 */, "Page 02");
stack.add_child(/* child #03 */, "Page 03");

auto stack_switcher = StackSwitcher(stack);

auto box = Box(Orientation::VERTICAL);
box.push_back(stack);
box.push_back(stack_switcher);
```

\image html stack_switcher.png

\how_to_generate_this_image_begin
```cpp
auto stack = Stack();
auto child = [](size_t id)
{
    auto overlay = Overlay();
    overlay.set_child(Separator());

    auto label = Label(std::string("Stack Child #") + (id < 10 ? "0" : "") + std::to_string(id));
    label.set_alignment(Alignment::CENTER);
    overlay.add_overlay(label);

    auto frame = Frame();
    frame.set_child(overlay);
    frame.set_size_request({300, 300});

    auto aspect_frame = AspectFrame(1);
    aspect_frame.set_child(frame);

    return aspect_frame;
};

stack.add_child(child(01), "Page 01");
stack.add_child(child(02), "Page 02");
stack.add_child(child(01), "Page 03");

auto stack_switcher = StackSwitcher(stack);

stack.set_expand(true);
stack.set_margin(10);
stack_switcher.set_expand_vertically(false);

auto box = Box(Orientation::VERTICAL);
box.push_back(stack);
box.push_back(stack_switcher);
window.set_child(box);
```
\how_to_generate_this_image_end

`StackSwitcher` has no other methods, it simply provides a user interface to control a `Stack`.

### StackSidebar

\a{StackSidebar} has the same purpose as `StackSwitcher`, though it displays the list of stack pages as a vertical list:

```cpp
auto stack = Stack();
stack.add_child(/* child #01 */, "Page 01");
stack.add_child(/* child #02 */, "Page 02");
stack.add_child(/* child #03 */, "Page 03");

auto stack_sidebar = StackSidebar(stack);

auto box = Box(Orientation::HORIZONTAL);
box.push_back(stack);
box.push_back(stack_sidebar);
```

\image html stack_sidebar.png

\how_to_generate_this_image_begin
```cpp
auto stack = Stack();
auto child = [](size_t id)
{
    auto overlay = Overlay();
    overlay.set_child(Separator());

    auto label = Label(std::string("Stack Child #") + (id < 10 ? "0" : "") + std::to_string(id));
    label.set_alignment(Alignment::CENTER);
    overlay.add_overlay(label);

    auto frame = Frame();
    frame.set_child(overlay);
    frame.set_size_request({300, 300});

    auto aspect_frame = AspectFrame(1);
    aspect_frame.set_child(frame);

    return aspect_frame;
};

stack.add_child(child(01), "Page 01");
stack.add_child(child(02), "Page 02");
stack.add_child(child(01), "Page 03");

auto stack_sidebar = StackSidebar(stack);

stack.set_expand(true);
stack.set_margin(10);

auto box = Box(Orientation::HORIZONTAL);
box.push_back(stack);
box.push_back(stack_sidebar);
window.set_child(box);
```
\how_to_generate_this_image_end

Other than this visual component, its purpose is identical to that of `StackSwitcher`.

### Transition Animation

When changing which of the stacks pages is currently shown, regardless of how that selection was triggered, an animation transitioning from one page to the other plays. Similar to `Revealer`, we can influence the type and speed of animation in multiple ways:

+ `Stack::set_transition_duration` governs how long the animation will take, thus influencing its speed
+ `Stack::set_interpolate_size`, if set to `true`, makes it such that while the transition animation plays, the stack will change from the size of the previous child to the size of the current child gradually. If set to `false`, this size change happens instantly
+ `Stack::set_animation_type` governs the type of animation

Mousetrap provides a large number of different animation, which are represented by the enum \a{StackTransitionType}. These include cross-fading, sliding, and rotating between pages. For a full list of animation types, see the \link mousetrap::StackTransitionType corresponding documentation page\endlink, as `Stack` offers an even larger selection of animations than `Revealer`.

---

## Notebook

\a{Notebook} is very similar to `Stack`, it always displays exactly one child. Unlike `Stack`, it comes with a built-in way for users to select which child to show:

\image html notebook.png

\how_to_generate_this_image_begin
```cpp
auto notebook = Notebook();
auto child = [](size_t id)
{
    auto overlay = Overlay();
    overlay.set_child(Separator());

    auto label = Label(std::string("Notebook Child #") + (id < 10 ? "0" : "") + std::to_string(id));
    label.set_alignment(Alignment::CENTER);
    overlay.add_overlay(label);

    auto frame = Frame();
    frame.set_child(overlay);
    frame.set_size_request({300, 300});

    auto aspect_frame = AspectFrame(1);
    aspect_frame.set_child(frame);

    return aspect_frame;
};

notebook.push_back(child(01), Label("Page 01"));
notebook.push_back(child(02), Label("Page 02"));
notebook.push_back(child(01), Label("Page 03"));
notebook.set_tabs_reorderable(true);

window.set_child(notebook);
``` 
\how_to_generate_this_image_end

We see that each notebook page has a tab with a title. This title widget will usually be a `Label`, though it can be any arbitrarily complex widget. When adding a page using `Notebook::push_back`, the first argument is the widget that should be used as the page, while the second argument is the widget that should be used as the label.

`Notebook` sports some additional features. Setting `Notebook::set_is_scrollable` to `true` allows users to change between pages by scrolling with the mouse or touchscreen.
When `Notebook::set_tabs_reorderable` is set to `true`, the user can drag and drop pages to reorder them in any order they wish. Users can even **drag pages from one notebook to another**. 

`Notebook` has a number of custom signals that reflect these multiple modes of interaction:

\signals
\signal_page_added{Notebook}
\signal_page_reordered{Notebook}
\signal_page_removed{Notebook}
\signal_page_selection_changed{Notebook}

Where `_` is an unused argument. For example, we would connect to `page_selection_changed` like so:

```cpp
notebook.connect_signal_page_selection_changed([](Notebook&, void*, int32_t page_index){
    std::cout << "Selected Page is now: " << page_index << std::endl;
});
```

\todo refactor notebook signals to remove unused argument

Note that `Notebook` does not provide `get_selection_model`. We use the `page_selection_changed` signal to monitor page selection, and `Notebook::goto_page` to manually switch between pages.

---

---

## Compound Widgets

This concludes our tour of most of mousetraps widgets. Even though the selection is wide and powerful, we have yet to learn one of the more important things: **how do we make our own widgets?**

If we want to start from scratch and manually choose every pixel and mode of interaction, we will have to wait until the chapter on [native rendering](09_opengl.md). Not all custom widgets need to be that low-level, however. Often, we simply want a collection of already existing widgets to act as one. To illustrate this, we'll work through a simple example.

In previous sections, whenever a figure was shown, the C++ code used to generate that figure was supplied along with it. Take, for example, the figure from the section on `GridView`:

\image html grid_view.png

Here, `GridView` has 7 children. Each child is clearly a widget, as `GridView::push_back` requires a widget to be used as the argument. Looking closely, the children are actually a collection of at least 3 widgets:

+ a `Label` with the number
+ a `Separator` as the background
+ a `Frame` for the rounded outline

On top of these, we have an `Overlay` in order to layer all three graphical elements on top of each other. Lastly, an `AspectFrame` keeps the element square.

While we could create 5 individual widgets for every element of `GridView`, this would be highly tedious and not very idiomatic, as C++ is an object-oriented language. Instead, we should create a new, **compound widget**, a widget that is made up of multiple other widgets, but acts as one.

We first create a class like so:

```cpp
class LabeledChild
{
    public:
        LabeledChild(size_t id);
        
    private:
        Separator _separator;
        Label _label;
        Frame _frame;
        Overlay _overlay;
        AspectFrame _aspect_frame = AspectFrame(1);
};
```

All the widgets are private fields of the compound widget. This means, as long as an instance of `LabeledChild` exists, the 5 widgets it contains will be kept in memory, but other objects cannot directly access the components individually.

We usually define how a compound widget is assembled in its constructor:

```cpp
// define constructor
LabeledChild(size_t id)
    : _label(std::to_string(id))
{
    _overlay.set_child(_separator);
    _overlay.add_overlay(_label);

    _frame.set_child(_overlay);
    _aspect_frame.set_child(_frame);
}
```

This constructor sets up the structure we discussed before.

The lowermost layer of the `Overlay` is the `Separator`, which will act as the background for the compound widget. On top of it, a `` is added. We set the string of the label based on the ID given to the constructor.

The entire `Overlay` is first inserted into a `Frame`, then that frame is set as the child of our `AspectFrame`, which has a ratio of `1`, keeping it square at all times.

We can now initialize our compound widget and add it to a window, right?

```cpp
auto instance = LabeledChild(0);
window.set_child(compound_widget);
```
```
/home/mousetrap/test/main.cpp:201:26: error: non-const lvalue reference to type 'mousetrap::Widget' cannot bind to a value of unrelated type 'LabeledChild'
        window.set_child(instance);
                         ^~~~~~~~
```
No, we cannot. 

As the error states, `LabeledChild` cannot bind to a reference of type `mousetrap::Widget`.  For this to work, we need to **declare it to be a widget**.

This is accomplished by inheriting from \a{CompoundWidget}:

```cpp
class LabeledChild : public CompoundWidget
{
    public:
        // ctor
        LabeledChild(size_t id);
        
        // function required by `Widget`
        operator NativeWidget() const override;
        
    private:
        Separator _separator;
        Label _label;
        Frame _frame;
        Overlay _overlay;
        AspectFrame _aspect_frame = AspectFrame(1);
};
```

Inherting from this class requires us to implement the pure virtual function `Widget& as_widget()`. This is only thing we need to do in order for our class to be able to be treated as a `Widget`

```cpp
Widget& as_widget()
{
    return _aspect_frame;
}
```

The returned value should be the **top-level** widget of our compound widget. All other parts of a compound widget are contained in the top-level widget, and the top-level widget is not contained in any other widget.

Writing out example `LabeledChild` like this may make the widget order clearer:

```cpp
AspectFrame \
    Frame \
        Overlay \
            Label 
            Separator
``` 

Where each line ending in `\` is a widget container. A widget being indented means it is a child of the widget above.

We see that `AspectFrame` is the only widget that is not also a child of another widget. Therefore, `AspectFrame` is the top-level widget, hence the definition of `as_widget` above.

Putting it all together:

```cpp
/// labeled_child.hpp
struct LabeledChild : public CompoundWidget
{
    public:
        LabeledChild(size_t id)
            : _label(std::to_string(id))
        {
            _overlay.set_child(_separator);
            _overlay.add_overlay(_label);

            _frame.set_child(_overlay);
            _aspect_frame.set_child(_frame);
            _aspect_frame.set_margin(10);
        }

    protected:
        Widget& as_widget()
        {
            return _aspect_frame;
        }
        
    private:
        Separator _separator;
        Label _label;
        Frame _frame;
        Overlay _overlay;
        AspectFrame _aspect_frame = AspectFrame(1);
};

/// main.cpp
auto instance = LabeledChild(0);
window.set_child(instance);
```

\image html compound_widget.png

In this example, `LabeledChild` is fairly simple. In practice, applications can have dozens if not hundreds of different compound widget, all made up of an even larger number of native widgets, which mousetrap will handle just fine.

Indeed, an entire application will usually be one, giant compound widget, with a `Window` as the top-level widget.

In any case, inherting from `CompuondWidget` and implementing `Widget& as_widget()` is the glue that binds our custom objects to the pre-built way mousetrap allows widgets to be used. Once it is implemented (by simply returning the top-level widget), everything works as expected.

