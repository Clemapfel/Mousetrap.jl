#
# Author: C. Cords (mail@clemens-cords.com)
# https://github.com/clemapfel/mousetrap.jl
#
# Copyright © 2023, Licensed under lGPL3-0
#

using Test
using mousetrap

### GLOBALS

app_id = "mousetrap.runtests.jl"
app = Ref{Union{Application, Nothing}}(nothing)
window = Ref{Union{Window, Nothing}}(nothing)
icon = Ref{Union{Icon, Nothing}}(nothing)

### MAIN

Container = Stack
function add_page!(container::Container, title::String, x::Widget)
    add_child!(container, title, x)
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

### ADJUSTMENT

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
        @test get_id(app) == Main.app_id

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
        detailed_message = "detailed message"
        alert_dialog = AlertDialog(["01", "02"], message, detailed_message)
        Base.show(devnull, alert_dialog)
        
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

        aspect_frame = AspectFrame(1.0)
        Base.show(devnull, aspect_frame)
        @test mousetrap.is_native_widget(aspect_frame)

        @test get_child_x_alignment(aspect_frame) == 0.5
        @test get_child_y_alignment(aspect_frame) == 0.5

        set_child_x_alignment!(aspect_frame, 1.0)
        set_child_y_alignment!(aspect_frame, 1.0)

        @test get_child_x_alignment(aspect_frame) == 1.0
        @test get_child_y_alignment(aspect_frame) == 1.0

        @test get_ratio(aspect_frame) == 1.0
        set_ratio!(aspect_frame, 1.5)
        @test get_ratio(aspect_frame) == 1.5
    end
end

function test_button(::Container)
    @testset "Button" begin
            
        button = Button()
        Base.show(devnull, button)
        @test mousetrap.is_native_widget(button)
        
        set_child!(button, Label("Button"))
        
        @test get_has_frame(button)
        set_has_frame!(button, false)
        @test !get_has_frame(button)

        @test get_is_circular(button) == false
        set_is_circular!(button, true)
        @test get_is_circular(button) == true

        clicked_called = Ref{Bool}(false)
        connect_signal_clicked!(button) do ::Button
            clicked_called[] = true
            return nothing
        end

        activate!(button)
        emit_signal_clicked(button)
        @test clicked_called[] == true
    end
end

function test_box(::Container)
    @testset "Box" begin
        box = Box(ORIENTATION_HORIZONTAL)
        Base.show(devnull, box)
        @test mousetrap.is_native_widget(box)

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
        center_box = CenterBox(ORIENTATION_HORIZONTAL)
        Base.show(devnull, center_box)
        @test mousetrap.is_native_widget(center_box)

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
        check_button = CheckButton()
        Base.show(devnull, check_button)
        @test mousetrap.is_native_widget(check_button)

        toggled_called = Ref{Bool}(false)
        connect_signal_toggled!(check_button, toggled_called) do _, toggled_called
            toggled_called[] = true
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

function test_event_controller(this::Container)

    area = this

    function test_single_click_gesture(controller)
        
    end

    function test_event_controller(controller)
        @test get_propagation_phase(controller) != PROPAGATION_PHASE_NONE
        set_propagation_phase!(controller, PROPAGATION_PHASE_NONE)
        @test get_propagation_phase(controller) == PROPAGATION_PHASE_NONE

        if controller isa SingleClickGesture
            @test get_current_button(controller) isa ButtonID
            set_only_listens_to_button!(controller, BUTTON_ID_NONE)
            @test get_only_listens_to_button(controller) == BUTTON_ID_NONE

            @test get_touch_only(controller) == false
            set_touch_only!(controller, true)
            @test get_touch_only(controller) == true
        end
    end

    let controller = ClickEventController()
        Base.show(devnull, controller)
        @testset "ClickEventController" begin
            
            test_event_controller(controller)

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
        Base.show(devnull, controller)
        @testset "DragEventController" begin

            test_event_controller(controller)

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
        Base.show(devnull, controller)
        @testset "FocusEventController" begin

            test_event_controller(controller)

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
        Base.show(devnull, controller)
        @testset "KeyEventController" begin

            test_event_controller(controller)

            connect_signal_key_pressed!(controller) do self::KeyEventController, key::KeyCode, modifier::ModifierState
            end
            @test get_signal_key_pressed_blocked(controller) == false

            connect_signal_key_released!(controller) do self::KeyEventController, key::KeyCode, modifier::ModifierState
            end
            @test get_signal_key_released_blocked(controller) == false

            connect_signal_modifiers_changed!(controller) do self::KeyEventController, modifier::ModifierState
            end
            @test get_signal_modifiers_changed_blocked(controller) == false
        end
        add_controller!(area, controller)
    end

    let controller = LongPressEventController()
        Base.show(devnull, controller)
        @testset "LongPressEventController" begin

            test_event_controller(controller)

            connect_signal_pressed!(controller) do self::LongPressEventController, x::AbstractFloat, y::AbstractFloat
            end
            @test get_signal_pressed_blocked(controller) == false

            connect_signal_press_cancelled!(controller) do self::LongPressEventController
            end
            @test get_signal_press_cancelled_blocked(controller) == false
        end
        add_controller!(area, controller)
    end

    let controller = MotionEventController()
        Base.show(devnull, controller)
        @testset "MotionEventController" begin

            test_event_controller(controller)

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
        Base.show(devnull, controller)
        @testset "PanEventController" begin
            
            test_event_controller(controller)

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
        Base.show(devnull, controller)
        @testset "PinchZoomController" begin
            
            test_event_controller(controller)

            connect_signal_scale_changed!(controller) do self::PinchZoomEventController, scale::AbstractFloat
            end
            @test get_signal_scale_changed_blocked(controller) == false                
        end
        add_controller!(area, controller)
    end

    let controller = RotateEventController()
        Base.show(devnull, controller)
        @testset "RotateEventController" begin
            
            test_event_controller(controller)

            connect_signal_rotation_changed!(controller) do self::RotateEventController, angle_absolute::AbstractFloat, angle_delta::AbstractFloat
            end
            @test get_signal_rotation_changed_blocked(controller) == false
        end
        add_controller!(area, controller)

    end

    let controller = ScrollEventController(false)
        Base.show(devnull, controller)
        @testset "ScrollEventController" begin

            test_event_controller(controller)
            
            @test get_kinetic_scrolling_enabled(controller) == false
            set_kinetic_scrolling_enabled!(controller, true)
            @test get_kinetic_scrolling_enabled(controller) == true

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
        Base.show(devnull, controller)
        @testset "ShortcutEventController" begin
            
            test_event_controller(controller)

            @test get_scope(controller) == SHORTCUT_SCOPE_LOCAL
            set_scope!(controller, SHORTCUT_SCOPE_GLOBAL)
            @test get_scope(controller) == SHORTCUT_SCOPE_GLOBAL

            action = Action("test.action", Main.app[]) do self end
            add_action!(controller, action)
            remove_action!(controller, action)
        end
        add_controller!(area, controller)
    end

    let controller = StylusEventController()
        Base.show(devnull, controller)
        @testset "StylusEventController" begin
            
            test_event_controller(controller)

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

            @test get_hardware_id(controller) isa Csize_t
            @test get_tool_type(controller) isa ToolType
            @test has_axis(controller, DEVICE_AXIS_Y) isa Bool 
        end
        add_controller!(area, controller)
    end

    let controller = SwipeEventController()
        Base.show(devnull, controller)
        @testset "SwipeEventController" begin
            
            test_event_controller(controller)
            
            connect_signal_swipe!(controller) do self::SwipeEventController, x_velocity::AbstractFloat, y_velocity::AbstractFloat
            end
            @test get_signal_swipe_blocked(controller) == false
        end
        add_controller!(area, controller)
    end
end

function test_clipboard(::Container)
    @testset "Clipboard" begin
        clipboard = get_clipboard(Main.window[])
        Base.show(devnull, clipboard)

        set_string!(clipboard, "test")
        @test contains_string(clipboard) == true
        @test get_is_local(clipboard) == true

        get_string(clipboard) do self::Clipboard, value::String
            @test true
            return nothing
        end

        set_file!(clipboard, FileDescriptor("."))
        @test contains_file(clipboard) == true
        @test get_is_local(clipboard) == true

        get_string(clipboard) do self::Clipboard, value::String
            @test true
            return nothing
        end
        
        set_image!(clipboard, Image(1, 1, RGBA(1, 0, 0, 1)))
        @test contains_image(clipboard) == true
        @test get_is_local(clipboard) == true

        get_image(clipboard) do self::Clipboard, value::Image
            @test true
            return nothing
        end
    end
end

function test_clamp_frame(::Container)
    @testset "ClampFrame" begin
        frame = ClampFrame(150)
        Base.show(devnull, frame)

        set_child!(frame, Separator())
        remove_child!(frame)

        @test get_orientation(frame) == ORIENTATION_HORIZONTAL
        set_orientation!(frame, ORIENTATION_VERTICAL)
        @test get_orientation(frame) == ORIENTATION_VERTICAL

        @test get_maximum_size(frame) == 150
        set_maximum_size!(frame, 50)
        @test get_maximum_size(frame) == 50
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

        Base.show(devnull, milliseconds(1234))
    end

    @testset "Clock" begin
        clock = Clock()
        sleep(0.1)
        @test as_seconds(elapsed(clock)) > 0.0
        @test as_seconds(restart!(clock)) > 0.0

        Base.show(devnull, clock)
    end
