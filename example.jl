using mousetrap




############################################

@static if false

using mousetrap

# compound widget that is an entire stack page, render area with the shape + a label below
struct ShapePage <: Widget

    separator::Separator
    render_area::RenderArea
    overlay::Overlay
    frame::Frame
    aspect_frame::AspectFrame
    label::Label
    center_box::CenterBox

    function ShapePage(title::String, shape::Shape)

        out = new(
            Separator(),
            RenderArea(),
            Overlay(),
            Frame(),
            AspectFrame(1.0),
            Label(title),
            CenterBox(ORIENTATION_VERTICAL)
        )

        set_child!(out.overlay, out.separator)
        add_overlay!(out.overlay, out.render_area)
        set_child!(out.frame, out.overlay)
        set_child!(out.aspect_frame, out.frame)
    
        set_center_child!(out.center_box, out.aspect_frame)
        set_end_child!(out.center_box, out.label)

        set_size_request!(out.aspect_frame, Vector2f(150, 150))
        set_expand!(out.aspect_frame, true)

        set_margin!(out.aspect_frame, 10)
        set_margin!(out.label, 10)

        add_render_task!(out.render_area, RenderTask(shape))

        radius = 0.001
        n_vertices = get_n_vertices(shape)
        for i in 1:n_vertices
            pos = get_vertex_position(shape, i)
            to_add = Circle(Vector2f(pos.x, pos.y), radius, 16)
            set_color!(to_add, HSVA(i / n_vertices, 1, 1, 1))
            add_render_task!(out.render_area, RenderTask(to_add))
        end

        # Widget hierarchy for clarity:
        # 
        # CenterBox \
        #   AspectFrame \
        #       Frame \
        #           Overlay \
        #               RenderArea 
        #               Separator
        #   Label

        return out
    end
end
mousetrap.get_top_level_widget(x::ShapePage) = x.center_box

