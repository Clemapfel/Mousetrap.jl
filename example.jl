import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

function generate_child(label::String) ::Widget
    
    child = Frame(Overlay(Separator(), Label(label)))
    set_size_request!(child, Vector2f(150, 150))
    set_margin!(child, 10)
    return child
end

main(; application_id = "stack.example") do app::Application

    window = Window(app)
    set_title!(window, "mousetrap.jl")

    stack = Stack()

    add_child!(stack, generate_child("Child #01"), "Page #01")
    add_child!(stack, generate_child("Child #02"), "Page #02")
    add_child!(stack, generate_child("Child #03"), "Page #03")

    stack = Stack()
    stack_model = get_selection_model(stack)
    connect_signal_selection_changed!(stack_model, stack) do x::SelectionModel, position::Integer, n_items::Integer, stack::Stack
        println("Current stack page is now: $(get_child_at(stack, position))")
    end

    set_child!(window, hbox(stack, StackSidebar(stack)))
    present!(window)
end
