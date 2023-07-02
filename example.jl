import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application

    window = Window(app)
    set_title!(window, "mousetrap.jl")

    dropdown = DropDown()
    push_back!(dropdown,
        Label("Item #01"),
        Label("01")
    )

    push_back!(dropdown, Label("Item #02"), Label("02"))
    push_back!(dropdown, Label("Item #03"), Label("03"))

    frame = Frame(dropdown)
    set_margin!(frame, 10)

    set_child!(window, frame)
    present!(window)
end
