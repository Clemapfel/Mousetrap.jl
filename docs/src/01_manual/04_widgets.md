# Chapter 4: Widgets

In this chapter, we will learn:
+ What a widget is
+ Properties that all widgets share
+ What widgets are available in mousetrap and how to use each of them
+ How to create compound widgets

---

!!! note "Running snippets from this Chapter"
    To run any partial code snippet from this section, we can use the following `main.jl` file:
    ```julia
    using mousetrap
    main() do app::Application
        window = Window(app)

        # snippet here, creates widget and adds it to `window' using `set_child!`

        present!(window)
    end
    ```

!!! note "Images in this Chapter"
    Images for this chapter were captured on a Fedora Linux machine running Gnome 44.2. The exact look of each window and widget may be slightly different, depending on the users operating system and application theme. We will learn how to manually change the global theme in the [section on app customization](./07_os_interface.md#theme).

---

## What is a widget?

Widgets are the central element to any and all GUI applications. In general, a widget is anything that can be rendered on screen. Often, wigdets are **interactable**, which means that the user can trigger behavior by interacting with the widget using a device such as a mouse, keyboard, or touchcsreen.

For example, to interact with the widget [`Button`](@ref) from the previous chapter, the user has to move the cursor over the area of the button on screen, then press the left mouse button. This will trigger an animation where the button changes its appearance to look "pressed in", emit its signal `clicked` to trigger custom behavior, then return to its previous state. 

Having used computers for many years, most of us never think about how things work in this gradual of a manner. `Button` makes it so we don't have to, all of these steps are already implemented for us. All we have to do is place the button and connect to its signals.

## Widget Signals

In mousetrap, [`Widget`](@ref) is an abstract type that all widgets subtype. `Widget` is a subtype of `SignalEmitter`, meaning
all widgets are signal emitters, but not all signal emitters are widgets. 

All widgets **share a number of signals**. These signals are accessible for every subtype of `Widget`:

| Signal ID  | Signature                       |
|------------|---------------------------------|
| `realize`  | `(::T, [::Data_t]) -> Nothing`  |
| `destroy`  | `(::T, [::Data_t]) -> Nothing`  | 
| `show`     | `(::T, [::Data_t]) -> Nothing`  | 
| `hide`     | `(::T, [::Data_t]) -> Nothing`  |
| `map`      | `(::T, [::Data_t]) -> Nothing`  | 
| `unmap`    | `(::T, [::Data_t]) -> Nothing`  | 

Where `T` is the subtype. For example, since `Button` is a `Widget`, the signature of `Button`s signal `realize` is `(::Button, [::Data_t]) -> Nothing`.

By the end of this chapter, we will have learned when all these signals are emitted and what they mean. For now, we will just note that all widgets share these signals. For any class subtyping `Widget`, these signals are available. 

---

## Widget Properties

When displayed on screen, a widgets size and location will be chosen dynamically. Resizing the window may or may not resize all widgets inside such that they fill the entire window. A somewhat complex heuristic determines the exact position and size of a widget during runtime. We can influence this process using multiple properties all widgets share.

Each widget will choose a position and size on screen. We call this area, an [axis-aligned rectangle](https://en.wikipedia.org/wiki/Minimum_bounding_box#Axis-aligned_minimum_bounding_box), the widgets **allocated area**. The allocated area can change over the course of runtime, most widgets are easily resized either by us, the developers, or the user.

### Parent and Children

Widgets can be inside other widgets. A widget that can contain other widgets is called a **container** widget. Each widget inside this container is called the **child** of the container. `Window`, in our previous `main.jl`, is a container widget, we inserted `Button`, a widget, into it using `set_child!`.

How many children a widget can contain depends on the type of widget. Some may have no children, exactly one child, exactly two, excatly three, or any number of children. Shared for all widgets, however, is that each widget has exactly one **parent**. This is the widget it is contained within. 

Because a widget can only have exactly one parent, we cannot put the same widget instance into two containers. If we want two identical `Button`s in two different positions on screen, we have to create two button instances.

```julia
box_a = Box(ORIENTATION_HORIZONTAL)
box_b = Box(ORIENTATION_HORIZONTAL)
button = Button()

# insert `button` into box A
push_back!(box_a, button)

# insert `button` into box B also
push_back!(box_b, button)
```

This latter call will print a warning

```
(julia:445703): mousetrap-CRITICAL **: 18:13:31.132: In Box::push_back: Attemping to insert widget into a container, but that widget already has a parent.
```

because `button`s parent is already `box_a`. Instead, we should create two buttons:

```julia
box_a = Box(ORIENTATION_HORIZONTAL)
box_b = Box(ORIENTATION_HORIZONTAL)
button_a = Button()
button_b = Button()

push_back!(box_a, button_a)
push_back!(box_b, button_b)
```

By connecting the same handler to both of these buttons signals, we have two identically behaving objects, that are still separate widget instances.

### Size Request
 
Moving onto the properties that determines the widgets size, we have its **size request**. This is a [`Vector2f`](@ref Vector2) which governs the minimum width and height of the widget, in pixels. Once set with [`set_size_request!`](@ref), no matter what, that widget will always allocate at least that amount of space. 

By default, all widgets size request is `Vector2f(0, 0)`. Setting the width and/or height of a widgets size request to `0` will tell the size manager, the algorithm determining the widgets final size on screen, that the widget has not made a request for a minimum size. A size request may not be negative.

Manipulating the size request to influence a widgets minimum size is also called **size-hinting**.

### Accessing Widget Size

We can query information about a widgets current and target size using multiple functions, some of which are only available after a widget is **realized**. Realization means that the widget is initialized, has chosen its final size on screen, and is ready to be displayed. When these conditions are met, any widget will emit its signal `realize`. 

Once realized, [`get_allocated_size`](@ref) and [`get_position`](@ref) return the current size and position of a widget, in pixels.

This size may or may not be equal to what we size-hinted the widget to, as size-hinting only determines the widgets *minimum size*. The layout manager is free to allocate a size larger than that.

Lastly, [`get_natural_size`](@ref) will access the size preferred by the layout manager. This size will always be equal to or larger than the size request. When trying to predict the size a widget has, `get_natural_size` will give us the best estimate. Once the widget and all its children are realized, `get_allocated_size` and `get_position`  will gives us the exact value.

Layout management is complex and the algorithm behind managing the size of the totality of all widgets is sophisiticated. Users of mousetrap are not required to understand this exact mechanism, only how to influence it.

On top of a widgets size request, a widgets final allocated size depends on a number of other variables.

### Margin

Any widget has four margins: `start`, `end`, `top` and `bottom`. Usually, these correspond to empty space left, right, above, and below the widget, respectively. Margins are rendered as empty space added to the corresponding side of the widget. In this way, they work similar to the [css properties of the same name](https://www.w3schools.com/css/css_margin.asp), though in mousetrap, margins may not be negative.

We use [`set_margin_start!`](@ref), [`set_margin_end!`](@ref), [`set_margin_top!`](@ref) and [`set_margin_bottom!`](@ref) to control each individual margin:

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

Where [`set_margin_horizontal!`](@ref), [`set_margin_vertical!`](@ref) set two of the margins at the same time, while [`set_margin!`](@ref) sets all four margins at once.

Margins are used extensively in UI design. They make an application look more professional and aesthetically pleasing. A good rule of thumb is that for a 1920x1080 display, the **margin unit** should be 10 pixels. That is, all margins should be a multiple of 10. If the display has a higher or lower resolution, the margin unit should be adjusted.

### Expansion

If the size of the parent of a widget changes, for example when resizing the window a `Button` is contained within, the child widget may or may not **expand**. Expansion governs if a widget should fill out the entire space available to it. We set expansion along the x- and y-axis separately using [`set_expand_horizontally!`](@ref) and [`set_expand_vertically!`](@ref). If set to `false`, a widget will usually not grow past its natural size.

[`set_expand!`](@ref) is a convenience function that sets expansion along both axes simultaneously.

```julia
widget = # ...
set_expand_horizontally!(widget, true)
set_expand_vertically!(widget, true)

# equivalent to
set_expand!(widget, true)
```

### Alignment

Widget **alignment** governs where inside its container a widget will attempt to position itself.

An example: a `Button` size-hinted to 100x100 pixels has expansion disabled (`set_expand!` was set to `false`). It has a margin of 0 and is placed inside a `Window` of 200x200. When we scale the window, the button will not change size, and the button does not fill the entire area of the window. 

Alignment, then, governs **where in the window the button is positioned**.

We set alignment for the horizontal and vertical axis separately using [`set_horizontal_alignment!`](@ref) and [`set_vertical_alignment!`](@ref), which both take values of the enum [`Alignment`](@ref). This enum has three possible values, whose meaning depends on whether we use this value for the horizontal or vertical alignment:

+ `ALIGNMENT_START`: left if horizontal, top if vertical
+ `ALIGNMENT_END`: right if horizontal, bottom if vertical
+ `ALIGNMENT_CENTER`: center of axis, regardless of orientation

We note that the horizontal x-axis is oriented from left to right, while the vertical y-axis is oriented from top to bottom.

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

Using alignment, size-hinting, and expansion, we can fully control where and at what size a widget will appear on screen, without having to worry to manually place it by choosing the exact position or size.

---

### Visibility & Opacity

Once a widget is realized, when we call [`present!`](@ref) on the window it is contained within, it is **shown**, appearing on screen and emitting signal `show`. If the widget leaves the screen, for example because it is removed from a container or its window is closed, it is **hidden**, emitting signal `hide`.

To hide a shown widget or show a hidden widget, we use [`set_is_visible!`](@ref):

```julia
button = Button()
connect_signal_clicked!(button) do self::Button
    set_is_visible!(self, false)
