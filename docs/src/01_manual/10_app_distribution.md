# Chapter 10: Customization & App Distribution

In this chapter we will learn:
+ How to change the app-wide UI theme
+ How to apply a new theme to specific widgets
+ How to bundle our app for distribution
+ How to install our app on a users machine

!!! danger "Note"
    Many of these features are not yet implement, this section is incomplete.

---

# UI Themes

TODO

## CSS & SCSS

## Applying a Theme to the entire App

TODO

## Applying a Theme to a specific Widget

TODO

## Choosing from pre-made themes

TODO

## Creating our own themes

TODO

---

# Bundling with `Mousehole`

!!! warning
    This feature is not yet implemented

Mousetrap offers `mousehole`, a tool that takes our entire project, all the Julia code, binaries, images, themes, etc. and **bundles** it. 
The result is a folder with a C-executable. Running this executable starts our project, as if we had started it from the commandline. What's special is that this folder **contains everything necessary to run our app**. If we want to distribute our app to users, all we need to do is send them this folder, no further installation necessary.

The folder contains:

+ Our Julia package
+ All our packages dependencies
+ Project resources such as image, text, binaries, themes, settings files
+ mousetrap and all of its dependencies
+ entire Julia runtime
+ C executable launcher

TODO

---

# Installing our App

TODO

## .desktop Files

TODO

## On Linux

TODO

## On Windows

TODO

## On MacOS

TODO

---

# Closing Statements


