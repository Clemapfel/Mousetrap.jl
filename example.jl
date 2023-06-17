import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."


main() do app::Application

    window = Window(app)

    swipe_controller = SwipeEventController()
    connect_signal_swipe!(swipe_controller) do self::SwipeEventController, x_velocity::AbstractFloat, y_velocity::AbstractFloat
        print("swiping ")

        if (y_velocity < 0)
            print("up ")
        elseif (y_velocity > 0)
            print("down ")
        end

        if (x_velocity < 0)
            println("left")
        elseif (x_velocity > 0)
            println("right")
        end
    end
    add_controller!(window, swipe_controller)
    present!(window)
end