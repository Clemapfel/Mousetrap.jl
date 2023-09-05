# Theme & Widget Customization

In this chapter we will learn:
+ How to swap between light- and dark- mode
+ How to create custom animations
+ How to change the look of individual widgets using style classes
+ Which pre-made style classes are available
+ How to create our own style class
+ How to create a global theme using CSS
+ How to share global themes with others

---

As our app grows and becomes closer to what we personally envionised for our project, some may want to not only customizes the layout and functionality of widgets, but the widges themself. This can range from small changes such as changing something that is blue by default to green, or large sweeping changes that affect the entire application, such as moving to a light- or dark-, low- or high-contrast theme, or even applying a completely custom theme.

Mousetrap allows for all of these options, using it's very powerful theme customization component, we can customize our app to a point where most peope will not able to tell it was ever mousetrap- / GTK4-based at all.

## Switching between Dark- and Light Mode

The most common task that almost any app want to offers is for the user to be able to swap between ligth and dark mode. This is an ubiquitos feature of modern apps, and as such, mousetrap offers a very simpe way of changing the global theme.

Mousetrap supports four default application-wide themes, which are a values of enum [`Theme`](@ref):

+ `THEME_DEFAULT_LIGHT`
+ `THEME_DEFAULT_DARK`
+ `THEME_HIGH_CONTRAST_LIGHT`
+ `THEME_HIGH_CONTRAST_DARK`

At any point after the back-end has been initialized, we can swap the global theme using [`set_current_theme!`](@ref). This will immediately change the look  of all widgets and windows, allowing apps to change the entire GUI with just one function call at runtime.

For example, to create a window that has a button to switch between light and dark themes in its header bar, we could do the following:

```julia
main() do app::Application

    window = Window(app)

    # add theme swap button to windows header bar
    header_bar = get_header_bar(window)
    swap_button = Button()
    set_tooltip_text!(swap_button, "Click to Swap Themes")
    connect_signal_clicked!(swap_button, app) do self::Button, app::Application

        # get currently used theme
        current = get_current_theme(app)

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

        # set new theme
        set_current_theme!(app, next)
    end
    push_front!(header_bar, swap_button)
    present!(window)
end
```