end
set_child!(window, button)
```

In which a button is hidden when it is clicked. This means the button cannot be clicked again, as its interactivity is only available while it is shown. Once the button is hidden, its allocated size becomes `(0, 0)`.

If we instead just want to make the button invisible, but still have it be clickable, we should use [`set_opacity!`](@ref). This functions takes a float in `[0, 1]`, where `0` is fully transparent, `1` is fully opaque:

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

Setting opacity does **not** emit the `hide` or `show` signal. While the widget may be fully transparent and thus invisible to us humans, it retains its interactivity and allocated area on screen.

---

### Cursor Type

Each widget has a property governing what the user's cursor will look like while it is inside the widgets allocated area. By default, the cursor is a simple arrow. A widget intended for text-entry would want the cursor to be a [caret](https://en.wikipedia.org/wiki/Cursor_(user_interface)), while a clickable widget would likely want a [pointer](https://en.wikipedia.org/wiki/Cursor_(user_interface)#Pointer).

Some widgets already set the cursor to an appropriate shape automatically, but we can control the cursor shape for each individual widget manually using [`set_cursor!`](@ref), which takes a value of the enum [`CursorType`](@ref):

| `CursorType` value             | Appearance                                                                                          |
|--------------------------------|-----------------------------------------------------------------------------------------------------|
| `CURSOR_TYPE_NONE`             | Invisible cursor                                                                                    |
| `CURSOR_TYPE_DEFAULT`          | Default arrow pointer                                                                               |
| `CURSOR_TYPE_POINTER`          | Hand pointing                                                                                       |
| `CURSOR_TYPE_TEXT`             | Caret                                                                                               |
| `CURSOR_TYPE_GRAB`             | Hand, not yet grabbing                                                                              |
| `CURSOR_TYPE_GRABBING`         | Hand, currently grabbing                                                                            |
| `CURSOR_TYPE_CELL`             | Cross, used for selecting cells from a table                                                        |
| `CURSOR_TYPE_CROSSHAIR`        | Crosshair, used for making pixel-perfect selections                                                 |
| `CURSOR_TYPE_HELP`             | Questionmark, instructs the user that clicking or hovering above this element will open a help menu |
| `CURSOR_TYPE_CONTEXT_MENU`     | Questionmark, instructs the user that clicking will open a context menu                             |
| `CURSOR_TYPE_NOT_ALLOWED`      | Instructs the user that this action is currently disabled                                           |
| `CURSOR_TYPE_PROGRESS`         | Spinning animation, signifies that the object is currently busy                                     |
| `CURSOR_TYPE_WAIT`             | Loading animation, Instructs the user that an action will become available soon                     |
| `CURSOR_TYPE_ZOOM_IN`          | Lens, usually with a plus icon                                                                      |
| `CURSOR_TYPE_ALL_SCROLL`       | Omni-directional scrolling                                                                          |
| `CURSOR_TYPE_MOVE`             | 4-directional arrow                                                                                 |
| `CURSOR_TYPE_NORTH_RESIZE`     | Up-arrow                                                                                            |
| `CURSOR_TYPE_NORTH_EAST_RESIZE` | Up-left arrow                                                                                       |
| `CURSOR_TYPE_EAST_RESIZE`      | Left arrow                                                                                          |
| `CURSOR_TYPE_SOUTH_EAST_RESIZE` | Down-left arrow                                                                                     |
| `CURSOR_TYPE_SOUTH_RESIZE`     | Down arrow                                                                                          |
| `CURSOR_TYPE_SOUTH_WEST_RESIZE` | Down-right arrow                                                                                    |
| `CURSOR_TYPE_WEST_RESIZE`      | Right arrow                                                                                         |
| `CURSOR_TYPE_NORTH_WEST_RESIZE` | Up-right arrow                                                                                      |
| `CURSOR_TYPE_ROW_RESIZE`        | Up-down arrow                                                                                       |
| `CURSOR_TYPE_COLUMN_RESIZE`     | Left-right arrow                                                                                    |


`Button`s default cursor is `CURSOR_TYPE_DEFAULT`. If we want to indicate to the user that the button should be clicked, we can instead set it to be a pointer:

```julia
button = Button()
set_cursor!(button, CURSOR_TYPE_POINTER)
```

The exact look of each cursor type depends on the users operating system and UI configuration. To choose a fully custom cursor, we use [`set_cursor_from_image!`](@ref), which takes an `Image`. We will learn more about `Image` in the [chapter dedicated to it](./06_image_and_sound.md). Until then, this is how we set a cursor from a `.png` file on disk:

```julia
widget = # ...
set_cursor_from_image!(widget, Image("/path/to/image.png"))
```

---

### Tooltip

Each widget can have a **tooltip**. This is a little window that opens when the cursor hovers over a widgets allocated area for enough time. The exact duration is decided by the users OS, we do not have control over it. 

Tooltips are usually a simple text message. We can set the text directly using [`set_tooltip_text!`](@ref):

```julia
button = Button()
set_tooltip_text!(button, "Click to Open")
```
![](../assets/widget_tooltip_text.png)

If we want to use something more complex than just simple text, we can register an arbitrarily complex widget as a tooltip by calling [`set_tooltip_widget!`](@ref). As a matter of style, this widget should not be interactable, though there is no mechanism in place to enforce this.

---

Now that we know properties shared by all widgets, we can continue onto learning about all the specific widget types. From this point onwards, we can be sure that **all widgets support all properties and signals discussed so far**.

## Window

For our first widget, we have [`Window`](@ref). Windows are central to any application, as such, `Window` and `Application` are inherently connected. We cannot create a `Window` without an `Application` instance. If all windows are closed, the underlying application usually exists.

While windows are widget, they occupy a somewhat of a special place. `Window` is the only widget that does not have a parent. This is called being **top-level**, nothing is "above" the window in the parent-child hierarchy. 

`Window` has exactly on child, which we set with `set_child!`, as we have so far already.

### Opening / Closing a Window

When we create a `Window` instance, it will be initially hidden. None of its children will be realized or shown, and the user has no way to know that the window exists. A `Window`s lifetime only begins once we call [`present!`](@ref). This opens the window and shows it to the user, realizing all its children. We've seen this in our `main` functions before:

```julia
main() do app::Application

    # create the window
    window = Window(app)
    
    # show the window, this realizes all widgets inside
    present!(window)
end
```

At any point we can call `close!`, which hides the window. This does not destroy the window permanently, unless [`set_hide_on_close!`](@ref) was set to `false` previously, we can `present!` to show the window again. For an application to exit, all its windows only need to be hidden, not permanently destroyed. Therefore, calling `close!` on all windows may cause the application to attempt to exit.

### Close Request

`Window` has three signals, only the latter of which is relevant to us for now.

```@eval
using mousetrap
mousetrap.@signal_table(Window,
    activate_default_widget,
    activate_focused_widget,
    close_request
)
```

When the window handler of the users OS asks the window to close, for example because user pressed the "x" button, signal `close_request` will be emitted. Its result, of type [`WindowCloseRequestResult`](@ref), determines whether the window actually does close.

```julia
# create a window that cannot be closed
window = Window(app)
connect_signal_close_request!(window) do self::Window
    return WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE
end
present!(window)
```

If the signal handler instead returns `WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE`, the window will close, which is the default behavior. We should never call `close!` from within the signal handler of `closer_request`. Whether the window is closed should only be controlled by the handlers return value.

### Window Properties

Other than its singular child, `Window` has a number of other properties.

#### Title & Header Bar

[`set_title!`](@ref) sets the name displayed in the windows **header bar**, which is the part on top of the content area. By default, this name will be the name of the application. We can choose to hide the title by simply calling `set_title!(window, "")`.

By default, the header bar will show the window title, a minimize-, maximize-, and close-button. We can completely hide the header bar using `set_is_decorated!(window, false)`, which also means the user has now way to move or close the window.

#### Modality & Transience

When dealing with multiple windows, we can influence the way two windows interact with each other. Two of these interactions are determined by whether a window is **modal** and whether it is **transient** for another window.

By setting [`set_is_modal!`](@ref) to true, if the window is revealed, **all other windows of the application will be deactivated**, preventing user interaction with them. This also freezes animations, it essentially pauses all other windows. The most common use-case for this is for dialogs, for example, if the user requests to close the application, it is common to open a small dialog requesting the user to confirm exiting the application. While this dialog is shown, the main window should be disabled and all other processes should halt until a selection is made. This is possible by making the dialog window *modal*. If two modal windows are active at the same time, the user can choose to swap betwee active windows by clicking a currently inactive window.

Using [`set_transient_for!`](@ref), we can make sure a window will always be shown in front of another. `set_transient_for!(A, B)` will make it so, while `A` overlaps `B` on the users desktop, `A` will be shown in front of `B`. 

---

## Label

In contention for being *the* most used widget, `Label`s are important to understand. A [`Label`](@ref) displays static text, meaning it is not interactable. It is initialized as one would expect:

```julia
label = Label("text")
```

To change a `Label`s text after initialization, we use [`set_text!`](@ref). This can be any number of lines, `Label` is not just for single-line text. If our text has more than one line, a number of additional formatting options are available.

### Justify Mode

[Justification](https://en.wikipedia.org/wiki/Typographic_alignment) determines how words are distributed along the horizontal axis. There are 5 modes in total, all of which are values of the enum [`JustifyMode`](@ref), set using [`set_justify_mode!`](@ref):

![](../assets/text_justify_center.png)
`JUSTIFY_MODE_LEFT`

![](../assets/text_justify_center.png)

`JUSTIFY_MODE_CENTER`

![](../assets/text_justify_right.png)

`JUSTIFY_MODE_RIGHT`

![](../assets/text_justify_fill.png)

`JUSTIFY_MODE_FILL`

Where the fifth mode is `JUSTIFY_MODE_NONE`, which arranges all text in exactly one line.

### Wrapping

Wrapping determines where a line break is inserted if the a lines width exceeds that of `Label`s allocated area. For wrapping to happen at all, the `JustifyMode` has to be set to anything other than `LABEL_WRAP_MODE_NONE`.

Wrapping modes are values of the enum [`LabelWrapMode`](@ref). We set the wrap mode of a `Label` using [`set_wrap_mode!`](@ref).

| `LabelWrapMode` value  | Meaning                                                 | Example                 |
|------------------------|---------------------------------------------------------|-------------------------|
| `NONE`                 | no wrapping                                             | `"humane mousetrap"`    |
| `ONLY_ON_WORD`         | line will only be split between two words               | `"humane\nmousetrap"`   |
| `ONLY_ON_CHAR`         | line will only be split between syllables, adding a `-` | `"hu-\nmane mouse-\ntrap"` |
| `WORD_OR_CHAR`         | line will be split between words and/or syllables       | `"humane\nmouse-\ntrap"`   |

Where `\n` is the newline character.

### Ellipsize Mode

If a line is too long for the available space and wrapping is disabled, **ellipsizing** will take place. The corresponding enum [`EllipsizeMode`](@ref) has four possible value, which we set using [`set_ellipsize_mode!`](@ref).

| `EllipsizeMode` value | Meaning                                                  | Example                     |
|-----------------------|----------------------------------------------------------|-----------------------------|
| `NONE`                | text will not be ellipsized                              | `"Humane mousetrap engineer"` |
| `START`               | starts with `...`, showing only the last few words       | `"...engineer"`               |
| `END`                 | ends with `...`, showing only the first few words        | `"Humane mousetrap..."`       |
| `MIDDLE`              | `...` in the center, shows start and beginning           | `"Humane...engineer"`         |

### Markup

Labels support **markup**, which allows users to change properties about individual words or characters in a way similar to text formatting in HTML. Markup in mousetrap uses [Pango attributes](https://docs.gtk.org/Pango/pango_markup.html), which allows for styles including the following:

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

!!! warning
    Pango only accepts the **decimal** code, not *hexadecimal*. For example, the mousetrap emoji has the decimal code `129700`, while its hexadecimal code is `x1FAA4`. 
    To use this emote in text, we choose `&#129700;`, **not** `&#x1FAA4;`. The latter will not work.

!!! note 
    All `<`, `>` will be parsed as style tags, regardless of whether they are escaped. To display them as characters, we us `&lt;` 
    (less-than) and `&gt;` (greater-than) instead of `<` and `>`. For example, we would write `x < y` as `"x &lt; y"`.

