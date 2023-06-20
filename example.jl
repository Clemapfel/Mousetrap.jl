import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    window = Window(app)
    
    # declare two buttons
    button_01 = Button()
    button_02 = Button()

    # when button 01 is clicked, 02 is triggered programmatically
    connect_signal_clicked!(button_01) do self::Button#, button_02::Button
        println("01 clicked")
        activate!(button_02)
    end

    # when button 02 is clicked, 01 is triggered programmatically
    connect_signal_clicked!(button_02) do self::Button#, button_01::Button
        println("02 clicked")
        activate!(button_01)
    end
    
    set_child!(window, hbox(button_01, button_02))
    present!(window)
end