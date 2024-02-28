# File used for debugging and for dosc examples, why are you snooping through this file?

using Mousetrap

main() do app::Application
    window = Window(app)
    aspect_frame = AspectFrame(1.0)

    set_child!(window, aspect_frame)

    connect_signal_motion!(aspect_frame) do _, x, y
        println((x,y))
    end

    present!(window)
end

#==

main() do app::Application
    window = Window(app)

    # create column view with columns
    column_view = ColumnView()

    row_index_column = push_back_column!(column_view, " ")
    count_column = push_back_column!(column_view, "#")
    name_column = push_back_column!(column_view, "Name")
    weight_column = push_back_column!(column_view, "Weight")
    unit_column = push_back_column!(column_view, "Units")

    set_expand!.((row_index, count_column, name_column, weight_column, unit_column), true)

    # fill columns with text
    for i in 1:100
        row = [
            Label(string(i)),           # row index
            Label(string(rand(0:99))),  # count
            Label(rand(["Apple", "Orange", "Banana", "Kumquat", "Durian", "Mangosteen"])), # name
            Label(string(rand(0:100))), # weight
            Label(string(rand(["mg", "g", "kg", "ton"]))) # unit
        ]

        set_horizontal_alignment!.(row, ALIGNMENT_START)
        push_back_row!(column_view, row...)
    end

    # create viewport, this will add a scrollbar
    scrolled_viewport = Viewport()
    set_propagate_natural_width!(scrolled_viewport, true) # hides horizontal scrollbar
    set_child!(scrolled_viewport, column_view)

    # show both in window
    set_child!(window, scrolled_viewport)
    present!(window)
end

#==
add_css!("""
@keyframes spin-animation {
    0%   { transform: rotate(0turn)   scale(1); }
    50%  { transform: rotate(0.5turn) scale(2); }
    100% { transform: rotate(1turn)   scale(1); }
}

.spinning {
    animation: spin-animation;
    animation-duration: 1s;
    animation-iteration-count: infinite;
    animation-timing-function: ease-in-out;
}

.monospaced {
    font-family: monospace;
}
""")

main() do app::Application
    window = Window(app)
    set_title!(window, "mousesnap.jl")

    button = Button()
    add_css_class!(button, "spinning")

    frame = AspectFrame(1.0, button)
    set_margin!(frame, 10)

    #set_child!(window, frame)

    text_view = TextView();
    add_css_class!(text_view, "monospaced")
    set_child!(window, text_view)
    present!(window)
end

exit(0)

add_css!("""
.custom {
    background-color: hotpink;
    border-color: darker(hotpink);
    font-family: monospace;
    border-radius: 0%;
}
""")

function set_accent_color!(color::RGBA) 
    add_css!("""
        @define-color accent_bg_color $(serialize(color));
    """)
end

main() do app::Application

    window = Window(app)
    set_title!(window, "mousetrap.jl")
    
    box = CenterBox(ORIENTATION_VERTICAL)
    
    check_button = CheckButton()
    set_alignment!(check_button, ALIGNMENT_CENTER)
    set_expand!(check_button, false)
    set_start_child!(box, check_button)

    scale = Scale(0, 1, 0.01)
    set_expand!(scale, true)
    set_center_child!(box, scale)

    switch = Switch()
    set_expand!(switch, false)
    set_alignment!(switch, ALIGNMENT_CENTER)
    set_end_child!(box, switch)

    action = Action("change_accent_color", app) do self
        set_accent_color!(RGBA(1, 0, 1, 1))
    end
    add_shortcut!(action, "<Control>e")
    set_listens_for_shortcut_action!(scale, action)

    set_expand!(box, true)
    set_margin!(box, 10)
    set_child!(window, box)
    present!(window)
end

exit(0)

# define widget colors
const WidgetColor = String
const WIDGET_COLOR_DEFAULT = "default"
const WIDGET_COLOR_ACCENT = "accent"
const WIDGET_COLOR_SUCCESS = "success"
const WIDGET_COLOR_WARNING = "warning"
const WIDGET_COLOR_ERROR = "error"

# create a CSS classes for each and load it into the global theme
for name in [WIDGET_COLOR_DEFAULT, WIDGET_COLOR_ACCENT, WIDGET_COLOR_SUCCESS, WIDGET_COLOR_WARNING, WIDGET_COLOR_ERROR]
    add_css!("""
    $name:not(.opaque) {
        background-color: @$(name)_fg_color;
    }
    .$name.opaque {
        background-color: @$(name)_bg_color;
        color: @$(name)_fg_color;
    }
    """)
end

