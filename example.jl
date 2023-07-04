import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main(; application_id = "stack.example") do app::Application

    println("called")

    window = Window(app)
    set_title!(window, "mousetrap.jl")

    column_view = ColumnView()

    column_01 = push_back_column!(column_view, "Column #01")
    column_02 = push_back_column!(column_view, "Column #02")
    column_03 = push_back_column!(column_view, "Column #03")

    n_rows = 9
    column_i = 1
    for column in [column_01, column_02, column_03]
        for row_i in 1:n_rows
            set_widget_at!(column_view, column, row_i, Label("0$column_i | 0$row_i"))
        end
        column_i = column_i + 1
    end

    set_expand!(column_view, true)
    set_child!(window, column_view)
    present!(window)
end
