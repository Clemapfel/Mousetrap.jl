import Pkg
Pkg.activate(".")

@info "Importing `mousetrap_julia_binding` shared library"
using mousetrap 
@info "Done."

GC.enable(false)

main() do app::Application
    window = Window(app)

    # list file types of all file in current directory
    current_dir = FileDescriptor(".")
    for file in get_children(current_dir)
        println(get_name(file) * ":\t" * get_content_type(file))
    end

    present!(window)
end