Pango also supports colors, different fonts, text direction, and more. For these, we can [consult the Pango documentation](https://docs.gtk.org/Pango/pango_markup.html) directly.

```julia
label = Label("&lt;tt&gt;01234&lt;/tt&gt; is rendered as <tt>01234</tt>")
set_child!(window, label)
```
![](../assets/label_example.png)

---

## Box

[`Box`](@ref) is a multi-widget container that aligns its children horizontally or vertically, depending on **orientation**. A number of widgets are orientable like this, which means they support the functions [`set_orientation!`](@ref) and [`get_orientation`](@ref), which take / return an enum value of [`Orientation`](@ref):

| `Orientation` Value       | Meaning                                  |
|---------------------------|------------------------------------------|
| `ORIENTATION_HORIZONTAL`  | Oriented left-to-right, along the x-axis |
| `ORIENTATION_VERTICAL`    | Oriented top-to-bottom, along the y-axis |

To add widgets to the `Box`, we use `push_front!`, `push_back!` and `insert_after!`:

```julia
left = Label("LEFT")
set_margin_start!(left, 10)

center = Label("CENTER")
set_margin_horizontal!(center, 10)

right = Label("RIGHT")
set_margin_end!(right, 10)

# create a horizontal box
box = Box(ORIENTATION_HORIZONTAL)

# add `left` to the start
push_front!(box, left)

# add `right to the end
push_back!(box, right)

# insert `center` after `left`
insert_after!(box, center, left)

# add box to window
set_child!(window, box)
```

![](../assets/box_example.png)

In this example, we use margins to add a 10px gap in between each child. This can be done more succinctly using the boxes own **spacing** property. By setting [`set_spacing!`](@ref) to `10`, it will automatically insert a 10 pixel gap in between any two children, in addition to the childrens regular margin.

[`hbox`](@ref) and [`vbox`](@ref) are two convenience functions that take any number of widgets and return a horizontal or vertical box with those widgets already inserted. Using this, and spacing instead of margins, we can write the above as two lines:

```julia
box = hbox(Label("LEFT"), Label("CENTER"), Label("RIGHT"))
set_spacing!(box, 10)
set_child!(window, box)
```
---

## CenterBox

[`CenterBox`](@ref) is an orientable container that has exactly three children. `CenterBox` prioritizes keeping the designated center child centered at all costs, making it a good choice when symmetry is desired.

We use [`<set_start_child!`](@ref), [`set_center_child!`](@ref), and [`set_end_child!`](@ref) to insert a child widget in the corresponding position:

```julia
center_box = CenterBox(ORIENTATION_HORIZONTAL)
set_start_child!(center_box, Label("start"))
set_center_child!(center_box, Button())
set_end_child!(center_box, Label("end"))
```

![](../assets/center_box.png)

Using `CenterBox`s constructor, we can also write the above as a one-liner:

```julia
center_box = CenterBox(ORIENTATION_HORIZONTAL, Label("start"), Button(), Label("end"))
```

---

## HeaderBar

The visual element on top of a window, which usually contains the windows title along with the title buttons, is actually its own separate widget called [`HeaderBar`](@ref). All `Window` instances come with their own `HeaderBar`, which we can access using [`get_header_bar`](@ref). It's rarely necessary to create a `HeaderBar` on our own.

Each `HeaderBar` has a title widget, which will usually be a `Label`, along with two areas for widgets to be inserted. To insert widgets left of the title, we use [`push_front!](@ref), while inserting widgets right of the title is done using [`push_back!`](@ref).

Each `HeaderBar` can have a close-, minimize- and maximize- button, all of which are optional. To specify which buttons should appear and in what order, we use [`set_layout!`](@ref). This function takes a string, which has the following components:

+ `close`
+ `minimize`
+ `maximize`

Each element is separated using `,`. The string has to furthermore contain a `:`. Each element before the `:` will appear left of the title, while elements after `:` will appear right of the title. Note that this just affects the close-, minimize-, and maximize-buttons, any widget inserted using `push_front!` or `push_back!` is unaffected.

A few examples:

| `set_layout!` string | close button | minimize button | maximize button |
|----------------------|--------------|----------------|-----------------|
| `:minimize,maximize,close` | right of title | right of title | right of title |
| `close:`             | left of title | hidden        | hidden |
| `minimize:maximize`  | hidden | left of title | right of title |
| `:`                  | hidden | hidden | hidden |

For example, to create a `HeaderBar` that has no elements, meaning no title and none of the title buttons, we would do the following:

```julia
window = Window(app)

# access windows header bar instance
header_bar = get_header_bar(window)

# hide title buttons
set_layout!(header_bar, ":")

# hide default title by replacing it with an empty label
set_title_widget!(header_bar, Label(""))
```
![](../assets/header_bar_blank.png)


---

## Separator

Perhaps the simplest widget is [`Separator`](@ref). It simply fills its allocated area with a solid color:

```julia
separator = Separator()
set_margin!(separator, 20)
set_expand!(separator, true)
set_child!(window, separator)
```

![](../assets/separator_example.png)

This widget is used as a background to another widget, to fill empty space, or as en element visually separating two sections. 

Often, we want to have the separator be a specific thickness. This can be accomplished using size-hinting. For example, to draw a horizontal line similar to the `<hr>` element in HTML, we would do the following:

```julia
hr = Separator()
set_expand_horizontally!(hr, true)
set_expand_vertically!(hr, false)
set_size_request!(hr, Vector2f(
    0,  # width: any 
    3   # height: exactly 3 px
));
```

This will render as a line that has a height of `3` px at all times, but will assume the entire width of its parent.

---

## ImageDisplay

[`ImageDisplay`](@ref) is used to display static images.

Assuming we have an image at the absolute path `/assets/image.png`, we can create an `ImageDisplay` like so:

```julia
image_display = ImageDisplay()
create_from_file!(image_display, "/assets/image.png")

# equivalent to
image_display = ImageDisplay("/assets/image.png")
```

The following image formats are supported by `ImageDisplay`:

| Format Name             | File Extensions            |
|-------------------------|----------------------------|
| PNG                     | `.png`                     |
| JPEG                    | `.jpeg` `.jpe` `.jpg`      |
| JPEG XL image           | `.jxl`                     |
| Windows Metafile        | `.wmf` `.apm`              |
| Windows animated cursor | `.ani`                     |
| BMP                     | `.bmp`                     |
| GIF                     | `.gif`                     |
| MacOS X icon            | `.icns`                    |
| Windows icon            | `.ico` `.cur`              |
| PNM/PBM/PGM/PPM         | `.pnm` `.pbm` `.pgm` `.ppm` |
| QuickTime               | `.qtif` `.qif`             |
| Scalable Vector Graphics | `.svg` `.svgz` `.svg.gz`   |
| Targa                   | `.tga` `.targa`            |
| TIFF                    | `.tiff` `.tif`             |
| WebP                    | `.webp`                    |
| XBM                     | `.xbm`                     |
| XPM                     | `.xpm`                     |

After realization, we cannot change the contents of `ImageDisplay` directly. If the file on disk changes, `ImageDisplay` remains unchanged. If we want to update `ImageDisplay`, we need to call [`create_from_file!`](@ref) manually again.

---

## Button

Familiar from previous chapters, [`Button`](@ref) is commonly used to trigger behavior.

It has one signal, which is emitted when the button is activated:

```@eval
using mousetrap
mousetrap.@signal_table(Button,
    clicked
)
```

We can manually emit this signal using `emit_signal_clicked`, or by calling `activate!` on the button instance. The latter will also play the animation associated with a user physically clicking the button.

`Button` has a single child that is used as its label. We set it using `set_child!`. Other than this child widget, we can customize the look of a button further. `set_has_frame!` will make all graphical elements of the button other than its label invisible, while `set_is_circular!` changes the button from rectangular to fully rounded:

![](../assets/button_types.png)

!!! details "How to generate this image"
    ```julia
    using mousetrap
    main() do app::Application
        window = Window(app)
    
        normal = Button()
        set_child!(normal, Label("01"))
    
        no_frame = Button()
        set_has_frame!(no_frame, false)
        set_child!(no_frame, Label("02"))
    
        circular = Button()
        set_is_circular!(circular, true)
        set_child!(circular, Label("03"))
    
        box = CenterBox(ORIENTATION_HORIZONTAL, normal, no_frame, circular)
        set_margin!(box, 75)
    
        set_child!(window, box)
        pesent!(window)
    end
    ```

Where the above shown buttons have the following properties:

| Button | `set_has_frame!` | `set_is_circular!`|
|--------|------------------|-------------------|
| 01     | `true`             | `false`             |
| 02     | `false`            | `false`             |
| 03     | `true`             | `true`              |

---

## ToggleButton

[`ToggleButton`](@ref) is a specialized form of `Button`. It supports most of `Button`s methods / signals, including `set_child!`, `set_has_frame!`, `set_is_circular!` and signal `clicked`.

Unique to `ToggleButton` is that, if clicked, the button will **remain pressed**. When clicked again, it returns to being unpressed. Anytime the state of the `ToggleButton` changes, signal `toggled` will be emitted. In this way, `ToggleButton` can be used to track a boolean state.

```@eval
using mousetrap
mousetrap.@signal_table(ToggleButton,
    toggled,
    clicked
)
```

To check whether the button is currently toggled, we use `get_is_active`, which returns `true` if the button is currently depressed, `false` otherwise.

```julia
toggle_button = ToggleButton()
connect_signal_toggled!(toggle_button) do self::ToggleButton
  println("state is now: $(get_is_active(self))")
end
set_child!(window, toggle_button)
```

---

## CheckButton

[`CheckButton`](@ref) is very similar to `ToggleButton` in function - but not appearance. `CheckButton` is an empty box in which a checkmark appears when it is toggled. Just like before, we query whether it is pressed by calling `get_is_active`. 

```@eval
using mousetrap
mousetrap.@signal_table(ToggleButton,
    toggled,
    clicked
)
```

`CheckButton` can be in one of **three** states, which are represented by the enum [`CheckButtonState`](@ref). The button can either be `CHECK_BUTTON_STATE_ACTIVE`, `CHECK_BUTTON_STATE_INACTIVE`, or `CHECK_BUTTON_STATE_INCONSISTENT`. This changes the appearance of the button:

![](../assets/check_button_states.png)

!!! details "How to generate this image"
    ```julia
    using mousetrap
    main() do app::Application
    
        window = Window(app)
    
        active = CheckButton()
        set_state!(active, CHECK_BUTTON_STATE_ACTIVE)
        active_box = vbox(active, Label("active"))
    
        inconsistent = CheckButton()
        set_state!(inconsistent, CHECK_BUTTON_STATE_INCONSISTENT)
        inconsistent_box = vbox(inconsistent, Label("inconsistent"))
    
        inactive = CheckButton()
        set_state!(inactive, CHECK_BUTTON_STATE_INACTIVE)
        inactive_box = vbox(inactive, Label("inactive"))
    
        for button in [active, inconsistent, inactive]
            set_horizontal_alignment!(button, ALIGNMENT_CENTER)
        end
    
        box = CenterBox(ORIENTATION_HORIZONTAL, active_box, inconsistent_box, inactive_box)
        set_margin!(box, 75)
    
        set_child!(window, box)
        present!(window)
    end
    ```

