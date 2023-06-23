import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    function on_motion(self::MotionEventController, x::AbstractFloat, y::AbstractFloat, instance::Widget)
        widget_position = get_position(instance)
        cursor_position = Vector2f(x, y)
    
        println("Absolute Cursor Position: $(widget_position + cursor_position)")
    end
    
    window = Window(app)
    motion_controller = MotionEventController()
    connect_signal_motion!(on_motion, motion_controller, window)
    add_controller!(window, motion_controller)

    present!(window)
end
