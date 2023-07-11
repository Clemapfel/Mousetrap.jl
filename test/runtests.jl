import Pkg; Pkg.activate(".")
using mousetrap
using Test

### action

const test_action = Ref{Union{Action, Nothing}}(nothing)

### button

struct ButtonTest <: Widget
    button::Button
    ButtonTest() = new(Button())
end
mousetrap.get_top_level_widget(x::ButtonTest) = x.button

function (this::ButtonTest)()
    @testset "Button" begin

        button = this.button

        set_child!(button, Label("Button"))

        @test get_has_frame(button)
        set_has_frame!(button, false)
        @test !get_has_frame(button)

        @test !get_is_circular(button)
        set_is_circular!(button, true)
        @test get_is_circular(button)

        set_action!(button, test_action)

        connect_signal_activate!(button) do ::Button
            @test true
        end

        connect_signal_clicked!(button) do ::Button
            @test true
        end

        println(button)
    end
end

###

function add_page(grid::Grid, title::String, page::T, x::Integer, y::Integer) where T <: Widget
    
    button = Button()
    set_child!(button, Label("&#11208;"))
    
    connect_signal_clicked!(button, page) do _::Button, page
    end

    label = Label(title)
    spacer = Separator(; opacity = 0.0)

    set_horizontal_alignment!(label, ALIGNMENT_START)
    set_horizontal_alignment!(spacer, ALIGNMENT_CENTER)
    set_horizontal_alignment!(button, ALIGNMENT_END)

    set_margin_start!(label, 10)
    set_expand!(page, true)

    frame = Frame()
    set_child!(frame, vbox(hbox(label, spacer, button), page))
    set_label_x_alignment!(frame, 0.5)

    aspect_frame = AspectFrame(1.0)
    set_child!(aspect_frame, frame)

    mousetrap.insert!(grid, aspect_frame, x, y, 1, 1)
end

main("mousetrap.runtests.jl") do app::Application
    
    window = Window(app)
    grid = Grid()
    set_rows_homogeneous!(grid, true)
    set_columns_homogeneous!(grid, true)
    set_row_spacing!(grid, 10)
    set_column_spacing!(grid, 10)
    set_margin!(grid, 10)

    Main.test_action[] = Action("test.action", app) do ::Action
        println("test")
    end
        
    add_page(grid, "Button", ButtonTest(), 1, 1)

    set_child!(window, grid)
    present!(window)
end
