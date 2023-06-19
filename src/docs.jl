## Classification

widgets = Symbol[]
event_controllers = Symbol[]
signal_emitters = Symbol[]
abstract_types = Symbol[]
types = Symbol[]
functions = Symbol[]
enums = Symbol[]
enum_values = Symbol[]
other = Symbol[]

for n in names(mousetrap)

    binding = getproperty(mousetrap, n)

    if binding isa Type
        if isabstracttype(binding)
            push!(abstract_types, n)
        elseif binding <: Widget
            push!(widgets, n)
        elseif binding <: EventController
            push!(event_controllers, n)
        elseif binding <: SignalEmitter
            push!(signal_emitters, n)
        elseif binding <: Int64
            push!(enums, n)
        else
            push!(types, n)
        end
    elseif typeof(binding) <: Function
        if isnothing(match(r".*_signal_.*", string(binding))) # filter autogenerated signal functions
            if string(n)[1] != `@` # filter macros
                push!(functions, n)
            end
        end
    elseif typeof(binding) <: Int64
        push!(enum_values, n)
    else
        push!(other, n)
    end
end

## Docs Common

macro document(name, string)
    :(@doc $string $name)
end

function enum_docs(name, brief, values)
    out = "# $(name)\n"
    out *= "$(brief)\n"
    out *= "## Enum Values\n"

    for value in values
        out *= "+ `$value`\n"
    end

    return out
end

function type_brief(name, super, brief)
    out = "# $name <: $super\n"
    out *= "$brief\n"
    return out
end

struct SignalDescriptor
    id::Symbol
    signature::String
    emitted_when::String
end
const signal_descriptors = Dict{Symbol, SignalDescriptor}()

macro type_signals(name, signals...)
    out = "# Signals\n"

    if isempty(signals)
        out *= "(no unique signals)"
    else
        out *= "| Signal ID | Signature | Emitted when...|\n|---|---|---|\n"
        for id in signals
            descriptor = signal_descriptors[id]
            out *= "| `" * string(descriptor.id) * "` | `(instance::" * string(name) * ", " * descriptor.signature * "` | " * descriptor.emitted_when * "|\n"
        end
    end
    return out
end

macro type_constructors(constructors...)
    out = "# Constructors\n"
    if !isempty(constructors)
        out *= "```\n"
        for constructor in constructors
            out *= string(constructor) * "\n"
        end
        out *= "```\n"
    else
        out *= "(no public constructors)\n"
    end
    return out
end

macro type_fields()
    out = "# Fields\n"
    out *= "(no public fields)\n"   
    return out
end

macro type_fields(fields...)
    out = "# Fields\n"
    if !isempty(fields)
        for field in fields
            out *= "+ `$field`\n"
        end
    else
        out *= "(no public fields)\n"
    end
    return out
end

macro example(string)
    return "# Example\n```julia\n$string\n```"
end

using InteractiveUtils

function abstract_type_docs(type_in, super_type, brief)

    type = string(type_in)
    out = "$brief\n"
    out *= "## Supertype\n`$super_type`\n"

    out *= "## Subtypes\n"
    for t in InteractiveUtils.subtypes(type_in)
        out *= "+ `$t`\n"
    end
    return out
end

## include

include("docs/signals.jl")
include("docs/functions.jl")
include("docs/types.jl")
include("docs/enums.jl")

@do_not_compile const _generate_class_index = quote
    
    for name in sort(union(
        mousetrap.types, 
        mousetrap.signal_emitters, 
        mousetrap.widgets, 
        mousetrap.event_controllers, 
        mousetrap.abstract_types,
        mousetrap.enums
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
        
        binding = getproperty(mousetrap, name)
        already_seen = Set{Symbol}()

        for m in methodswith(binding, mousetrap)
            as_string = string(m)

            seen = m.name in already_seen
            push!(already_seen, m.name)
            if seen
                continue
            elseif binding === String # skip ID typedefs
                continue
            elseif !isnothing(match(r".*_signal_.*", as_string)) # omit autogenerated
                continue
            elseif isdefined(Base, m.name) # omit base overload
                continue
            elseif getproperty(mousetrap, m.name) isa Type # omit ctors
                continue
            end

            out *= match(r".*\(", string(m)).match[1:end-1] * "\n"
        end

        out *= "```\n"
        out *= "---\n"

        println(out)
    end
end

@do_not_compile const _generate_function_docs = quote

    for name in mousetrap.functions

        method_list = ""
        method_table = methods(getproperty(mousetrap, name))
        for i in eachindex(method_table)
            as_string = string(method_table[i])
            method_list *= as_string[1:match(r" \@.*", as_string).offset]
            if i != length(method_table)
                method_list *= "\n"
            end
        end

        println("""
        @document $name \"\"\"
        ```
        $method_list
        ```
        TODO
        \"\"\"
        """)
    end
end

@do_not_compile const _generate_type_docs = quote
    
    for name in sort(union(
        mousetrap.types, 
        mousetrap.signal_emitters, 
        mousetrap.widgets, 
        mousetrap.event_controllers, 
        mousetrap.abstract_types    
    ))

        if name in mousetrap.types
            println("""
            @document $name \"\"\"
                ## $name

                TODO

                \$(@type_constructors(
                ))

                \$(@type_fields(
                ))
            \"\"\"
            """)
        elseif name in mousetrap.abstract_types
            println("""
            @document $name abstract_type_docs($name, Any, \"\"\"
                TODO
            \"\"\")
            """)            
        else
            super = ""

            if name in mousetrap.event_controllers
                super = "EventController"
            elseif name in mousetrap.widgets
                super = "Widget"
            elseif name in mousetrap.signal_emitters
                super = "SignalEmitter"
            else
                continue
            end
            
            println("""
            @document $name \"\"\"
                ## $name <: $super

                TODO

                \$(@type_constructors(
                ))

                \$(@type_signals($name, 
                ))

                \$(@type_fields())
            \"\"\"
            """)
        end
    end
end