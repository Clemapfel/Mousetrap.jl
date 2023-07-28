# Chapter 1: Installation & Workflow

In this chapter, we will learn:
+ How to install mousetrap.jl
+ (optional) How to compile the C++ component of mousetrap from source
+ How to write and start our first mousetrap program

# Installation

Installation of the Julia component is only a few lines. After pressing `]` while in the REPL to enter Pkg mode, we execute

```julia
add https://github.com/Clemapfel/mousetrap_windows_jll
add https://github.com/Clemapfel/mousetrap_linux_jll
add https://github.com/Clemapfel/mousetrap.jl
```

We can make sure everything works by calling `test mousetrap` while still in Pkg mode.
