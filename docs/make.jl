using Documenter, Pkg

Pkg.activate(".")
using mousetrap

using InteractiveUtils

let file = open("docs/src/02_library/classes.md", "w+")
    @info "Exporting..."
    write(file, "# Index: Classes\n")

    for name in sort(union(
        mousetrap.types, 
        mousetrap.signal_emitters, 
        mousetrap.widgets, 
        mousetrap.event_controllers, 
        mousetrap.abstract_types,
    ))
        if name in [
            :Vector2f, :Vector3f, :Vector4f,
            :Vector2i, :Vector3i, :Vector4i,
            :Vector2ui, :Vector3ui, :Vector4ui
        ]
            continue
        end
        
        out = "## $name\n"
        out *= "```@docs\n"
        out *= "$name\n"
        out *= "```\n"
        
        binding = getproperty(mousetrap, name)
        already_seen = Set{Symbol}()

        once = true

        signal_methods = []
        non_signal_methods = []

        for method in methodswith(binding, mousetrap) 
            if isnothing(match(r".*_signal_.*", string(method.name)))
                push!(non_signal_methods, method.name)
            else
                push!(signal_methods, method.name)
            end
        end

        for m in union(non_signal_methods, signal_methods)

            if once
                out *= "#### Functions that interact with this type:\n"
                once = false
            end

            as_string = string(m)

            seen = m in already_seen
            push!(already_seen, m)
            if seen
                continue
            elseif binding === String # skip ID typedefs
                continue
            elseif getproperty(mousetrap, m) isa Type # omit ctors
                continue
            end

            out *= "+ [`mousetrap.$m`](@ref)\n"
        end

        out *= "---\n"
        write(file, out)
    end

    close(file)

    file = open("docs/src/02_library/enums.md", "w+")
    write(file, "# Index: Enums\n")
    for enum_name in mousetrap.enums
        write(file, "## $enum_name\n")
        write(file, "```@docs\n")
        write(file, "$enum_name\n")
        enum = getproperty(mousetrap, enum_name)
        values = []
        for value_name in mousetrap.enum_values
            if typeof(getproperty(mousetrap, value_name)) <: enum
                write(file, "$value_name\n")
            end
        end

        write(file, "```\n")
        write(file, "---\n")
    end
    close(file)

    file = open("docs/src/02_library/functions.md", "w+")

    write(file, "# Index: Functions\n")
    
    for f in mousetrap.functions
        write(file, "## `$f`\n")
        write(file, "```@docs\n")
        write(file, "mousetrap.", f, "\n")
        write(file, "```\n")
    end
    close(file)
    @info "Done."
end 

makedocs(sitename="mousetrap")
