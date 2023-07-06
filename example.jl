import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main(; application_id = "stack.example") do app::Application

    println("called")

    window = Window(app)
    set_title!(window, "mousetrap.jl")

    
    adjustment = Adjustment(0.5, 0, 1, 0.01)
    scrollbar = Scrollbar(ORIENTATION_HORIZONTAL, adjustment)
    connect_signal_value_changed!(adjustment) do self::Adjustment
        println("Value is now $(get_value(self))")
    end

    set_child!(window, scrollbar)
    present!(window)
end
