# Chapter 2: Signals

In this chapter, we will learn:
+ What signals and signal handlers are
+ How to connect to a signal
+ How to check which signature a signal expects
+ How and why to block signals

---

## Signal Architecture

Central to mousetrap, as well as other GUI libraries like GT4 and QT, is **signal architecture** or [**signal programming**](https://en.wikipedia.org/wiki/Signal_programming), which is a software architecture that triggers behavior using signals.

A **signal**, in this context, has three components:
+ an **ID**, which uniquely identifies it. IDs may not be shared between signals
+ an **emitter**, which is a non-signal object
+ a **callback** or **signal handler**, which is a function called when an emitter emits a signal

It may be easiest to consider an example:

One of the simpler interactions with a GUI is clicking a button. In mousetrap, the [`Button`](@ref) class is made for this purpose. `Button` has the signal `clicked`, which is emitted when a user presses the left mouse button while the cursor hovers over the graphical element of the button.

In this case, the signals' **ID** is `clicked`, while the signal **emitter** is an instance of `Button`. When a user clicks the button, the in-memory object emits signal `clicked`. 

If we want to tie program behavior to the user clicking the button, we **connect a callback** (a function) to this signal. Once connected, when the button is clicked, `clicked` is emitted, which in turn will trigger invocation of the connected function.


```julia
# create `Button` instance
button = Button()

# create a signal handler
on_clicked(self::Button) = println("clicked")

# connect the signal handle to the signal
connect_signal_clicked!(on_clicked, button)
```

Which can be written more succinctly using [do-syntax](https://docs.julialang.org/en/v1/manual/functions/#Do-Block-Syntax-for-Function-Arguments):

```julia
button = Button()
connect_signal_clicked!(button) do self::Button
    println("clicked")
end
```

!!! note "Running Code Snippets"

    In this section, code snippets will only show the relevant lines. To actually compile and run the code stated here, we need to create a Julia script with the following content:

    ```julia
    using mousetrap
    main() do app::App
        window = Window(app)

        # code snippet goes here

        set_child!(window, widget) # add whatever widget the code snippet is about here
        present!(window)
    end
    ```

    For example, running the just mentioned button example, we would create the following `.jl` file:

    ```julia
    using mousetrap
    main() do app::App
        window = Window(app)

        button = Button()
        connect_signal_clicked!(button) do self::Button
            println("clicked")
        end

        set_child!(window, button) # add the button to the window
        present!(window)
    end
    ```

Executing this code we see that a small window opens which contains our button. Clicking it, and we get:

```
clicked
```

---

## SignalEmitters

`Button`, as most classes in mousetrap, is a subtype of an abstract type called [`SignalEmitter`](@ref). 

Inheriting from `SignalEmitter` is equivalent to saying "this object can emit signals". Not all objects in mousetrap are signal emitters, but most are.

When we say "an object can emit signal `<id>`", what that means is that the following functions are defined for that object:

+ `connect_signal_<id>!`
+ `disconnect_signal_<id>!`
+ `emit_signal_<id>`
+ `set_signal_<id>_blocked!`
+ `get_signal_<id>_blocked`

For example, `Button` supports the signal with id `clicked`, so the following functions are defined for it:

+ `connect_signal_clicked!`
+ `disconnect_signal_clicked!`
+ `emit_signal_clicked`
+ `set_signal_clicked_blocked!`
+ `get_signal_clicked_blocked`


We'll now go through what each of these functions do and how to use them.

---

## Connecting Signal Handlers

Above, we've already seen an example of how to connect a signal handler to a signal using `connect_signal_clicked!`. 

What may not have been obvious is that the signal handler, the anonymous function in the above code snippet, is required to **conform to a specific signature**.

!!! note "Function Signature Syntax" 
    
    A functions' **signature** describes a functions' return- and argument types. For example, the function

    ```julia
    function foo(i::Int32, string::String) ::String
        return string(i) * string
    end
    ```
    
    Has the signature `(::Int32, ::String) -> String`.  It takes a 32-bit integer and a string, and it returns a string.

    The anonymous function from this do-block:

    ```julia
    connect_signal_clicked!(button) do self::Button
        println("clicked")
    end
    ```

    Has the signature `(::Button) -> Nothing`. It takes an instance of type `Button` and returns `nothing`.

    For a function with an optional argument like this:
    ```julia
    function foo_optional(i::Int32, string::String; optional::Bool = true) ::String
        return string(i) * string * string(optional)
    end
    ```

    We signal that the last argument is optional be enclosing it in `[]`: `(::Int32, ::String, [::Bool]) -> String`

    In general, a function with argument types `Arg1_t, Arg2_t, ...`, return type `Return_t`, and optional arguments `Optional1_t, Optional2_t` has the signature 
    ```
    (Arg1_t, Arg2_t, ..., [Optional1_t, Optional2_t, ...]) -> Return_t`.
    ```

Each signal requires its handler to conform to a specific signature. This signature  may be different between signals. If we attempt to connect a handler that has the wrong signature, an `AssertionError` will be thrown at compile time. This makes it important to know how to check which signal requires which signature. 

## Checking Signal Signature

Working with our example, signal `clicked` of class `Button`, let's say we do not know what function is able to connect to this signal.
To find out, we check the mousetrap documentation, either by visting [`Button`](@ref)s documentation online, or from within the REPL by pressing `?` and entering the name of the class we want to look up:

```
help?> mousetrap.Button
```

We see that in the `Signals` section, a table is shown which contains all signals unique to that class. We see that `Button` has two signals, `activate` and `clicked`. The table tells us
that `clicked` requires the signature `(instance::Button, [::Data_t]) -> Nothing`. 

Unlike in our example before, this signature mentions an optional argument `::Data_t`. Indeed, all signals support this last optional argument, which allows us to pass arbitary data to the signal handler.

---

## Handing Data to Signal Handlers

While we do get passed the signal emitter instance as the first argument to the signal handler, `::Button` in this case, we will often need to reference other objects. This may necessitate 
accessing potentially global variables, which [is discouraged in Julia](https://docs.julialang.org/en/v1/manual/performance-tips/#Avoid-untyped-global-variables).

Instead, mousetrap allows adding an optional, arbitrarily typed, *single* argument to the end of any signal handler signature. This object is often referred to as `data`, its type is therefore called `Data_t`.

Expanding on our previous example, if we want to send a customized message when the user clicks our button, we can change the snippet as follows:

```julia
button = Button()

# signal handler with an additional argument
on_clicked(self::Button, data) = println(data)  

# pass the data (a string) we want to forward as the last argument of `connect_signal_*!`
connect_signal_clicked!(on_clicked, button, "custom message")
```

Or, using do-syntax:

```julia
button = Button()
connect_signal_clicked!(button, "custom message") do self::Button, data
    println(data)
end
```

Clicking the button, we now get:

```
custom message
```

Any and all objects can be provided as `data`, however, they have to be packaged as exactly **one** argument.

### Grouping Data Arguments

Because there is only one `data`, it may seem limiting as to what or how much data we can pass to the signal handlers. This is not true, 
because we can use a simple trick to group any amount of objects into a single argument:

Let's say we want to forward a string `"abc"`, an integer `999` and a vector of floats `[1.0, 2.0, 3.0]` to the signal handler. To achieve this, we can do the following:

```julia
button = Button()

function on_clicked(self::Button, data)
    println(data.string_value)
    println(data.integer_value)
    println(data.vector_value)
end

named_tuple = (
    string_value = "abc",
    integer_value = 999,
    vector_value = [1.0, 2.0, 3.0]
)

connect_signal_clicked!(on_clicked, button, named_tuple)
```

Here, we grouped the values in a [named tuple](https://docs.julialang.org/en/v1/manual/types/#Named-Tuple-Types), then accessed each individual value by an
easy-to-read name.

Again, we can write the above more succinctly using do-syntax:

```julia
button = Button()
connect_signal_clicked!(button, (
    string_value = "abc", integer_value = 999, vector_value = [1.0, 2.0, 3.0]
)) do self::Button, data
    println(data.string_value)
    println(data.integer_value)
    println(data.vector_value)
end
```

Using this technique, we can forward any and all objects to the signal handler via the optional `[::Data_t]` argument.

---

## Blocking Signal Emission

If we want an object to *not* call the signal handler on signal emission, we have two options:

Using `disconnect_signal_<id>`, we can **disconnect** the signal, which will permanently remove the registered signal handler, deallocating it and fully dissociating it from the original signal emitter instance. This is a quite costly operation and should only rarely be necessary. 

A much more performant and convenient method to temporarily prevent signal emission is that of **blocking** the signal.

Blocking a signal will prevent invocation (calling) of the signal handler. This means, for our `Button` example, once we call:

```julia
set_signal_clicked_blocked(button, true)
```

the user can still click the button, however the connected handler is not called.

To block a signal, we use `set_signal_<id>_blocked`, which takes a boolean as its argument. We can check whether a signal is currently blocked using `get_signal_<id>_blocked`.

### Signal Blocking: An Example

When is blocking necessary? Consider the following use-case:

```julia
# declare two buttons
button_01 = Button()
button_02 = Button()

# when button 01 is clicked, 02 is triggered programmatically
connect_signal_clicked!(button_01) do self::Button
    println("01 clicked")
    activate!(button_02)
end

# when button 02 is clicked, 01 is triggered programmatically
connect_signal_clicked!(button_02) do self::Button
    println("02 clicked")
    activate!(button_01)
end

# add both buttons to the window
set_child!(window, hbox(button_01, button_02))
```

In which we use [`activate!`](@ref), which triggers the exact same behavior as if a use has clicked the button on screen, including emission of signal `clicked`, along with [`hbox`](@ref), so that we can display both buttons in the window.

The intended behavior is that if the user clicks either one of the buttons, both buttons emit their signal. Clicking one button should always trigger both, regardless of which button is clicked first.

Running the above code as-is, and clicking `button_01`, we get the following output:

```
01 clicked
02 clicked
01 clicked
02 clicked
01 clicked
02 clicked
01 clicked
02 clicked
...
```

And our application deadlocks. This is - of course - extremely undesirable, so let's talk through why this happens.

When `button_01` is clicked, it emits signal `clicked`, which invokes the connected signal handler. Going line-by-line through the handler :
+ `button_01`s handler prints `"01 clicked"`
+ `button_01`s handler activates `button_02`, triggering emission of signal `clicked` on `button_02`
+ `button_02`s handler prints `"02 clicked"`
+ `button_02`s handler activates `button_01`, triggering emission of signal `clicked` on `button_01`
+ `button_01`'s handler prints `"01 clicked"`
+ etc.

We created an infinite loop.

We can avoid this behavior by **blocking signals** at strategic times:

```julia
button_01 = Button()
button_02 = Button()

connect_signal_clicked!(button_01) do self::Button
    println("01 clicked")
    
    # block self (button 01) 
    set_signal_clicked_blocked!(self, true)

    # activate button 02
    activate!(button_02)

    # unblock self
    set_signal_clicked_blocked(self, false)
end

connect_signal_clicked!(button_02) do self::Button
    println("02 clicked")

    # block self (button 02)
    set_signal_clicked_blocked(self, true)

    # activate button 01
    activate!(button_01)

    # unblock self
    set_signal_clicked_blocked(self, false)
end

set_child!(window, hbox(button_01, button_02))
```

Let's talk through what happens when the user clicks one of the two buttons now, again assuming `button_01` is the first to be clicked:

+ `button_01` invokes its signal handler
+ `button_01`s signal handler prints `01 clicked`
+ `button_01` blocks invocation of its own signal handler
+ `button_01` activates `button_02`, triggering emission of signal `clicked`
+ `button_02`s signal handler prints `02 clicked`
+ `button_02` blocks invocation of its own signal handler
+ `button_02` attempts to activate `button_01`, **but that buttons signal is blocked, so nothing happens**
+ `button_02` unblocks itself
+ `button_01` unblocks itself
+ both signal handlers return normally 
```
01 clicked
02 clicked
```

By blocking signals, we get the correct behavior of both buttons being triggered exactly once. Because they unblock themself at the end of the signal handler, after the two buttons are done, everything returns to the way it was before, meaning both buttons can be clicked once again.

To verify this is indeed the resulting behavior, we can run the following:

```julia
using mousetrap
main() do app::Application

    window = Window(app)

    button_01 = Button()
    button_02 = Button()

    connect_signal_clicked!(button_01) do self::Button
        println("01 clicked")

        set_signal_clicked_blocked!(button_01, true)
        activate!(button_02)
        set_signal_clicked_blocked(button_01, false)
    end

    connect_signal_clicked!(button_02) do self::Button
        println("02 clicked")

        set_signal_clicked_blocked(button_02, true)
        activate!(button_01)
        set_signal_clicked_blocked(button_02, false)
    end

    set_child!(window, hbox(button_01, button_02))
    present!(window)
end
```

![](../resources/double_button_signal_blocking.png)

---