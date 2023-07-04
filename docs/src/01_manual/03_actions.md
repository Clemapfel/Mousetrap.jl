# Chapter 3: Actions

In this chapter, we will learn:
+ How and why to use the command pattern to encapsulate application functionality
+ How to create and use `Action`
+ How to trigger actions using `Button` or by pressing a keyboard shortcut

---

## Introduction: The Command Pattern

As we create more and more complex applications, keeping track of how / when to trigger which functionality gets harder and harder. An application can have hundreds, if not thousands of functions, all linked to one or more triggers such a buttons, menus, keyboard shortcuts, etc. 

Things will get out of hand very quickly, which is why there's a software design pattern just for this purpose: the [**command pattern**](https://en.wikipedia.org/wiki/Command_pattern).

A **command**, henceforth called **action**, is an object which has the following components:
+ A **function**, which is the actions behavior
+ An **ID** which uniquely identifies the action
+ An optional **state**, which is a boolean
+ An optional **shortcut trigger**, also often called a keybinding

In mousetrap, a command is respresented by the type [`Action`](@ref).

## Action

As early as possible, we should drop the habit of defining application behavior inside a global function. Unless a function is used exactly once, it should be an action.

For example, in the previous chapter, we declared a [`Button`](@ref) with the following behavior:

```julia
button = Button()
connect_signal_clicked!(button) do self::Button
    println("clicked")
end
```

In this section, we will learn how to reproduce this behavior using the command pattern, and why we should prefer this over connecting a signal handler.

### Action IDs

When creating an action, we first need to choose the actions **ID**. An ID is any identifier that uniquely identifies the action. The ID can only contain the character `[a-zA-Z0-9_-.]`, that is, all roman letters, numbers 0 to 9, `_`, `-` and `.`. The dot is usually reserved to simulate scoping. 

For example, one action could be called `image_file.save`, while another is called `text_file.save`. Both actions say what they do, `save` a file, but the prefix makes clear which part of the application they act on.

An approriate ID for our button behavior would therefore be `example.print_clicked`. 

### Action Function

Armed with this ID, we can create an action:

```julia
action = Action("example.print_clicked", app)
```
Where `app` is the application instance from our `main`.

The second part of an action is its function, also called its callback. We assign an actions function using [`set_function!`](@ref):

```julia
action = Action("example.print_clicked", app)
set_function!(action) do x::Action
    println("clicked")
end
```

The function registered using `set_function!` is required to have the following signature:

```julia
(::Action, [::Data_t]) -> Nothing
```

We see that, much like with signal handlers, the callback is provided our action instance along with an optional `data` argument.

`Action` provides a constructor that directly takes the function as its first argumnet. Using this, we can write the above more succinctly:

```julia
action = Action("example.print_clicked", app) do x::Action
    println("clicked")
end
```

### Triggering Actions

At any point, we can call [`activate!`](@ref), which will trigger the actions callback. This is not the only way to trigger an action, however. 

`Button` provides [`set_action!`](@ref), which makes it such that when the button is clicked, the action is triggered:

```julia
action = Action("example.print_clicked", app)
set_function!(action) do x::Action
    println("clicked")
end

button = Button()
set_action!(button, action)
```
```
clicked
```

So far, this doesn't seem to have an upsides over just connecting to signal `clicked`. This is about to change.

## Disabling Actions

Similarly to how blocking signals work, we can disable an action using [`set_enabled!`](@ref). If set to `false`, calling `activate!` will trigger no behavior. Furthermore, **all objects the action is connect to are automatically disabled**. This means we do not need to keep track of which button calls which action. To disable all of them, we can simply disable the action. 

## Action Maps

Eagle-eyed readers may have noticed that `Action`s constructor requires an instance of our `Application`. This is because the two are linked internally, all actions are registered with the application and are accesible to all widgets. In this way, `Application` itself acts as an **action map**, an index of all actions.

Once `set_function!` was called, we can, at any point, retrieve the action from the application using `get_action!`:

```julia
let action = Action("example.print_clicked", app)
    set_function!(action) do x::Action
        println("clicked")
    end
end

# `action` is no longer defined here

activate!(get_action(app, "example.print_clicked"))
```
```
clicked
```

