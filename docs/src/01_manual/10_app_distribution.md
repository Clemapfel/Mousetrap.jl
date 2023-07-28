# Chapter 10: Customization & App Distribution

In this chapter we will learn:
+ How to change the app-wide UI theme
+ How to apply a new theme to specific widgets
+ How to bundle our app for distribution
+ How to install our app on a users machine

!!! danger
    Features in this section are experimental. There is no guaruantee that they work as expected, or will be included in future updates of mousetrap

# Theme Customization

## App Theme

Each pre-made widget in mousetrap has their exact look specified in what is called a **theme**. This theme is a collection of css classes, which determine how a widget will look. 

As of version 0.1.0, mousetrap offers limited ways of changing this theme. For now, we can only pick a global theme, not change how that global theme looks.

Mousetrap supports four default themes, which are an value of enum [`Theme`](@ref):

[Image: default light widget gallery]
`THEME_DEFAULT_LIGHT`

[Image: default dark widget gallery]
`THEME_DEFAULT_DARK`

[Image: high contrast light widget gallery]
`THEME_HIGH_CONTRAST_LIGHT`

[Image: high contrast dark widget gallery]
`THEME_HIGH_CONTRAST_DARK`

At any point after the back-end has been initialized, we can swap the global theme using [`set_current_theme!`](@ref). This will immediately change all widgets looks, allowing apps to change the entire GUI with just one function at run-time.

For example, to create a window that has button to switch between light and dark themes, we could do the following:

```julia
main() do app::Application

    window = Window(app)

    # add theme swap button to windows header bar
    header_bar = HeaderBar()
    swap_button = Button()
    set_tooltip_tex(swap_button, "Click to Swap Themes")
    connect_signal_clicked!(swap_button, app) do self::Button, app::Application
        current = get_current_theme!(app)

        # swap light with dark, preservng whether the theme is high contrast
        if current == THEME_DEFAULT_DARK
            next = THEME_DEFAULT_LIGHT
        elseif current == THEME_DEFAULT_LIGHT
            next = THEME_DEFAULT_DARK
        elseif current == THEME_HIGH_CONTRAST_DARK
            next = THEME_HIGH_CONTRAST_LIGHT
        elseif current == THEME_HIGH_CONTRAST_LIGHT
            next = THEME_HIGH_CONTRAST_DARK
        end

        set_current_theme!(app, next)
    end
    push_front!(header_bar, swap_button)
    set_titlebar_widget!(window, header_bar)

    present!(window)
end
```
[Image: comparing light and dark version]

