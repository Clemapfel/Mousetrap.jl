import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    window = Window(app)

    let action = Action("example.print_clicked", app)
        set_function!(action) do x::Action
            println("clicked")
        end
    end

    # action is no longer defined here, instead, we can do:
    activate!(get_action(app, "example.print_clicked"))

    present!(window)
end
