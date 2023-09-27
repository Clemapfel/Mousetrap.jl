using Mousetrap
using GLMakie

const WindowType = Mousetrap.GLCanvas
function GLMakie.resize_native!(canvas::WindowType, resolution...)
    if !get_is_realized(canvas) 
        return
    end

    println("resize_native!: $resolution")
end

struct MakieCanvas
    _gl_canvas::GLCanvas 
    _makie_screen::GLMakie.Screen
end

function on_makie_canvas_realize(self::GLCanvas, )
    make_current(self)
end

function on_makie_canvas_resize(self::GLCanvas, width, height)
    println("resize: $width $height")
    queue_render(self)
end

function on_makie_canvas_render(self::GLCanvas, context::Ptr{Cvoid})
    return true
end

function MakieCanvas()
    out = Makie
end


function MakieCanvas()
    out = Mousetrap.GLCanvas()
    connect_signal_realize!(on_makie_canvas_realize, self)
    connect_signal_resize!(on_makie_canvas_resize, self)
    connect_signal_render!(on_makie_canvas_render, self)
end

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