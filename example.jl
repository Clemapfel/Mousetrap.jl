import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    window = Window(app)

    root = MenuModel()

    # action

    action_model = MenuModel()
    add_action!(action_model, "Action Item #1", Action("action.01", app) do x end)
    add_action!(action_model, "Action item #2", Action("action.02", app) do x end)
    add_action!(action_model, "Action item #3", Action("action.02", app) do x end)

    add_submenu!(root, "Actions", action_model)

    # widgets 

    widget_model = MenuModel()

    box = Box(ORIENTATION_HORIZONTAL)
    push_back!(box, Label("Choose Value:  "))
    push_back!(box, SpinButton(0, 1, 0.01))
    #set_margin!(box, 10.0)

    add_widget!(widget_model, box)
    add_submenu!(root, "Widgets", widget_model)

    scale = Scale(Cfloat(0.0), Cfloat(1.0), Cfloat(0.1))
    set_lower!(scale, 0)

    menu_bar = MenuBar(root)
    set_child!(window, menu_bar);
    present!(window)
end
