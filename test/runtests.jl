
mt = mousetrap
mt.main() do app::mt.Application

    window = mt.Window(app)

    spin_button = mt.SpinButton(0.0, 1.0, 0.01)
    mt.connect_signal_value_changed!(spin_button) do x::mt.SpinButton
        println(mt.get_value(x))
    end

    mt.set_child!(window, spin_button)
    mt.present!(window)
end