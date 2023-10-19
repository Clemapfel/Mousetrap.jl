# Chapter 1: Installation & Workflow

In this chapter, we will learn:
+ How to install Mousetrap.jl
+ How to create our first Mousetrap application
+ Basic Julia skills that are needed to understand the rest of this manual

---

## Installation


To install mousetrap, in the REPL:

```julia
import Pkg;
begin
  Pkg.install(url="https://github.com/clemapfel/mousetrap_jll")
  Pkg.install(url="https://github.com/clemapfel/mousetrap.jl")
end
```

We can then make sure eveything works by executing `test Mousetrap` (still in `Pkg` mode). This may take a long time. If installation was succesfull, `Mousetrap tests passed` will be printed at the end.

!!! compat "Removing older versions"
  Mousetraps installation procedure has changed starting with `v0.3.0`. If mousetrap `v0.2.*` or older installed on our computer, we should make sure to delete any trace of the older versions by executing the following, before running `add Mousetrap`:

  ```
  import Pkg
  begin
      try Pkg.rm("mousetrap") catch end
      try Pkg.rm("mousetrap_windows_jll") catch end
      try Pkg.rm("mousetrap_linux_jll") catch end
      try Pkg.rm("mousetrap_apple_jll") catch end
  end
  ```

```

## Hello World

To create our first Mousetrap app, we create a Julia file `main.jl`, with the following contents:

```julia
using Mousetrap
main() do app::Application
    window = Window(app)
    set_child!(window, Label("Hello World!"))
    present!(window)
end
```

To start our app, we navigate to the location of `main.jl` in our console, then execute:

```shell
# in same directory as `main.jl`
julia main.jl
```
![](../assets/readme_hello_world.png)

!!! compat "GIO Warnings on non-Linux"
    On Windows and macOS, running `main` may be produce warnings of the type:

    ```
    (julia:10512): GLib-GIO-WARNING **: 15:29:40.047: dbus binary failed to launch bus, maybe incompatible version

    (julia:10512): GLib-GIO-CRITICAL **: 15:29:41.923: g_settings_schema_source_lookup: assertion 'source != NULL' failed  
    ```

    This is due to a non-critical bug in one of Mousetraps dependencies, and does not indicate a problem. **These warnings can be safely ignored** and will be fixed in future versions of Mousetrap. See [here](https://github.com/Clemapfel/mousetrap.jl/issues/5) for more information.

!!! compat "Interactive Use"
  Interactive use inside the Julia REPL is only available for Mousetrap `v0.2.1` or newer.

---

## Julia Crash Course

The rest of this manual will assume that readers are familiar with the basics of Julia and some fundamentals of graphics programming. To bring anyone who considers themselves not in this group up to speed, this section contains a crash course on programming basics needed to understand the rest of this manual.

### Glossary

The following terms may be unfamiliar to some.

#### Invocation

To "invoke" a function means to execute it using a command, possibly providing arguments. For example, the second line in the following snippet *invokes function `foo`*:

```julia
foo(x) = println(x) # definition
foo(1234) # invocation
```

#### Instantiation, Construction

In Julia, for a type `T`, to create an actual object of this type, we need to call its *constructor*. This is a function that returns an object of that type:

```julia
struct T 
  function T() # constructor
    return new() 
  end
end
```

We call an object returned by a constructor an **instance** of `T`. The act of creating an instance is called **instantiation** of `T`. 

In the above, `T()` (the constructor, which is a function), *instantiates* an object of type `T`, then returns that *instance*.

#### Scope

"Scope" refers to where a variable is available after it is defined. For example, the following function introduces what is called a "hard scope", meaning we do not have access to any variable defined inside the *functions scope*, which is the block of code between `function` and `end`

```julia
function f(x) # hard scope begin
    y = x + 1
    return y
end # hard scope end

println(y) # errors because y not available, it was defined in hard scope
```

`begin`-`end` blocks are a "soft scope", meaning we can access definitions from within this soft scope from the outer scope:

```julia
begin # soft scope begin
    z = 1234
end # soft scope end

println(z) # works
```
```
1234
```

A "global" variable is a variable that is defined in *module scope*. For example, in the following snippet, **both** `a` and `b` are defined in module scope:

```julia
a = 1234
module M
    b = "abcd"
