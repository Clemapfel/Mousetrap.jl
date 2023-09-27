using Mousetrap
using GLMakie

main() do app::Application
    window = Window(app)
    canvas = GLCanvas()

    connect_signal_resize!(canvas) do self, x, y
        println("resize: $x, $y")
    end

    connect_signal_render!(canvas) do self, ptr
        println("render: $ptr")
        return true
    end

    set_child!(window, canvas)
    present!(window)
end