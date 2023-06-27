import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    window = Window(app)

    entry = Entry()
    connect_signal_activate!(entry) do self::Entry
        text = get_text(self)
        println(text)
        if is_valid_html_code(text)
            println("User entered: $(html_code_to_rgba(text))")
        else
            println("error")
        end
    end

    set_child!(window, entry)

    color_chooser = ColorChooser("Choose Color")
    on_accept!(color_chooser) do self::ColorChooser, color::RGBA
        println("Selected $color")
    end
    on_cancel!(color_chooser) do self::ColorChooser
        println("color selection canceleld")
    end
    present!(color_chooser)

    present!(window)
end

#=
root = MenuModel()

    action = Action("dummy.action", app) do x 
        println("triggered.")
    end

    # action

    let model = MenuModel()
        add_action!(model, "Action Item #1", action)
        add_action!(model, "Action item #2", action)
        add_action!(model, "Action item #3", action)
        add_submenu!(root, "Actions", model)
    end
    
    # widgets 

    let model = MenuModel()
        add_widget!(model, hbox(Label("Choose Value:  "), SpinButton(0, 1, 0.01)))
        add_widget!(model, Scale(0, 1, 0.01, ORIENTATION_HORIZONTAL))
        add_widget!(model, hbox(Label("Enter Text:  "), Entry()))
        add_submenu!(root, "Widgets", model)
    end

    # submenu

    let model = MenuModel()

        function submenu_content()
            overlay = Overlay()
            separator = Separator()
            set_size_request!(separator, Vector2f(200, 100))
            set_child!(overlay, separator)
            add_overlay!(overlay, Label("&lt; submenu content &gt;"))
            return overlay
        end

        submenu_01 = MenuModel()
        
        add_widget!(submenu_01, submenu_content())
        add_submenu!(model, "Submenu #1", submenu_01)

        submenu_02 = MenuModel()
        add_widget!(submenu_02, submenu_content())
        add_submenu!(model, "Submenu #2", submenu_02)

        add_submenu!(root, "Submenu", model)
    end

    # icons

    theme = IconTheme(window)
    resolution = 64

    icon_model = MenuModel()

    let model = MenuModel()
        add_icon!(model, Icon(theme, "weather-clear-large", resolution), action)
        add_icon!(model, Icon(theme, "weather-few-clouds-large", resolution), action)
        add_icon!(model, Icon(theme, "weather-showers-large", resolution), action)
        add_icon!(model, Icon(theme, "weather-storm-large", resolution), action)    
        add_submenu!(root, "Icons", model)
    end

    # section

    let model = MenuModel()
        section = MenuModel()
        add_action!(section, "Section Item #01", action)
        add_action!(section, "Section Item #02", action)
        add_action!(section, "Section Item #03", action)
        add_section!(model, "Section Label", section)

        add_submenu!(root, "Sections", model)
    end
    
    # section format

    function add_icon_section(title::String, format::SectionFormat)
        
        section = MenuModel()
        
        add_icon!(section, Icon(theme, "weather-clear-large", resolution), action)
        add_icon!(section, Icon(theme, "weather-few-clouds-large", resolution), action)
        add_icon!(section, Icon(theme, "weather-showers-large", resolution), action)
        add_icon!(section, Icon(theme, "weather-storm-large", resolution), action)    
        
        add_section!(icon_model, title, section, format)
    end

    add_icon_section("Normal", SECTION_FORMAT_NORMAL)
    add_icon_section("Horizontal Buttons", SECTION_FORMAT_HORIZONTAL_BUTTONS)
    add_icon_section("Inline Buttons:  ", SECTION_FORMAT_INLINE_BUTTONS)
    add_icon_section("Circular Buttons", SECTION_FORMAT_CIRCULAR_BUTTONS)
   
    add_submenu!(root, "Section Formats", icon_model)
    
    # display

    view = PopoverButton(PopoverMenu(root))
    set_child!(window, view)

    # menu bar example

    root = MenuModel()

    file_submenu = MenuModel()
    add_action!(file_submenu, "Open", action)    

    file_recent_submenu = MenuModel()
    add_action!(file_recent_submenu, "Project 01", action)
    add_action!(file_recent_submenu, "Project 02", action)
    add_action!(file_recent_submenu, "Other...", action)
    add_submenu!(file_submenu, "Recent...", file_recent_submenu)

    add_action!(file_submenu, "Save", action)
    add_action!(file_submenu, "Save As...", action)
    add_action!(file_submenu, "Exit", action)

    help_submenu = MenuModel()
    add_submenu!(root, "File", file_submenu)
    add_submenu!(root, "Help", help_submenu)

    separator = Separator()
    set_expand_vertically!(separator, true)

    menubar = MenuBar(root)
    set_expand_vertically!(menubar, false)

   
    alert_dialog = AlertDialog(["Yes", "No"], "Is this is a dialog?")
    on_selection!(alert_dialog) do self::AlertDialog, button_index::Signed
        if button_index == 1
            println("User chose `Yes`")
        elseif button_index == 2
            println("User chose `No`")
        elseif button_index == 0
            println("User dismissed the dialog")
        end
    end
    present!(alert_dialog)

    set_child!(window, vbox(menubar, separator))
    =#