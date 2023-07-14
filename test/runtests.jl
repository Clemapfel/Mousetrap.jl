#
# Author: C. Cords (mail@clemens-cords.com)
# https://github.com/clemapfel/mousetrap.jl
#
# Copyright © 2023, Licensed under lGPL3-0
#

using Test
using mousetrap

### GLOBALS

const app = Ref{Union{Application, Nothing}}(nothing)

### MAIN

const Container = Stack
function add_page!(container::Container, title::String, x::Widget)
    add_child!(container, title, x)
end

main("mousetrap.runtests.jl") do app::Application

    Main.app[] = app
    window = Window(app)

    container = Container()
    viewport = Viewport()
    set_child!(viewport, container)
    set_child!(window, viewport)

    connect_signal_realize!(container) do self::Container
        test_action(self)
        test_adjustment(self)
        test_application(self)
        test_alert_dialog(self)
        test_angle(self)
        test_aspect_frame(self)
        test_button(self)
        test_box(self)
        test_center_box(self)
        test_check_button(self)
        test_event_controller(self)
        test_clipboard(self)
        test_time(self)
        test_color_chooser(self)
        test_column_view(self)
        test_drop_down(self)
        test_entry(self)
        test_expander(self)
        test_file_chooser(self)

        return nothing
    end

    present!(window)
end

### 

function test_action(::Container)
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

function test_adjustment(::Container)
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

function test_application(::Container)
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

function test_alert_dialog(::Container)
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

function test_angle(::Container)
    @testset "Angle" begin
        @test isapprox(as_degrees(radians(as_radians(degrees(90)))), 90.0)
    end
end

function test_aspect_frame(::Container)
    @testset "AspectFrame" begin

        aspect_frame = this.aspect_frame

        @test get_child_x_alignment(aspect_frame) == 0.5
        set_child_x_alignment!(aspect_frame, 0.0)
        @test get_child_x_alignment(aspect_frame) == 0.0

        @test get_child_y_alignment(aspect_frame) == 0.5
        set_child_y_alignment!(aspect_frame, 0.0)
        @test get_child_y_alignment(aspect_frame) == 0.0

        @test get_ratio(aspect_frame) == aspect_frame_test_ratio
        set_ratio!(aspect_frame, 1.0)
        @test get_ratio(aspect_frame) == 1.0
    end
end

function test_button(::Container)
    @testset "Button" begin
            
        button = this.button
        Base.show(devnull, button)
        
        set_child!(button, Label("Button"))
        set_icon!(button, icon[])

        @test get_has_frame(button)
        set_has_frame!(button, false)
        @test !get_has_frame(button)

        @test !get_is_circular(button)
        set_is_circular!(button, true)
        @test get_is_circular(button)

        activate_called = Ref{Bool}(false)
        connect_signal_activate!(button, activate_called) do ::Button, activate_called
           activate_called[] = true
        end

        clicked_called = Ref{Bool}(false)
        connect_signal_clicked!(button) do ::Button
            clicked_called[] = true
        end

        activate!(button)
        emit_signal_clicked!(button)
        @test activate_called[] == true
        @test clicked_called[] == true
    end
end

function test_box(::Container)
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

function test_center_box(::Container)
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

function test_check_button(::Container)
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