end

function test_color_chooser(::Container)
    @testset "ColorChooser" begin
        color_chooser = ColorChooser()
        Base.show(devnull, color_chooser)

        on_accept!(color_chooser) do self::ColorChooser, color::RGBA
        end

        on_cancel!(color_chooser) do self::ColorChooser
        end

        @test get_color(color_chooser) isa RGBA
        @test get_is_modal(color_chooser) == true
        set_is_modal!(color_chooser, false)
        @test get_is_modal(color_chooser) == false
    end
end

function test_column_view(::Container)
    @testset "ColumnViewTest" begin
        column_view = ColumnView()
        Base.show(devnull, column_view)
        @test mousetrap.is_native_widget(column_view)

        push_back_column!(column_view, "column 01")
        push_front_column!(column_view, "column 03")

        column_name = "column 02"
        column = insert_column!(column_view, 1, column_name)

        @test get_title(column) == column_name

        new_title = "new title"
        set_title!(column, new_title)
        @test get_title(column) == new_title

        @test get_fixed_width(column) isa Float32
        set_fixed_width!(column, 100)
        @test get_fixed_width(column) == 100

        model = MenuModel()
        set_header_menu!(column, model)

        @test get_is_visible(column) == true
        set_is_visible!(column, false)
        @test get_is_visible(column) == false

        set_is_resizable!(column, true)
        @test get_is_resizable(column) == true

        @test has_column_with_title(column_view, new_title) == true
        other_column = get_column_with_title(column_view, new_title)
        @test get_title(other_column) == new_title

        remove_column!(column_view, get_column_at(column_view, 1))
    end
end

function test_drop_down(::Container)
    @testset "DropDown" begin
        drop_down = DropDown()
        Base.show(devnull, drop_down)
        @test mousetrap.is_native_widget(drop_down)

        label = "Label";
        id_02 = push_back!(drop_down, label, label) do self::DropDown
        end

        @test get_item_at(drop_down, 1) == id_02

        id_01 = push_front!(drop_down, label, label) do self::DropDown
        end

        id_03 = insert_at!(drop_down, 1, label) do self::DropDown
        end

        remove!(drop_down, id_03)

        set_selected!(drop_down, id_01)
        @test get_selected(drop_down) == id_01

        @test get_always_show_arrow(drop_down) == true
        set_always_show_arrow!(drop_down, false)
        @test get_always_show_arrow(drop_down) == false
    end
end

function test_entry(::Container)
    @testset "Entry" begin
        entry = Entry()
        Base.show(devnull, entry)
        @test mousetrap.is_native_widget(entry)

        activate_called = Ref{Bool}(false)
        connect_signal_activate!(entry, activate_called) do entry::Entry, activate_called
            activate_called[] = true
            return nothing
        end

        text_changed_called = Ref{Bool}(false)
        connect_signal_text_changed!(entry, text_changed_called) do entry::Entry, text_changed_called
            text_changed_called[] = true
            return nothing
        end

        @test get_has_frame(entry) == true
        set_has_frame!(entry, false)
        @test get_has_frame(entry) == false

        @test get_max_width_chars(entry) == 0
        set_max_width_chars!(entry, 64)
        @test get_max_width_chars(entry) == 64

        @test get_text(entry) == ""
        set_text!(entry, "text")
        @test get_text(entry) == "text"
        
        @test get_text_visible(entry) == true
        set_text_visible!(entry, false)
        @test get_text_visible(entry) == false

        set_primary_icon!(entry, Main.icon[])
        set_secondary_icon!(entry, Main.icon[])
        remove_primary_icon!(entry)
        remove_secondary_icon!(entry)

        # TODO: activate! does not cause `activate` signal to be emitted, see gtk_widget_set_activate_signal
        emit_signal_activate(entry)

        @test activate_called[] == true
        @test text_changed_called[] == true
    end
end

function test_expander(::Container)
    @testset "Expander" begin
        expander = Expander()
        Base.show(devnull, expander)
        @test mousetrap.is_native_widget(expander)

        activate_called = Ref{Bool}(false)
        connect_signal_activate!(expander, activate_called) do self::Expander, activate_called
            activate_called[] = true
            return nothing
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

    filter = FileFilter("test")
    @testset "FileFilter" begin
        Base.show(devnull, filter)
        add_allow_all_supported_image_formats!(filter)
        add_allowed_mime_type!(filter, "text/plain")
        add_allowed_pattern!(filter, "*.jl")
        add_allowed_suffix!(filter, "jl")

        @test get_name(filter) == "test"
    end

    @testset "FileChooser" begin
        file_chooser = FileChooser(FILE_CHOOSER_ACTION_SAVE)
        Base.show(devnull, file_chooser)

        add_filter!(file_chooser, filter)
        set_initial_filter!(file_chooser, filter)
        set_initial_file!(file_chooser, FileDescriptor("."))
        set_initial_folder!(file_chooser, FileDescriptor("."))
        set_initial_name!(file_chooser, "name");

        set_accept_label!(file_chooser, "accept")
        @test get_accept_label(file_chooser) == "accept"

        @test get_is_modal(file_chooser) == true
        set_is_modal!(file_chooser, false)
        @test get_is_modal(file_chooser) == false

        on_accept!(file_chooser) do x::FileChooser, files::Vector{FileDescriptor}
        end

        on_cancel!(file_chooser) do x::FileChooser
        end

        #present!(file_chooser)
        cancel!(file_chooser)
    end
end

function test_file_descriptor(::Container)
    @testset "FileDescriptor" begin
           
        name = tempname()
        path = name * ".txt"
        file = open(path, "w+")
        write(file, "test\n")
        close(file)

        descriptor = FileDescriptor(".")
        Base.show(devnull, descriptor)

        create_from_path!(descriptor, path)
        @test exists(descriptor)

        @test get_name(descriptor)[end-3:end] == ".txt"
        @test get_path(descriptor) == path
        @test get_uri(descriptor) isa String

        @test get_path_relative_to(descriptor, descriptor) == ""
        @test exists(get_parent(descriptor))
        
        @test is_file(descriptor) == true
        @test is_folder(descriptor) == false
        @test is_symlink(descriptor) == false

        # todo read_symlink

        @test is_executable(descriptor) == false
        @test get_content_type(descriptor) isa String # type is OS-specific
        @test query_info(descriptor, "standard::name") == get_name(descriptor)

        monitor = create_monitor(descriptor)
        on_file_changed!(monitor) do ::FileMonitor, ::FileMonitorEvent, ::FileDescriptor, ::FileDescriptor
        end
        cancel!(monitor)
        @test is_cancelled(monitor)

        gtk_file = FileDescriptor(tempname() * ".txt")
        create_file_at!(gtk_file)
        delete_at!(gtk_file)
        create_directory_at!(gtk_file)
        #move_to_trash!(gtk_file)
        # silenced because /tmp files can't be moved to the trash

        close(file)
    end
end

function test_fixed(::Container)
    @testset "Fixed" begin
        fixed = Fixed()
        Base.show(devnull, fixed)
        @test mousetrap.is_native_widget(fixed)

        child = Label("(32, 32)")

        add_child!(fixed, child, Vector2f(32, 32))
        #@test get_child_position(fixed, child) == Vector2f(32, 32)
        set_child_position!(fixed, child, Vector2f(64, 64))
        #@test get_child_position(fixed, child) == Vector2f(64, 64)

        # position is (0, 0) until fixed is realized

        remove_child!(fixed, child)
    end
end

function test_frame(::Container)
    @testset "Frame" begin

        frame = Frame()
        Base.show(devnull, frame)
        @test mousetrap.is_native_widget(frame)

        set_child!(frame, Separator())
        @test get_label_x_alignment(frame) == 0.0
        set_label_x_alignment!(frame, 0.5)
        @test get_label_x_alignment(frame) == 0.5

        set_child!(frame, Separator())
        set_label_widget!(frame, Label())
        remove_child!(frame)
        remove_label_widget!(frame)
    end
end

function test_gl_transform(::Container)
    @testset "GLTransform" begin

        if !mousetrap.MOUSETRAP_ENABLE_OPENGL_COMPONENT
            return 
        end    

        transform = GLTransform()
        Base.show(devnull, transform)

        rotate!(transform, degrees(90))
        scale!(transform, 1.5, 1.5)
        translate!(transform, Vector2f(0.5, 0.5))

        new_transform = combine_with(transform, GLTransform())
        for x in 1:3
            for y in 1:3
                @test transform[x, y] == new_transform[x, y]
            end
        end

        reset!(new_transform)
    end
end

