# Chapter 9: Native Rendering

In this chapter we will learn:
+ How to use `RenderArea`
+ How to draw any shape
+ How to bind a shape, transform, shader, and blend mode for rendering
+ How to render to a (multi-sampled) texture

---

!!! danger "Native Rendering on MacOS"
    All classes and functions in this chapter **are impossible to use on MacOS**. For this platform,
    mousetrap was compiled in a way where any function relating to OpenGL was made unavailable. This 
    is because of Apples decision to deprecate OpenGL in a way where only physical owners of a Mac
    can compile libraries that have it as a dependency.

    See [here](https://github.com/users/Clemapfel/projects/2?pane=issue&itemId=33978341) for more information.

    If you try to use a disabled object, a fatal error will be thrown.

!!! note 