function test_event_controller(::Container)

    area = this.area
    let controller = ClickEventController()
        @testset "ClickEventController" begin
            connect_signal_click_pressed!(controller) do self::ClickEventController, n_presses::Integer, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_click_pressed_blocked(controller) == false

            connect_signal_click_released!(controller) do self::ClickEventController, n_presses::Integer, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_click_released_blocked(controller) == false

            connect_signal_click_stopped!(controller) do self::ClickEventController
            end
            @test get_signal_click_stopped_blocked(controller) == false
        end
        add_controller!(area, controller)
    end

    let controller = DragEventController()
        @testset "DragEventController" begin
            connect_signal_drag_begin!(controller) do self::DragEventController, start_x::AbstractFloat, start_y::AbstractFloat
            end
            @test get_signal_drag_begin_blocked(controller) == false

            connect_signal_drag!(controller) do self::DragEventController, x_offset::AbstractFloat, y_offset::AbstractFloat
            end
            @test get_signal_drag_blocked(controller) == false

            connect_signal_drag_end!(controller) do self::DragEventController, x_offset::AbstractFloat, y_offset::AbstractFloat
            end
            @test get_signal_drag_end_blocked(controller) == false
        end 
        add_controller!(area, controller)
    end

    let controller = FocusEventController() 
        @testset "FocusEventController" begin
            connect_signal_focus_gained!(controller) do self::FocusEventController
            end
            @test get_signal_focus_gained_blocked(controller) == false

            connect_signal_focus_lost!(controller) do self::FocusEventController
            end
            @test get_signal_focus_lost_blocked(controller) == false
        end
        add_controller!(area, controller)
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
        add_controller!(area, controller)
    end

    let controller = LongPressEventController()
        @testset "LongPressEventController" begin
            connect_signal_pressed!(controller) do self::LongPressEventController, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_pressed_blocked(controller) == false

            connect_signal_press_cancelled!(controller) do self::LongPressEventController
            end
            @test get_signal_pess_cancelled_blocked(controller) == false
        end
        add_controller!(area, controller)
    end

    let controller = MotionEventController()
        @testset "MotionEventController" begin
            connect_signal_motion!(controller) do self::MotionEventController, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_motion_blocked(controller) == false

            connect_signal_motion_enter!(controller) do self::MotionEventController, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_motion_enter_blocked(controller) == false

            connect_signal_motion_leave!(controller) do self::MotionEventController
            end
            @test get_signal_motion_leave_blocked(controller) == false
        end
        add_controller!(area, controller)
    end

    let controller = PanEventController(ORIENTATION_HORIZONTAL)
        @testset "PanEventController" begin
            connect_signal_pan!(controller) do self::PanEventController, direction::PanDirection, offset::AbstractFloat
            end
            @test get_signal_pan_blocked(controller) == false

            @test get_orientation(controller) == ORIENTATION_HORIZONTAL
            set_orientation!(controller, ORIENTATION_VERTICAL)
            @test get_orientation(controller) == ORIENTATION_VERTICAL
        end
        add_controller!(area, controller)
    end

    let controller = PinchZoomEventController()
        @testset "PinchZoomController" begin
            connect_signal_scale_changed!(controller) do self::PinchZoomEventController, scale::AbstractFloat
            end
            @test get_signal_scale_changed_blocked(controller) == false                
        end
        add_controller!(area, controller)
    end

    let controller = RotateEventController()
        @testset "RotateEventController" begin
            connect_signal_rotation_changed!(controller) do self::RotateEventController, angle_absolute::AbstractFloat, angle_delta::AbstractFloat
            end
            @test get_signal_rotation_changed_blocked(controller) == false
        end
        add_controller!(area, controller)

    end

    let controller = ScrollEventController()
        @testset "ScrollEventController" begin
            connect_signal_scroll_begin!(controller) do self::ScrollEventController
            end
            @test get_signal_scroll_begin_blocked(controller) == false

            connect_signal_scroll!(controller) do self::ScrollEventController, x_delta::AbstractFloat, y_delta::AbstractFloat
                return true
            end
            @test get_signal_scroll_blocked(controller) == false

            connect_signal_scroll_end!(controller) do self::ScrollEventController
            end
            @test get_signal_scroll_end_blocked(controller) == false

            connect_signal_kinetic_scroll_decelerate!(controller) do self::ScrollEventController, x_velocity::AbstractFloat, y_velocity::AbstractFloat
            end
            @test get_signal_kinetic_scroll_decelerate_blocked(controller) == false
        end
        add_controller!(area, controller)
    end

    let controller = ShortcutEventController()
        @testset "ShortcutEventController" begin
            @test get_scope(controller) == SHORTCUT_SCOPE_LOCAL
            set_scope!(controller, SHORTCUT_SCOPE_GLOBAL)
            @test get_scope(controller) == SHORTCUT_SCOPE_GLOBAL

            add_action!(controller, test_action)
            remove_action!(controller, test_action)
        end
        add_controller!(area, controller)
    end

    let controller = StylusEventController()
        @testset "StylusEventController" begin
            connect_signal_stylus_up!(controller) do self::StylusEventController, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_stylus_up_blocked(controller) == false

            connect_signal_stylus_down!(controller) do self::StylusEventController, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_stylus_down_blocked(controller) == false

            connect_signal_proximity!(controller) do self::StylusEventController, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_proximity_blocked(controller) == false

            connect_signal_motion!(controller) do self::StylusEventController, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_motion_blocked(controller) == false

            @test get_axis_value(controller, DEVICE_AXIS_X) isa Float64
            @test get_hardware_id(controller) isa Csize_t
            @test get_tool_type(controller) isa ToolType
            @test has_axis(controller, DEVICE_AXIS_Y) isa Bool 
        end
        add_controller!(area, controller)
    end

    let controller = SwipeEventController()
        @testset "SwipeEventController" begin
            connect_signal_swipe!(controller) do self::SwipeEventController, x_velocity::AbstractFloat, y_velocity::AbstractFloat
            end
            @test get_signal_swipe_blocked(controller) == false
        end
        add_controller!(area, controller)
    end

    let controller = ClickEventController()
        
        @testset "SingleClickGesture" begin
            @test get_current_button(controller) isa ButtonID
            @test get_only_listens_to_button(controller) == BUTTON_ID_ANY
            set_only_listens_to_button!(controller, BUTTON_ID_NONE)
            @test get_only_listens_to_button(controller) == BUTTON_ID_NONE

            @test get_touch_only(controller) == false
            set_touch_only!(controller, true)
            @test get_touch_only(controller) == true
        end

        @testset "EventController" begin
            @test get_propagation_phase(controller) != PROPAGATION_PHASE_NONE
            set_propagation_phase!(controller, PROPAGATION_PHASE_NONE)
            @test get_propagation_phase(controller) == PROPAGATION_PHASE_NONE
        end
    end