function test_grid(::Container)
    @testset "Grid" begin
        grid = Grid()
        Base.show(devnull, grid)
        @test mousetrap.is_native_widget(grid)

        @test get_column_spacing(grid) == 0.0
        set_column_spacing!(grid, 2.0)
        @test get_column_spacing(grid) == 2.0

        @test get_row_spacing(grid) == 0.0
        set_row_spacing!(grid, 2.0)
        @test get_row_spacing(grid) == 2.0

        @test get_orientation(grid) == ORIENTATION_HORIZONTAL
        set_orientation!(grid, ORIENTATION_VERTICAL)
        @test get_orientation(grid) == ORIENTATION_VERTICAL

        @test get_rows_homogeneous(grid) == false
        set_rows_homogeneous!(grid, true)
        @test get_rows_homogeneous(grid) == true

        @test get_columns_homogeneous(grid) == false
        set_columns_homogeneous!(grid, true)
        @test get_columns_homogeneous(grid) == true

        widget_01 = Separator()
        widget_02 = Separator()

        insert_at!(grid, widget_01, 1, 2, 3, 4)
        #insert_next_to!(grid, widget_02, widget_01, RELATIVE_POSITION_RIGHT_OF, 3, 4)

        @test get_position(grid, widget_01) == Vector2i(1, 2)
        @test get_size(grid, widget_01) == Vector2i(3, 4)
        @test get_size(grid, widget_02) == Vector2i(3, 4)

        insert_row_at!(grid, 1)
        insert_column_at!(grid, 1)
        remove_row_at!(grid, 1)
        remove_column_at!(grid, 1)
    end
end

### GRID_VIEW

function test_grid_view(::Container)
    @testset "GridView" begin
        grid_view = GridView(ORIENTATION_HORIZONTAL,SELECTION_MODE_MULTIPLE)
        Base.show(devnull, grid_view)
        @test mousetrap.is_native_widget(grid_view)

        @test get_orientation(grid_view) == ORIENTATION_HORIZONTAL
        set_orientation!(grid_view, ORIENTATION_VERTICAL)
        @test get_orientation(grid_view) == ORIENTATION_VERTICAL

        @test get_max_n_columns(grid_view) > 0
        set_max_n_columns!(grid_view, 3)
        @test get_max_n_columns(grid_view) == 3
        
        @test get_min_n_columns(grid_view) > 0
        set_min_n_columns!(grid_view, 3)
        @test get_min_n_columns(grid_view) == 3

        set_enable_rubberband_selection!(grid_view, true)
        @test get_enable_rubberband_selection(grid_view) == true

        @test get_single_click_activate(grid_view) == false
        set_single_click_activate!(grid_view, true)
        @test get_single_click_activate(grid_view) == true

        push_front!(grid_view, Separator())
        push_back!(grid_view, Separator())

        child = Separator()
        insert_at!(grid_view, 1, child)
        @test find(grid_view, child) == 1 
        
        remove!(grid_view, 1)
        @test get_n_items(grid_view) == 2
        @test get_selection_model(grid_view) isa SelectionModel
        
        activate_item_called = Ref{Bool}(false)
        connect_signal_activate_item!(grid_view, activate_item_called) do self::GridView, index, activate_item_called
            activate_item_called[] = true
            return nothing
        end
        
        #@test activate_called[] == true
    end
end

### COLORS

function test_colors(::Container)
    @testset "Colors" begin
        color_rgba = RGBA(1, 0, 1, 1)
        color_hsva = HSVA(1, 0, 1, 1)

        Base.show(devnull, color_rgba)
        Base.show(devnull, color_hsva)
        
        @test color_rgba == hsva_to_rgba(rgba_to_hsva(color_rgba))
        @test color_hsva == rgba_to_hsva(hsva_to_rgba(color_hsva))
    end
end

### HEADER_BAR

function test_header_bar(::Container)
    @testset "HeaderBar" begin

        layout = "close:minimize,maximize"
        header_bar = HeaderBar(layout)
        @test mousetrap.is_native_widget(header_bar)

        Base.show(devnull, header_bar)

        @test get_layout(header_bar) == layout
        set_layout!(header_bar, "")
        @test get_layout(header_bar) == ""
        
        @test get_show_title_buttons(header_bar) == true
        set_show_title_buttons!(header_bar, false)
        @test get_show_title_buttons(header_bar) == false

        widget = Separator()
        push_front!(header_bar, widget)
        push_back!(header_bar, Separator())
        remove!(header_bar, widget)

        set_title_widget!(header_bar, Label("title"))
        remove_title_widget!(header_bar)
    end
end

function test_icon(::Container)

    theme = IconTheme(Main.window[])

    @testset "Icon" begin
        icon_name = get_icon_names(theme)[1]
        icon = Icon(theme, icon_name, 64)
        Base.show(devnull, icon)

        @test get_size(icon).x == 64 && get_size(icon).y == 64
    end 

    @testset "IconTheme" begin

        Base.show(devnull, theme)

        names = get_icon_names(theme)
        @test isempty(names) == false
        @test has_icon(theme, names[1])

        add_resource_path!(theme, ".")
        set_resource_path!(theme, ".")
        
        # TODO: validate resource path
    end
end

### IMAGE

function test_image(::Container)
    @testset "Image" begin
        image = Image(1, 1, RGBA(1, 0, 1, 1))
        Base.show(devnull, image)

        @test get_size(image) == Vector2i(1, 1)
        @test get_n_pixels(image) == 1

        @test get_pixel(image, 1, 1) == RGBA(1, 0, 1, 1)
        set_pixel!(image, 1, 1, RGBA(0, 0, 1, 1))
        @test get_pixel(image, 1, 1) == RGBA(0, 0, 1, 1)

        flipped = as_flipped(image, true, true)
        @test get_size(flipped) == Vector2i(1, 1)
        @test get_size(as_scaled(image, 2, 2, INTERPOLATION_TYPE_HYPERBOLIC)) == Vector2i(2, 2)
        @test get_size(as_cropped(image, 0, 0, 2, 2)) == Vector2i(2, 2)

        save_to_file(image, tempname() * ".png")
    end
end

### IMAGE_DISPLAY

function test_image_display(::Container)
    @testset "ImageDisplay" begin
        image_display = ImageDisplay()
        Base.show(devnull, image_display)
        @test mousetrap.is_native_widget(image_display)

        image = Image(1, 1, RGBA(1, 0, 1, 1))
        create_from_image!(image_display, image)
        @test get_size(image_display) == Vector2i(1, 1)
        clear!(image_display)

        create_from_icon!(image_display, Main.icon[])
        @test get_size(image_display) == Vector2i(64, 64)
        clear!(image_display)
        @test get_size(image_display) == Vector2i(0, 0)
    end
end

### KEY_FILE

function test_key_file(::Container)
    @testset "KeyFile" begin
        file = KeyFile()
        Base.show(devnull, file)

        group_name = "group_01"
        bool_key = "bool"
        float_key = "float"
        integer_key = "integer"
        string_key = "string"

        bool_list_key = "bool_list"
        float_list_key = "float_list"
        integer_list_key = "integer_list"
        color_key = "rgba"
        string_list_key = "string_list"

        group_comment = " group comment"
        key_comment = " key comment"

        create_from_string!(file, """
        #$group_comment
        [$group_name]
        #$key_comment
        $bool_key = true
        $float_key = 1234.0
        $integer_key = 1234
        $string_key = abcd

        $bool_list_key = true;false
        $float_list_key = 1234.0;5678.0
        $integer_list_key = 1234;5678
        $string_list_key = abcd;efgh
        $color_key = 1.0;0.0;1.0;1.0
        """)

        @test get_groups(file) == [group_name]
        @test has_group(file, group_name) == true
        @test isempty(get_keys(file, group_name)) == false
        @test has_key(file, group_name, color_key) == true

        @test get_comment_above(file, group_name) == group_comment
        @test get_comment_above(file, group_name, bool_key) == key_comment

        @test get_value(file, group_name, bool_key, Bool) == true
        @test get_value(file, group_name, float_key, Float32) == 1234.0
        @test get_value(file, group_name, integer_key, Int64) == 1234
        @test get_value(file, group_name, string_key, String) == "abcd"
        @test get_value(file, group_name, color_key, RGBA) == RGBA(1, 0, 1, 1)
        @test get_value(file, group_name, color_key, HSVA) == HSVA(1, 0, 1, 1)
        @test get_value(file, group_name, bool_list_key, Vector{Bool}) == [true, false]
        @test get_value(file, group_name, float_list_key, Vector{Float32}) == Float32[1234.0, 5678.0]
        @test get_value(file, group_name, integer_list_key, Vector{Int64}) == Int64[1234, 5678]
        @test get_value(file, group_name, string_list_key, Vector{String}) == ["abcd", "efgh"]

        set_value!(file, group_name, bool_key, false)
        @test get_value(file, group_name, bool_key, Bool) == false

        set_value!(file, group_name, float_key, Float32(999))
        @test get_value(file, group_name, float_key, Float32) == 999

        set_value!(file, group_name, integer_key, Int64(999))
        @test get_value(file, group_name, integer_key, Int64) == 999

        set_value!(file, group_name, string_key, String("none"))
        @test get_value(file, group_name, string_key, String) == "none"

        set_value!(file, group_name, color_key, RGBA(0, 0, 0, 1))
        @test get_value(file, group_name, color_key, RGBA) == RGBA(0, 0, 0, 1)

        set_value!(file, group_name, bool_list_key, [false, true])
        @test get_value(file, group_name, bool_list_key, Vector{Bool}) == [false, true]

        set_value!(file, group_name, float_list_key, [Float32(1), Float32(2)])
        @test get_value(file, group_name, float_list_key, Vector{Float32}) == Float32[1.0, 2.0]

        set_value!(file, group_name, integer_list_key, [Int64(1), Int64(2)])
        @test get_value(file, group_name, integer_list_key, Vector{Int64}) == Int64[1, 2]

        set_value!(file, group_name, string_list_key, ["none", "nothing"])
        @test get_value(file, group_name, string_list_key, Vector{String}) == ["none", "nothing"]
    end
