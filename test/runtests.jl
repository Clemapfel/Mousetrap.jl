using mousetrap
using Test

### GLOBALS

const app = Ref{Union{Application, Nothing}}(nothing)
const test_action = Ref{Union{Action, Nothing}}(nothing)

### ACTION

struct ActionTest <: Widget end
function mousetrap.get_top_level_widget(x::ActionTest)
    return Button()
end

const action_test_action_id = "testset.action"
const action_test_action = Ref{Union{Action, Nothing}}(nothing)

function (this::ActionTest)()
    @testset "Action" begin

        action = action_test_action[]
        println(action)

        triggered = Ref{Bool}(false)
        function on_activate(::Action, triggered::Ref{Bool}) 
            triggered[] = true
            return nothing
        end

        set_function!(on_activate, action, triggered)
        connect_signal_activated!(on_activate, action, triggered) 

        activate!(action)
        @test triggered[] == true
        @test get_id(action) == action_test_action_id
        @test get_enabled(action) == true
        set_enabled!(action, false)
        @test get_enabled(action) == false
    end
end

### APPLICATION



### BUTTON

struct ButtonTest <: Widget
    button::Button
    ButtonTest() = new(Button())
end
mousetrap.get_top_level_widget(x::ButtonTest) = x.button

function (this::ButtonTest)()
    @testset "Button" begin
        
        button = this.button
        println(button)
        
        set_child!(button, Label("Button"))

        @test get_has_frame(button)
        set_has_frame!(button, false)
        @test !get_has_frame(button)

        @test !get_is_circular(button)
        set_is_circular!(button, true)
        @test get_is_circular(button)

        set_action!(button, test_action[])

        connect_signal_activate!(button) do ::Button
            @test true
            return nothing
        end

        connect_signal_clicked!(button) do ::Button
            @test true
            return nothing
        end

        set_has_frame!(button, true)
    end
end

### MAIN

function add_page(grid::Grid, title::String, page::T, x::Integer, y::Integer) where T <: Widget
    
    button = Button()
    set_child!(button, Label("&#11208;"))
    set_tooltip_text!(button, "Run testset \"$title\"")
    
    connect_signal_clicked!(button, page) do _, page
        page()
        return nothing
    end

    connect_signal_realize!(get_top_level_widget(page), page) do _, page
        page()
        return nothing
    end

    label = Label(title)
    spacer = Separator(; opacity = 0.0)

    set_horizontal_alignment!(label, ALIGNMENT_START)
    set_horizontal_alignment!(spacer, ALIGNMENT_CENTER)
    set_horizontal_alignment!(button, ALIGNMENT_END)

    set_margin_start!(label, 10)
    set_expand!(page, true)

    frame = Frame()
    aspect_frame = AspectFrame(1.0)
    frame_spacer = Separator()
    set_expand_vertically!(frame_spacer, false)
    set_size_request!(frame_spacer, Vector2f(0, 1))

    set_child!(frame, vbox(hbox(label, spacer, button), frame_spacer, page))
    set_child!(aspect_frame, frame)

    mousetrap.insert!(grid, aspect_frame, x, y, 1, 1)
end

main("mousetrap.runtests.jl") do app::Application
    
    println(app)

    Main.app[] = app
    Main.test_action[] = Action("test.action", app) do ::Action
        # noop
    end

    Main.action_test_action[] = Action(action_test_action_id, app)

    window = Window(app)
    grid = Grid()
    set_rows_homogeneous!(grid, true)
    set_columns_homogeneous!(grid, true)
    set_row_spacing!(grid, 10)
    set_column_spacing!(grid, 10)
    set_margin!(grid, 10)
        
    add_page(grid, "Action", ActionTest(), 1, 1)
    #add_page(grid, "Button", ButtonTest(), 2, 1)

    set_child!(window, grid)
    present!(window)
end