Where we used a [let-block](https://docs.julialang.org/en/v1/base/base/#let) to create a "hard" scope, meaning at the end of the block, `action`, the Julia-side object, is no longer defined. We can nonetheless retrieve it by calling `get_action!` on our `Application` instance. 

This way, we do not have to keep track of actions ourself, by simply remembering the actions ID we can - at any point - trigger the action from anywhere in our application.

## Signals

`Action` has a single signal, `activated` (note the `d`, which distinguishes it from signal `activate`), which is emitted when the signals callback is invoked in any way. 

```@eval
using mousetrap
mousetrap.@signal_table(Action,
    activated
)
```

We would connect to it like so:

```julia
action = #...
connect_signal_activated!(action) do self::Action
    println("activated")
end
```

This can be helpful to trigger additional behavior when an action is activated, without changing the actions callback function. The signal handler can
also be blocked / unblocked independently of enabling / disabling the action.

---

## Stateful vs Stateless Actions

After using `set_function!` to register a callback with an action, that action will be considered **stateless**; it does not have an internal state. This is in opposition
to a **stateful** action. To make an action stateful, we use [`set_stateful_function!`](@ref) to register a callback. 

The callback for a stateful function has to have the signature

```julia
(::Action, ::Bool) -> Bool
```
Where the bool argument is the current state of the action, and the boolean return type is the state of the action after the callback has been invoked:

```julia
stateful_action = Action("example.stateful", app)
set_stateful_function!(stateful_action) do x::Action, current_state::Bool
    println("stateful action activated")
    next_state = !current_state
    return next_state
end
```

We can also modify the state from the outside: [`set_state!`](@ref) and [`get_state`](@ref) access the internal state of a stateful action. If we are unsure about whether an action is stateful or stateless, we can call [`get_is_stateful`](@ref), which returns `true` if the actions callback was registered using `set_stateful_function!`.

Stateful actions will become useful in the [chapter on menus](./08_menus.md), where we will use them to trigger a global boolean flag using an automatically constructed menu. 

---

## Shortcuts

Any action, regardless of whether it is stateful or stateless, can have a number of optional **shortcut triggers**, also commonly called **keybindings**. 

A keybinding is a combination of keyboard keys, that, when pressed, trigger an action exactly once. Common keyboard shortcuts familiar to most users of modern operating systems are `Control + A` to "select all", or `Control + Z` to undo. These will not usually be defined for our applications, instead, we will have to implement behavior likes this manually using actions.

### Shortcut Trigger Syntax

Before we can learn about keybindings, we need to talk about keys. In mousetrap, keyboard keys
are split into two groups: **modifiers**  and **non-modifiers**.

A modifier is one of the following:
+ `Shift`
+ `Control`
+ `Alt`

!!! note 
    Additional modifiers include `CapsLock`, `AltGr`, `Meta`, `Apple` and `Win`. These are keyboard-layout and/or OS-specific. See [here](https://docs.gtk.org/gdk4/flags.ModifierType.html) for more information.

A non-modifier, then, is any key that is not a modifiers. 

A keybinding, or shortcut trigger, henceforth called "shortcut", is the combination of **any number of modifiers, along with exactly one non-modifier key**. A few examples:

+ `a` (that is the `A` keyboard key) is a shortcut
+ `<Control><Shift>plus` (that is the `+` keyboard key) is a shortcut
+ `<Alt><Control><Shift>` is **not** a shortcut, because it does not contain a non-modifier
+ `<Control>xy` (that is the `X` key *and* the `Y` key) is **not** a shortcut, because it contains more than one non-modifier key

Shortcuts are represented as c-strings, which have a specific syntax. As seen above, each modifier is enclosed in `<``>`, with no spaces. After the group of modifiers, the non-modifier key is placed after the last modifiers `>`. Some more examples:

+ "Control + C" is written `<Control>c`
+ "Alt + LeftArrow" is written as `<Alt>Left` (sic, `L` is capitalized)
+ "Shift + 1" is written as `exclam`

That last one requires explanation. On most keyboard layouts, to type `!`, the user has to press the shift modifier key, then press the `1` key. When "Shift + 1" is pressed, mousetrap does not receive this keyboard key event as-is, instead, it receives a single key event for the `!` key, with no modifiers. The identifier of `!` is `exclam`, hence why "Shift + 1" is written as `exclam`.

!!! note "Hint: Looking up Key Identifiers"

    An example on how to look up the key identifier will be performed here.

    Let's say we want to write the shortcut "Control + Space". We know that we can write "Control" as `<Control>`. Next, we navigate to https://github.com/Clemapfel/mousetrap.jl/blob/main/src/key_codes.jl, 
    which has a list of all keys recognized by mousetrap. In [line 1039](https://github.com/Clemapfel/mousetrap.jl/blob/main/src/key_codes.jl#L1039), we find that the constant for the space key is called `KEY_space`. The identifier of a key used for shortcuts is this name, minus the `KEY_`. For the spacebar key, the identifier is therefore `space`.

    One more obscure example, to write "Alt + Beta", that is the `β` key on the somewhat rare greek keyboard layout, we find the constant named `KEY_Greek_BETA` in [line 3034](https://github.com/Clemapfel/mousetrap.jl/blob/main/src/key_codes.jl#L3034). Erasing `KEY_` again, the keys identifier is `Greek_BETA`. "Alt + Beta" is therefore written as `<Alt>Greek_BETA`

    If we make an error and use the wrong identifier, a soft warning will be printed at runtime, informing us of this. 

### Assigning Shortcuts to Actions

Now that we know how to write a shortcut as a shortcut trigger string, we can assign it to our actions. For this, we use [`add_shortcut!`](@ref):

```julia
shortcut_action = Action("example.shortcut_action", app)
add_shortcut!(shortcut_action, "<Control>space")
```

An action can have multiple shortcuts, and one shortcut can be associated with two or more actions, though this is usually not recommended.

We need one more thing before we can trigger our action: an object that can receive keyboard key events. We will learn much more about the event model in [its own dedicated chapter](./05_event_handling.md), for now, we can use [`set_listens_for_shortcut_action!`](@ref) on our top-level window. This makes the window instance listen for any keyboard presses. If it recognizes that a keybinding associated with an action it is listening for was pressed, it will trigger that action.

A complete `.jl` file showing how to trigger an action using a shortcut is given here:

```julia
using mousetrap

main() do app::Application

    # create a window
    window = Window(app)

    # create an action that prints "activated"
    action = Action("example.print_activated", app) do action::Action
        println("activated.")
    end

    # add the shortcut `Control + Space`
    add_shortcut!(action, "<Control>space")
    
    # make `window` listen for all shortcuts of `action`
    set_listens_for_shortcut_action!(window, action)

    # show the window to the user
    present!(window)
end
```

Pressing "Control + Space", we get:

```
activated.
```
