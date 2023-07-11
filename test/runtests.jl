using mousetrap
using Test

### GLOBALS

const app_id = "mousetrap.runtests.jl"
const app = Ref{Union{Application, Nothing}}(nothing)
const test_action = Ref{Union{Action, Nothing}}(nothing)

### ACTION

    struct ActionTest <: Widget end
    mousetrap.get_top_level_widget(::ActionTest) = Separator()

    function (::ActionTest)()
        @testset "Action" begin
            action_id = "test.action"
            action = Action(action_id, Main.app[])
            Base.show(devnull, action)

            triggered = Ref{Bool}(false)
            function on_activate(::Action, triggered::Ref{Bool}) 
                triggered[] = true
                return nothing
            end

            set_function!(on_activate, action, triggered)
            connect_signal_activated!(on_activate, action, triggered) 

            activate!(action)
            @test triggered[] == true
            @test get_id(action) == action_id
            @test get_enabled(action) == true
            set_enabled!(action, false)
            @test get_enabled(action) == false
        end
    end

### ADJUSTMENT

    struct AdjustmentTest <: Widget end
    mousetrap.get_top_level_widget(::AdjustmentTest) = Separator()

    function (::AdjustmentTest)()
        @testset "Adjustment" begin
            adjustment = Adjustment(0, -1, 2, 0.05)
            Base.show(devnull, adjustment)

            properties_changed_called = Ref{Bool}(false)
            connect_signal_properties_changed!(adjustment, properties_changed_called) do ::Adjustment, properties_changed_called
                properties_changed_called[] = true
                return nothing
            end

            value_changed_called = Ref{Bool}(false)
            connect_signal_value_changed!(adjustment, value_changed_called) do ::Adjustment, value_changed_called
                value_changed_called[] = true
                return nothing
            end

            @test get_lower(adjustment) == -1.0f0
            set_lower!(adjustment, 0)
            @test get_lower(adjustment) == 0.0f0

            @test get_upper(adjustment) == 2.0f0
            set_upper!(adjustment, 1)
            @test get_upper(adjustment) == 1.0f0

            @test get_step_increment(adjustment) == 0.05f0
            set_step_increment!(adjustment, 0.01)
            @test get_step_increment(adjustment) == 0.01f0
            
            @test get_value(adjustment) == 0.0f0
            set_value!(adjustment, 0.5)
            @test get_value(adjustment) == 0.5f0

            @test properties_changed_called[] == true
            @test value_changed_called[] == true
        end
    end

### APPLICATION

    struct ApplicationTest <: Widget end
    mousetrap.get_top_level_widget(::ApplicationTest) = Separator()

    function (::ApplicationTest)()
        @testset "Application" begin
            app = Main.app[]
            Base.show(devnull, app)
            @test get_id(app) == app_id

            action_id = "application.test_action"
            action = Action(action_id, app) do ::Action end

            add_action!(app, action)
            @test has_action(app, action_id) == true
            @test get_id(get_action(app, action_id)) == action_id
            remove_action!(app, action_id)
            @test has_action(app, action_id) == false
            
            @test get_is_holding(app) == false
            hold!(app)
            @test get_is_holding(app) == true
            release!(app)
            @test get_is_holding(app) == false

            @test get_is_marked_as_busy(app) == false
            mark_as_busy!(app)
            @test get_is_marked_as_busy(app) == true
            unmark_as_busy!(app)
            @test get_is_marked_as_busy(app) == false
        end
    end

### BUTTON

    struct ButtonTest <: Widget
        button::Button
        ButtonTest() = new(Button())
    end
    mousetrap.get_top_level_widget(x::ButtonTest) = x.button

    function (this::ButtonTest)()
        @testset "Button" begin
            
            button = this.button
            Base.show(devnull, button)
            
            set_child!(button, Label("Button"))

            @test get_has_frame(button)
            set_has_frame!(button, false)
            @test !get_has_frame(button)

            @test !get_is_circular(button)
            set_is_circular!(button, true)
            @test get_is_circular(button)

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

function add_page(grid::Grid, title::String, page::T, x::Integer = 1, y::Integer = 1) where T <: Widget

    frame = Frame()
    connect_signal_realize!(frame, page) do _, page
        page()
        return nothing
    end

    aspect_frame = AspectFrame(1.0)
    frame_spacer = Separator()
    set_expand_vertically!(frame_spacer, false)
    set_size_request!(frame_spacer, Vector2f(0, 1))

    set_label_widget!(frame, Label(title))
    set_label_x_alignment!(frame, 0.5)
    set_child!(frame, page)
    set_child!(aspect_frame, frame)

    mousetrap.insert!(grid, aspect_frame, x, y, 1, 1)
end

main(app_id) do app::Application
    
    Main.app[] = app
    Main.test_action[] = Action("test.action", app) do ::Action
        # noop
    end

    window = Window(app)
    grid = Grid()
    set_rows_homogeneous!(grid, true)
    set_columns_homogeneous!(grid, true)
    set_row_spacing!(grid, 10)
    set_column_spacing!(grid, 10)
    set_margin!(grid, 10)
        
    add_page(grid, "Action", ActionTest())
    add_page(grid, "Adjustment", AdjustmentTest())
    add_page(grid, "Application", ApplicationTest())
    add_page(grid, "Button", ButtonTest())

    # this will be realized after all pages, at which point it will quit the app
    sentinel = Separator()
    connect_signal_realize!(sentinel, app) do _, app
        sleep(1)
        quit!(app)
    end
    overlay = Overlay()
    set_child!(overlay, grid)
    add_overlay!(overlay, sentinel)

    set_child!(window, overlay)
    present!(window)
end