end

function test_clipboard(::Container)
    @testset "Clipboard" begin
        clipboard = get_clipboard(main_window[])

        set_string!(clipboard, "test")
        @test get_is_local(clipboard) == true

        string_read = Ref{Bool}(false)
        get_string!(clipboard, string_read) do self::Clipboard, value::String, string_read
            if value == "test"
                string_read[] = true
            end
        end
        sleep(0.1)
        @test string_read[] == true

        set_image!(clipboard, Image(1, 1, RGBA(1, 0, 0, 1)))
        @test get_is_local(clipboard) == true

        image_read = Ref{Bool}(false)
        get_image!(clipboard, image_read) do self::Clipboard, value::Image, image_read
            if get_pixel(image, 1, 1) == RGBA(1, 0, 0, 1)
                image_read[] = true
            end
        end
        sleep(0.1)
        @test image_read[] == true
    end
end

function test_time(::Container)
    @testset "Time" begin
        value = 1234
        @test as_minutes(minutes(value)) == value
        @test as_seconds(seconds(value)) == value
        @test as_milliseconds(milliseconds(value)) == value
        @test as_microseconds(microseconds(value)) == value
        @test as_nanoseconds(nanoseconds(value)) == value
    end

    @testset "Clock" begin
        clock = Clock()
        sleep(0.1)
        @test as_seconds(elapsed(clock)) > 0.0
        @test as_seconds(restart!(clock)) > 0.0
    end
end

function test_color_chooser(::Container)
    @testset "ColorChooser" begin
        color_chooser = ColorChooser()
        on_accept!(color_chooser) do self::ColorChooser, color::RGBA
        end
        on_cancel!(color_chooser) do self::ColorChooser
        end

        @test get_color(color_chooser) isa Color
        @test get_is_modal(color_chooser) == false
        set_modal!(color_chooser, true)
        @test get_is_modal(color_chooser) == true
    end
end

