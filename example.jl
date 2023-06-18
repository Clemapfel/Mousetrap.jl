import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."


main() do app::Application

    window = Window(app)

    model = MenuModel()
    section = MenuModel()

    add_action!(section, "01", Action("example.action_01", app) do x::Action
        println("02")
    end)

    add_action!(section, "02", Action("example.action_02", app) do x::Action
        println("02")
    end)

    add_action!(section, "03", Action("example.action_03", app) do x::Action
        println("03")
    end)

    add_section!(model, "section", section, SECTION_FORMAT_INLINE_BUTTONS)

    popover_menu = PopoverMenu(model)
    button = PopoverButton()
    set_popover_menu!(button, popover_menu)
    set_child!(window, button)

    present!(window)
end