end

### LABEL

function test_label(::Container)
    @testset "Label" begin
        label_string = "label"
        label = Label(label_string)
        Base.show(devnull, label)
        @test mousetrap.is_native_widget(label)

        @test get_ellipsize_mode(label) == ELLIPSIZE_MODE_NONE
        set_ellipsize_mode!(label, ELLIPSIZE_MODE_MIDDLE)
        @test get_ellipsize_mode(label) == ELLIPSIZE_MODE_MIDDLE

        @test get_justify_mode(label) == JUSTIFY_MODE_LEFT
        set_justify_mode!(label, JUSTIFY_MODE_CENTER)
        @test get_justify_mode(label) == JUSTIFY_MODE_CENTER

        @test get_is_selectable(label) == false
        set_is_selectable!(label, true)
        @test get_is_selectable(label) == true

        @test get_max_width_chars(label) == -1
        set_max_width_chars!(label, 1234)
        @test get_max_width_chars(label) == 1234

        @test get_text(label) == label_string
        set_text!(label, "new")
        @test get_text(label) == "new"

        @test get_use_markup(label) == true
        set_use_markup!(label, false)
        @test get_use_markup(label) == false

        @test get_wrap_mode(label) == LABEL_WRAP_MODE_NONE
        set_wrap_mode!(label, LABEL_WRAP_MODE_WORD_OR_CHAR)
        @test get_wrap_mode(label) == LABEL_WRAP_MODE_WORD_OR_CHAR

        @test get_x_alignment(label) == 0.5
        set_x_alignment!(label, 0.0)
        @test get_x_alignment(label) == 0.0

        @test get_y_alignment(label) == 0.5
        set_y_alignment!(label, 0.0)
        @test get_y_alignment(label) == 0.0
    end
end

### LEVEL_BAR

function test_level_bar(::Container)
    @testset "LevelBar" begin    
        level_bar = LevelBar(0, 1)
        Base.show(devnull, level_bar)
        @test mousetrap.is_native_widget(level_bar)

        @test get_max_value(level_bar) == 1
        set_max_value!(level_bar, 2)
        @test get_max_value(level_bar) == 2

        @test get_min_value(level_bar) == 0
        set_min_value!(level_bar, 1)
        @test get_min_value(level_bar) == 1

        @test get_mode(level_bar) == LEVEL_BAR_MODE_CONTINUOUS
        set_mode!(level_bar, LEVEL_BAR_MODE_DISCRETE)
        @test get_mode(level_bar) == LEVEL_BAR_MODE_DISCRETE

        @test get_orientation(level_bar) == ORIENTATION_HORIZONTAL
        set_orientation!(level_bar, ORIENTATION_VERTICAL)
        @test get_orientation(level_bar) == ORIENTATION_VERTICAL
        
        set_value!(level_bar, 1)
        @test get_value(level_bar) == 1

        marker_label = "marker"
        add_marker!(level_bar, marker_label, 1)
        remove_marker!(level_bar, marker_label)
    end
end

### LIST_VIEW

function test_list_view(::Container)
    @testset "ListView" begin
        list_view = ListView(ORIENTATION_HORIZONTAL, SELECTION_MODE_MULTIPLE)
        Base.show(devnull, list_view)
        @test mousetrap.is_native_widget(list_view)

        @test get_orientation(list_view) == ORIENTATION_HORIZONTAL
        set_orientation!(list_view, ORIENTATION_VERTICAL)
        @test get_orientation(list_view) == ORIENTATION_VERTICAL

        set_enable_rubberband_selection!(list_view, true)
        @test get_enable_rubberband_selection(list_view) == true

        @test get_single_click_activate(list_view) == false
        set_single_click_activate!(list_view, true)
        @test get_single_click_activate(list_view) == true

        @test get_show_separators(list_view) == false
        set_show_separators!(list_view, true)
        @test get_show_separators(list_view) == true

        push_front!(list_view, Separator())
        push_back!(list_view, Separator())

        child = Separator()
        it = insert_at!(list_view, 1, child)
        @test find(list_view, child) == 1

        push_back!(list_view, Separator(), it)
        set_widget_at!(list_view, 1, Separator(), it)

        @test get_n_items(list_view) == 3
        remove!(list_view, 1)
        @test get_n_items(list_view) == 2

        @test get_selection_model(list_view) isa SelectionModel

        connect_signal_activate_item!(list_view) do self::ListView, index::Integer
            @test true
            return nothing
        end
    end
end

### LOG

function test_log(::Container)
    @testset "Log" begin
    
        name = tempname()
        @test set_log_file!(name) == true

        set_surpress_debug!(mousetrap.MOUSETRAP_DOMAIN, false)
        set_surpress_info!(mousetrap.MOUSETRAP_DOMAIN, false)

        message = "LOG TEST"
        log_info(mousetrap.MOUSETRAP_DOMAIN, message)
        log_debug(mousetrap.MOUSETRAP_DOMAIN, message)
        log_warning(mousetrap.MOUSETRAP_DOMAIN, message)
        log_critical(mousetrap.MOUSETRAP_DOMAIN, message)
        # log_fatal(mousetrap.MOUSETRAP_DOMAIN, message) # this would quit runtime 

        file = open(name)
        lines = readlines(file)
        @test isempty(lines) == false
        close(file)

        @test get_surpress_debug(mousetrap.MOUSETRAP_DOMAIN) == false
        set_surpress_debug!(mousetrap.MOUSETRAP_DOMAIN, true)
        @test get_surpress_debug(mousetrap.MOUSETRAP_DOMAIN) == true
        
        @test get_surpress_info(mousetrap.MOUSETRAP_DOMAIN) == false
        set_surpress_info!(mousetrap.MOUSETRAP_DOMAIN, true)
        @test get_surpress_info(mousetrap.MOUSETRAP_DOMAIN) == true
    end
end

### MENU_MODEL

function test_menus(::Container)
   
    icon = Main.icon[]
    action = Action("test.action", Main.app[]) do self::Action
    end

    root = MenuModel()
    submenu = MenuModel()
    section = MenuModel()

    items_changed_called = Ref{Bool}(false)
    connect_signal_items_changed!(root, items_changed_called) do self::MenuModel, position::Integer, n_removed::Integer, n_added::Integer, items_changed_called
        items_changed_called[] = true
        return nothing
    end

    add_action!(submenu, "Action", action)
    add_icon!(submenu, icon, action)
    add_widget!(submenu, Separator())

    add_action!(section, "Section", action)
    add_section!(submenu, "section", section)
    add_submenu!(root, "Submenu", submenu)

    @testset "MenuModel" begin
        Base.show(devnull, root)
        @test items_changed_called[] == true
    end
   
    @testset "MenuBar" begin
        bar = MenuBar(root)
        @test mousetrap.is_native_widget(bar)
        Base.show(devnull, bar)
    end

    @testset "PopoverMenu" begin
        popover = PopoverMenu(root)
        @test mousetrap.is_native_widget(popover)
        Base.show(devnull, popover)
    end
end

### NOTE_BOOK

function test_notebook(::Container)

    @testset "Notebook" begin
        notebook = Notebook()

        Base.show(devnull, notebook)
        @test mousetrap.is_native_widget(notebook)

        page_added_called = Ref{Bool}(false)
        connect_signal_page_added!(notebook, page_added_called) do self::Notebook, page_index::Integer, page_added_called
            page_added_called[] = true
            return nothing
        end

        page_removed_called = Ref{Bool}(false)
        connect_signal_page_removed!(notebook, page_removed_called) do self::Notebook, page_index::Integer, page_removed_called
            page_removed_called[] = true
            return nothing
        end

        page_reordered_called = Ref{Bool}(false)
        connect_signal_page_reordered!(notebook, page_reordered_called) do self::Notebook, page_index::Integer, page_reordered_called
            page_reordered_called[] = true
            return nothing
        end

        page_selection_changed_called = Ref{Bool}(false)
        connect_signal_page_selection_changed!(notebook, page_selection_changed_called) do self::Notebook, page_index::Integer, page_selection_changed_called
            page_selection_changed_called[] = true
            return nothing
        end

        push_front!(notebook, Label("01"), Label("01"))
        push_back!(notebook, Label("02"), Label("02"))
        insert_at!(notebook, 1, Label("03"), Label("03"))
        move_page_to!(notebook, 1, 2)


        @test get_current_page(notebook) == 1

        #=
        next_page!(notebook)
        @test get_current_page(notebook) == 2

        previous_page!(notebook)
        @test get_current_page(notebook) == 1
        =#

        # these tests pass, but they trigger "gtk_root_get_focus: assertion 'GTK_IS_ROOT (self)' failed" because notebook is not yet realized

        @test get_n_pages(notebook) == 3
        remove!(notebook, 1)
        @test get_n_pages(notebook) == 2

        @test get_is_scrollable(notebook) == false
        set_is_scrollable!(notebook, true)
        @test get_is_scrollable(notebook) == true
        
        @test get_has_border(notebook) == true
        set_has_border!(notebook, false)
        @test get_has_border(notebook) == false

        @test get_tabs_visible(notebook) == true
        set_tabs_visible!(notebook, false)
        @test get_tabs_visible(notebook) == false

        @test get_quick_change_menu_enabled(notebook) == false
        set_quick_change_menu_enabled!(notebook, true)
        @test get_quick_change_menu_enabled(notebook) == true

        @test get_tab_position(notebook) == RELATIVE_POSITION_ABOVE
        set_tab_position!(notebook, RELATIVE_POSITION_BELOW)
        @test get_tab_position(notebook) == RELATIVE_POSITION_BELOW

        @test get_tabs_reorderable(notebook) == false
        set_tabs_reorderable!(notebook, true)
        @test get_tabs_reorderable(notebook) == true

        @test page_added_called[]
        @test page_removed_called[]
        @test page_reordered_called[]
        @test page_selection_changed_called[]
    end