"""
```
set_color!(::Widget, ::WidgetColor) -> Nothing
```
"""
function set_accent_color!(widget::Widget, color, opaque = true)
    if !(color in [WIDGET_COLOR_DEFAULT, WIDGET_COLOR_ACCENT, WIDGET_COLOR_SUCCESS, WIDGET_COLOR_WARNING, WIDGET_COLOR_ERROR])
        log_critical("In set_color!: Color ID `" * color * "` is not supported")
    end    
    add_css_class!(widget, color)
    if opaque
        add_css_class!(widget, "opaque")
    end
end

main() do app::Application
    window = Window(app)

    set_title!(window, "mousetrap.jl")
    function create_widget() 
        return Button(Label("TEST"))
    end
    
    column_view = ColumnView()
    column = push_back_column!(column_view, " ")
    set_widget_at!(column_view, column, 1, Label("<small>!opaque</small>"))
    set_widget_at!(column_view, column, 2, Label("<small>opaque</small>"))

    for color in [WIDGET_COLOR_DEFAULT, WIDGET_COLOR_ACCENT, WIDGET_COLOR_SUCCESS, WIDGET_COLOR_WARNING, WIDGET_COLOR_ERROR]
        column = push_back_column!(column_view, color)
        
        # non-opaque version
        widget = create_widget()
        set_accent_color!(widget, color, false)
        set_widget_at!(column_view, column, 1, widget)

        # opaque version
        widget = create_widget()
        set_accent_color!(widget, color, true)
        set_widget_at!(column_view, column, 2, widget)
    end

    set_child!(window, column_view)
    present!(window)
end
exit(0)

using Mousetrap
main() do app::Application
    window = Window(app)
    widget = Button()

    box = Box(ORIENTATION_HORIZONTAL)
    for name in ["accent", "success", "warning", "error"]
        add_css!("""
        $name:not(.opaque) {
            background-color: @$(name)_fg_color;
        }
        .$name.opaque {
            background-color: @$(name)_bg_color;
            color: @$(name)_fg_color;
        }
        """)
    end

    names = ["default", "accent", "success", "warning", "error"]


    column_view = ColumnView()
    
    first_column = push_back_column!(column_view, " ")
    

    for name in names
        push_back_column!(column_view, name)
    end

    #, Switch, CheckButton, ProgressBar, Spinner, Scale, SpinButton, Entry, Separator

    j = 1
    for create_widget in [
        () -> Button(Label("TEST")), 
        () -> Switch(),
        () -> ProgressBar(),
        () -> Spinner(),
        () -> LevelBar(0, 1),
        () -> Scale(0, 1, 1),
        () -> Entry(),
        () -> Separator()
    ]
        local default_label = Label("default")
        local opaque_label = Label("opaque")

        for label in [default_label, opaque_label]
            add_css_class!(label, "dimmed")
            add_css_class!(label, "caption")
        end

        set_widget_at!(column_view, first_column, j, default_label)
        set_widget_at!(column_view, first_column, j + 1, opaque_label)

        for name in names
            i = j 
            column = get_column_with_title(column_view, name)

            local non_opaque = create_widget()
            add_css_class!(non_opaque, name)
            set_widget_at!(column_view, column, i, non_opaque)

            try
                set_child!(non_opaque, Label("TEST"))
            catch end

            i = i + 1

            local opaque = create_widget()
            add_css_class!(opaque, name)
            add_css_class!(opaque, "opaque")
            set_widget_at!(column_view, column, i, opaque)

            try
                set_child!(opaque, Label("TEST"))
            catch end

            for widget in [non_opaque, opaque]
                #set_alignment!(widget, ALIGNMENT_CENTER)
                #set_expand!(widget, false)
            end
        end
        j = j + 2
    end

    set_child!(window, Viewport(column_view))
    present!(window)
end

exit(0)

main() do app::Application
    window = Window(app)
    set_title!(window, "mousetrap.jl")

    # animate a gradual fade-out
    button = Button(Label("SPIN"))
    aspect_frame = AspectFrame(1.0, button)
    set_margin!(aspect_frame, 10)

    transform_bin = TransformBin()
    set_child!(transform_bin, aspect_frame)

    animation = Animation(transform_bin, seconds(1))
    on_tick!(animation, transform_bin) do self::Animation, value::AbstractFloat, transform_bin::TransformBin
        reset!(transform_bin)
        rotate!(transform_bin, degrees(value * 360))
        scale!(transform_bin, 1 + value, 1 + value)
    end

    on_done!(animation, transform_bin) do self::Animation, transform_bin::TransformBin
        reset!(transform_bin)
    end

    # start animation when button is clicked
    connect_signal_clicked!(button, animation) do self::Button, animation::Animation
        play!(animation)
    end
   
    set_child!(window, transform_bin)
    present!(window)
end


#=
@static if false

