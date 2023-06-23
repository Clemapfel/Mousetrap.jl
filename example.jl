import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    # create a window
    window = Window(app)
    label = Label("test label")
    println(label)
    set_child!(window, label)
    present!(window)
end
