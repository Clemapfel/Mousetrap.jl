import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    window = Window(app)

    distance_scrolled = Vector2f(0);
    scroll_controller = ScrollEventController()
    connect_signal_scroll!(scroll_controller) do self::ScrollEventController, delta_x::AbstractFloat, delta_y::AbstractFloat
        global distance_scrolled += Vector2f(delta_x, delta_y)
        println("Distanc scrolled: $distance_scrolled")
    end
    add_controller(window, scroll_controller)
    
    present!(window)
end
