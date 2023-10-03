using mousetrap_jll
using Mousetrap
using ModernGL, GLMakie, Colors, GeometryBasics, ShaderAbstractions
using GLMakie.GLAbstraction
using GLMakie.Makie

const WindowType = Mousetrap.Window
const screens = Dict{Ptr{Gtk4.GtkGLArea}, GLMakie.Screen}();

_mousetrap_gl_makie_id = 0

"""
"""
mutable struct MousetrapGLMakie <: Widget
    
    _gl_area::Mousetrap.GLCanvas
    _handle::UInt64
    _framebuffer_id::Ref{Int64}

    function MousetrapGLMakie()
        canvas = GLCanvas()
        set_auto_render!(canvas, false)

        _mousetrap_gl_makie_id = _mousetrap_gl_makie_id + 1
        return new(
            canvas,
            _mousetrap_gl_makie_id,
            Ref{Int64}(0)
        )
    end
end
Mousetrap.get_toplevel_widget(x::GLMakieCanvas) = x._gl_area

# callback for `render` signal
function on_makie_canvas_render(self, context)
    if haskey(screens, )
end