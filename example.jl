import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

function generate_child(label::String) ::Widget
    
    child = Frame(Overlay(Separator(), Label(label)))
    set_size_request!(child, Vector2f(150, 150))
    set_margin!(child, 10)
    return child
end

main() do app::Application

    window = Window(app)
    set_title!(window, "mousetrap.jl")

    notebook = Notebook()

    push_back!(notebook, generate_child("Child #01"), Label("Label #01"))
    push_back!(notebook, generate_child("Child #02"), Label("Label #02"))
    push_back!(notebook, generate_child("Child #03"), Label("Label #03"))

    set_child!(window, notebook)
    present!(window)
end
