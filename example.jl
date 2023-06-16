import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application
    window = Window(app)

    drop_down = DropDown()
    push_back!(drop_down, Label("Item 01 List Label"), Label("Item 01")) do x::DropDown
       println("Item 01 selected") 
       return nothing
    end

    push_back!(drop_down, Label("Item 02 List Label"), Label("Item 02")) do x::Widget
        println("Item 02 selected") 
     end
    
    set_child!(window, drop_down)
    present!(window)
end