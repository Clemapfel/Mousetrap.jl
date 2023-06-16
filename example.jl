import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

main() do app::Application
    window = Window(app)

    column_view = ColumnView(SELECTION_MODE_NONE)

    for column_i in 1:4
        column = push_back_column!(column_view, "Column #\$1")

        # fill each column with 10 labels
        for row_i in 1:10
            set_widget!(column, row_i, Label("\$row_\$column_i)"))
        end
    end

    # or append an entire row at once
    push_back_row!(column_view, Label("01"), Label("02"), Label("03"), Label("04"))        
    present!(window)
end