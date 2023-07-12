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

            add_shortcut!(action, "a")
            add_shortcut!(action, "b")

            shortcuts = get_shortcuts(action)
            @test "a" in shortcuts
            @test "b" in shortcuts

            clear_shortcuts!(action)
            @test isempty(get_shortcuts(action))
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

### ALERT DIALOG

    struct AlertDialogTest <: Widget end
    mousetrap.get_top_level_widget(::AlertDialogTest) = Separator()

    function (::AlertDialogTest)() 
        @testset "AlertDialog" begin
            message = "message"
            detailed_message = "detailed message
            "
            alert_dialog = AlertDialog(["01", "02"], message, detailed_message)
            
            button_label = "Label"
            add_button!(alert_dialog, 1, button_label)
            @test get_button_label(alert_dialog, 1) == button_label

            @test get_message(alert_dialog) == message
            @test get_detailed_description(alert_dialog) == detailed_message

            @test get_n_buttons(alert_dialog) == 3
            remove_button!(alert_dialog, 3)
            remove_button!(alert_dialog, 2)
            @test get_n_buttons(alert_dialog) == 1

            @test get_is_modal(alert_dialog) == true
            set_is_modal!(alert_dialog, false)
            @test get_is_modal(alert_dialog) == false
        end
    end

### ANGLE

    struct AngleTest <: Widget end
    mousetrap.get_top_level_widget(::AngleTest) = Separator()

    function (::AngleTest)()
        @testset "Angle" begin
            angle = degrees(90)
            @test as_degrees(angle) == 90
            angle_rad = as_radians(angle)
            angle_dg = as_degrees(radians(angle_rad))

            @test 
            @test isapprox(as_radians(angle), π / 180)
        end
    end

### AspectFrame

    const aspect_frame_test_ratio = 1.5
    struct AspectFrameTest <: Widget
        aspect_frame::AspectFrame

        function AspectFrameTest()
            out = new(AspectFrame(Main.aspect_frame_test_ratio))
            child = Separator()
            set_child!(out.aspect_frame, child)
            return out
        end
    end
    mousetrap.get_top_level_widget(x::AspectFrameTest) = x.aspect_frame

    function (this::AspectFrameTest)()
        @testset "AspectFrame" begin

            aspect_frame = this.aspect_frame

            @test get_child_x_alignment(aspect_frame) == 0.5
            set_child_x_alignment!(aspect_frame, 0.0)
            @test get_child_x_alignment(aspect_frame) == 0.0

            @test get_child_y_alignment(aspect_frame) == 0.0
            set_child_y_alignment!(aspect_frame, 0.5)
            @test get_child_y_alignment(aspect_frame) == 0.5

            @test get_ratio(aspect_frame) == aspect_frame_test_ratio
            set_ratio!(aspect_frame, 1.0)
            @test get_ratio(aspect_frame) == 1.0
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

### BOX

    struct BoxTest <: Widget
        box::Box

        BoxTest() = new(Box(ORIENTATION_HORIZONTAL))
    end
    mousetrap.get_top_level_widget(x::BoxTest) = return x.box

    function (this::BoxTest)()
        @testset "Box" begin
            box = this.box

            @test get_homogeneous(box) == false
            set_homogeneous!(box, true)
            @test get_homogeneous(box) == true

            @test get_orientation(box) == ORIENTATION_HORIZONTAL
            set_orientation!(box, ORIENTATION_VERTICAL)
            @test get_orientation(box) == ORIENTATION_VERTICAL

            start = Separator()
            push_front!(box, start)
            push_back!(box, Separator())
            insert_after!(box, Separator(), start)
            remove!(box, start)

            @test get_n_items(box) == 2

            @test get_spacing(box) == 0
            set_spacing!(box, 10)
            @test get_spacing(box) == 10
        end
    end

