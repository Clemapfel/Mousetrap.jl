import Pkg; Pkg.activate(.)
using mousetrap

function test_aspect_frame()

    instance = AspectFrame(2, 0.25, 0.75)
    @testset "AspectFrame" begin
        @test get_ratio(instance) == 2
        @test get_child_x_alignment == 0.25
        @test get_child_y_alignment == 0.75

        set_ratio!(instance, 3)
        set_child_x_alignment(instance, 0.5)
        set_child_y_alignment(instance, 0.5)

        @test get_ratio(instance) == 3
        @test get_child_x_alignment == 0.5
        @test get_child_y_alignment == 0.5
    end
end