end
```

This is because all Julia code is scoped in module `Main`. In the above, `a`s scope is `Main`, while `b`s scope is `Main.M`. Both are global in respect to their module.

#### Front-End, Back-End, Engine

Regarding GUI apps, developers will often refer to "front-end" vs. "back-end" code. The exact meaning of these can vary depending on the field; in this manual, *front-end*  refers to any code that produces an object the user can see on screen, meaning the actual GUI. *back-end*, then, is anything that is not *front-end*. 

An *engine* is a programming library that allows developers to create the *front-end*. For this package, Mousetrap is an *engine* for your (the readers) app.

#### Rendering, Frames

In our `main.jl` above, Mousetrap created a window and presented it on the physical screen. This process of drawing graphics to the screen is also called *rendering*.

Each screen updates at a set frequency, for example 60hz, which means a new image is drawn to the screen every 1/60th of a second. Each of these drawing steps is called a *frame*. This is why we often refer to the speed at which a graphical app updates as *frames-per-second* (fps), the number of times a new frame is drawn to the screen - per second.

In Mousetrap, fps is tied to the monitors refresh rate. If the user's monitor updates at 120Hz, Mousetrap will attempt to draw a new image 120 times per second. Depending on the user's machine, this could be too costly performance-wise, which is why Mousetrap features a "lazy" rendering process. An area on screen will only be updated if it needs to be. 
For example, in the `main.jl` above, the label `"Hello World!"` will only be drawn once. Because it is static (it stays the same and does not move) there is no need to redraw it every frame.

This is in opposition to how many video games work. Usually, in video game engines, each frame will make it such that the entire screen is re-drawn every time. This difference is important to realize.

#### Native Rendering

Native rendering, in Mousetrap, is the process of updating the currently displayed frame using the graphics card, making it a hardware accelerated, GPU-side operation. This is in opposition to CPU-side rendering, which is generally slower. Native rendering in Mousetrap is performed using [OpenGL](https://www.khronos.org/opengl/wiki/), with an entire chapter of this manual dedicated to this technique.

---

## Object Oriented Design

While Julia is technically object-oriented, it lacks many of the features of "proper" OOP languages such as C++ or Java. Examples of missing features include [member functions](https://en.cppreference.com/w/cpp/language/member_functions) and [inheritance from concrete types](https://learn.microsoft.com/en-us/cpp/cpp/inheritance-cpp?view=msvc-170). Additionally, in mousetrap specifically, most objects will have **no public properties**.

To interact with an object, we use *outer methods*, which are functions defined in global scope that operate on one of their arguments by modifying its hidden properties.

If our object is of type `T`, an outer method will have the structure

```julia
function get_foo(instance::T) ::Foo
    # ...
end

function set_foo!(instance::T, new_value::Foo) ::Nothing
    # ...
end
```

Where `get_foo` accesses a hidden property of our `T` instance, while `set_foo!` modifies that property of the instance. The `!` at the end of the method name signals that it will modify the `T` instance. In Mousetrap, only functions marked with `!` will mutate (modify). This is the equivalent of [non-const methods](https://learn.microsoft.com/en-us/cpp/cpp/const-cpp?view=msvc-170#const-member-functions) in other OOP languages.

Because we cannot inspect an object's properties to learn about it, we are reliant on the Mousetrap documentation to know which functions are available for which object. Navigating to the [index of classes](../02_library/classes.md), we see that after each class, there is a list of all "member functions", that is, all functions that operate on that object.

Another way to find out which functions are available is to use [`methodswith`](https://docs.julialang.org/en/v1/stdlib/InteractiveUtils/#InteractiveUtils.methodswith) from within the REPL:

```julia
using Mousetrap
methodswith(Window)
```

Which will print a list of all functions that have at least one argument of type `Window`.

---

## C Enums   

Mousetraps back-end is written in C++, whose enums differ from Julia enums in a number of ways. To assure compatibility, mousetrap uses its own enum definitions, it does not use Julias `@enum`.

Each enum is a proper Mousetrap type, while each enum *value* is a numerical constant which is defined as being of that type. 

For example, the enum `Orientation`, which describes whether on object is vertically or horizontally oriented, is a type called `Mousetrap.Orientation`.

The **values** of `Orientation` are global constants:

+ `ORIENTATION_HORIZONTAL`
+ `ORIENTATION_VERTICAL`

In this example, `Orientation` is the enum, while `ORIENTATION_HORIZONTAL` and `ORIENTATION_VERTICAL` are the enums values.

Inspecting the values in the REPL, we see that they are actually just numbers:

```
julia> ORIENTATION_HORIZONTAL
Orientation(0)