### CENTER_BOX

    struct CenterBoxTest <: Widget
        center_box::CenterBox
        CenterBoxTest() = new(CenterBox(ORIENTATION_HORIZONTAL))
    end
    mousetrap.get_top_level_widget(x::CenterBoxTest) = return x.center_box

    function (this::CenterBoxTest)()
        @testset "CenterBox" begin
            center_box = this.center_box

            @test get_orientation(center_box) == ORIENTATION_HORIZONTAL
            set_orientation!(center_box, ORIENTATION_VERTICAL)
            @test get_orientation(center_box) == ORIENTATION_VERTICAL

            set_start_child!(center_box, Separator())
            remove_start_child!(center_box)

            set_center_child!(center_box, Separator())
            remove_center_child!(center_box)

            set_end_child!(center_box, Separator())
            remove_end_child!(center_box)
        end
    end

### CHECK_BUTTON

    struct CheckButtonTest <: Widget
        check_button::CheckButton
        CheckButtonTest() = new(CheckButton())
    end
    mousetrap.get_top_level_widget(x::CheckButtonTest) = x.check_button

    function (this::CheckButtonTest)()

        @testset "CheckButton" begin
            check_button = this.check_button

            toggled_called = Ref{Bool}(false)
            connect_signal_toggled!(check_button, toggled_called) do _, toggled_called
                toggled_called[] = true
                return nothing
            end

            activate_called = Ref{Bool}(false)
            connect_signal_activate!(check_button, activate_called) do _, activate_called
                activate_called[] = true
                return nothing
            end

            set_is_active!(check_button, true)
            @test get_is_active(check_button) == true

            set_state!(check_button, CHECK_BUTTON_STATE_INACTIVE)
            @test get_state(check_button) == CHECK_BUTTON_STATE_INACTIVE
            @test get_is_active(check_button) == false

            set_state!(check_button, CHECK_BUTTON_STATE_ACTIVE)
            @test get_state(check_button) == CHECK_BUTTON_STATE_ACTIVE
            @test get_is_active(check_button) == true

            set_state!(check_button, CHECK_BUTTON_STATE_INCONSISTENT)
            @test get_state(check_button) == CHECK_BUTTON_STATE_INCONSISTENT
            @test get_is_active(check_button) == false

            set_child!(check_button, Separator())
            remove_child!(check_button)
        end
    end

### EVENT_CONTROLLER

    struct EventControllerTest <: Widget
        area::Separator
    end
    mousetrap.get_top_level_widget(x::EventControllerTest) = x.area

    function (this::EventControllerTest)()
        area = this.area

        let controller = FocusEventController() 
            @testset "FocusEventController" begin
                connect_signal_focus_gained!(controller) do self::FocusEventController
                end
                @test get_signal_focus_gained_blocked(controller) == false

                connect_signal_focus_lost!(controller) do self::FocusEventController
                end
                @test get_signal_focus_lost_blocked(controller) == false

                add_controller!(area, controller)
            end
        end

        let controller = KeyEventController()
            @testset "KeyEventController" begin
                connect_signal_key_pressed!(controller) do self::KeyEventController, key::KeyCode, modifier::ModifierState
                end
                @test get_signal_key_pressed_blocked(controller) == false

                connect_signal_key_released!(controller) do self::KeyEventController, key::KeyCode, modifier::ModifierState
                end
                @test get_signal_key_released_blocked(controller) == false

                connect_signal_modifiers_changed!(controller) do self::KeyEventController, key::KeyCode, modifier::ModifierState
                end
                @test get_signal_modifiers_changed_blocked(controller) == false
            end
        end

        let controller = ShortcutEventController()

        end
    end

### MAIN

function add_page!(grid::Grid, title::String, page::T, x::Integer = 1, y::Integer = 1) where T <: Widget

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
        
    add_page!(grid, "Action", ActionTest())
    add_page!(grid, "Adjustment", AdjustmentTest())
    add_page!(grid, "AlertDialog", AlertDialogTest())
    add_page!(grid, "Application", ApplicationTest())
    add_page!(grid, "Angle", AngleTest())
    add_page!(grid, "AspectFrame", AspectFrameTest())
    add_page!(grid, "Button", ButtonTest())
    add_page!(grid, "Box", BoxTest())
    add_page!(grid, "CenterBox", CenterBoxTest())
    add_page!(grid, "CheckButton", CheckButtonTest())


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