main() do app::Application

    window = Window(app)
    set_title!(window, "mousetrap.jl")

    shapes = [
        "Point" => Point(
            Vector2f(0, 0)
        ),
        "Points" => Points([
            Vector2f(-0.5, 0.5), 
            Vector2f(0.5, 0.5), 
            Vector2f(0.0, -0.5)
        ]),
        "Line" => Line(
            Vector2f(-0.5, +0.5), 
            Vector2f(+0.5, -0.5)
        ),
        "Lines" =>Lines([
            Vector2f(-0.5, 0.5) => Vector2f(0.5, -0.5),
            Vector2f(0.5, -0.5) => Vector2f(-0.5, 0.5)
        ]),
        "LineStrip" =>  LineStrip([
            Vector2f(-0.5, +0.5),
            Vector2f(+0.5, +0.5),
            Vector2f(+0.5, -0.5),
            Vector2f(-0.5, -0.5)
        ]),
        "Wireframe" => Wireframe([
            Vector2f(-0.5, +0.5),
            Vector2f(+0.5, +0.5),
            Vector2f(+0.5, -0.5),
            Vector2f(-0.5, -0.5)
        ]),
        "Triangle" => Triangle(
            Vector2f(-0.5, 0.5),
            Vector2f(+0.5, 0.5),
            Vector2f(0.0, -0.5)
        ),
        "Rectangle" => Rectangle(
            Vector2f(-0.5, 0.5),
            Vector2f(1, 1)
        ),
        "Circle" => Circle(
            Vector2f(0, 0),
            0.5, 
            32
        ),
        "Ellipse" => Ellipse(
            Vector2f(0, 0),
            0.6, 
            0.4, 
            32
        ),
        "Polygon" => Polygon([
            Vector2f(0.0, 0.75),
            Vector2f(0.75, 0.25),
            Vector2f(0.5, -0.75),
            Vector2f(-0.5, -0.5),
            Vector2f(-0.75, 0.0)
        ]),
        "RectangularFrame" => RectangularFrame(
            Vector2f(-0.5, 0.5),
            Vector2f(1, 1),
            0.15,
            0.15,
        ),
        "CircularRing" =>  CircularRing(
            Vector2f(0, 0),
            0.5, 
            0.15,
            32
        ),
        "EllipticalRing" =>  EllipticalRing(
            Vector2f(0, 0),
            0.6,
            0.4,
            0.15, 
            0.15,
            32
        )
    ]

    # add button that allow switching between light and dark theme
    button = Button()
    connect_signal_clicked!(button, app) do self::Button, app::Application

        current = get_current_theme(app)

        # swap light to dark, dark to light
        if current == THEME_DEFAULT_DARK
            next = THEME_DEFAULT_LIGHT
        elseif current == THEME_DEFAULT_LIGHT
            next = THEME_DEFAULT_DARK
        elseif current == THEME_HIGH_CONTRAST_DARK
            next = THEME_HIGH_CONTRAST_LIGHT
        elseif current == THEME_HIGH_CONTRAST_LIGHT
            next = THEME_HIGH_CONTRAST_DARK
        end

        set_current_theme!(app, next)

        # also swap colors to contrast well
        for pair in shapes
            shape = pair[2]
            if next == THEME_DEFAULT_LIGHT || next == THEME_HIGH_CONTRAST_LIGHT
                set_color!(shape, RGBA(0, 0, 0, 1))
            else
                set_color!(shape, RGBA(1, 1, 1, 1))
            end
        end
    end
    set_tooltip_text!(button, "Click to Swap UI Theme")
    push_front!(get_header_bar(window), button)

    # add outline shapes for shapes that have a volume
    for name in ["Triangle", "Rectangle", "Circle", "Ellipse", "Polygon", "RectangularFrame", "CircularRing", "EllipticalRing"]
        
        # get shape of pairs whos first element is equal to `name`
        shape = (shapes[findfirst(x -> x[1] == name, shapes)]).second

        # add the new outline to shapes
        push!(shapes, (name * " (Outline)" => Outline(shape)))
    end

    # create the stack and fill it with pages, in order
    stack = Stack()
    for (name, shape) in shapes
        add_child!(stack, ShapePage(name, shape), name)
    end

    # create side bar to be able to pick the stack page
    viewport = Viewport(StackSidebar(stack))
    set_propagate_natural_width!(viewport, true)
    set_horizontal_scrollbar_policy!(viewport, SCROLLBAR_VISIBILITY_POLICY_NEVER) 
        # forces witdh of viewport to be equal to width of stack side bar at all time

    # make it so stack page expands instead of side-bar
    set_expand_horizontally!(stack, true)
    set_expand_horizontally!(viewport, false)

    # add a revealer that can hide the side bar for screenshots
    revealer = Revealer(viewport)
    set_transition_type!(revealer, REVEALER_TRANSITION_TYPE_SLIDE_RIGHT)

    # Allow hiding / showing the sidebar by pressing `Control + H`
    # To do this, we create an action that triggers the revealer, then add a shortcut
    revealer_action = Action("trigger_revealer", app)
    set_function!(revealer_action, revealer) do self::Action, revealer::Revealer
        set_is_revealed!(revealer, !get_is_revealed(revealer))
    end
    add_shortcut!(revealer_action, "<Control>h");
    set_listens_for_shortcut_action!(window, revealer_action)
    set_tooltip_text!(revealer, "press <tt>Control + H</tt> to hide this element.")

    key_controller = KeyEventController()
    connect_signal_key_released!(key_controller, stack) do _::KeyEventController, code::KeyCode, modifiers::ModifierState, stack::Stack
        
        stack_model = get_selection_model(stack)
        current = get_selection(stack_model)[1]

        if code == KEY_Left || code == KEY_Up && (current > 1)
            select!(stack_model, current - 1)
        elseif code == KEY_Right || code == KEY_Down && (current < get_n_items(stack_model))
            select!(stack_model, current + 1)
        end
    end
    add_controller!(window, key_controller)

    # main layout
    box = hbox(stack, revealer)
    set_child!(window, box)
    present!(window)
end

end # @static if