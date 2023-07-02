import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    window = Window(app)
    set_title!(window, "mousetrap.jl")

    child = Frame(Overlay(Separator(), Label("Child")))
    set_margin!(child, 10)
    set_size_request!(child, Vector2f(0, 100))

    label = Label("Label")
    set_margin!(label, 10)
   
    expander_and_frame = Frame(Expander(child, label))
    set_margin!(expander_and_frame, 10)

    set_child!(window, expander_and_frame)
    present!(window)
end