julia> ORIENTATION_VERTICAL
Orientation(1)
```

But both are of type `Orientation`:

```julia
julia> ORIENTATION_HORIZONTAL isa Orientation && ORIENTATION_VERTICAL isa Orientation
true
```

All enum values are written in `SCREAMING_SNAKE_CASE`, while the enum types name uses `UpperCamelCase`. 

To check which enum has which values, we can again use the [Mousetrap documentation](../02_library/enums.md).

---

## Do Syntax

In Julia, any function whose **first argument is another function** can use **do-syntax**.

For example, the following function takes two arguments:

```julia
function example_f(f, arg)
    f(arg)
end
```
It applies its first argument, a function, to its second argument.

Invoking `example_f`, we could do:

```julia
to_invoke(x::Integer) = println(x)
example_f(to_invoke, 1234)
```
```
1234
```

Where `to_invoke` is used as the **first** argument. Because it is the first, we can also write the above using do-syntax:

```julia
example_f(1234) do x::Integer
    println(x)
end
```

Here, the first argument of `example_f` was ommitted, while the second argument, `1234` remained. Instead of the first argument, we append the line `do x::Integer`, where `x` is the name of the anonymous functions argument. After this line, we define the functions body, then `end`.

## Anonymous Functions in Stacktraces

In the REPL, we can print any objects name to inspect it. Creating a new function, which prints its argument's name:

```julia
print_f_name(f) = println(f)
```

We see that if we invoke this function using regular function syntax, we get the following output:

```julia
function to_invoke()
    # do nothing
end

print_f_name(to_invoke)
```
```
to_invoke
```

If we instead call this function using do-syntax:

```julia
print_f_name() do 
    # do nothing
end
```
```
#9
```

We get `#9`. This is a **temporary name** used by Julia to keep track of anonymous functions. A stacktrace in Mousetrap will often contain many anonymous function names like this:

```julia
main() do app::Application
    throw(ErrorException("error"))
end
```
```
[ERROR] In Mousetrap.main: error
Stacktrace:
 [1] (::var"#11#12")(app::Application)
   @ Main ./REPL[15]:2
 [2] (::TypedFunction)(args::Application)
   @ Mousetrap ~/Workspace/Mousetrap.jl/src/Mousetrap.jl:74
 [3] (::Mousetrap.var"#15#17"{TypedFunction})(app::Application)
   @ Mousetrap ~/Workspace/Mousetrap.jl/src/Mousetrap.jl:1571
 [4] (::TypedFunction)(args::Application)
   @ Mousetrap ~/Workspace/Mousetrap.jl/src/Mousetrap.jl:74
 [5] (::Mousetrap.var"#6#8"{TypedFunction})(x::Tuple{CxxWrap.CxxWrapCore.CxxRef{Mousetrap.detail._Application}})
   @ Mousetrap ~/Workspace/Mousetrap.jl/src/Mousetrap.jl:620
 [6] safe_call(scope::String, f::Function, args::Tuple{CxxWrap.CxxWrapCore.CxxRef{Mousetrap.detail._Application}})
   @ Mousetrap ~/Workspace/Mousetrap.jl/src/Mousetrap.jl:144
 [7] run!(arg1::Mousetrap.detail._ApplicationAllocated)
   @ Mousetrap.detail ~/.julia/packages/CxxWrap/aXNBY/src/CxxWrap.jl:624
 [8] run!(app::Application)
   @ Mousetrap ~/Workspace/Mousetrap.jl/src/Mousetrap.jl:1538
 [9] (::Mousetrap.var"#14#16"{var"#11#12", String})()
   @ Mousetrap ~/Workspace/Mousetrap.jl/src/Mousetrap.jl:1581
```

We see that the anonymous functions was allocated as `var"#11#12"`. This refers to the function defined using the do-block after `main()`.

Mousetrap stacktraces can get quite long, so it's best to parse them by reading the original message at the top first:

```
[ERROR] In Mousetrap.main: error
```
We see that the message mentions that the error occured during invokation of `Mousetrap.main`. We should therefore look for an error inside the do-block after `main`.

Knowledge about anonymous functions and how to read stacktraces will greatly aid us in debugging mousetrap applications while learning.