end

### OVERLAY

function test_overlay(::Container)
    @testset "Overlay" begin
        overlay = Overlay()
        Base.show(devnull, overlay)
        @test mousetrap.is_native_widget(overlay)

        overlay_child = Separator()

        set_child!(overlay, Separator())
        add_overlay!(overlay, overlay_child)

        remove_child!(overlay)
        remove_overlay!(overlay, overlay_child)

        @test overlay isa Widget
    end
end

### PANED

function test_paned(::Container)
    @testset "Paned" begin
        paned = Paned(ORIENTATION_HORIZONTAL)
        Base.show(devnull, paned)
        @test mousetrap.is_native_widget(paned)

        set_start_child!(paned, Separator())
        set_end_child!(paned, Separator())

        @test get_start_child_resizable(paned) == true
        set_start_child_resizable!(paned, false)
        @test get_start_child_resizable(paned) == false

        @test get_start_child_shrinkable(paned) == true
        set_start_child_shrinkable!(paned, false)
        @test get_start_child_shrinkable(paned) == false

        @test get_end_child_resizable(paned) == true
        set_end_child_resizable!(paned, false)
        @test get_end_child_resizable(paned) == false

        @test get_end_child_shrinkable(paned) == true
        set_end_child_shrinkable!(paned, false)
        @test get_end_child_shrinkable(paned) == false

        @test get_has_wide_handle(paned) == true
        set_has_wide_handle!(paned, false)
        @test get_has_wide_handle(paned) == false

        @test get_orientation(paned) == ORIENTATION_HORIZONTAL
        set_orientation!(paned, ORIENTATION_VERTICAL)
        @test get_orientation(paned) == ORIENTATION_VERTICAL

        set_position!(paned, 32)
        @test get_position(paned) == 32

        remove_start_child!(paned)
        remove_end_child!(paned)
    end
end

### POPOVER 

function test_popover(container::Container)

    popover = Popover()

    #=
    @testset "Popover" begin
        Base.show(devnull, popover)
        @test mousetrap.is_native_widget(popover)

        set_child!(popover, Separator())
        id = add_child!(container, popover, "Popover")

        @test get_has_base_arrow(popover) == true
        set_has_base_arrow!(popover, false)
        @test get_has_base_arrow(popover) == false

        @test get_autohide(popover) == true
        set_autohide!(popover, false)
        @test get_autohide(popover) == false

        set_relative_position!(popover, RELATIVE_POSITION_BELOW)
        @test get_relative_position(popover) == RELATIVE_POSITION_BELOW

        connect_signal_closed!(popover) do self::Popover
            return nothing
        end

        connect_signal_realize!(popover) do self::Popover   
            popup!(popover)
            popdown!(popover)
        end

        remove_child!(container, id)
    end
    =#

    @testset "PopoverButton" begin
        popover_button = PopoverButton(popover)

        Base.show(devnull, popover_button)
        @test mousetrap.is_native_widget(popover_button)

        @test get_always_show_arrow(popover_button) == true
        set_always_show_arrow!(popover_button, false)
        @test get_always_show_arrow(popover_button) == false

        @test get_has_frame(popover_button) == true
        set_has_frame!(popover_button, false)
        @test get_has_frame(popover_button) == false

        @test get_is_circular(popover_button) == false
        set_is_circular!(popover_button, true)
        @test get_is_circular(popover_button) == true

        set_relative_position!(popover_button, RELATIVE_POSITION_BELOW)
        @test get_relative_position(popover_button) == RELATIVE_POSITION_BELOW

        set_child!(popover_button, Separator())
        #remove_child!(popover_button)
        # cf. https://gitlab.gnome.org/GNOME/gtk/-/issues/5969

        set_popover!(popover_button, Popover())
        remove_popover!(popover_button)

        set_popover_menu!(popover_button, PopoverMenu(MenuModel()))
        remove_popover!(popover_button)

        activate_called = Ref{Bool}(false)
        connect_signal_activate!(popover_button, activate_called) do self::PopoverButton, activate_called
            activate_called[] = true
            return nothing
        end
        activate!(popover_button)
        @test activate_called[] == true
    end
end

### PROGRESS_BAR

function test_progress_bar(::Container)
    @testset "ProgressBar" begin
        progress_bar = ProgressBar()
        Base.show(devnull, progress_bar)
        @test mousetrap.is_native_widget(progress_bar)

        @test get_fraction(progress_bar) == 0.0
        set_fraction!(progress_bar, 0.5)
        @test get_fraction(progress_bar) == 0.5

        @test get_orientation(progress_bar) == ORIENTATION_HORIZONTAL
        set_orientation!(progress_bar, ORIENTATION_VERTICAL)
        @test get_orientation(progress_bar) == ORIENTATION_VERTICAL

        @test get_is_inverted(progress_bar) == false
        set_is_inverted!(progress_bar, true)
        @test get_is_inverted(progress_bar) == true

        @test get_show_text(progress_bar) == false
        set_show_text!(progress_bar, true)
        set_text!(progress_bar, "text")
        @test get_show_text(progress_bar) == true
        @test get_text(progress_bar) == "text"

        pulse(progress_bar)
    end
end

### REVEALER

function test_revealer(::Container)
    @testset "Revealer" begin
        revealer = Revealer()
        Base.show(devnull, revealer)
        @test mousetrap.is_native_widget(revealer)

        revealed_called = Ref{Bool}(false)
        connect_signal_revealed!(revealer, revealed_called) do self::Revealer, revealed_called
            revealed_called[] = true
            return nothing
        end

        set_child!(revealer, Separator())
        set_is_revealed!(revealer, false)
        @test get_is_revealed(revealer) == false
        set_is_revealed!(revealer, true)
        @test get_is_revealed(revealer) == true
    
        set_transition_duration!(revealer, seconds(1))
        @test get_transition_duration(revealer) == seconds(1)

        set_transition_type!(revealer, REVEALER_TRANSITION_TYPE_SLIDE_DOWN)
        @test get_transition_type(revealer) == REVEALER_TRANSITION_TYPE_SLIDE_DOWN

        @test revealed_called[] == true
    end
end

### SCALE

function test_scale(::Container)
    @testset "Scale" begin
        scale = Scale(0, 1, 0.01)
        Base.show(devnull, scale)
        @test mousetrap.is_native_widget(scale)

        value_changed_called = Ref{Bool}(false)
        connect_signal_value_changed!(scale, value_changed_called) do self::Scale, value_changed_called
            value_changed_called[] = true
            return nothing
        end

        @test get_value(scale) == 0.5
        set_value!(scale, 0.6)
        @test get_value(scale) == 0.6f0

        @test get_lower(scale) == 0.0
        set_lower!(scale, 1.0)
        @test get_lower(scale) == 1.0

        @test get_upper(scale) == 1.0
        set_upper!(scale, 2.0)
        @test get_upper(scale) == 2.0

        @test get_step_increment(scale) == 0.01f0
        set_step_increment!(scale, 0.5)
        @test get_step_increment(scale) == 0.5

        @test get_has_origin(scale) == true
        set_has_origin!(scale, false)
        @test get_has_origin(scale) == false

        @test get_orientation(scale) == ORIENTATION_HORIZONTAL
        set_orientation!(scale, ORIENTATION_VERTICAL)
        @test get_orientation(scale) == ORIENTATION_VERTICAL

        @test get_should_draw_value(scale) == false
        set_should_draw_value!(scale, true)
        @test get_should_draw_value(scale) == true

        @test get_adjustment(scale) isa Adjustment
        add_mark!(scale, 1.5, RELATIVE_POSITION_RIGHT_OF, "label")
        clear_marks!(scale)

        @test value_changed_called[] == true
    end
end

### SCROLLBAR

function test_scrollbar(::Container)
    @testset "Scrollbar" begin
        scrollbar = Scrollbar(ORIENTATION_HORIZONTAL, Adjustment(0, 0, 1, 0.01))
        Base.show(devnull, scrollbar)
        @test mousetrap.is_native_widget(scrollbar)
        
        @test get_value(get_adjustment(scrollbar)) == 0.0
        
        @test get_orientation(scrollbar) == ORIENTATION_HORIZONTAL
        set_orientation!(scrollbar, ORIENTATION_VERTICAL)
        @test get_orientation(scrollbar) == ORIENTATION_VERTICAL 
    end
end

### SELECTION_MODEL

function test_selection_model(::Container)
    @testset "SelectionModel" begin
        list_view = ListView(ORIENTATION_HORIZONTAL, SELECTION_MODE_MULTIPLE)
        push_back!(list_view, Separator())
        push_back!(list_view, Separator())
        push_back!(list_view, Separator())

        selection_model = get_selection_model(list_view)
        Base.show(devnull, selection_model)
        @test mousetrap.is_native_widget(list_view)

        @test get_n_items(selection_model) == 3
        select!(selection_model, 1)
        select_all!(selection_model)
        @test length(get_selection(selection_model)) == 3
        unselect_all!(selection_model)
        @test length(get_selection(selection_model)) == 0
    end
