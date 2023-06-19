import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."


main() do app::Application

    window = Window(app)
    
    spin_button = SpinButton(0, 1, 0.001)
    connect_signal_realize!(spin_button) do x::Widget
        println("realize")
    end
    set_child!(window, spin_button)
    present!(window)
end