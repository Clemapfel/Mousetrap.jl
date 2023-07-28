using mousetrap

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
        set_revealed!(revealer, !get_revealed(revealer))
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