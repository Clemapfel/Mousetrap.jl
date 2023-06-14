macro document_function(name, brief::String, return_t, args...)
   
    arg_list = ""
    n_args = length(args)
    for i in 1:n_args
        arg_list *= string(args[i])
        if i != n_args
            arg_list *= ", "
        end
    end
    signature = "($arg_list) -> $return_t"
   
    text = ""
    text *= "```\n"
    text *= "$name$signature\n"
    text *= "```\n"
    text *= "$brief\n"

    return :(@doc $text $name)
end

function document_enum(name, brief, values...)
    out = "## $(name)\n"
    out *= "$(brief)\n"
    out *= "## Enum Values\n"

    for value in enum.values
        out *= "+ `$value`\n"
    end

    return out
end

function type_brief(name, super, brief)
    out = "## $name <: $super\n"
    out *= "$brief\n"
    return out
end

const signal_descriptors = Dict{Symbol, SignalDescriptor}()
function type_signals(name, signals...)
    out = "## Signals\n"
    out *= "| Signal ID | Signature | Emitted when...|\n|---|---|---|\n"
    for id in signals
        descriptor = signal_descriptors[id]
        out *= "| `" * string(descriptor.id) * "` | `(instance::" * string(name) * ", " * descriptor.signature * "` | " * descriptor.emitted_when * "|\n"
    end
    return out
end

function type_constructors(ctors...)
    out = "## Constructors\n"
    if !isempty(constructors)
        for constructor in constructors
            out *= "+ `" * constructor * "`\n"
        end
    else
        out *= "(no public constructors)\n"
    end
end

function type_fields(fields...)
    out = "## Fields\n"
    if !isempty(fields)
        for field in fields
            out *= "+ `" * string(field[1]) * "::" * string(field[2]) * "`\n"
        end
    else
        out *= "(no public fields)\n"
    end
    return out
end

function example(string)
    return "## Example\n```julia\n$string\n```"
end

include("docs/signals.jl")
include("docs/functions.jl")
include("docs/types.jl")
include("docs/enums.jl")