struct TexturePage <: Widget
    center_box::CenterBox
    label::Label
    render_area::RenderArea
    texture::Texture
    shape::Shape

    function TexturePage(label::String, image::Image, wrap_mode::TextureWrapMode)
        out = new(
            CenterBox(ORIENTATION_VERTICAL),
            Label("<tt>" * label * "</tt>"),
            RenderArea(),
            Texture(),
            Rectangle(Vector2f(-1, 1), Vector2f(2, 2))
        )

        set_expand!(out.render_area, true)
        set_size_request!(out.render_area, Vector2f(150, 150))    

        set_start_child!(out.center_box, AspectFrame(1.0, Frame(out.render_area)))
        set_end_child!(out.center_box, out.label)
        set_margin!(out.label, 10)

        create_from_image!(out.texture, image)
        set_wrap_mode!(out.texture, wrap_mode)
        
        set_texture!(out.shape, out.texture)
        set_vertex_texture_coordinate!(out.shape, 1, Vector2f(-1, -1))
        set_vertex_texture_coordinate!(out.shape, 2, Vector2f(2, -1))
        set_vertex_texture_coordinate!(out.shape, 3, Vector2f(2, 2))
        set_vertex_texture_coordinate!(out.shape, 4, Vector2f(-1, 2))

        add_render_task!(out.render_area, RenderTask(out.shape))
        return out
    end
end
Mousetrap.get_top_level_widget(x::TexturePage) = x.center_box


main() do app::Application
    window = Window(app)
    set_title!(window, "Mousetrap.jl")

    render_area = RenderArea()
   
    image = Image()
    create_from_file!(image, "docs/src/assets/logo.png")

    size = get_size(image)
    hue_step = 1 / size.x
    for i in 1:size.y
        for j in 1:size.x
            if get_pixel(image, i, j).a == 0
                set_pixel!(image, i, j, HSVA(j * hue_step, 1, 1, 1))
            end
        end
    end

    box = Box(ORIENTATION_HORIZONTAL)
    set_spacing!(box, 10)
    set_margin!(box, 10)

    push_back!(box, TexturePage("ZERO", image, TEXTURE_WRAP_MODE_ZERO))
    push_back!(box, TexturePage("ONE", image, TEXTURE_WRAP_MODE_ONE))
    push_back!(box, TexturePage("STRETCH", image, TEXTURE_WRAP_MODE_STRETCH))
    push_back!(box, TexturePage("REPEAT", image, TEXTURE_WRAP_MODE_REPEAT))
    push_back!(box, TexturePage("MIRROR", image, TEXTURE_WRAP_MODE_MIRROR))

    set_child!(window, box)
    present!(window)
end

end

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
Mousetrap.get_top_level_widget(x::ShapePage) = x.center_box

main() do app::Application

    window = Window(app)
    set_title!(window, "Mousetrap.jl")

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
            Vector2f(-0.5, -0.5) => Vector2f(0.5, 0.5)
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
    set_has_frame!(button, false)
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
    add_controller!(button, key_controller)

    # main layout
    box = hbox(stack, revealer)
    set_child!(window, box)
    present!(window)
end

@static if false

main() do app::Application

    window = Window(app)
    set_title!(window, "Mousetrap.jl")

    # create render areas with different MSAA modes
    left_area = RenderArea(ANTI_ALIASING_QUALITY_OFF)
    right_area = RenderArea(ANTI_ALIASING_QUALITY_BEST)

    # paned that will hold both areas
    paned = Paned(ORIENTATION_HORIZONTAL)

    # create singular shape, which will be shared between areas
    shape = Rectangle(Vector2f(-0.5, 0.5), Vector2f(1, 1))
    add_render_task!(left_area, RenderTask(shape))
    add_render_task!(right_area, RenderTask(shape))

    # rotate shape 1° per frame
    set_tick_callback!(paned) do clock::FrameClock

        # rotate shape 
        rotate!(shape, degrees(1), get_centroid(shape))

        # force redraw for both areas
        queue_render(left_area) 
        queue_render(right_area)

        # continue callback indefinitely
        return TICK_CALLBACK_RESULT_CONTINUE
    end

    # setup window layout for viewing
    for area in [left_area, right_area]
        set_size_request!(area, Vector2f(150, 150))
    end

    # caption labels
    left_label = Label("<tt>OFF</tt>")
    right_label = Label("<tt>BEST</tt>")

    for label in [left_label, right_label]
        set_margin!(label, 10)
    end

    # format paned
    set_start_child_shrinkable!(paned, false)
    set_end_child_shrinkable!(paned, false)
    set_start_child!(paned, vbox(AspectFrame(1.0, left_area), left_label))
    set_end_child!(paned, vbox(AspectFrame(1.0, right_area), right_label))

    # present
    set_child!(window, paned)
    present!(window)
end

end # @static if

    =#

end
==#