function test_column_view(::Container)
    @testset "ColumnViewTest" begin
        column_view = this.column_view
        push_back_column!(column_view, "column 01")
        push_front_column!(column_view, "column 03")

        column_name = "column 02"
        column = insert_column!(column_view, column_name)

        @test get_title(column) == column_name

        new_title = "new title"
        set_title!(column, new_title)
        @test get_title(column) == new_title

        @test get_fixed_width(column) isa Float32
        set_fixed_width(column, 100)
        @test get_fixed_width(column) == 100

        model = MenuModel()
        set_header_menu!(column, model)

        @test get_is_visible(column) == true
        set_is_visible!(column, false)
        @test get_is_visible(column) == false

        set_is_resizable!(column, true)
        @test get_is_resizable(column) == true

        remove_column!(column_view, get_column_at(column_view, 0))

        @test has_column_with_title(column_view, new_title) == true
        other_column = get_column_with_title(column_view, new_title)
        @test get_title(other_column) == new_title
    end
end

function test_drop_down(::Container)
    @testset "DropDown" begin
        drop_down = this.drop_down

        label = "Label";
        id_02 = push_back!(drop_down, label, label) do self::DropDown
        end

        @test get_item_it(drop_down, 1) == id_02

        id_01 = push_front!(drop_down, label, label) do self::DropDown
        end

        id_03 = insert!(drop_down, 1, label, label) do self::DropDown
        end

        remove!(drop_down, id_03)

        set_selected!(drop_down, id_01)
        @test get_selected(drop_down) == id_01

        @test get_always_show_arrow(drop_down) == true
        set_always_show_arrow(drop_down, false)
        @test get_always_show_arrow(drop_down) == false
    end
end

function test_entry(::Container)
    @testset "Entry" begin
        entry = this.entry

        activate_called = Ref{Bool}(false)
        connect_signal_activate!(entry, activate_called) do entry::Entry, activate_called
            activate_called[] = true
        end

        text_changed_called = Ref{Bool}(false)
        connect_signal_text_changed!(entry, text_changed_called) do entry::Entry, text_changed_called
            text_changed_called[] = true
        end

        @test get_has_frame(entry) == true
        set_has_frame!(entry, false)
        @test get_has_frame(entity) == false

        @test get_max_width_chars(entry) == 1
        set_max_width_chars!(entry, 64)
        @test get_max_width_chars(entry) == 64

        @test get_text(entry) == ""
        set_text(entry, "text")
        @test get_text(entry) == "text"
        
        @test get_text_visible(entry) == true
        set_text_visible(entry, false)
        @test get_text_visible(entry) == false

        set_primary_icon!(entry, Main.icon[])
        set_secondary_icon!(entry, Main.icon[])
        remove_primary_icon!(entry)
        remove_secondary_icon!(entry)

        activate!(entry)

        @test activate_called[] == true
        @test text_changed_called[] == true
    end
end

function test_expander(::Container)
    @testset "Expander" begin
        expander = this.expander

        activate_called = Ref{Bool}(false)
        connect_signal_activate!(expander, activate_called) do self::Expander, activate_called
            activate_called[] = true
        end

        activate!(expander)
        @test activate_called[] == true

        set_child!(expander, Separator())
        set_label_widget!(expander, Separator())

        set_is_expanded!(expander, true)
        @test get_is_expanded(expander) == true

        remove_child!(expander)
        remove_label_widget!(expander)
    end
end

function test_file_chooser(::Container)
    @testset "FileFilter" begin
        filter = FileFilter("test")
        add_allow_all_supported_image_formats!(filter)
        add_allowed_mime_type!(filter, "text/plain")
        add_allowed_pattern!(filter, "*.jl")
        add_allowed_suffix!(filter, "jl")

        @test get_name(filter) == "test"
    end

    @testset "FileChooser" begin
        file_chooser = FileChooser(FILE_CHOOSER_ACTION_SAVE)
        add_filter!(file_chooser, filter)
        set_initial_filter!(file_chooser, filter)
        set_initial_file!(file_chooser, FileDescriptor("."))
        set_initial_folder!(file_chooser, FileDescriptor("."))
        set_initial_name!(file_chooser, "name");

        set_accept_label!(file_chooser, "accept")
        @test get_accept_label(file_chooser) = "accept"

        @test get_is_modal(file_chooser) == true
        set_is_modal!(file_chooser, false)
        @test get_is_modal(file_chooser) == false

        on_accept!(file_chooser) do x::FileChooser, files::Vector{FileDescriptor}
        end

        on_cancel!(file_chooser) do x::FileChooser
        end

        present!(file_chooser)
        cancel!(file_chooser)
    end
end