end

### SEPARATOR 

function test_separator(::Container)
    @testset "Separator" begin
        separator = Separator(ORIENTATION_HORIZONTAL; opacity = 0.5)
        Base.show(devnull, separator)
        @test mousetrap.is_native_widget(separator)

        @test get_orientation(separator) == ORIENTATION_HORIZONTAL
        set_orientation!(separator, ORIENTATION_VERTICAL)
        @test get_orientation(separator) == ORIENTATION_VERTICAL
    end
end

### SPIN_BUTTON

function test_spin_button(::Container)
    @testset "SpinButton" begin

        scale = SpinButton(0, 1, 0.01)
        Base.show(devnull, scale)
        @test mousetrap.is_native_widget(scale)

        value_changed_called = Ref{Bool}(false)
        connect_signal_value_changed!(scale, value_changed_called) do self::SpinButton, value_changed_called
            value_changed_called[] = true
            return nothing
        end

        set_value!(scale, 0.5)
        @test get_value(scale) == 0.5

        @test get_lower(scale) == 0.0
        set_lower!(scale, 1.0)
        @test get_lower(scale) == 1.0

        @test get_upper(scale) == 1.0
        set_upper!(scale, 2.0)
        @test get_upper(scale) == 2.0

        @test get_step_increment(scale) == 0.01f0
        set_step_increment!(scale, 0.5)
        @test get_step_increment(scale) == 0.5f0

        set_acceleration_rate!(scale, 2)
        @test get_acceleration_rate(scale) == 2

        @test get_allow_only_numeric(scale) == true
        set_allow_only_numeric!(scale, false)
        @test get_allow_only_numeric(scale) == false
        
        @test get_n_digits(scale) > 0
        set_n_digits!(scale, 10)
        @test get_n_digits(scale) == 10

        @test get_should_wrap(scale) == false
        set_should_wrap!(scale, true)
        @test get_should_wrap(scale) == true

        @test get_should_snap_to_ticks(scale) == false
        set_should_snap_to_ticks!(scale, true)
        @test get_should_snap_to_ticks(scale) == true

        set_text_to_value_function!(scale) do self::SpinButton, text::String
            value::Float32 = 0
            return value
        end

        set_value_to_text_function!(scale) do self::SpinButton, value::AbstractFloat
            result = ""
            return result
        end

        @test value_changed_called[] == true
    end
end

### SPINNER

function test_spinner(::Container)
    @testset "Spinner" begin
        spinner = Spinner()
        Base.show(devnull, spinner)
        @test mousetrap.is_native_widget(spinner)

        @test get_is_spinning(spinner) == false
        set_is_spinning!(spinner, true)
        @test get_is_spinning(spinner) == true
        stop!(spinner)
        @test get_is_spinning(spinner) == false
        start!(spinner)
        @test get_is_spinning(spinner) == true
    end
end

### STACK

function test_stack(::Container)
    @testset "Stack" begin
        stack = Stack()
        Base.show(devnull, stack)
        @test mousetrap.is_native_widget(stack)

        id_01 = add_child!(stack, Separator(), "01")
        id_02 = add_child!(stack, Separator(), "02")

        @test get_child_at(stack, 1) == id_01

        @test get_is_horizontally_homogeneous(stack) == true
        set_is_horizontally_homogeneous!(stack, false)
        @test get_is_horizontally_homogeneous(stack) == false

        @test get_is_vertically_homogeneous(stack) == true
        set_is_vertically_homogeneous!(stack, false)
        @test get_is_vertically_homogeneous(stack) == false

        @test get_should_interpolate_size(stack) == false
        set_should_interpolate_size!(stack, true)
        @test get_should_interpolate_size(stack) == true

        set_transition_type!(stack, STACK_TRANSITION_TYPE_OVER_UP)
        @test get_transition_type(stack) == STACK_TRANSITION_TYPE_OVER_UP

        set_transition_duration!(stack, seconds(1))
        @test get_transition_duration(stack) == seconds(1)

        @test get_selection_model(stack) isa SelectionModel
        set_visible_child!(stack, id_02)

        sidebar = StackSidebar(stack)
        @test sidebar isa Widget

        switcher = StackSwitcher(stack)
        @test switcher isa Widget
    end
end

### SWITCH

function test_switch(::Container)
    @testset "Switch" begin
        switch = Switch()
        Base.show(devnull, switch)
        @test mousetrap.is_native_widget(switch)

        switched_called = Ref{Bool}(false)
        connect_signal_switched!(switch, switched_called) do self::Switch, switched_called
            switched_called[] = true
            set_is_active!(self, true) # `activate!` toggles switch only once it is realized, so we do it manually to avoid having to wait for the window to render
            return nothing
        end

        set_is_active!(switch, false)
        @test get_is_active(switch) == false
        @test switched_called[] == true
    end
end

### TEXT_VIEW

function test_text_view(::Container)
    @testset "TextView" begin
        text_view = TextView()
        Base.show(devnull, text_view)
        @test mousetrap.is_native_widget(text_view)

        text_changed_called = Ref{Bool}(false)
        connect_signal_text_changed!(text_view, text_changed_called) do self::TextView, text_changed_called
            text_changed_called[] = true
            return nothing
        end

        @test get_bottom_margin(text_view) == 0
        set_bottom_margin!(text_view, 10)
        @test get_bottom_margin(text_view) == 10

        @test get_left_margin(text_view) == 0
        set_left_margin!(text_view, 10)
        @test get_left_margin(text_view) == 10

        @test get_right_margin(text_view) == 0
        set_right_margin!(text_view, 10)
        @test get_right_margin(text_view) == 10

        @test get_top_margin(text_view) == 0
        set_top_margin!(text_view, 10)
        @test get_top_margin(text_view) == 10

        @test get_editable(text_view) == true
        set_editable!(text_view, false)
        @test get_editable(text_view) == false

        set_was_modified!(text_view, false)
        @test get_was_modified(text_view) == false
        set_text!(text_view, "modified")
        @test get_was_modified(text_view) == true

        undo!(text_view)
        redo!(text_view)

        @test text_changed_called[] == true
    end
end

### TOGGLE_BUTTON

function test_toggle_button(::Container)
    @testset "ToggleButton" begin
        
        button = ToggleButton()
        Base.show(devnull, button)
        @test mousetrap.is_native_widget(button)

        toggled_called = Ref{Bool}(false)
        connect_signal_toggled!(button, toggled_called) do self::ToggleButton, toggled_called
            toggled_called[] = true
            return nothing
        end

        clicked_called = Ref{Bool}(false)
        connect_signal_clicked!(button, clicked_called) do self::ToggleButton, clicked_called
            clicked_called[] = true
            return nothing
        end

        set_is_active!(button, true)
        @test get_is_active(button) == true

        set_child!(button, Separator())
        set_icon!(button, Main.icon[])
        remove_child!(button)

        @test get_is_circular(button) == false
        set_is_circular!(button, true)
        @test get_is_circular(button) == true
    end
end

function test_typed_function(::Container)
    @testset "TypedFunction" begin
        yes_f(x::Int64) ::Nothing = return nothing
        no_f1(x::Int32) ::Nothing = return nothing
        no_f2(x::Int64) ::Int64 = return 1234

        Test.@test TypedFunction(yes_f, Nothing, (Int64,)) isa TypedFunction
        Test.@test_throws AssertionError TypedFunction(no_f1, Nothing, (Int64,))
        Test.@test_throws AssertionError TypedFunction(no_f2, Nothing, (Int64,))

        Base.show(devnull, TypedFunction(() -> nothing, Nothing, ()))
    end
end

function test_viewport(::Container)
    @testset "Viewport" begin
        viewport = Viewport()
        Base.show(devnull, viewport)
        @test mousetrap.is_native_widget(viewport)

        connect_signal_scroll_child!(viewport) do self::Viewport, scroll_type::ScrollType, is_horizontal::Bool
        end

        @test get_has_frame(viewport) == false
        set_has_frame!(viewport, true)
        @test get_has_frame(viewport) == true

        @test get_horizontal_adjustment(viewport) isa Adjustment
        @test get_vertical_adjustment(viewport) isa Adjustment

        @test get_kinetic_scrolling_enabled(viewport) == true
        set_kinetic_scrolling_enabled!(viewport, false)
        @test get_kinetic_scrolling_enabled(viewport) == false

        @test get_propagate_natural_width(viewport) == false
        set_propagate_natural_width!(viewport, true)
        @test get_propagate_natural_width(viewport) == true

        @test get_propagate_natural_height(viewport) == false
        set_propagate_natural_height!(viewport, true)
        @test get_propagate_natural_height(viewport) == true

        @test get_vertical_scrollbar_policy(viewport) == SCROLLBAR_VISIBILITY_POLICY_AUTOMATIC
        set_vertical_scrollbar_policy!(viewport, SCROLLBAR_VISIBILITY_POLICY_NEVER)
        @test get_vertical_scrollbar_policy(viewport) == SCROLLBAR_VISIBILITY_POLICY_NEVER

        @test get_horizontal_scrollbar_policy(viewport) == SCROLLBAR_VISIBILITY_POLICY_AUTOMATIC
        set_horizontal_scrollbar_policy!(viewport, SCROLLBAR_VISIBILITY_POLICY_NEVER)
        @test get_horizontal_scrollbar_policy(viewport) == SCROLLBAR_VISIBILITY_POLICY_NEVER

        set_scrollbar_placement!(viewport, CORNER_PLACEMENT_TOP_LEFT)
        @test get_scrollbar_placement(viewport) == CORNER_PLACEMENT_TOP_LEFT
    end
