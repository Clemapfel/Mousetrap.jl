import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    # create a window
    window = Window(app)

    # create an action that prints "activated"
    action = Action("example.print_activated", app) do action::Action
        println("activated.")
    end

    # add the shortcut `Control + Space`
    add_shortcut!(action, "<Control>space")
    
    # make `window` listen for shortcuts of `action`
    set_listens_for_shortcut_action!(window, action)

    # show the window to the user
    present!(window)
end
