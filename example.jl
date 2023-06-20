import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."


main() do app::Application

    window = Window(app)
    
    drop_down = DropDown()
    push_back!(drop_down, "Item 01") do x::DropDown
        println("Item 01 selected") 
    end
    
    push_back!(drop_down, "Item 02") do x::DropDown
        println("Item 02 selected") 
    end
    
    set_child!(window, drop_down)
    present!(window)
end