end

function test_window(::Container)
    @testset "Window" begin
        window = Window(Main.app[])
        Base.show(devnull, window)
        @test mousetrap.is_native_widget(window)

        close_request_called = Ref{Bool}(false)
        connect_signal_close_request!(window, close_request_called) do self::Window, close_request_called
            close_request_called[] = true
            return WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE
        end

        activate_default_widget_called = Ref{Bool}(false)
        connect_signal_activate_default_widget!(window, activate_default_widget_called) do self::Window, activate_default_widget_called
            activate_default_widget_called[] = true
            return nothing
        end

        activate_focused_widget_called = Ref{Bool}(false)
        connect_signal_activate_focused_widget!(window, activate_focused_widget_called) do self::Window, activate_focused_widget_called
            activate_focused_widget_called[] = true
            return nothing
        end

        @test get_destroy_with_parent(window) == false
        set_destroy_with_parent!(window, true)
        @test get_destroy_with_parent(window) == true
        
        @test get_focus_visible(window) == true
        set_focus_visible!(window, false)
        @test get_focus_visible(window) == false

        @test get_has_close_button(window) == true
        set_has_close_button!(window, false)
        @test get_has_close_button(window) == false

        @test get_is_decorated(window) == true
        set_is_decorated!(window, false)
        @test get_is_decorated(window) == false

        @test get_is_modal(window) == false
        set_is_modal!(window, true)
        @test get_is_modal(window) == true

        set_title!(window, "test")
        @test get_title(window) == "test"

        button = Button()
        set_child!(window, button)
        set_default_widget!(window, button)
        activate!(button)

        #@test activate_default_widget_called[] == true
        #@test activate_focused_widget_called[] == true

        set_titlebar_widget!(window, Separator())

        @test get_hide_on_close(window) == false
        set_hide_on_close!(window, true)
        @test get_hide_on_close(window) == true

        present!(window)
        set_minimized!(window, true)
        set_maximized!(window, true)
        close!(window)
        destroy!(window)
    end
end

### WIDGET

function test_widget(widget::Container)

    @testset "Widget" begin

        for s in [:realize, :unrealize, :destroy, :hide, :show, :map, :unmap]
            signal_called = Ref{Bool}(false)
            connect_signal_f = Symbol("connect_signal_$(s)!")
            eval(:(
                $connect_signal_f($widget, $signal_called) do self::Container, signal_called
                    signal_called[] = true
                    @test signal_called[]
                    return nothing
                end
            ))
        end

        set_size_request!(widget, Vector2f(50, 100))
        @test get_size_request(widget) == Vector2f(50, 100)

        set_margin_top!(widget, 1)
        @test get_margin_top(widget) == 1
        
        set_margin_bottom!(widget, 2)
        @test get_margin_bottom(widget) == 2

        set_margin_start!(widget, 3)
        @test get_margin_start(widget) == 3

        set_margin_end!(widget, 4)
        @test get_margin_end(widget) == 4

        set_margin_horizontal!(widget, 5)
        @test get_margin_start(widget) == 5
        @test get_margin_end(widget) == 5

        set_margin_vertical!(widget, 6)
        @test get_margin_top(widget) == 6
        @test get_margin_bottom(widget) == 6

        set_margin!(widget, 7)
        @test get_margin_top(widget) == 7
        @test get_margin_bottom(widget) == 7
        @test get_margin_start(widget) == 7
        @test get_margin_end(widget) == 7

        set_expand_horizontally!(widget, true)
        @test get_expand_horizontally(widget) == true

        set_expand_vertically!(widget, true)
        @test get_expand_horizontally(widget) == true

        set_expand!(widget, false)
        @test get_expand_horizontally(widget) == false
        @test get_expand_horizontally(widget) == false 

        set_horizontal_alignment!(widget, ALIGNMENT_START)
        @test get_horizontal_alignment(widget) == ALIGNMENT_START

        set_vertical_alignment!(widget, ALIGNMENT_START)
        @test get_vertical_alignment(widget) == ALIGNMENT_START

        set_alignment!(widget, ALIGNMENT_END)
        @test get_vertical_alignment(widget) == ALIGNMENT_END
        @test get_horizontal_alignment(widget) == ALIGNMENT_END

        @test isapprox(get_opacity(widget), 1.0)
        set_opacity!(widget, 0.6)
        @test isapprox(get_opacity(widget), 0.6)
        set_opacity!(widget, 1.0)

        set_is_visible!(widget, false)
        @test get_is_visible(widget) == false
        set_is_visible!(widget, true)

        set_tooltip_text!(widget, "test")
        set_tooltip_widget!(widget, Label("test"))
        remove_tooltip_widget!(widget)

        set_cursor!(widget, CURSOR_TYPE_NONE)
        set_cursor_from_image!(widget, Image(1, 1, RGBA(1, 0, 0, 1)))

        hide!(widget)
        show!(widget)

        set_is_focusable!(widget, true)
        @test get_is_focusable(widget) == true
        set_is_focusable!(widget, false)
        @test get_is_focusable(widget) == false

        set_focus_on_click!(widget, true)
        @test get_focus_on_click(widget) == true

        grab_focus!(widget)
        @test get_has_focus(widget) isa Bool

        set_can_respond_to_input!(widget, false)
        @test get_can_respond_to_input(widget) == false
        set_can_respond_to_input!(widget, true)
        @test get_can_respond_to_input(widget) == true

        @test get_is_realized(widget) == true

        # sizes are only available after first show

        minimum_size = get_minimum_size(widget)
        @test minimum_size.x >= 0 && minimum_size.y >= 0

        natural_size = get_natural_size(widget)
        @test natural_size.x >= 0 && natural_size.y >= 0

        position = get_position(widget)
        @test position.x >= 0 && position.y >= 0

        allocated_size = get_allocated_size(widget)
        @test allocated_size.x >= 0 && allocated_size.y >= 0

        set_hide_on_overflow!(widget, true)
        @test get_hide_on_overflow(widget) == true
        set_hide_on_overflow!(widget, false)

        tick_callback_called = Ref{Bool}(false)
        set_tick_callback!(widget, tick_callback_called) do clock::FrameClock, tick_callback_called
            tick_callback_called[] = true

            @testset "FrameClock" begin
                Base.show(devnull, clock)
                
                paint_called = Ref{Bool}(false)
                connect_signal_paint!(clock, paint_called) do self::FrameClock, paint_called
                    paint_called[] = true
                    @test get_target_frame_duration(clock) isa Time
                    @test get_time_since_last_frame(clock) isa Time
                    return nothing
                end
        
                update_called = Ref{Bool}(false)
                connect_signal_update!(clock, update_called) do self::FrameClock, update_called
                    update_called[] = true
                    @test get_target_frame_duration(clock) isa Time
                    @test get_time_since_last_frame(clock) isa Time
                    return nothing
                end
        
                @test clock isa FrameClock
            end
            return TICK_CALLBACK_RESULT_DISCONTINUE
        end
        # @test tick_callback_called[] == true  # only called after first frame is done, which never happens in tests
    end
end

### RENDER_AREA