Note that `get_is_active` will only return `true` if the current state is specifically `CHECK_BUTTON_STATE_ACTIVE`. `toggled` is emitted whenever the state changes, regardless of which state the `CheckButton` was in.

---

## Switch

As the last widget intended to convey a boolean state to the user, we have [`Switch`](@ref), which has an appearance similar to a light switch. `Switch` does not emit `toggled`, instead, we connect to the `switched` signal, which is emitted anytime the switch's internal state changes:

```@eval
using mousetrap
mousetrap.@signal_table(Switch,
    switched
)
```

![](../assets/switch_states.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application
    
        window = Window(app)
    
        active = Switch()
        set_is_active!(active, true)
        active_box = vbox(active, Label("active"))
    
        inactive = Switch()
        set_is_active!(inactive, false)
        inactive_box = vbox(inactive, Label("inactive"))
    
        for switch in [active, inactive]
            set_horizontal_alignment!(switch, ALIGNMENT_CENTER)
            set_margin!(switch, 10)
        end
    
        box = CenterBox(ORIENTATION_HORIZONTAL)
        set_start_child!(box, active_box)
        set_end_child!(box, inactive_box)
        set_margin!(box, 75)
    
        set_child!(window, box)
        present!(window)
    end
    ```
---

---

## Adjustment

From widgets conveying a boolean state, we'll now move on to widgets conveying a discrete number. These let the user choose a value from a **range**, which, in mousetrap, is represented by a signal emitter called [`Adjustment`](@ref).

`Adjustment` has four properties:

+ `lower`: lower bound of the range
+ `upper`: upper bound of the range
+ `increment`: step increment
+ `value`: current value, in `[lower, upper]`

For example, the following `Adjustment`:

```julia
adjustment = Adjustment(
    1,      # value
    0,      # lower
    2,      # upper
    0.5     # step increment
)
```
Expresses the range `{0, 0.5, 1, 1.5, 2}`, with `1` being the value on initialization.

We usually do not need to create our own `Adjustment`, rather, it is provided by a number of widgets which use it to select their value. Notably, if the `Adjustment` is modified, that widget appearance is modified, and if the widget is modified, the adjustment is, too. 

`Adjustment` has two signals:

```@eval
using mousetrap
mousetrap.@signal_table(Adjustment,
    value_changed,
    properties_changed
)
```

We can connect to `value_changed` to monitor the `value` property of an `Adjustment` (and thus whatever widget is controlled by it), while `properties_changed` is emitted when one of `upper`, `lower` or `step increment` changes.

---

## SpinButton

`SpinButton` is used to pick an exact value from a range. The user can click the rectangular area and manually enter a value using the keyboard, or they can increase or decrease the current value by the step increment of the the widgets `Adjustment` by pressing the plus or minus button.

We supply the properties of the range underlying the `SpinButton` to its constructor:

```julia
# create SpinButton with range [0, 2] and increment 0.5
spin_button = SpinButton(0, 2, 0.5)
```

![](../assets/spin_button.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application
        window = Window(app)
    
        horizontal = SpinButton(0, 2, 0.5)
        set_value!(horizontal, 1)
    
        # Add invisible separator buffers above and below spin button for better symmetry
        horizontal_buffer = CenterBox(
            ORIENTATION_VERTICAL, 
            Separator(; opacity = 0.0),
            horizontal,
            Separator(; opacity = 0.0)
        )
    
        vertical = SpinButton(0, 2, 0.5)
        set_value!(vertical, 1)
        set_orientation!(vertical, ORIENTATION_VERTICAL)
    
        box = CenterBox(ORIENTATION_HORIZONTAL)
        set_start_child!(box, horizontal_buffer)
        set_end_child!(box, vertical)
    
        set_child!(window, box)
        present!(window)
    end             
    ```

We set and access any property of spin button using `get_value`, `set_value!`, `get_lower`, `set_lower!`, etc. These work exactly as if we were modifying the underlying `Adjustment`, which we can also obtain using `get_adjustment`.

Along with being *orientable*, `SpinButton` has two signals, one of which, `value_changed`, we recognize from `Adjustment`. To react to the user changing the value of a `SpinButton`, we would do the following:

```julia
spin_button = SpinButton(0, 2, 0.5)
connect_signal_value_changed!(spin_button) do self::SpinButton
    println("Value is now: $(get_value(self))")
end
```

The other signal is `wrapped`, which is emitted when [`set_should_wrap!`](@ref) was set to `true` and the spin buttons value under- or overflows.

---

## Scale

![](../assets/scale_no_value.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application
        window = Window(app)

        horizontal = Scale(0, 2, 0.5)
        set_orientation!(horizontal, ORIENTATION_HORIZONTAL)
        set_value!(horizontal, 1)
        set_size_request!(horizontal, Vector2f(200, 0))

        vertical = Scale(0, 2, 0.5)
        set_orientation!(vertical, ORIENTATION_VERTICAL)
        set_value!(vertical, 1)
        set_size_request!(vertical, Vector2f(0, 200))

        box = CenterBox(ORIENTATION_HORIZONTAL)
        set_start_child!(box, horizontal)
        set_end_child!(box, vertical)

        set_margin_horizontal!(box, 75)
        set_margin_vertical!(box, 40)

        set_child!(window, box)
        present!(window)
    end
    ```

[`Scale`](@ref), just like `SpinButton`, is a widget that allows a user to choose a value from the underlying `Adjustment`. This is done by click-dragging the knob of the scale, or clicking anywhere on its rail. In this way, it is usually harder to pick an exact decimal value on a `Scale` as opposed to a `SpinButton`. We can aid in this task by displaying the exact value next to the scale, which is enabled with [`set_should_draw_value!`](@ref):

![](../assets/scale_with_value.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application
        window = Window(app)

        window = Window(app)

        horizontal = Scale(0, 2, 0.5)
        set_orientation!(horizontal, ORIENTATION_HORIZONTAL)
        set_value!(horizontal, 1)
        set_size_request!(horizontal, Vector2f(200, 0))
        set_should_draw_value!(horizontal, true)

        vertical = Scale(0, 2, 0.5)
        set_orientation!(vertical, ORIENTATION_VERTICAL)
        set_value!(vertical, 1)
        set_size_request!(vertical, Vector2f(0, 200))
        set_should_draw_value!(vertical, true)

        box = CenterBox(ORIENTATION_HORIZONTAL)
        set_start_child!(box, horizontal)
        set_end_child!(box, vertical)

        set_margin_horizontal!(box, 75)
        set_margin_vertical!(box, 40)

        set_child!(window, box)
        present!(window)
    end
    ```

`Scale`supports most of `SpinButton`s functions, including querying information about its underlying range, setting the orientation, and signal `value_changed`:

```julia
scale = Scale(0, 2, 0.5)
connect_signal_value_changed!(scale) do self::Scale
    println("Value is now: $(get_value(self))")
end
```
---

## LevelBar

[`LevelBar`](@ref) is used to display a fraction to indicate the level of something, for example the volume of a playback device. This widget is static, it cannot be interacted with.

To create a `LevelBar`, we need to specify the minimum and maximum value of the range we wish to display. We can then set the current value using `set_value!`. The resulting fraction is computed automatically, based on the upper and lower limit we supplied to the constructor:

```julia
# create a LevelBar for range [0, 2]
level_bar = LevelBar(0, 2)
set_value!(level_bar, 1.0) # set to 50%
```

Unlike the previous widgets, `LevelBar` does not have a step increment.

Once the bar reaches 75%, it changes color:

![](../assets/level_bar.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application
        window = Window(app)

        box = Box(ORIENTATION_VERTICAL)
        set_spacing!(box, 10)
        set_margin!(box, 10)

        n_bars = 5
        for i in 1:n_bars
            fraction = Float32(i) / n_bars
            label = Label(string(Int64(round(fraction * 100))) * "%")
            set_size_request!(label, Vector2f(50, 0))

            bar = LevelBar(0, 1)
            set_value!(bar, fraction)
            set_expand_horizontally!(bar, true)

            row_box = Box(ORIENTATION_HORIZONTAL)
            set_spacing!(box, 10)
            push_back!(row_box, label)
            push_back!(row_box, bar)

            push_back!(box, row_box)
        end

        set_child!(window, box)
        present!(window)
    end
    ```

`LevelBar` also supports displaying a discrete value, in which case it will be drawn segmented. To enable this, we set [`set_mode!`](@ref) to `LEVEL_BAR_DISPLAY_MODE_DISCRETE`, as opposed to `LEVEL_BAR_MODE_CONTINUOUS`, which is the default.

---

## ProgressBar

Similarly to `LevelBar`, [`ProgressBar`](@ref) communicates a fraction to the user, which is frequently used to show the user how much of a task is currently completed.

`ProgressBar` only expresses values in `[0, 1]`, and [`set_fraction!`](@ref) will only accept values in this range.

Using `set_show_text!`, we can make it so the current percentage is drawn along with the progress bar, or we can draw a custom label using `set_text!`

![](../assets/progress_bar.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application
        window = Window(app)

        box = Box(ORIENTATION_VERTICAL)
    
        progress_bar = ProgressBar()
        set_fraction!(progress_bar, 0.47)
        set_vertical_alignment!(progress_bar, ALIGNMENT_CENTER)
        set_expand!(progress_bar, true)
        set_show_text!(progress_bar, true)
        set_margin!(progress_bar, 10)
        
        set_child!(window, progress_bar)
        present!(window)
    end
    ```
---

## Spinner

To signal progress when we do not have an exact fraction, we use [`Spinner`](@ref) which is a small spinning icon. Once we set [`set_is_spinning!`](@ref) to `true`, a spinning animation will play, indicating to the user that work is being done.

![](../assets/spinner.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application

        window = Window(app)

        spinner = Spinner()
        set_is_spinning!(spinner, true)

        set_child!(window, spinner)
        present!(window)
    end
     ```

---

## Entry

Text entry is central to many application. Mousetrap offers two widgets that allow the user to type freely. [`Entry`](@ref) is the widget of choice for **single-line** text entry.

The entries currently displayed text is stored in an internal text buffer. We can freely access or modify the buffers content with [`get_text`](@ref) and [`set_text!`](@ref).

While we could control the size of an `Entry` using size-hinting, a better way is [`set_max_width_chars!`](@ref), which resizes the entry such that its width is enough to fit a certain number of characters into its area. This automatically respects the systesm font and font size.

`Entry` supports "password mode", in which each character typed is replaced with a dot. This is to prevent a third party in the real world looking at a user screen and seeing what they are typing. 

To enter password mode, we set [`set_text_visible!`](@ref) to `false`. Note that this does not actually encrypt the text buffer in memory, it is a purely visual change.

![](../assets/entry.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application

        window = Window(app)

        clear = Entry()
        set_text!(clear, "text")

        password = Entry()
        set_text!(password, "text")
        set_text_visible!(password, false)

        box = vbox(clear, password)
        set_spacing!(box, 10)
        set_margin_horizontal!(box, 75)
        set_margin_vertical!(box, 40)

        set_child!(window, box)
        present!(window)
    end
    ```

Lastly, `Entry` is **activatable**, when the user presses the enter key while the cursor is inside the entries text area, it will emit signal `activate`. Its other signal, `text_changed`, is emitted whenever the internal text buffer changes: 

```@eval
using mousetrap
mousetrap.@signal_table(Entry,
    activate,
    text_changed
)
```

We would therefore connect a handler that reacts to the text of an entry changing like so:

```julia
entry = Entry()
set_text!(entry, "Write here")
connect_signal_text_changed!(entry) do self::Entry
    println("text is now: $(get_text(self))")
end
```

Note that the user cannot insert a newline character using the enter key. `Entry` should exclusively be used for text prompts which have **no line breaks**. For multi-line text entry, we should use the next widget instead.

## TextView

[`TextView`](@ref) is the multi-line equivalent of `Entry`. It supports a number of basic text-editor features, including **undo / redo**, which are triggered by the user pressing `Control + Z` and `Control + Y` respectively. We as developers can also trigger this behavior manually with [`undo!`](@ref) / [`redo!`](@ref).

Much like `Label`, we can set how the text aligns horizontally using `set_justify_mode!`. To further customize how text is displayed, we can choose the **internal margin**, which is the distance between the frame of the `TextView` and the text inside of it. `set_left_margin!`, `set_right_margin!`, `set_top_margin!` and `set_bottom_margin!` allow us to choose these values freely.

`TextView` does **not** have the `activate` signal, pressing enter while the cursor is inside the widget will simply create a new line. Instead, it only has signal `text_changed`, which behaves identical to that of `Entry`:

```@eval
using mousetrap
mousetrap.@signal_table(TextView,
    text_changed
)
```

```julia
text_view = TextView()
set_text!(text_view, "Write here")
connect_signal_text_changed!(text_view) do self::TextView
    println("text is now: $(get_text(self))")
end
```

---

## Dropdown

We sometimes want users to be able to pick a value from a **set list of values**, which may or may not be numeric. [`DropDown`](@ref) allows for this. If clicked, a small popup presents the user with a list of items. When clicking one of these items, that item becomes the active item.

We add an item using `push_back!`, which takes a string that will be used as the items label:

```julia
dropdown = DropDown()
item_01_id = push_back!(dropdown, "Item #01")
item_02_id = push_back!(dropdown, "Item #02")
item_03_id = push_back!(dropdown, "Item #03")
```

![](../assets/dropdown_simple.png)

`push_back!` returns the internal ID of the item. We should keep track of this ID, as it will be used to identify the currently selected item when using [`get_selected`](@ref).

If we do loose track of the ID, we can always retrieve it using [`get_item_at`](@ref), which returns the ID of the item at a given position.

`push_back!`, and its equivalents `push_front!` and `insert_at!`, provide a method that also takes a *callback*. This callback will be invoked when the item is selected. It is required to have the signature:

```
(::DropDown, [::Data_t]) -> Nothing
```

```julia
dropdown = DropDown()
push_back!(dropdown, "Item #01") do self::DropDown
    println("Item #01 selected")
end
push_back!(dropdown, "Item #02") do self::DropDown
    println("Item #03 selected")
end
push_back!(dropdown, "Item #03") do self::DropDown
    println("Item #03 selected")
end
```

This gives us a better mechanism of keeping track of which item is currently selected. Instead of querying the `DropDown` using `get_selected` and react to its result, we should instead register a callback using this method, in a similar way to using signals.

Lastly, sometimes we want a different label for when an item is selected, and for when the user opens the menu to select an item. For this situation, `push_back!` offers a method that lets us specify the label widgets separately:

```julia
dropdown = DropDown()
push_back!(dropdown,
    Label("Item #01"),  # Widget displayed in dropdown menu
    Label("01")         # Widget displayed when item is selected
)

push_back!(dropdown, Label("Item #02"), Label("02"))
push_back!(dropdown, Label("Item #03"), Label("03"))
```

![](../assets/dropdown_separate.png)

Where we had to first create a `Label` instance, then use it as the label widget, as this method of `push_back!` takes any two *widgets*, as opposed to just strings. This gives us full flexibility with how we want the dropdown to be displayed. This method, along with all methods of `push_front!` and `insert_at!`, also supports adding a callback as the first argument, which behaves exactly as before.

---

## Frame

[`Frame`](@ref) is a purely cosmetic widget that displays its singular child in a frame with a small border and rounded corners:

![](../assets/frame.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application

        window = Window(app)

        left = Separator()
        right = Separator()

        for separator in [left, right]
            set_size_request!(separator, Vector2f(50, 50))
            set_expand!(separator, false)
        end

        box = CenterBox(ORIENTATION_HORIZONTAL)
        set_start_child!(box, left)
        set_end_child!(box, Frame(right))

        set_margin_horizontal!(box, 75)
        set_margin_vertical!(box, 40)
    
        set_child!(window, box)
        present!(window)
    end
    ```

Using [`set_label_widget!`](@ref), we can furthermore choose a widget to be displayed above the child widget of the frame. This will usually be a `Label`, though `set_label_widget!` accepts any kind of widget.

`Frame` is rarely necessary, but will make GUIs seem more aesthetically pleasing and polished. 

---

## AspectFrame

Not to be confused with `Frame`, [`AspectFrame`](@ref) adds no graphical element to its singular child. Instead, the widget added with `set_child!` will be forced to allocate a size that conforms to a specific **aspect ratio**. That is, its width-to-height ratio will stay constant, regardless of the size of its parent. If expansion is enabled, the `AspectFrame` will still try to expand to the maximum size that still fullfills the aspect ratio requirement.

We choose the aspect ratio in `AspectFrame`s constructor, though we can later adjust it using [`set_ratio!`](@ref). Both of these functions accept a floating point ratio calculated as `width / height`. For example, if we want to force a widget to keep an aspect ratio of 4:3, we would do:

```julia
child_widget = # ...
aspect_frame = AspectFrame(4.0 / 3.0)
set_child!(aspect_frame, child_widget);
```

---

## ClampFrame

Using size-hinting, we are able to control the *minimum* size of a widget. There is no widget property that lets us control the *maximum size*, however. For this, we need [`ClampFrame`](@ref), a widget which constrains it singular child to never exceed the given maximum width, or height if the frames orientation is `ORIENTATION_VERTICAL`.

We choose the maximum size in pixels during construction, or using [`set_maximum_size!`](@ref):

```julia
child_widget = # ...
width_clamp_frame = ClampFrame(150, ORIENTATION_HORIZONTAL)
height_clamp_frame = ClampFame(150, ORIENTATION_VERTICAL)

set_child!(width_clamp_frame, child_widget)
set_child!(height_clamp_frame, width_clamp_frame)
```

In which we use two nested `ClampFrame`s, such that `child_widget` can never exceed `150px` for both its width and height.

---


## Overlay

So far, all widget containers have aligned their children such that they do not overlap. In cases where we do want this to happen, for example if we want to render one widget in front of another, we have to use [`Overlay`](@ref).

`Overlay` has one "base" widget, which is at the conceptual bottom of the overlay. It is set using `set_child!`. We can then add any number of widgets "on top" of the base widget using [`add_overlay!`](@ref):

![](../assets/overlay_buttons.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application

        window = Window(app)

        lower = Button()
        set_horizontal_alignment!(lower, ALIGNMENT_START)
        set_vertical_alignment!(lower, ALIGNMENT_START)

        upper = Button()
        set_horizontal_alignment!(upper, ALIGNMENT_END)
        set_vertical_alignment!(upper, ALIGNMENT_END)

        overlay = Overlay()
        set_child!(overlay, lower)
        add_overlay!(overlay, upper)

        set_child!(window, AspectFrame(1, overlay))
        present!(window)
    end
    ```

Where the position and size of overlayed widgets depend on their expansion and alignment properties.

By default, `Overlay` will allocate exactly as much space as the base widget (set with `set_child!`) does. If one of the overlaid widgets takes up more space than the base widget, it will be truncated. We can avoid this by supplying a second argument to `add_overlay!`, which is a boolean keyword argument indicated whether the overlay widget should be included in the entire containers size allocation. That is, if the overlaid widget is larger than the base widget, should the `Overlay` resize itself such that the entire overlaid widget is visible:

```julia
add_overlay!(overlay, overlaid_widge; include_in_measurement = true)
```

---

## Paned

[`Paned`](@ref) is a widget that always has exactly two children. Between the two children, a visual barrier is drawn. The user can click on this barrier and drag it horizontally or vertically, depending on the orientation of the `Paned`. This gives the user the option to resize how much of a shared space the two widgets allocate.

`Paned` is orientable. Depending on its orientation, `set_start_child!` and  `set_end_child!` add a widget to the corresponding side.

![](../assets/paned.png)

!!! details "How to generate this image"
    ```julia
    function generate_child(label::String)
        out = Frame(Overlay(Separator(), Label(label)))
        set_margin!(out, 10)
        return out
    end

    main() do app::Application

        window = Window(app)

        paned = Paned(ORIENTATION_HORIZONTAL)
        set_start_child!(paned, generate_child("Left"))
        set_end_child!(paned, generate_child("Right"))

        set_start_child_shrinkable!(paned, true)
        set_end_child_shrinkable!(paned, true)

        set_child!(window, paned)
        present!(window)
    end
    ```

`Paned` has two per-child properties: whether a child is **resizable** and whether it is **shrinkable**.

Resizable means that if the `Paned` changes size, the allocated area of its child should resize accordingly.

Shrinkable sets whether the side of the `Paned` can be made smaller than the allocated size of that sides child widget. If set to `true`, the user can drag the `Paned`s barrier, such that one of the widgets is partially or completely hidden:

```julia
set_start_child_shrinkable!(paned, true)
set_end_child_shrinkable!(paned, true)
```

![](../assets/paned_shrinkable.png)

---

## Revealer

While not technically necessary, animations can improve user experience drastically. Not only do they add visual style, they can hide abrupt transitions or small loading times. As such, they should be in any advanced GUI designer's repertoire.

One of the most common applications for animations is the act of hiding or showing a widget. [`Revealer`](@ref) was made for this purpose.

To trigger the `Revealer`s animation and change whether its singular child widget is currently visible, we call [`set_is_revealed!`](@ref) which takes a boolean as its argument. If the widget goes from hidden to shown or shown to hidden, the animation will play. Once the animation is done, signal `revealed` will be emittedd.

### Transition Animation

We have control over the kind and speed of the transition animation. By calling [`set_transition_duration!`](@ref), we can set the exact amount of time an animation should take. For example, to set the animation duration to 1 second:

```julia
revealer = Revealer()
set_child!(revealer, #= widget =#)
set_transition_duration!(revealer, seconds(1));
```

Where `seconds` returns a [`mousetrap.Time`](@ref).

Apart from the speed, we also have a choice of animation **type**, represented by the enum [`RevealerTransitionType`](@ref). Animations include a simple cross-fade, sliding, swinging, or no animation at all, which instantly shows or hides the widget.

![](../assets/revealer.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application
        window = Window(app)

        # create child
        child = Frame(Overlay(Separator(), Label("<span size='200%'>[Item]</span>")))
        set_margin!(child, 10)
        set_size_request!(child, Vector2f(0, 100))

        # setup revealer
        revealer = Revealer()
        set_child!(revealer, child)
        set_transition_duration!(revealer, seconds(1))
        set_transition_type!(revealer, REVEALER_TRANSITION_TYPE_SLIDE_DOWN)

        # create a button that, when clicked, triggers the revealer animation
        button = Button()
        connect_signal_clicked!(button, revealer) do self::Button, revealer::Revealer
            set_is_revealed!(revealer, !get_revealed(revealer))
        end
    
        set_child!(window, vbox(button, revealer))
        present!(window)
    end
    ```
---

## ActionBar

One common application for using a `Revealer` is to show or hide a *toolbar*, which is a horizontal box with any number of buttons for contextual actions. For this purpose, [`ActionBar`](@ref) is well suited, because it can be shown/hidden using [`set_is_revealed!`](@ref) all by itself, making it so we don't need to use a separate `Revealer` instance.

`ActionBar` is always horizontal, it cannot be oriented. It has space for any number of widgets on either side, along with having a singular centered widget. We pack widgets at to both sides using `push_start!` and `push_end!`, while the centered widget is set using `set_center_widget!`. 

---

## Expander

[`Expander`](@ref) is similar to `Revealer`, in that it also has exactly one child widget, and it shows / hides the widget. Unlike `Revealer`, there is no animation attached to `Expander`. Instead, it hides the widget behind a collapsible label.

Expander has two children, the label, set with `set_label_widget!`, and its child, set with `set_child!`, which is the widget that will be shown / hidden.

![](../assets/expander.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application
        window = Window(app)

        child = Frame(Overlay(Separator(), Label("Child")))
        set_margin!(child, 10)
        set_size_request!(child, Vector2f(0, 100))

        label = Label("Label")
        set_margin!(label, 10)
    
        expander_and_frame = Frame(Expander(child, label))
        set_margin!(expander_and_frame, 10)

        set_child!(window, expander_and_frame)
        present!(window)
    end
    ```

Note that `Expander` should not be used to create nested lists, as `ListView`, a widget we will learn about later in this chapter, is better suited for this purpose.

---

## Viewport

By default, most containers will allocate a size equal to or exceeding that of its children. For example, if we create a widget that has a natural size of 5000x1000 px and use it as the child of a `Window`, the `Window` will attempt to allocate 5000x1000 pixels on screen, making the window far larger than most screens can display. 

Sometimes widgets that are this large are unavoidable. In situations like this, we can use [`Viewport`](@ref) to only display part of a widget.

We set the viewports singular child using `set_child!`, after which the user can operate the two scrollbars to change which part of the child is currently visible:

![](../assets/viewport.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application

        window = Window(app)

        child = Frame(Overlay(Separator(), Label("<span size='800%'>CHILD</span>")))
        set_margin!(child, 10);

        viewport = Viewport()
        set_child!(viewport, child)

        set_child!(window, viewport)
        present!(window)
    end
    ```

### Size Propagation

By default, `Viewport` will disregard the size of its child and simply allocate an area based only on the properties of the `Viewport` itself. This behavior can be overridden by setting the viewports **size propagation**.

If [`set_propagate_natural_height!`](@ref) is set to true, the viewports height will be equal the height of its child. Conversely, [`set_propagate_natural_width!`](@ref) does the same for the childs width.

```julia
set_propagate_natural_width!(viewport, true)
set_propagate_natural_height!(viewport, false)
```

![](../assets/viewport_propagation.png)

Here, the viewport will be the same width as the child, but the viewports height is independent of that of its child. 

### Scrollbar Policy

`Viewport` has two scrollbars, controlling the horizontal and vertical position. By default, these will automatically reveal themself when the users cursor enters the viewport, hiding again once the cursor exists.

If and when to reveal the scrollbars is determined by the viewports **scrollbar policy**, set with [`set_horizontal_scrollbar_policy!`](@ref) and  [`set_vertical_scrollbar_policy!`](@ref), both of which take a value of the enum [`ScrollbarVisibilityPolicy`](@ref), which has the following instances:


| `ScrollbarVisibilityPolicy` | Meaning |
|-----------------------------|-----------|
| `SCROLLBAR_VISIBILITY_POLICY_NEVER` | scrollbar always hidden |
| `SCROLLBAR_VISIBILITY_POLICY_ALWAYS` | scrollbar is always shown |
| `SCROLLBAR_VISIBILITY_POLICY_AUTOMATIC` | scrollbar hides/shows automatically|

If `set_propagate_natural_height!` is set to `true`, the vertical scrollbar will always be hidden, regardless of policy. The same is true for `set_propagate_natural_width!` and the horizontal scrollbar.

### Scrollbar Position

Lastly, we can customize the location of both scrollbars at the same time using [`set_scrollbar_placement!`](@ref), which takes one of the following values of the enum [`CornerPlacement`](@ref).

| `CornerPlacement` | Meaning |
|-------------------|---------|
| `CORNER_PLACEMENT_TOP_LEFT` | horizontal scrollbar at the top, vertical scrollbar on the left |
| `CORNER_PLACEMENT_TOP_RIGHT` | horizontal at the top, vertical on the right |
| `CORNER_PLACEMENT_BOTTOM_LEFT` | horizontal at the bottom, vertical on the left |
| `CORNER_PLACEMENT_BOTTOM_RIGHT` | horizontal at the bottom, vertical on the right |

### Signals

If we want to react to the user scrolling the `Viewport`s child, we can either connect to its signal `scroll_child`, or we can access the `Adjustment` controlling each scrollbar using `get_horizontal_adjustment` and `get_vertical_adjustment`, then connect to the signals of the obtained `Adjustment`s.

With this, scrollbar policy, and size propagation we have full control over every aspect of `Viewport`.

--- 

## Scrollbar

`Viewport` comes with two scrollbars, but we can also create our own. Using [`Scrollbar`](@ref), which takes an `Orientation` as well as an  `Adjustment` for its constructor, we can create a fully custom scrolling widget.

To react to the user scrolling, we need to connect to the signals of the `Adjustment`, as `Scrollbar` does not provide any signals itself:

```julia
adjustment = Adjustment(0.5, 0, 1, 0.01)
scrollbar = Scrollbar(ORIENTATION_HORIZONTAL, adjustment)
connect_signal_value_changed!(adjustment) do self::Adjustment
    println("Value is now $(get_value(self))")
end

set_child!(window, scrollbar)
```

Where we made it such that the scrollbar expresses the range `[0, 1]`, with a step increment of `0.01` and an initial value of `0.5`.

If we loose track of the `Adjustment` instance after constructing the `ScrollBar`, we can retrieve it anytime using `get_adjustment`.

---

## Popover

A [`Popover`](@ref) is a special kind of window. It is always [modal](#modality--transience). Rather than having the normal window decoration with a close button and title, `Popover` closes dynamically (or when requested by the application).

Showing the popover is called **popup**, closing the popover is called **popdown**, `Popover` correspondingly has [`popup!`](@ref) and [`popdown!`](@ref) to show / hide itself.

![](../assets/popover.png)

!!! details "How to generate this image"
    ```julia
    using mousetrap

    main() do app::Application
        window = Window(app)

        child = Frame(Overlay(Separator(), Label("Child")))
        set_size_request!(child, Vector2f(100, 75))
        set_margin!(child, 10);

        popover = Popover()
        set_child!(popover, child)
        button = Button()

        # when the button is clicked, the popover is shown. It hides automatically
        connect_signal_clicked!(button, popover) do self::Button, popover::Popover
            popup!(popover)
        end

        # to show the popover, it needs to be inside the same container as the child it should be attached to
        set_child!(window, vbox(popover, button))
        present!(window)
    end
    ```

Manually calling `popup!` or `popdown!` to show / hide the `Popover` can be bothersome. To address this, mousetrap offers a widget that automatically manages the popover for us: [`PopoverButton`](@ref)

## PopoverButton

`PopoverButton` has a single child and one signal: `activate`:

```@eval
using mousetrap
mousetrap.@signal_table(PopoverButton,
    activate
)
```

Instead of triggering behavior, `PopoverButton`s purpose is to reveal and hide a `Popover`.

We first create the `Popover`, then supply it as the argument to `PopoverButton`s constructor:

```julia
popover = Popover()
popover_button = PopoverButton(popover)
```

Additionally, an arrow is shown next to the label of the `PopoverButton`, indicating to the user that, when it is clicked, a popover will open.

---

## SelectionModel

We will now move on to **selectable widgets**, which tend to be the most complex and powerful widgets in mousetrap.

All selectable widgets have on thing in common: their multiple children are managed by a **selection model**. This model is a list of widgets. For each widget, the model will keep track of whether that widget is currently selected. If it is, a graphical element will be added to the selectable widget that indicates to the user which item(s) are currently selected:

![](../assets/list_view_selected.png)

Modifying the model will modify the selectable widget, and modifying the selectable widget will modify the model. In this way, the two are linked, similar to how `Adjustment` works. We use [`select!`](@ref) and [`unselect!`](@ref) to change the selection manually, while [`get_selection!`](@ref) returns a vector with one or more of the selected items indices.

`SelectionModel` has signal `selection_changed`, which is emitted anytime an item is selected or unselected in any way. This signal requires the signature
```
(::SelectionModel, position::Integer, n_items::Integer, [::Data_t]) -> Nothing
```
Where `position` is the new index of the changed item (1-based), while `n_items` is the number of currently selected items.

Each model has an associated property called the **selection mode**, which is expressed by the enum [`SelectionMode`](@ref). This governs how many items can be selected at one time:

| `SelectionMode`           | Number of Items |
|---------------------------|-----------------|
| `SELECTION_MODE_NONE`     | exactly zero    |
| `SELECTION_MODE_SINGLE`   | exactly one     |
| `SELECTION_MODE_MULTIPLE` | zero or more    |


We do not create instances of `SelectionModel` ourselves, instead, they are automatically created along with the selectable widget. Because of this, we will need to specify the selection mode in the selectable widgets constructor.

## ListView

For our first selectable widget, we have [`ListView`](@ref). This is a widget that arranges its children in a row or column, depending on orientation. We add children using `push_back!`, `push_front!` and `insert_at!`:

```julia
list_view = ListView(ORIENTATION_VERTICAL, SELECTION_MODE_SINGLE)
push_back!(list_view, Label("Child #01"))
push_back!(list_view, Label("Child #02"))
push_back!(list_view, Label("Child #03"))
```

![](../assets/list_view_simple.png)

Where the second child is currently selected.

`ListView` can be requested to automatically show separators in-between two items by setting [`set_show_separators!`](@ref) to `true`. To check which item is selected, we query its selection model, which we obtain using [`get_selection_model`](@ref).

### Nested Trees

By default, `ListView` displays its children in a linear list, either horizontally or vertically. `ListView` also supports **nested lists**, sometimes called a **tree view**:

![](../assets/list_view_nested.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application

        window = Window(app)

        list_view = ListView(ORIENTATION_VERTICAL, SELECTION_MODE_SINGLE)
        push_back!(list_view, Label("Child #01"))
        child_02_it = push_back!(list_view, Label("Child #02"))
        push_back!(list_view, Label("Child #03"))

        push_back!(list_view, Label("Nested Child #01"), child_02_it)
        nested_child_02_it = push_back!(list_view, Label("Nested Child #02"), child_02_it)

        push_back!(list_view, Label("Inner Child #01"), nested_child_02_it)

        frame = Frame(list_view)
        set_margin!(frame, 10)
        set_child!(window, frame)
        present!(window)
    end
    ```

The user can click any item to hide or show its children. Items that do not have any children will appear just as with a non-nested `ListView`.

Each item of a `ListView` can in itself be made a list view. To do this, we use an optional argument of `push_back!` (or `push_front!`, `insert_at!`), which is of type [`ListViewIterator`](@ref). 

This iterator identifies which list view to insert the item in. We obtain an iterator like so:

```julia
list_view = ListView()
child_01_it = push_back!(list_view, Label("Child #01"))
child_02_it = push_back!(list_view, Lable("Child #02"))
child_03_it = push_back!(list_view, Lable("Child #03"))
```

If we want to convert the item containing the label `Child #02` to a list view and insert an item as its child, we use that items iterator as the optional argument:

```julia
nested_child_01_it = push_back!(list_view, Label("Nested Child #01"), child_02_it)
```

To insert a new widget as the child of this already nested list, we use its iterator. Through this mechanism, we can create arbitrarily deep nested lists.

If we do not want a nested list, we can instead completely ignore the iterator. Specifying no iterator when using `push_back!` means we will be inserting items into the outer most list.

---

## GridView

[`GridView`](@ref) supports many of the same functions as `ListView`, including `push_back!`, `push_front!`, and `insert_at!`. Unlike `ListView`, `GridView` cannot be nested, as it instead displays its children in a **uniform grid**.

`GridView`s constructor also takes an orientation as well as the selection mode. The orientation determines in which order elements will be shown. Consider the next two images, the first of which is a `GridView` whose orientation is `ORIENTATION_HORIZONTAL`, while the latters is `ORIENTATION_VERTICAL`:

![](../assets/grid_view_horizontal.png)

*A horizontal `GridView`*

![](../assets/grid_view_vertical.png)

*A vertical `GridView`*

!!! details "How to generate this image"
    ```julia
    function generate_child(label::String) ::Widget

        child = Frame(Overlay(Separator(), Label(label)))
        set_size_request!(child, Vector2f(50, 50))
        set_expand!(child, false)
        return AspectFrame(1, child)
    end

    main() do app::Application
        window = Window(app)

        grid_view = GridView(ORIENTATION_VERTICAL) # or `ORIENTATION_HORIZONTAL`
        set_expand!(grid_view, true)

        for i in 1:9
            push_back!(grid_view, generate_child("0$i"))
        end

        separator = Separator()
        set_expand!(separator, true)
        set_expand!(grid_view, false)

        set_child!(window, vbox(separator, grid_view))
        present!(window)
    end
    ```

We can control the exact distribution of widgets more closely by using [`set_max_n_columns!`](@ref) and [`set_min_n_columns!`](@ref), which make it so the grid view will always have the given number of columns (or rows, for a horizontal `GridView`).

---

## Column View

[`ColumnView`](@ref) is used to display widgets as a table, with rows and columns. Each column has a title, which uniquely identifies it.

To fill our `ColumnView`, we first instance it, then allocate a number of columns:

```julia
column_view = ColumnView()

column_01 = push_back_column!(column_view, "Column #01")
column_02 = push_back_column!(column_view, "Column #02")
column_03 = push_back_column!(column_view, "Column #03")
```

Each column requires a title that should be unique to that column.

We can also add a column at any point, even after rows have been added. Along with [`push_back_column!`](@ref), [`push_front_column!`](@ref) and [`insert_column_at!`](@ref) are also available. All of these functions return an object of type [`ColumnViewColumn`](@ref).

To add a widget into the n-th row (1-based) of a `ColumnViewColumn`, we use `set_widget_at!`:

```julia
# add 3 labels into column 1, rows 1 - 3
set_widget_at!(column_view, column_01, Label("01"))
set_widget_at!(column_view, column_01, Label("02"))
set_widget_at!(column_view, column_01, Label("03"))
```

![](../assets/column_view.png)

!!! details "How to generate this image"
    ```julia
    main() do app::Application

        println("called")

        window = Window(app)
        set_title!(window, "mousetrap.jl")

        column_view = ColumnView()

        column_01 = push_back_column!(column_view, "Column #01")
        column_02 = push_back_column!(column_view, "Column #02")
        column_03 = push_back_column!(column_view, "Column #03")

        column_i = 1
        for column in [column_01, column_02, column_03]
            for row_i in 1:9
                set_widget_at!(column_view, column, row_i, Label("0$column_i | 0$row_i"))
            end
            column_i = column_i + 1
        end

        set_expand!(column_view, true)
        set_child!(window, column_view)
        present!(window)
    end
    ```

Any rows that does not yet have widgets will be backfilled and appear empty. 

If we loose track of the `ColumnViewColumn` instance returned when adding a new column, we can retrieve it using `get_column_at` or `get_column_with_title`, the latter of which takes the unique title we chose when adding the column.

Since most of the time we will want all cells in a row to contain a widget, we can also use [`push_back_row!`](@ref), [`push_front_row!`](@ref), or [`insert_row_at!`](@ref), which insert n widgets at once, where n is the number of columns:

```julia
# add 1st widget to 1st column, 2nd widget to 2nd column, etc.
push_back_row!(column_view, Label("Column 01 Child"), Label("Column 02 Child"), Label("Column 03 Child"))
```

This is a more convenient way to fill the column view, though if we later want to edit it, we will have to use `set_widget_at!` to override widgets in any rows.

`ColumnViewColumn` has a number of other features. We can make it so the user can freely resize each column by setting [`set_is_resizable!`](@ref) to `true`, or we can force each column to have an exact width using [`set_fixed_width!`](@ref), which takes the widget as a number of pixels.

---

## Stack

[`Stack`](@ref) is a selectable widget that can only ever display exactly one child at a time. Each child of the stack is called a **page**.

We add a page using `add_child!`, which takes any widget, and the pages title. This title is mandatory and it has to uniquely identify the page. `add_child!` returns the pages ID, which, similarly to how adding elements to `DropDown` works, we need to keep track of in order to later refer to pages in a position-independent manner.

```julia
stack = Stack()

id_01 = add_child!(stack, page_01_widget, "Page #01")
id_02 = add_child!(stack, page_02_widget, "Page #02")
id_03 = add_child!(stack, page_03_widget, "Page #03")
```

To check which page is currently visible, we use [`get_visible_child`](@ref), which returns that pages ID. If we loose track of it, we can retrieve the ID of a stack page at a given position using [`get_child_at`](@ref).

To keep track of which page is currently selected, we should connect to the stacks underlying `SelectionModel`, just like we would with `ListView` and `GridView`:

```julia
function on_selection_changed(self::SelectionModel, position::Integer, n_items::Integer, stack::Stack)
    println("Current stack page is now: $(get_child_at(stack, position))")
end

stack = Stack()
stack_model = get_selection_model(stack)
connect_signal_selection_changed!(on_selection_changed, stack_model, stack)
```

Where we provided the `Stack` instance to the selection models signal handler as the optional `data` argument, so that we can reference it from within the signal handler.

While we can change the currently active page using `set_visible_child!`, our user cannot. To allow them to change the page of a `Stack`, we either need
to provide another widget that modifies the stack, or we can use one of two pre-made widgets for this purpose: `StackSwitcher` and `StackSidebar`.

### StackSwitcher

[`StackSwitcher`](@ref) presents the user with a row of buttons, each of which use the corresponding stack pages title:

![](../assets/stack_switcher.png)

!!! details "How to generate this image"
    ```julia
    function generate_child(label::String) ::Widget
        child = Frame(Overlay(Separator(), Label(label)))
        set_size_request!(child, Vector2f(150, 150))
        set_margin!(child, 10)
        return child
    end

    main() do app::Application
        window = Window(app)

        stack = Stack()

        add_child!(stack, generate_child("Child #01"), "Page #01")
        add_child!(stack, generate_child("Child #02"), "Page #02")
        add_child!(stack, generate_child("Child #03"), "Page #03")

        stack_model = get_selection_model(stack)
        connect_signal_selection_changed!(stack_model, stack) do x::SelectionModel, position::Integer, n_items::Integer, stack::Stack
            println("Current stack page is now: $(get_child_at(stack, position))")
        end

        set_child!(window, vbox(stack, StackSwitcher(stack))) # create StackSwitcher from stack
        present!(window)
    end
    ```

`StackSwitcher` has no other methods or properties, though it provides the signals that all widgets share.

### StackSidebar

[`StackSidebar`](@ref) has the same purpose as `StackSwitcher`, except it displays the list of stack pages as a vertical list:

!!! details "How to generate this image"
    ```julia
    function generate_child(label::String) ::Widget
        child = Frame(Overlay(Separator(), Label(label)))
        set_size_request!(child, Vector2f(150, 150))
        set_margin!(child, 10)
        return child
    end

    main() do app::Application
        window = Window(app)

        stack = Stack()

        add_child!(stack, generate_child("Child #01"), "Page #01")
        add_child!(stack, generate_child("Child #02"), "Page #02")
        add_child!(stack, generate_child("Child #03"), "Page #03")

        stack_model = get_selection_model(stack)
        connect_signal_selection_changed!(stack_model, stack) do x::SelectionModel, position::Integer, n_items::Integer, stack::Stack
            println("Current stack page is now: $(get_child_at(stack, position))")
        end

        set_child!(window, vbox(stack, StackSwitcher(stack))) # Create StackSidebar from stack
        present!(window)
    end
    ```

Other than this visual component, its purpose is identical to that of `StackSwitcher`.

### Transition Animation

When changing which of the stacks pages is currently shown, regardless of how that selection was triggered, an animation transitioning from one page to the other plays. Similar to `Revealer`, we can influence the type and speed of animation in multiple ways:

+ [`set_transition_duration!`](@ref) chooses how long the animation will take to complete
+ [`set_interpolate_size!`](@ref), if set to `true`, makes it, such that while the transition animation plays, the stack will change from the size of the previous child to the size of the current child gradually. If set to `false`, this size change happens instantly
+ [`set_animation_type!`](@ref) governs the type of animation, which is one of the enum values of [`StackTransitionType`](@ref).

If we want all of the stacks children to allocate the same size, we can set [`set_is_vertically_homogeneous!`](@ref) and [`set_is_horizontally_homogeneous!!`](@ref) to `true`, in which case the stack will assume the height or widget of its largest page, respectively.

---

Moving on from selectable widgets, we have a few more widget containers to get through. These offer more flexibility in arranging widgets, but do not offer `get_selection_model` and its related features.

## Grid

Not to be confused with `GridView`, [`Grid`](@ref) arranges its children in a **non-uniform** grid:

![](../assets/grid.png)

!!! details "How to generate this image"
    ```julia
    function generate_child(label::String) ::Widget
        child = Frame(Overlay(Separator(), Label(label)))
        set_size_request!(child, Vector2f(50, 50))
        return child
    end

    main() do app::Application

        window = Window(app)
        
        grid = Grid()

        mousetrap.insert_at!(grid, generate_child("01"), 1, 1, 2, 1)
        mousetrap.insert_at!(grid, generate_child("02"), 3, 1, 1, 2)
        mousetrap.insert_at!(grid, generate_child("03"), 4, 1, 1, 1)
        mousetrap.insert_at!(grid, generate_child("04"), 1, 2, 1, 2)
        mousetrap.insert_at!(grid, generate_child("05"), 2, 2, 1, 1)
        mousetrap.insert_at!(grid, generate_child("06"), 4, 2, 1, 1)
        mousetrap.insert_at!(grid, generate_child("07"), 2, 3, 3, 1)
    
        set_margin!(grid, 10)
        set_child!(window, grid)
        present!(window)
    end
    ```

Each widget in the grid has a x- and y-position, along with a widget and height, both measured in **number of cells** . 

For example, in the image above, the widget labeled `05` has the x-position of 2, y-position of 2, a width of 1 cell and a height of 1 cell. 

```julia
mousetrap.insert_at!(
    grid, 
    widget_05,
    2,  # x-position
    2,  # y-position
    1,  # width
    1   # height
)
```

Meanwhile, the widget labeled `07` has an x-position of 2, y-position of 3, width of 3 cells and height of 1 cell.

```julia
mousetrap.insert_at!(
    grid, 
    widget_07, 
    2,  # x-position
    3,  # y-position
    3,  # width
    1   # height
)
```

When using `insert_at!`, we have to make sure that no two widgets overlap.

For a less manual way of arranging widgets, we can insert a widget next to another widget already in the grid using [`insert_next_to!`](@ref), which takes an argument of type [`RelativePosition`](@ref) in order to specify whether we want to insert the new widget above, below, left of, or right of the widget already inside the grid:

```julia
child = # ...

# insert `child` at position (1, 1)
insert_at!(grid, child, 1, 1)

new_widget = # ...
# insert new widget left of child
insert_next_to!(grid, new_widget, child, RELATIVE_POSITION_LEFT_OF)
```

Where we ommitted the width and height in cells, which default to `1` respectively. 

Note that in this example, `child` is at position `(1, 1)`, and `new_widget` was inserted left of `child`, meaning it is now at position `(0, 1)`. `Grid` will dynamically insert rows and columns as needed, meaning that the x- and y-position may be `0` or even negative.

Lastly, `set_column_spacing!` and `set_row_spacing!` automatically insert margins in between columns and rows, while `set_rows_homogeneous!` and `set_columns_homogeneous!` make it so all rows or columns will allocate the same height and width, respectively.

`Grid` offers a more flexible, but also more manual way of arranging widgets in 2D space.

---

## Notebook

[`Notebook`](@ref) is very similar to `Stack`, it always displays exactly one child, though `Notebook` is not based on a `SelectionModel`. Unlike `Stack`, it comes with a built-in way for users to choose which child to show.

Each notebook page has two widgets, the **child widget**, which is displayed in the content area of each page, and the **label widget**, which is the label used for the tab. This will usually be a `Label`, though any widget can be used.

We add pages using `push_back!`, `push_front!` or `insert_at!`, which take the child and label widget as their arguments:

```julia
notebook = Notebook()

push_back!(notebook, child_01, Label("Label #01"))
push_back!(notebook, child_02, Label("Label #02"))
push_back!(notebook, child_03, Label("Label #03"))
```
![](../assets/notebook.png)

!!! details "How to generate this image"
    ```julia
    function generate_child(label::String) ::Widget
        child = Frame(Overlay(Separator(), Label(label)))
        set_size_request!(child, Vector2f(150, 150))
        set_margin!(child, 10)
        return child
    end

    main() do app::Application
        window = Window(app)

        notebook = Notebook()

        push_back!(notebook, generate_child("Child #01"), Label("Label #01"))
        push_back!(notebook, generate_child("Child #02"), Label("Label #02"))
        push_back!(notebook, generate_child("Child #03"), Label("Label #03"))

        set_child!(window, notebook)
        present!(window)
    end
    ```

We can allow the user to reorder the pages by setting [`set_tabs_reorderable!`](@ref) to `true`. This will make it so they can click drag-and-drop the label widget, moving the entire notebook page to that position.

If we want to change the currently selected page, we use `next_page!`, `previous_page!`, or `goto_page!`, the latter of which takes the page position as an integer.

To react to the user changing the currently selected page, we have to connect to one of `Notebook`s unique signals, all of which require a signal handler with the same signature: 

```@eval
using mousetrap
mousetrap.@signal_table(Notebook,
    page_added,
    page_removed,
    page_reordered,
    page_selection_changed
)
```

For example, if we want to react to the currently selected page changing, we would connect to signal `page_selection_changed` like so:

```julia
notebook = Notebook()
connect_signal_page_selection_changed!(notebook) do self::Notebook, index::Integer
    println("Page #$index is now selected")
end
```

---

## Compound Widgets

Now that we have many new widgets in our arsenal, a natural question is "how do we make our own?". If we want to construct a completely new widget pixel-by-pixel we will have to wait until the chapter on [native rendering](./09_native_rendering.md). Until then, we are already perfectly capable of creating what we'll call a **compound widget**.

A compound widget is a widget that groups many other, pre-made widgets together. Compound widgets give an easy mechanism to 
logically group a collection of widgets and treat them as a whole, instead of having to operate on each of its parts individually.

In order for a Julia object to be considered a `Widget`, that is, all functions that take a `mousetrap.Widget` also work 
on this new object, it has to implement the **widget interface**. An object is considered a `Widget` if...

+ it is a direct or indirect subtype of `Widget`
+ [`get_top_level_widget`](@ref), which maps it to its top-level widget, is defined for this type

In this section we will work through an example, explain what both of these conditions mean, and how to fullfill them.

### Example: Placeholder

In the previous section on selectable containers such as a `ListView` and `GridView`, we used this "placeholder" widget:

![](../assets/compound_widget_list_view.png)

In this image we have a `ListView` with four elements, each of the elements is an object of type `Placeholder`, which is a newly created compound widget.

Looking closely, we see that each placeholder has a `Label` with the title and a `Separator` behind the label. Because they are rendered on top of each other, an `Overlay` has to be involved. A `Frame` is used to give the element rounded corners, lastly, each element is square at all times, which means its size is managed by an `AspectFrame`.

Creating a new Julia struct with these elements, we do:

```julia
struct Placeholder
    label::Label
    separator::Separator
    overlay::Overlay
    frame::Frame
    aspect_frame::AspectFrame
end
```

We add a constructor that assembles these widgets in the correct way like so:

```julia
function Placeholder(text::String)
    out = Placeholder(
        Label("<tt>" * text * "</tt>")  # label with monospaced text 
        Separator()                     # background
        Overlay()                       # overlay to draw `label` on top of `separator` background
        Frame()                         # frame for outline and rounded corners
        AspectFrame(1.0)                # square aspect frame
   )     
   
   # make the background the lower most layer
   set_child!(out.overlay, out.separator)
   
   # add the label on top
   add_overlay(out.overlay, out.label; include_in_measurement = true)
   
   # add everything into the `Frame`
   set_child!(frame, overlay)
   
   # force frame to be square
   set_child!(aspect_frame, frame)
   
   return out
end
```

With our compound widget assembled, we will want to make it the child of a `Window` or other container:

```julia
main() do app::Application
    window = Window(app)
    set_child!(window, Placeholder("Test"))
    present!(window)
end 
```
```
[ERROR] In mousetrap.main: MethodError: no method matching set_child!(::Window, ::Placeholder)

Closest candidates are:
  set_child!(::Window, ::Widget)
```

We can't, because `Placeholder`, the new Julia struct, is not yet considered a `mousetrap.Widget`. 

### Widget Interface

To solve this, we come back to our two properties that make something a widget:
1) it is direct or indirect subtype of `Widget`
2) `get_top_level_widget`, which maps it to its top-level widget, is defined for this type

Solving 1), we make `Placeholder` a subtype of `mousetra.Widget`:

```julia
struct Placeholder <: Widget
    label::Label
    separator::Separator
    overlay::Overlay
    frame::Frame
    aspect_frame::AspectFrame
end
```

To implement `get_top_level_widget`, we need to look at how we assembled `Placeholder` during its constructor, then figure out which widget is indeed top-level.

We can write the `Placeholder` architecture out like so:

```cpp
AspectFrame \
  Frame \
    Overlay \
      Label
      Separator
```

Where a widget with `\` is a widget container. The only widget without a direct parent is the `AspectFrame`, therefore `aspect_frame` is the top-level widget.

Given this, we implement `get_top_level_widget` like so:

```julia
mousetrap.get_top_level_widget(x::Placeholder) = x.aspect_frame
```

Where the `mousetrap.` prefix is necessary to tell the compiler that we are overloading that method, not creating a new method in our current module.

With `Widget` subtyped and `get_top_level_widget` implemented, our `main.jl` now looks like this:

```julia
struct Placeholder <: Widget
    label::Label
    separator::Separator
    overlay::Overlay
    frame::Frame
    aspect_frame::AspectFrame
end

function Placeholder(text::String)
    out = Placeholder(
        Label("<tt>" * text * "</tt>"),
        Separator(),
        Overlay(),
        Frame(),
        AspectFrame(1.0)
    )     
    
    set_child!(out.overlay, out.separator)
    add_overlay!(out.overlay, out.label; include_in_measurement = true)
    set_child!(out.frame, out.overlay)
    set_child!(out.aspect_frame, out.frame)
    return out
end

mousetrap.get_top_level_widget(x::Placeholder) = x.aspect_frame

main() do app::Application
    window = Window(app)
    set_child!(window, Placeholder("TEST"))
    present!(window)
end
```

![](../assets/compound_widget_complete.png)

Now that `Placeholder` is a proper widget, all of mousetraps functions, including all widget signals, have become avaialable to use. We need to keep in mind that these functions will modify the top-level widget, so only signals of the top-level widget are available to compound widgets.

Using this technique, we can build an application piece by piece. A compound widget itself can be made up of multiple other compound widgets. In some way, the entire application itself is just one giant compound widget, with a `Window` as the top-level widget.

Our users are only able to interact with the compound widget by interacting with each of its components, which works but is fairly limiting. In the next chapter, this will change. By learning about **event handling**, we will be able to react to any kind of user-interaction, giving us the last tool needed to create an application that isn't just a collection of pre-made widgets, but something we have built ourselves.

