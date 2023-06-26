import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    window = Window(app)
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
    
    # sections

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
   
    add_submenu!(root, "Sections", icon_model)
    
    # display

    view = PopoverButton(PopoverMenu(root))
    set_child!(window, view)
    present!(window)
end
