# Chapter 1: Installation & Workflow

In this chapter, we will learn:
+ How to install mousetrap.jl
+ How to create our first mousetrap program

# Installation

Installation of the Julia component is only a few lines. After pressing `]` while in the REPL to enter Pkg mode, we execute

```julia
add https://github.com/Clemapfel/mousetrap_windows_jll
add https://github.com/Clemapfel/mousetrap_linux_jll
add https://github.com/Clemapfel/mousetrap.jl
```

We can make sure everything works by calling `test mousetrap`, while still in Pkg mode.

# Workflow

To create an app using mousetrap, we first need to create our own Julia package. Assuming our desired package name is `Foo`, we navigate to the folder we want to create our project in, then execute (from within the REPL):

```julia
project_name = "foo"

import Pkg;
Pkg.generate(project_name)
Pkg.add("mousetrap")
cd(project_name)
mkdir("test")
cd("test") do
    file = open("./runtests.jl", "w+")
    close(file)
end
```

When can then enter Pkg mode by pressing `]`, and execute

```
dev .
```


This will create the following project structure:

```
Foo \
    Project.toml
    src \
        Foo.jl
    test \
        runtest.jl
```
We then replace the contents of `Foo.jl` with the following:

```julia
module Foo
    using mousetrap
    function main()
    end
end
```

    
