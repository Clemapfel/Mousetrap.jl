#
# Author: C. Cords (mail@clemens-cords.com)
# https://github.com/clemapfel/mousetrap.jl
#
# Copyright © 2023, Licensed under lGPL3-0
#

using Documenter, Pkg, InteractiveUtils
using mousetrap

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

        if occursin("STYLE_CLASS", string(name))
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
                # first or second argument is type, this is the equivalent of a member function in Julia
                try
                    if hasproperty(method.sig, :parameters) && (method.sig.parameters[2] == binding || method.sig.parameters[3] == binding)
                        push!(non_signal_methods, method.name)
                    end
                catch end
            else
                push!(signal_methods, method.name)
            end
        end

        # sort by signal, as opposed to alphabetically

        signals = Set{String}()
        for method in signal_methods
            m = match(r".*_signal_(.*)_", string(method))
            if !isnothing(m)
                push!(signals, m.captures[1])
            end
        end

        signal_methods_sorted = []
        for signal in sort([signals...])
            for method in signal_methods
                if occursin("_" * signal, string(method))
                    push!(signal_methods_sorted, method)
                end
            end
            push!(signal_methods_sorted, Symbol(""))
        end

        if length(non_signal_methods) + length(signal_methods) > 0
            for m in [non_signal_methods..., Symbol(""), signal_methods_sorted...]

                if once
                    out *= "#### Functions that operate on this type:\n"
                    once = false
                end

                as_string = string(m)
                if isempty(as_string)
                    out *= "\n\n"
                    continue
                end

                seen = m in already_seen
                push!(already_seen, m)
                if seen
                    continue
                elseif binding === String # skip ID typedefs
                    continue
                elseif getproperty(mousetrap, m) isa Type # omit ctors
                    continue
                end

                out *= "+ [`$m`](@ref)\n"
            end
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
        write(file, "mousetrap.$f\n")
        write(file, "```\n")
    end
    close(file)
    @info "Done."
end 

makedocs(sitename="mousetrap")
