using mousetrap
using Test

### GLOBALS

const app_id = "mousetrap.runtests.jl"
const app = Ref{Union{Application, Nothing}}(nothing)
const test_action = Ref{Union{Action, Nothing}}(nothing)
const main_window = Ref{Union{Window, Nothing}}(nothing)
const icon = Ref{Union{Icon, Nothing}}(nothing)

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
        

### APPLICATION

    struct ApplicationTest <: Widget end
    mousetrap.get_top_level_widget(::ApplicationTest) = Separator()

    function (::ApplicationTest)()
        
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
            @test isapprox(as_degrees(radians(as_radians(degrees(90)))), 90.0)
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

### BOX

    struct BoxTest <: Widget
        box::Box

        BoxTest() = new(Box(ORIENTATION_HORIZONTAL))
    end
    mousetrap.get_top_level_widget(x::BoxTest) = return x.box

    function (this::BoxTest)()
       
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
        EventControllerTest() = new(Separator)
    end
    mousetrap.get_top_level_widget(x::EventControllerTest) = x.area

    function (this::EventControllerTest)()
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
    end

### CLIPBOARD

    struct ClipboardTest <: Widget end
    mousetrap.get_top_level_widget(x::ClipboardTest) = Separator()

    function (::ClipboardTest)()
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

### TIME

    struct TimeTest <: Widget end
    mousetrap.get_top_level_widget(x::TimeTest) = Separator()

    function (::TimeTest)()
       
    end

### COLOR_CHOOSER

    struct ColorChooserTest <: Widget end
    mousetrap.get_top_level_widget(x::ColorChooserTest) = Separator()

    function (::ColorChooserTest)()
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

### COLUMN_VIEW

    struct ColumnViewTest <: Widget
        column_view::ColumnView
        ColumnViewTest() = new(ColumnView())
    end
    mousetrap.get_top_level_widget(x::ColumnViewTest) = x.column_view

    function (this::ColumnViewTest)()
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

### DROP_DOWN

    struct DropDownTest <: Widget
        drop_down::DropDown
    end
    mousetrap.get_top_level_widget(x::DropDownTest) = x.drop_down

    function (this::DropDownTest)()
        
    end

### ENTRY

    struct EntryTest <: Widget
        entry::Entry
    end
    mousetrap.get_top_level_widget(x::EntryTest) = x.entry

    function (this::EntryTest)()
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

### EXPANDER

    struct ExpanderTest <: Widget
        expander::Expander
    end
    mousetrap.get_top_level_widget(x::ExpanderTest) = x.expander

    function (this::ExpanderTest)()
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

### FILE_CHOOSER

    struct FileChooserTest <: Widget end
    mousetrap.get_top_level_widget(x::FileChooserTest) = Separator()

    function (::FileChooserTest)()

        
    end

### FILE_DESCRIPTOR

    struct FileDescriptorTest <: Widget end
    mousetrap.get_top_level_widget(::FileDescriptorTest) = Separator()
    
    function (::FileDescriptorTest)()
        @testset "FileDescriptor" begin
           
            name = tempname()
            path = name * ".txt"
            file = open(path, "w+")

            descriptor = FileDescriptor()
            create_from_ptah!(descriptor, path)

            @test exists(descriptor)

            @test get_name(descriptor) == name
            @test get_path(descriptor) == path
            @test get_uri(descriptor) isa String

            @test get_path_relative_to(descriptor, descriptor) == "."
            @test exists(get_parent(descriptor))
            
            @test is_file(descriptor) == true
            @test is_folder(descriptor) == false
            @test is_symlink(descriptor) == false

            # todo read_symlink

            @test is_executable(descriptor) == false
            @test get_content_type(descriptor) == "text/plain"
            @test query_info(descriptor, "standard::name") == get_name(descriptor)

            monitor = create_monitor(descriptor)
            on_file_changed!(monitor) do ::FileMonitor, ::FileMonitorEvent, ::FileDescriptor, ::FileDescriptor
            end
            cancel!(monitor)

            gtk_file = FileDescriptor(tempname() * ".txt")
            create_file_at!(gtk_file)
            delete_at!(gtk_file)
            create_direcotry_at!(gtk_file)
            move_to_trash!(gtk_file)

            close(file)
        end
    end

### FIXED



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
    Main.main_window[] = window

    Main.icon[] = Icon()

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
    add_page!(grid, "Clipboard", ClipboardTest())
    add_page!(grid, "EventController", EventControllerTest()) #=
    add_page!(grid, "Time", TimeTest())
    add_page!(grid, "ColorChooser", ColorChooserTest())
    add_page!(grid, "ColumnView", ColumnViewTest())
    add_page!(grid, "DropDown", DropDownTest())
    add_page!(grid, "Entry", EntryTest())
    add_page!(grid, "Expander", ExpanderTest())
    add_page!(grid, "FileChooser", FileChooser())
    add_page!(grid, "FileDescriptor", FileDescriptorTest())
    =#


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