function test_render_area(::Container)

    if !mousetrap.MOUSETRAP_ENABLE_OPENGL_COMPONENT
        return
    end
    
    render_area = RenderArea()

    @testset "RenderArea" begin
        #make_current(render_area) # would print soft warning because render area is not yet realized
        queue_render(render_area)
        @test render_area isa RenderArea
    end

    for pair in [
        "Point" => Point(Vector2f(0, 0)),
        "Points" => Points([Vector2f(0.5, 0.5), Vector2f(0, 0,)]),
        "Triangle" => Triangle(Vector2f(-0.5, 0.5), Vector2f(0.5, 0.5), Vector2f(0.5, -0.5)),
        "Rectangle" => Rectangle(Vector2f(-0.5, -0.5), Vector2f(1, 1)),
        "Circle" => Circle(Vector2f(0, 0), 1, 16),
        "Ellipse" => Ellipse(Vector2f(0, 0), 0.5, 1, 16),
        "Line" => Line(Vector2f(-0.5, 0.5), Vector2f(0.5, 0.5)),
        "LineStrip" => LineStrip([Vector2f(-0.5, 0.5), Vector2f(0.5, 0.5), Vector2f(0.5, -0.5)]),
        "Polygon" => Polygon([Vector2f(-0.5, 0.5), Vector2f(0.5, 0.5), Vector2f(0.5, -0.5)]),
        "RectangularFrame" => RectangularFrame(Vector2f(-0.5, 0.5), Vector2f(1, 1), 0.1, 0.1),
        "CircularRing" => CircularRing(Vector2f(0.0, 0.0), 1.0, 0.1, 8),
        "EllipticalRing" => EllipticalRing(Vector2f(0.0, 0.0), 1.0, 0.1, 0.2, 0.1, 8),
        "Wireframe" => Wireframe([Vector2f(-0.5, 0.5), Vector2f(0.5, 0.5), Vector2f(0.5, -0.5)])
    ]
        @testset "$(pair[1])" begin
        
            shape = pair[2]
            add_render_task!(render_area, RenderTask(shape))
            add_render_task!(render_area, RenderTask(Outline(shape)))

            for i in 1:get_n_vertices(shape)
                set_vertex_color!(shape, i, RGBA(1, 0, 1, 1))
                @test get_vertex_color(shape, i) == RGBA(1, 0, 1, 1)
                coordinate = get_vertex_texture_coordinate(shape, i) 
                @test coordinate.x >= 0 && coordinate.x <= 1
                @test coordinate.y >= 0 && coordinate.y <= 1
                
                set_vertex_position!(shape, i, Vector3f(0, 0, 0))
                @test get_vertex_position(shape, i) == Vector3f(0, 0, 0)

                Base.show(devnull, shape)
            end

            @test get_is_visible(shape) == true
            set_is_visible!(shape, false)
            @test get_is_visible(shape) == false
            
            bounding_box = get_bounding_box(shape)
            @test bounding_box.top_left == get_top_left(shape)
            @test bounding_box.size == get_size(shape)

            set_top_left!(shape, Vector2f(1, 2))
            @test get_top_left(shape) == Vector2f(1, 2)

            set_centroid!(shape, Vector2f(1, 2))
            centroid = get_centroid(shape)
            @test isapprox(centroid.x, 1) && isapprox(centroid.y, 2)

            rotate!(shape, degrees(180), get_centroid(shape))

            new_centroid = get_centroid(shape)
            @test isapprox(centroid.x, new_centroid.x) && isapprox(centroid.y, new_centroid.y)

            set_color!(shape, RGBA(0, 1, 1, 1))
            @test get_vertex_color(shape, 1) == RGBA(0, 1, 1, 1)
        end
    end

    @testset "Shader" begin
        
        vertex_shader_source = """
        #version 330

        layout (location = 0) in vec3 _vertex_position_in;
        layout (location = 1) in vec4 _vertex_color_in;
        layout (location = 2) in vec2 _vertex_texture_coordinates_in;

        uniform mat4 _transform;

        out vec4 _vertex_color;
        out vec2 _texture_coordinates;
        out vec3 _vertex_position;

        void main()
        {
            gl_Position = _transform * vec4(_vertex_position_in, 1.0);
            _vertex_color = _vertex_color_in;
            _vertex_position = _vertex_position_in;
            _texture_coordinates = _vertex_texture_coordinates_in;
        }
        """

        fragment_shader_source = """
        #version 130

        in vec4 _vertex_color;
        in vec2 _texture_coordinates;
        in vec3 _vertex_position;

        out vec4 _fragment_color;

        uniform int _texture_set;
        uniform sampler2D _texture;

        uniform float _float;
        uniform int _int;
        uniform uint _uint;
        uniform vec2 _vec2;
        uniform vec3 _vec3;
        uniform vec4 _vec4;
        uniform mat4 _mat4;

        void main()
        {
            // prevent optimizing uniform away
            float value = _float + _int + _uint + _vec2.x + _vec3.x + _vec4.x + _mat4[0][0];
            _fragment_color = vec4(vec3(value), 1);
        }
        """

        shader = Shader()
        @test create_from_string!(shader, SHADER_TYPE_FRAGMENT, fragment_shader_source)
        @test create_from_string!(shader, SHADER_TYPE_VERTEX, vertex_shader_source)

        @test get_program_id(shader) != 0
        @test get_fragment_shader_id(shader) != 0
        @test get_vertex_shader_id(shader) != 0

        for name in ["_float", "_int", "_uint", "_vec2", "_vec3", "_vec4", "_mat4"]
            @test get_uniform_location(shader, name) >= 0
        end

        set_uniform_float!(shader, "_float", Cfloat(1234.0))
        set_uniform_int!(shader, "_int", Cint(1234))
        set_uniform_uint!(shader, "_uint", Cuint(1234))
        set_uniform_vec2!(shader, "_vec2", Vector2f(1, 2))
        set_uniform_vec3!(shader, "_vec3", Vector3f(1, 2, 3))
        set_uniform_vec4!(shader, "_vec4", Vector4f(1, 2, 3, 4))
        set_uniform_transform!(shader, "_mat4", GLTransform())

        Base.show(devnull, shader)
    end

    @testset "RenderTask" begin
        shape = Rectangle(Vector2f(-0.5, 0.5), Vector2f(1, 1))
        shader = Shader()
        blend_mode = BLEND_MODE_NONE
        transform = GLTransform()

        task = RenderTask(shape; shader = shader, transform = transform, blend_mode = blend_mode)

        set_uniform_float!(task, "_float", Cfloat(1234.0))
        @test get_uniform_float(task, "_float") == 1234.0

        set_uniform_int!(task, "_int", Cint(1234))
        @test get_uniform_int(task, "_int") == 1234

        set_uniform_uint!(task, "_uint", UInt32(1234))
        @test get_uniform_uint(task, "_uint") == UInt(1234)

        set_uniform_vec2!(task, "_vec2", Vector2f(1, 2))
        @test get_uniform_vec2(task, "_vec2") == Vector2f(1, 2)

        set_uniform_vec3!(task, "_vec3", Vector3f(1, 2, 3))
        @test get_uniform_vec3(task, "_vec3") == Vector3f(1, 2, 3)

        set_uniform_vec4!(task, "_vec4", Vector4f(1, 2, 3, 4))
        @test get_uniform_vec4(task, "_vec4") == Vector4f(1, 2, 3, 4)

        set_uniform_rgba!(task, "_rgba", RGBA(1, 0, 1, 1))
        @test get_uniform_rgba(task, "_rgba") == RGBA(1, 0, 1, 1)

        set_uniform_hsva!(task, "_hsva", HSVA(0.5, 0, 1, 1))
        @test get_uniform_hsva(task, "_hsva") == HSVA(0.5, 0, 1, 1)

        transform = GLTransform()
        translate!(transform, Vector2f(0.5, 0.5))

        set_uniform_transform!(task, "_transform", transform)
        @test get_uniform_transform(task, "_transform") == transform

        Base.show(devnull, task)
    end

    @testset "TextureObject" begin
        image = Image(32, 32, RGBA(1, 0, 0, 1))
        texture = Texture()
        render_texture = RenderTexture()

        for t in [texture, render_texture]
            create!(t, 100, 100)
            create_from_image!(t, image)

            mousetrap.download(texture) == image
            mousetrap.bind(t)
            mousetrap.unbind(t)

            @test get_wrap_mode(t) == TEXTURE_WRAP_MODE_REPEAT
            set_wrap_mode!(t, TEXTURE_WRAP_MODE_STRETCH)
            @test get_wrap_mode(t) == TEXTURE_WRAP_MODE_STRETCH

            @test get_scale_mode(t) == TEXTURE_SCALE_MODE_NEAREST
            set_scale_mode!(t, TEXTURE_SCALE_MODE_LINEAR)
            @test get_scale_mode(t) == TEXTURE_SCALE_MODE_LINEAR

            @test get_size(t) == Vector2i(32, 32)
            @test get_native_handle(t) != 0

            Base.show(devnull, t)
        end

        bind_as_render_target(render_texture)
        unbind_as_render_target(render_texture)
    end
end

### MAIN

main(Main.app_id) do app::Application

    window = Window(app)

    Main.app[] = app
    Main.window[] = window
    set_is_decorated!(window, false) # prevent user from closing the window during tests

    theme = IconTheme(Main.window[])
    Main.icon[] = Icon()

    container = Container()
    viewport = Viewport()
    set_child!(viewport, container)
    set_child!(window, viewport)

    connect_signal_realize!(container, window) do container::Container, window

        test_action(container)
        test_adjustment(container)
        test_alert_dialog(container)
        test_angle(container)
        test_application(container)
        test_aspect_frame(container)
        test_box(container)
        test_button(container)
        test_center_box(container)
        test_check_button(container)
        test_clamp_frame(container)
        test_clipboard(container)
        test_color_chooser(container)
        test_colors(container)
        test_column_view(container)
        test_drop_down(container)
        test_entry(container)
        test_event_controller(container)
        test_expander(container)
        test_file_chooser(container)
        test_file_descriptor(container)
        test_fixed(container)
        test_frame(container)
        test_gl_transform(container)
        test_grid(container)
        test_grid_view(container)
        test_header_bar(container)
        test_icon(container)
        test_image(container)
        test_image_display(container)
        test_key_file(container)
        test_label(container)
        test_level_bar(container)
        test_list_view(container)
        test_log(container)
        test_menus(container)
        test_notebook(container)
        test_overlay(container)
        test_paned(container)
        test_popover(container)
        test_progress_bar(container)
        test_revealer(container)
        test_render_area(container)
        test_scale(container)
        test_scrollbar(container)
        test_selection_model(container)
        test_separator(container)
        test_spin_button(container)
        test_spinner(container)
        test_stack(container)
        test_switch(container)
        test_text_view(container)
        test_time(container)
        test_toggle_button(container)
        test_typed_function(container)
        test_viewport(container)
        test_widget(container)
        test_window(container)
                
        return nothing
    end

    present!(window)
    close!(window)
    #quit!(app)
end
