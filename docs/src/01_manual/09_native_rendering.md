# Chapter 9: Native Rendering

In this chapter we will learn:
+ How to use `RenderArea`
+ How to draw any shape
+ How to bind a shape, transform, shader, and blend mode for rendering
+ How to render to a (multi-sampled) texture

---

In the [chapter on widgets](./04_widgets.md), we learned that we can create new widgets by combining already pre-defined widgets into a **compound widget**.

We can create a new widget that has a `Scale`, but we can't render our own scale with, for example, a square knob. In this chapter, this will change. By using the native rendering interface mousetrap provides, we are free to create any shape we want to assemble completely new widgets pixel-by-pixel.

## RendeArea

The central widget of this chapter is [`RenderArea`](@ref), which is a canvas used to display native graphics. Initialization is simple enough:

```julia
area = RenderArea()
```

This widget will render as a transparent area, meaning it is invisible because `RenderArea` provides no graphical element itself, instead. we have to create separate **shapes**, then bind them for rendering.



