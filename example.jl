import Pkg

@info "Importing `mousetrap_julia_binding` shared library"
Pkg.activate(".")
using mousetrap
@info "Done."

struct ShapePage <: Widget

    render_area::RenderArea
    aspect_frame::AspectFrame
    frame::Frame
    label::Label
    center_box::CenterBox

    function ShapePage(title::String, shape::Shape)

        out = new(
            RenderArea(),
            AspectFrame(1.0),
            Frame(),
            Label(title),
            CenterBox(ORIENTATION_VERTICAL)
        )
        
        add_render_task!(out.render_area, RenderTask(shape))
        set_child!(out.frame, out.render_area)
        set_child!(out.aspect_frame, out.frame)
        set_margin!(out.aspect_frame, 10)

        set_size_request!(out.aspect_frame, Vector2f(150, 150))

        set_center_child!(out.center_box, out.aspect_frame)
        set_end_child!(out.center_box, out.label)

        set_margin!(out.label, 10)
    
        return out
    end
end
mousetrap.get_top_level_widget(x::ShapePage) = x.center_box

function add_page!(stack::Stack, title::String, shape::Shape)
    page = ShapePage(title, shape)
    add_child!(stack, page, title)
end

main() do app::Application

    window = Window(app)

    stack = Stack()
    set_expand!(stack, true)

    add_page!(stack, "Point",
        Point(Vector2f(0, 0))
    )

    add_page!(stack, "Points",
        Points([Vector2f(-0.5, 0.5), Vector2f(0.5, 0.5), Vector2f(0.0, -0.5)])
    )


    add_page!(stack, "Line",
        Line(Vector2f(-0.5, +0.5), Vector2f(+0.5, -0.5))
    )

    add_page!(stack, "Lines", 
        Lines([
            Vector2f(-0.5, 0.5) => Vector2f(0.5, -0.5),
            Vector2f(0.5, -0.5) => Vector2f(-0.5, 0.5),
        ])
    )

    add_page!(stack, "LineStrip",
        LineStrip([
            Vector2f(-0.5, +0.5),
            Vector2f(+0.5, +0.5),
            Vector2f(+0.5, -0.5),
            Vector2f(-0.5, -0.5)
        ])
    )
    

    add_page!(stack, "Wireframe",
        Wireframe([
            Vector2f(-0.5, +0.5),
            Vector2f(+0.5, +0.5),
            Vector2f(+0.5, -0.5),
            Vector2f(-0.5, -0.5)
        ])
    )


    add_page!(stack, "Triangle",
        Triangle(
            Vector2f(-0.5, 0.5),
            Vector2f(+0.5, 0.5),
            Vector2f(0.0, -0.5)
        )
    )

    add_page!(stack, "Rectangle",
        Rectangle(
            Vector2f(-0.5, 0.5),
            Vector2f(1, 1)
        )
    )

    add_page!(stack, "Circle", 
        Circle(
            Vector2f(0, 0),
            0.5, 
            32
        )
    )

    add_page!(stack, "Ellipse",
        Ellipse(
            Vector2f(0, 0),
            0.6, 
            0.4, 
            32
        )
    )

    add_page!(stack, "Polgyon", 
        Polygon([
            Vector2f(0.0, 0.75),
            Vector2f(0.75, 0.25),
            Vector2f(0.5, -0.75),
            Vector2f(-0.5, -0.5),
            Vector2f(-0.75, 0.0)
        ])
    )

    add_page!(stack, "Rectangular Frame", 
        RectangularFrame(
            Vector2f(-0.5, 0.5),
            Vector2f(1, 1),
            0.15,
            0.15,
        )
    )

    add_page!(stack, "Circular Ring", 
        CircularRing(
            Vector2f(0, 0),
            0.5, 
            0.15,
            32
        )
    )

    add_page!(stack, "Elliptical Ring",
        EllipticalRing(
            Vector2f(0, 0),
            0.6,
            0.4,
            0.15, 
            0.15,
            32
        )
    )

    viewport = Viewport(StackSidebar(stack))
    set_propagate_natural_width!(viewport, true);
    box = hbox(stack, viewport)
    set_expand!(box, true)

    set_child!(window, box)
    present!(window)
end
