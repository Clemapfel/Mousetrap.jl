import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    window = Window(app)
    set_title!(window, "mousetrap.jl")

    list_view = ListView()
    push_back!(list_view, Label("Child #01"))
    push_back!(list_view, Button("Child #02"))
    push_Back!()

    set_child!(window, button)
    present!(window)
end
