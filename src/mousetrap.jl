@info "Compiling module `mousetrap`..."
__mousetrap_compile_time_start = time()

module mousetrap

####### detail.jl

    @info "Importing `libmousetrap.so`..."
    __cxxwrap_compile_time_start = time()

    module detail
        using CxxWrap
        function __init__() @initcxx end
        @wrapmodule("libjulia_binding.so")
    end

    @info "Done (" * string(round(time() - __cxxwrap_compile_time_start; digits=2)) * "s)"

####### typed_function.jl

    """
    # TypedFunction

    Object used to invoke an arbitrary function using the given signature. This wrapper
    will automatically convert any arguments and return values to the given types
    unless impossible, at which point an assertion error will be thrown on instantiation.

    In this way, it can be used to assert a functions signature at compile time.

    ### Example

    ```julia
    as_typed = TypedFunction(Int64, (Integer,)) do(x::Integer)
        return string(x)
    end
    as_typed(12) # returns 12, because "12" will be converted to given return type, Int64
    ```
    """
    mutable struct TypedFunction

        _apply::Function
        _return_t::Type
        _arg_ts::Tuple

        function TypedFunction(f::Function, return_t::Type, arg_ts::Tuple)

            actual_return_ts = Base.return_types(f, arg_ts)
            for arg_t in arg_ts

                match_found = false
                for type in actual_return_ts
                     if type <: return_t || !isempty(Base.return_types(Base.convert, (Type{return_t}, type)))
                        match_found = true
                        break;
                    end
                end

                if !match_found
                     signature = "("
                     for i in 1:length(arg_ts)
                        signature = signature * string(arg_ts[i]) * ((i < length(arg_ts)) ? ", " : ")")
                     end
                     signature = signature * " -> $return_t"
                     throw(AssertionError("Object `$f` is not invokable as function with signature `$signature`"))
                end
            end

            return new(f, return_t, arg_ts)
        end
    end
    export TypedFunction

    function (instance::TypedFunction)(args...)
        return Base.convert(instance._return_t, instance._apply([Base.convert(instance._arg_ts[i], args[i]) for i in 1:length(args)]...))
    end

####### types.jl

    abstract type SignalEmitter end
    export SignalEmitter

    abstract type Widget end
    export Widget

    abstract type EventController end
    export EventController

####### log.jl

    const LogDomain = String;
    export LogDomain

    const MOUSETRAP_DOMAIN::String = detail.MOUSETRAP_DOMAIN

    macro debug(domain, message)
        return :(mousetrap.detail.log_debug($message, $domain))
    end
    export debug

    macro info(domain, message)
        return :(mousetrap.detail.log_info($message, $domain))
    end
    export info

    macro warning(domain, message)
        return :(mousetrap.detail.log_warning($message, $domain))
    end
    export warning

    macro critical(domain, message)
        return :(mousetrap.detail.log_critical($message, $domain))
    end
    export critical

    macro fatal(domain, message)
        return :(mousetrap.detail.log_fatal($message, $domain))
    end
    export fatal

    set_surpress_debug(domain::LogDomain, b::Bool) = detail.log_set_surpress_debug(domain, b)
    export set_surpress_debug

    set_surpress_info(domain::LogDomain, b::Bool) = detail.log_set_surpress_info(domain, b)
    export set_surpress_info

    get_surpress_debug(domain::LogDomain) ::Bool = detail.log_get_surpress_debug(domain, b)
    export set_surpress_debug

    get_surpress_info(domain::LogDomain) ::Bool = detail.log_get_surpress_info(domain, b)
    export set_surpress_info

    set_log_file(path::String) = detail.log_set_file(path)
    export set_log_file

####### common.jl

    function safe_call(scope::String, f, args...)
        try
            return f(args...)
        catch exception
            printstyled(stderr, "[ERROR] "; bold = true, color = :red)
            printstyled(stderr, "In " * scope * ": "; bold = true)
            Base.showerror(stderr, exception, catch_backtrace())
            print(stderr, "\n")
            throw(exception) # this causes jl_call to return nullptr, which we can check against C-side
        end
    end

    macro export_function(type, name, return_t)

        return_t = esc(return_t)

        mousetrap.eval(:(export $name))
        return :($name(x::$type) = Base.convert($return_t, detail.$name(x._internal)))
    end

    macro export_function(type, name, return_t, arg1_type, arg1_name)

        return_t = esc(return_t)
        arg1_name = esc(arg1_name)
        arg1_type = esc(arg1_type)

        mousetrap.eval(:(export $name))
        out = :($name(x::$type, $arg1_name::$arg1_type) = Base.convert($return_t, detail.$name(x._internal, $arg1_name)))
        return out
    end

    macro export_function(type, name, return_t, arg1_type, arg1_name, arg2_type, arg2_name)

        return_t = esc(return_t)
        arg1_name = esc(arg1_name)
        arg1_type = esc(arg1_type)
        arg2_name = esc(arg2_name)
        arg2_type = esc(arg2_type)

        out = Expr(:block)
        mousetrap.eval(:(export $name))
        return :($name(
                x::$type,
                $arg1_name::$arg1_type,
                $arg2_name::$arg2_type
            ) = Base.convert(return_t, detail.$name(x._internal, $arg1_name, $arg2_name)))
    end

    macro export_function(type, name, return_t, arg1_type, arg1_name, arg2_type, arg2_name, arg3_type, arg3_name)

        return_t = esc(return_t)
        arg1_name = esc(arg1_name)
        arg1_type = esc(arg1_type)
        arg2_name = esc(arg2_name)
        arg2_type = esc(arg2_type)
        arg3_name = esc(arg3_name)
        arg3_type = esc(arg3_type)

        mousetrap.eval(:(export $name))
        return :($name(
                x::$type,
                $arg1_name::$arg1_type,
                $arg2_name::$arg2_type,
                $arg3_name::$arg3_type
            )  = Base.convert($return_t, detail.$name(x._internal, $arg1_name, $arg2_name, $arg3_name)))
    end

    macro export_function(type, name, return_t, arg1_type, arg1_name, arg2_type, arg2_name, arg3_type, arg3_name, arg4_type, arg4_name)

        return_t = esc(return_t)
        arg1_name = esc(arg1_name)
        arg1_type = esc(arg1_type)
        arg2_name = esc(arg2_name)
        arg2_type = esc(arg2_type)
        arg3_name = esc(arg3_name)
        arg3_type = esc(arg3_type)
        arg4_name = esc(arg4_name)
        arg4_type = esc(arg4_type)

        mousetrap.eval(:(export $name))
        return :($name(
                x::$type,
                $arg1_name::$arg1_type,
                $arg2_name::$arg2_type,
                $arg3_name::$arg3_type,
                $arg4_name::$arg4_type
            )  = Base.convert($return_t, detail.$name(x._internal, $arg1_name, $arg2_name, $arg3_name, $arg4_name)))
    end

    macro export_type(name, super)

        super = esc(super)
        internal_name = Symbol("_" * "$name")

        if !isdefined(detail, :($internal_name))
            throw(AssertionError("In mousetrap.@export_type: detail.$internal_name undefined"))
        end

        out = Expr(:block)
        mousetrap.eval(:(export $name))
        push!(out.args, quote
            struct $name <: $super
                _internal::detail.$internal_name
            end
        end)
        return out
    end

    macro export_type(name)

        internal_name = Symbol("_" * "$name")

        if !isdefined(detail, :($internal_name))
            throw(AssertionError("In mousetrap.@export_type: detail.$internal_name undefined"))
        end

        out = Expr(:block)
        mousetrap.eval(:(export $name))
        push!(out.args, quote
            struct $name
                _internal::detail.$internal_name
            end
        end)
        return out
    end

    macro export_enum(enum, block)

        @assert block isa Expr

        out = Expr(:toplevel)

        push!(out.args, (:(export $enum)))

        detail_enum_name = :_ * enum
        @assert isdefined(detail, detail_enum_name)

        push!(out.args, :(const $(esc(enum)) = mousetrap.detail.$detail_enum_name))
        for name in block.args
            if !(name isa Symbol)
                continue
            end

            push!(out.args, :(const $(esc(name)) = detail.$name))
            push!(out.args, :(export $name))
        end

        to_int_name = Symbol(enum) * :_to_int
        push!(out.args, :(Base.string(x::$enum) = return string(mousetrap.detail.$to_int_name(x))))
        push!(out.args, :(Base.convert(::Type{Integer}, x::$enum) = return Integer(mousetrap.detail.to_int_name(x))))

        return out
    end

    function show_aux(io::IO, x::T, fields::Symbol...) where T

        out = ""

        tostring(x) = string(x)
        tostring(x::String) = "\"" * x * "\""

        super = ""
        if T <: SignalEmitter
            super = tostring(SignalEmitter)
        elseif T <: Widget
            super = tostring(Widget)
        elseif T <: EventController
            super = tostring(EventController)
        end

        out *= "mousetrap." * tostring(T) * (!isempty(super) ? " <: " * super : "") * "\n"
        #out *= "  " * "internal" * " = @" * tostring(x._internal.cpp_object) * "\n"

        for field in fields
            getter = getproperty(mousetrap, Symbol("get_") * field)
            out *= "  " * tostring(field) * " = " * tostring(getter(x)) * "\n"
        end

        print(io, out, "end\n")
    end

    import Base: *
    *(x::Symbol, y::Symbol) = return Symbol(string(x) * string(y))

    import Base: clamp
    clamp(x::AbstractFloat, lower::AbstractFloat, upper::AbstractFloat) = if x < lower return lower elseif x > upper return upper else return x end


    function from_julia_index(x::Integer) ::UInt64
        return x - 1
    end

    function to_julia_index(x::Integer) ::Int64
        return x + 1
    end

###### vector.jl

    using StaticArrays

    """
    # Vector2{T}

    ## Public Fields
    x::T
    y::T
    """
    const Vector2{T} = SVector{2, T}
    export Vector2

    function Base.getproperty(v::Vector2{T}, symbol::Symbol) where T
        if symbol == :x
            return v[1]
        elseif symbol == :y
            return v[2]
        else
            throw(ErrorException("type Vector2 has no field " * string(symbol)))
        end
    end

    function Base.setproperty!(v::Vector2{T}, symbol::Symbol, value) where T
        if symbol == :x
            v[1] = convert(T, value)
        elseif symbol == :y
            v[2] = convert(T, value)
        else
            throw(ErrorException("type Vector2 has no field " * string(symbol)))
        end
    end

    const Vector2f = Vector2{Cfloat}
    export Vector2f

    const Vector2i = Vector2{Cint}
    export Vector2i

    const Vector2ui = Vector2{Csize_t}
    export Vector2ui

    """
    # Vector3{T}

    ## Public Fields
    x::T
    y::T
    z::T
    """
    const Vector3{T} = SVector{3, T}
    export Vector3

    function Base.getproperty(v::Vector3{T}, symbol::Symbol) where T
        if symbol == :x
            return v[1]
        elseif symbol == :y
            return v[2]
        elseif symbol == :z
            return v[3]
        else
            throw(ErrorException("type Vector3 has no field " * string(symbol)))
        end
    end

    function Base.setproperty!(v::Vector2{T}, symbol::Symbol, value) where T
        if symbol == :x
            v[1] = convert(T, value)
        elseif symbol == :y
            v[2] = convert(T, value)
        elseif symbol == :z
            v[3] = convert(T, value)
        else
            throw(ErrorException("type Vector2 has no field " * string(symbol)))
        end
    end

    const Vector3f = Vector3{Cfloat}
    export Vector3f

    const Vector3i = Vector3{Cint}
    export Vector3i

    const Vector3ui = Vector3{Csize_t}
    export Vector3ui

    """
    # Vector4{T}

    ## Public Fields
    x::T
    y::T
    z::T
    w::T
    """
    const Vector4{T} = SVector{4, T}
    export Vector4

    function Base.getproperty(v::Vector4{T}, symbol::Symbol) where T
        if symbol == :x
            return v[1]
        elseif symbol == :y
            return v[2]
        elseif symbol == :z
            return v[3]
        elseif symbol == :w
            return v[4]
        else
            throw(ErrorException("type Vector4 has no field " * string(symbol)))
        end
    end

    function Base.setproperty!(v::Vector4{T}, symbol::Symbol, value) where T
        if symbol == :x
            v[1] = convert(T, value)
        elseif symbol == :y
            v[2] = convert(T, value)
        elseif symbol == :z
            v[3] = convert(T, value)
        elseif symbol == :w
            v[4] = convert(T, value)
        else
            throw(ErrorException("type Vector4 has no field " * string(symbol)))
        end
    end

    const Vector4f = Vector4{Cfloat}
    export Vector4f

    const Vector4i = Vector4{Cint}
    export Vector4i

    const Vector4ui = Vector4{Csize_t}
    export Vector4ui

    Base.show(io::IO, x::Vector2{T}) where T = print(io, "Vector2{" * string(T) * "}(" * string(x.x) * ", " * string(x.y) * ")")
    Base.show(io::IO, x::Vector3{T}) where T = print(io, "Vector3{" * string(T) * "}(" * string(x.x) * ", " * string(x.y) * ", " * string(x.z) * ")")
    Base.show(io::IO, x::Vector4{T}) where T = print(io, "Vector4{" * string(T) * "}(" * string(x.x) * ", " * string(x.y) * ", " * string(x.z) * ", " * string(x.w) * ")")

####### geometry.jl

    struct Rectangle
        top_left::Vector2f
        size::Vector2f
    end
    export Rectangle

####### time.jl

    struct Time
        _ns::UInt64
    end
    export Time

    as_minutes(time::Time) ::Cdouble = detail.ns_to_minutes(time._ns)
    export as_minutes

    as_seconds(time::Time) ::Cdouble = detail.ns_to_seconds(time._ns)
    export as_seconds

    as_milliseconds(time::Time) ::Cdouble = detail.ns_to_milliseconds(time._ns)
    export as_milliseconds

    as_microseconds(time::Time) ::Cdouble = detail.ns_to_microseconds(time._ns)
    export as_microseconds

    as_nanoseconds(time::Time) ::Int64 = time._ns
    export as_nanoseconds

    minutes(n::AbstractFloat) = Time(detail.minutes_to_ns(n))
    export minutes

    seconds(n::AbstractFloat) = Time(detail.seconds_to_ns(n))
    export seconds

    milliseconds(n::AbstractFloat) = Time(detail.milliseconds_to_ns(n))
    export milliseconds

    microseconds(n::AbstractFloat) = Time(detail.microseconds_to_ns(n))
    export microseconds

    nanoseconds(n::Int64) = Time(n)
    export nanoseconds

    import Base.+
    +(a::Time, b::Time) = Time(a._ns + b._ns)

    import Base.-
    -(a::Time, b::Time) = Time(a._ns - b._ns)

    import Base.==
    ==(a::Time, b::Time) = a._ns == b._ns

    import Base.!=
    !=(a::Time, b::Time) = a._ns != b._ns

    import Base.<
    <(a::Time, b::Time) = a._ns < b._ns

    import Base.<=
    <=(a::Time, b::Time) = a._ns <= b._ns

    import Base.>
    >(a::Time, b::Time) = a._ns > b._ns

    import Base.>=
    >=(a::Time, b::Time) = a._ns >= b._ns

    import Dates
    Base.convert(::Type{Dates.Minute}, time::Time) = Dates.Minute(as_minutes(time))
    Base.convert(::Type{Dates.Second}, time::Time) = Dates.Second(as_seconds(time))
    Base.convert(::Type{Dates.Millisecond}, time::Time) = Dates.Millisecond(as_millisecond(time))
    Base.convert(::Type{Dates.Microsecond}, time::Time) = Dates.Microsecond(as_microsecond(time))
    Base.convert(::Type{Dates.Nanosecond}, time::Time) = Dates.Nanosecond(as_nanoseconds(time))

    @export_type Clock SignalEmitter
    Clock() = Clock(detail._Clock())

    restart!(clock::Clock) ::Time = microseconds(detail.restart!(clock._internal))
    export restart!

    elapsed(clock::Clock) ::Time = microseconds(detail.elapsed(clock._internal))
    export elapsed

####### angle.jl

    struct Angle
        _rads::Cfloat
    end
    export Angle

    degrees(x::Number) = return Angle(convert(Cfloat, deg2rad(x)))
    export degrees

    radians(x::Number) = return Angle(convert(Cfloat, x))
    export radians

    as_degrees(angle::Angle) = return rad2deg(angle._rads)
    export as_degrees

    as_radians(angle::Angle) = return angle._rads
    export as_radians

    import Base: +
    +(a::Angle, b::Angle) = return Angle(a._rads + b._rads)

    import Base: -
    -(a::Angle, b::Angle) = return Angle(a._rads - b._rads)

    import Base: *
    *(a::Angle, b::Angle) = return Angle(a._rads * b._rads)

    import Base: /
    /(a::Angle, b::Angle) = return Angle(a._rads / b._rads)

    import Base: ==
    ==(a::Angle, b::Angle) = return a._rads == b._rads

    import Base: !=
    !=(a::Angle, b::Angle) = return a._rads != b._rads

####### signal_components.jl

    macro add_signal(T, snake_case, Return_t)

        out = Expr(:block)

        connect_signal_name = :connect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T,))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]))
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

    macro add_signal(T, snake_case, Return_t, Arg1_t, arg1_name)

        out = Expr(:block)

        connect_signal_name = :connect_signal_ * snake_case * :!

        Arg1_t = esc(Arg1_t)

        arg1_name = esc(arg1_name)

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2])
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2], data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T, $arg1_name::$Arg1_t) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, $arg1_name))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

    macro add_signal(T, snake_case, Return_t, Arg1_t, arg1_name, Arg2_t, arg2_name)

        out = Expr(:block)

        connect_signal_name = :connect_signal_ * snake_case * :!

        Arg1_t = esc(Arg1_t)
        Arg2_t = esc(Arg2_t)

        arg1_name = esc(arg1_name)
        arg2_name = esc(arg2_name)

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg2_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2], x[3])
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg2_t, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2], x[3], data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T, $arg1_name::$Arg1_t, $arg2_name::$Arg2_t) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, $arg1_name, $arg2_name))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

    macro add_signal(T, snake_case, Return_t, Arg1_t, arg1_name, Arg2_t, arg2_name, Arg3_t, arg3_name)

        out = Expr(:block)

        connect_signal_name = :connect_signal_ * snake_case * :!

        Arg1_t = esc(Arg1_t)
        Arg2_t = esc(Arg2_t)
        Arg3_t = esc(Arg3_t)

        arg1_name = esc(arg1_name)
        arg2_name = esc(arg2_name)
        arg3_name = esc(arg3_name)

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg2_t, $Arg3_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2], x[3], x[4])
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg2_t, $Arg3_t, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2], x[3], x[4], data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T, $arg1_name::$Arg1_t, $arg2_name::$Arg2_t, $arg3_name::$Arg3_t) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, $arg1_name, $arg2_name, $arg3_name))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

    macro add_signal(T, snake_case, Return_t, Arg1_t, arg1_name, Arg2_t, arg2_name, Arg3_t, arg3_name, Arg4_t, arg4_name)

        out = Expr(:block)

        connect_signal_name = :connect_signal_ * snake_case * :!

        Arg1_t = esc(Arg1_t)
        Arg2_t = esc(Arg2_t)
        Arg3_t = esc(Arg3_t)
        Arg4_t = esc(Arg4_t)

        arg1_name = esc(arg1_name)
        arg2_name = esc(arg2_name)
        arg3_name = esc(arg3_name)
        arg4_name = esc(arg4_name)

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg2_t, $Arg3_t, $Arg4_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2], x[3], x[4], x[5])
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg2_t, $Arg3_t, $Arg4_t, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2], x[3], x[4], x[5], data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T, $arg1_name::$Arg1_t, $arg2_name::$Arg2_t, $arg3_name::$Arg3_t, $arg4_name::$Arg4_t) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, $arg1_name, $arg2_name, $arg3_name, $arg4_name))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

    macro add_widget_signals(x)
        return quote
            @add_signal $x realize Cvoid
            @add_signal $x unrealize Cvoid
            @add_signal $x destroy Cvoid
            @add_signal $x hide Cvoid
            @add_signal $x show Cvoid
            @add_signal $x map Cvoid
            @add_signal $x unmap Cvoid
        end
    end

    ## TODO: JUMP

    macro add_signal_activate(x) return :(@add_signal $x activate Cvoid) end
    macro add_signal_shutdown(x) return :(@add_signal $x shutdown Cvoid) end
    macro add_signal_clicked(x) return :(@add_signal $x clicked Cvoid) end
    macro add_signal_toggled(x) return :(@add_signal $x toggled Cvoid) end
    macro add_signal_activate_default_widget(x) return :(@add_signal $x activate_default_widget Cvoid) end
    macro add_signal_activate_focused_widget(x) return :(@add_signal $x activate_focused_widget Cvoid) end
    macro add_signal_close_request(x) return :(@add_signal $x close_request WindowCloseRequestResult) end
    macro add_signal_items_changed(x) return :(@add_signal $x items_changed Cvoid Int32 position Int32 n_removed Int32 n_added) end
    macro add_signal_closed(x) return :(@add_signal $x closed Cvoid) end
    macro add_signal_text_changed(x) return :(@add_signal $x text_changed Cvoid) end
    macro add_signal_redo(x) return :(@add_signal $x redo Cvoid) end
    macro add_signal_undo(x) return :(@add_signal $x undo Cvoid) end
    macro add_signal_drag_begin(x) return :(@add_signal $x drag_begin Cvoid Cdouble start_x Cdouble start_y) end
    macro add_signal_drag(x) return :(@add_signal $x drag Cvoid Cdouble offset_x Cdouble offset_y) end
    macro add_signal_drag_end(x) return :(@add_signal $x drag_end Cvoid Cdouble offset_x Cdouble offset_y) end
    macro add_signal_click_pressed(x) return :(@add_signal $x click_pressed Cvoid Cint n_press Cdouble x Cdouble y) end
    macro add_signal_click_released(x) return :(@add_signal $x click_released Cvoid Cint n_press Cdouble x Cdouble y) end
    macro add_signal_click_stopped(x) return :(@add_signal $x click_stopped Cvoid) end
    macro add_signal_focus_gained(x) return :(@add_signal $x focus_gained Cvoid) end
    macro add_signal_focus_lost(x) return :(@add_signal $x focus_lost Cvoid) end
    macro add_signal_key_pressed(x) return :(@add_signal $x key_pressed Bool Cint key_value Cint key_code ModifierState modifier) end
    macro add_signal_key_released(x) return :(@add_signal $x key_released Bool Cint key_value Cint key_code ModifierState modifier) end
    macro add_signal_modifiers_changed(x) return :(@add_signal $x modifiers_changed Bool Cint key_value Cint key_code ModifierState modifier) end
    macro add_signal_pressed(x) return :(@add_signal $x pressed Cvoid Cdouble x Cdouble y) end
    macro add_signal_press_cancelled(x) return :(@add_signal $x press_cancelled Cvoid) end
    macro add_signal_motion_enter(x) return :(@add_signal $x motion_enter Cvoid Cdouble x Cdouble y) end
    macro add_signal_motion(x) return :(@add_signal $x motion Cvoid Cdouble x Cdouble y) end
    macro add_signal_motion_leave(x) return :(@add_signal $x motion_leave Cvoid) end
    macro add_signal_scale_changed(x) return :(@add_signal $x scale_changed Cvoid Cdouble scale) end
    macro add_signal_rotation_changed(x) return :(@add_signal $x rotation_changed Cvoid Cdouble angle_absolute_rads Cdouble angle_delta_rads) end
    macro add_signal_kinetic_scroll_decelerate(x) return :(@add_signal $x scroll_decelerate Cvoid Cdouble x_velocity Cdouble y_velocity) end
    macro add_signal_scroll_begin(x) return :(@add_signal $x scroll_begin Cvoid) end
    macro add_signal_scroll(x) return :(@add_signal $x scroll Bool Cdouble delta_x Cdouble delta_y) end
    macro add_signal_scroll_end(x) return :(@add_signal $x scroll_end Cvoid) end
    macro add_signal_stylus_up(x) return :(@add_signal $x stylus_up Cvoid Cdouble x Cdouble y) end
    macro add_signal_stylus_down(x) return :(@add_signal $x stylus_down Cvoid Cdouble x Cdouble y) end
    macro add_signal_proximity(x) return :(@add_signal $x proximity Cvoid Cdouble x Cdouble y) end
    macro add_signal_swipe(x) return :(@add_signal $x swipe Cvoid Cdouble x_velocity Cdouble y_velocity) end
    macro add_signal_pan(x) return :(@add_signal $x pan Cvoid PanDirection direction Cdouble offset) end
    macro add_signal_paint(x) return :(@add_signal $x paint Cvoid) end
    macro add_signal_update(x) return :(@add_signal $x paint Cvoid) end
    macro add_signal_value_changed(x) return :(@add_signal $x value_changed Cvoid) end
    macro add_signal_wrapped(x) return :(@add_signal $x wrapped Cvoid) end
    macro add_signal_scroll_child(x) return :(@add_signal $x scroll_child Cvoid ScrollType type Bool is_horizontal) end
    macro add_signal_resize(x) return :(@add_signal $x resize Cvoid Cint width Cint height) end

    macro add_signal_activated(T)

        out = Expr(:block)
        snake_case = :activated
        Return_t = Cvoid

        connect_signal_name = :connect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T,))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]))
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, nothing))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

    macro add_signal_revealed(T)

        out = Expr(:block)
        snake_case = :revealed
        Return_t = Cvoid

        connect_signal_name = :connect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T,))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]))
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, nothing))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

    macro add_signal_selection_changed(T)

        snake_case = :selection_changed

        Arg1_t = Int64
        arg1_name = :position

        Arg2_t = Int64
        arg2_name = :n_items

        Return_t = Cvoid

        out = Expr(:block)

        connect_signal_name = :connect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg2_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), to_julia_index(x[2]), x[3])
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg2_t, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), to_julia_index(x[2]), x[3], data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T, $arg1_name::$Arg1_t, $arg2_name::$Arg2_t) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, from_julia_index($arg1_name), $arg2_name))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

    macro add_notebook_signal(T, snake_case)

        out = Expr(:block)

        Return_t = Cvoid
        connect_signal_name = :connect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T, Integer))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), to_julia_index(x[3]))
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, Integer, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), to_julia_index(x[3]), data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T, page_index::Integer) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, from_julia_index(page_index)))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

    macro add_signal_render(T)

        out = Expr(:block)
        snake_case = :render
        Return_t = Bool

        connect_signal_name = :connect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T,))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]))
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, Ptr{Cvoid}()))
            end
        )))

        disconnect_signal_name = :disconnect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $disconnect_signal_name(x::$T)
                detail.$disconnect_signal_name(x._internal)
            end
        )))

        set_signal_blocked_name = :set_signal_ * snake_case * :_blocked * :!

        push!(out.args, esc(:(
            function $set_signal_blocked_name(x::$T, b)
                detail.$set_signal_blocked_name(x._internal, b)
            end
        )))

        get_signal_blocked_name = :get_signal_ * snake_case * :_blocked

        push!(out.args, esc(:(
            function $get_signal_blocked_name(x::$T)
                return detail.$get_signal_blocked_name(x._internal)
            end
        )))

        push!(out.args, esc(:(export $connect_signal_name)))
        push!(out.args, esc(:(export $disconnect_signal_name)))
        push!(out.args, esc(:(export $set_signal_blocked_name)))
        push!(out.args, esc(:(export $get_signal_blocked_name)))
        push!(out.args, esc(:(export $emit_signal_name)))

        return out
    end

####### application.jl

    @export_type Application SignalEmitter
    @export_type Action SignalEmitter

    Application(id::String) = Application(detail._Application(id))

    run!(x::Application) = mousetrap.detail.run!(x._internal)
    export run!

    @export_function Application quit! Cvoid
    @export_function Application hold! Cvoid
    @export_function Application release! Cvoid
    @export_function Application mark_as_busy! Cvoid
    @export_function Application unmark_as_busy! Cvoid
    @export_function Application get_id String

    add_action!(app::Application, action::Action) = detail.add_action!(app._internal, action._internal)
    export add_action

    get_action(app::Application, id::String) ::Action = return Action(detail.get_action(app._internal, id))
    export get_action

    @export_function Application remove_action! Cvoid String id
    @export_function Application has_action Bool String id

    @add_signal_activate Application
    @add_signal_shutdown Application

    Base.show(io::IO, x::Application) = show_aux(x, :id)

    function main(f; application_id::String = "mousetrap.jl") ::Int64
        app = Application(application_id)
        typed_f = TypedFunction(f, Any, (Application,))
        connect_signal_activate!(app) do app::Application
            try
                typed_f(app)
            catch(exception)
                printstyled(stderr, "[ERROR] "; bold = true, color = :red)
                printstyled(stderr, "In mousetrap.main: "; bold = true)
                Base.showerror(stderr, exception, catch_backtrace())
                print(stderr, "\n")
                quit!(app)
            end
        end

        try
            return run!(app)
        finally
            quit!(app)
        end
    end
    # sic, no export

####### window.jl

    @export_enum WindowCloseRequestResult begin
        WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE
        WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE
    end

    @export_type Window Widget
    Window(app::Application) = Window(detail._Window(app._internal))

    function set_application!(window::Window, app::Application)
        detail.set_application!(window._internal, app._internal)
    end
    export set_application!

    @export_function Window set_maximized! Cvoid
    @export_function Window set_fullscreen! Cvoid
    @export_function Window present! Cvoid
    @export_function Window set_hide_on_close! Cvoid Bool b
    @export_function Window close! Cvoid

    function set_child!(window::Window, child::Widget)
        detail.set_child!(window._internal, child._internal.cpp_object)
    end
    export set_child!

    @export_function Window remove_child! Cvoid
    @export_function Window set_destroy_with_parent! Cvoid Bool n
    @export_function Window get_destroy_with_parent Bool
    @export_function Window set_title! Cvoid String title
    @export_function Window get_title String

    function set_titlebar_widget!(window::Window, titlebar::Widget)
        detail.set_titlebar_widget!(window._internal, titlebar._internal.cpp_object)
    end
    export set_titlebar_widget!

    @export_function Window remove_titlebar_widget! Cvoid
    @export_function Window set_is_modal! Cvoid Bool b
    @export_function Window get_is_modal Bool

    function set_transient_for(self::Window, other::Window)
        detail.set_transient_for!(self._itnernal, other._internal)
    end
    export set_transient_for!

    @export_function Window set_is_decorated! Cvoid Bool b
    @export_function Window get_is_decorated Bool
    @export_function Window set_has_close_button! Cvoid Bool b
    @export_function Window get_has_close_button Bool
    @export_function Window set_startup_notification_identifier! Cvoid String id
    @export_function Window set_focus_visible! Cvoid Bool b
    @export_function Window get_focus_visible Bool

    function set_default_widget!(window::Window, widget::Widget)
        detail.set_default_widget!(window._internal, widget._internal.cpp_object)
    end
    export set_default_widget!

    @add_widget_signals Window
    @add_signal_close_request Window
    @add_signal_activate_default_widget Window
    @add_signal_activate_focused_widget Window

    Base.show(io::IO, x::Window) = show_aux(io, x, :title)

####### action.jl

    @export_type Action SignalEmitter
    Action(id::String, app::Application) = Action(detail._Action(id, app._internal.cpp_object))

    @export_function Action get_id String
    @export_function Action set_state! Cvoid Bool b
    @export_function Action get_state Bool
    @export_function Action activate Cvoid
    @export_function Action add_shortcut! Cvoid String shortcut

    get_shortcuts(action::Action) ::Vector{String} = return detail.get_shortcuts(action._internal)[]
    export get_shortcuts

    @export_function Action clear_shortcuts! Cvoid
    @export_function Action set_enabled! Cvoid Bool b
    @export_function Action get_enabled Bool
    @export_function Action get_is_stateful Bool

    function set_function!(f, action::Action, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (Action, Data_t))
        detail.set_function!(action._internal, function (internal_ref)
            typed_f(Action(internal_ref[]), data)
        end)
    end

    function set_function!(f, action::Action)
        typed_f = TypedFunction(f, Cvoid, (Action,))
        detail.set_function!(action._internal, function (internal_ref)
            typed_f(Action(internal_ref[]))
        end)
    end
    export set_function!

    function set_stateful_function!(f, action::Action, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Bool, (Action, Bool, Data_t))
        detail.set_stateful_function!(action._internal, function (internal_ref, state::Bool)
            typed_f(Action(internal_ref[]), state, data)
        end)
    end

    function set_stateful_function!(f, action::Action)
        typed_f = TypedFunction(f, Bool, (Action, Bool))
        detail.set_stateful_function!(action._internal, function (internal_ref, state::Bool)
            typed_f(Action(internal_ref[]), state)
        end)
    end
    export set_stateful_function!

    @add_signal_activated Action

    Base.show(io::IO, x::Action) = mousetrap.show_aux(io, x, :id, :enabled, :shortcuts, :is_stateful, :state)

####### adjustment.jl

    @export_type Adjustment SignalEmitter

    function Adjustment(value::Number, lower::Number, upper::Number, increment::Number)
        return Adjustment(detail._Adjustment(
            convert(Cfloat, value),
            convert(Cfloat, lower),
            convert(Cfloat, upper),
            convert(Cfloat, increment)
        ));
    end

    Adjustment(internal::Ptr{Cvoid}) = Adjustment(detail._Adjustment(internal))

    @export_function Adjustment get_lower Float32
    @export_function Adjustment get_upper Float32
    @export_function Adjustment get_value Float32
    @export_function Adjustment get_increment Float32

    set_lower!(adjustment::Adjustment, x::Number) = detail.set_lower!(adjustment._internal, convert(Cfloat, x))
    export set_lower!

    set_upper!(adjustment::Adjustment, x::Number) = detail.set_upper!(adjustment._internal, convert(Cfloat, x))
    export set_upper!

    set_value!(adjustment::Adjustment, x::Number) = detail.set_value!(adjustment._internal, convert(Cfloat, x))
    export set_value!

    set_increment!(adjustment::Adjustment, x::Number) = detail.set_increment!(adjustment._internal, convert(Cfloat, x))
    export set_increment!

    Base.show(io::IO, x::Adjustment) = mousetrap.show_aux(io, x, :value, :lower, :upper, :increment)

####### alignment.jl

    @export_enum Alignment begin
        ALIGNMENT_START
        ALIGNMENT_CENTER
        ALIGNMENT_END
    end

####### orientation.jl

    @export_enum Orientation begin
        ORIENTATION_HORIZONTAL
        ORIENTATION_VERTICAL
    end

####### cursor_type.jl

    @export_enum CursorType begin
        CURSOR_TYPE_NONE
        CURSOR_TYPE_DEFAULT
        CURSOR_TYPE_HELP
        CURSOR_TYPE_POINTER
        CURSOR_TYPE_CONTEXT_MENU
        CURSOR_TYPE_PROGRESS
        CURSOR_TYPE_WAIT
        CURSOR_TYPE_CELL
        CURSOR_TYPE_CROSSHAIR
        CURSOR_TYPE_TEXT
        CURSOR_TYPE_MOVE
        CURSOR_TYPE_NOT_ALLOWED
        CURSOR_TYPE_GRAB
        CURSOR_TYPE_GRABBING
        CURSOR_TYPE_ALL_SCROLL
        CURSOR_TYPE_ZOOM_IN
        CURSOR_TYPE_ZOOM_OUT
        CURSOR_TYPE_COLUMN_RESIZE
        CURSOR_TYPE_ROW_RESIZE
        CURSOR_TYPE_NORTH_RESIZE
        CURSOR_TYPE_NORTH_EAST_RESIZE
        CURSOR_TYPE_EAST_RESIZE
        CURSOR_TYPE_SOUTH_EAST_RESIZE
        CURSOR_TYPE_SOUTH_RESIZE
        CURSOR_TYPE_SOUTH_WEST_RESIZE
        CURSOR_TYPE_WEST_RESIZE
        CURSOR_TYPE_NORTH_WEST_RESIZE
    end

    const CURSOR_TYPE_HORIZONTAL_RESIZE = CURSOR_TYPE_ROW_RESIZE
    const CURSOR_TYPE_VERTICAL_RESIZE = CURSOR_TYPE_COLUMN_RESIZE

####### aspect_frame.jl

    @export_type AspectFrame Widget
    function AspectFrame(ratio::AbstractFloat; child_x_alignment::AbstractFloat = 0.5, child_y_alignment::AbstractFloat = 0.5)
        return AspectFrame(detail._AspectFrame(ratio, child_x_alignment, child_y_alignment))
    end

    @export_function AspectFrame set_ratio! Cvoid AbstractFloat ratio
    @export_function AspectFrame get_ratio Cfloat
    @export_function AspectFrame set_child_x_alignment! Cvoid AbstractFloat alignment
    @export_function AspectFrame set_child_y_alignment! Cvoid AbstractFloat alignment
    @export_function AspectFrame get_child_x_alignment Cfloat
    @export_function AspectFrame get_child_y_alignment Cfloat

    @export_function AspectFrame remove_child! Cvoid

    set_child!(aspect_frame::AspectFrame, child::Widget) = detail.set_child!(aspect_frame._internal, child._internal.cpp_object)
    export set_child!

    Base.show(io::IO, x::AspectFrame) = mousetrap.show_aux(io, x, :ratio, :child_x_alignment, :child_y_alignment)

####### box.jl

    @export_type Box Widget
    Box(orientation::Orientation) = Box(detail._Box(orientation))

    function push_back!(box::Box, widget::Widget)
        detail.push_back!(box._internal, widget._internal.cpp_object)
    end
    export push_back!

    function push_front!(box::Box, widget::Widget)
        detail.push_front!(box._internal, widget._internal.cpp_object)
    end
    export push_front!

    function insert_after!(box::Box, to_append::Widget, after::Widget)
        detail.push_front!(box._internal, to_append._internal.cpp_object, after._internal.cpp_object)
    end
    export insert_after!

    function remove!(box::Box, widget::Widget)
        detail.remove!(box._internal, widget._internal.cpp_object)
    end
    export remove!

    @export_function Box clear Cvoid
    @export_function Box set_homogeneous! Cvoid Bool b
    @export_function Box get_homogeneous Bool

    function set_spacing!(box::Box, spacing::Number) ::Cvoid
        detail.set_spacing!(box._internal, convert(Cfloat, spacing))
    end
    export set_spacing!

    @export_function Box get_spacing Cfloat
    @export_function Box get_n_items Cint
    @export_function Box get_orientation Orientation
    @export_function Box set_orientation! Cvoid Orientation orientation

    @add_widget_signals Box

####### button.jl

    @export_type Button Widget
    Button() = Button(detail._Button())

    @export_function Button set_has_frame! Cvoid Bool b
    @export_function Button get_has_frame Bool
    @export_function Button set_is_circular Cvoid Bool b
    @export_function Button get_is_circular Bool

    function set_child!(button::Button, child::Widget)
        detail.set_child!(button._internal, child._internal.cpp_object)
    end
    export set_child!

    @export_function Button remove_child! Cvoid

    function set_action!(button::Button, action::Action)
        detail.set_action!(button._internal, action._internal)
    end
    export set_action!

    @add_widget_signals Button
    @add_signal_activate Button
    @add_signal_clicked Button

####### center_box.jl

    @export_type CenterBox Widget
    CenterBox(orientation::Orientation) = CenterBox(detail._CenterBox(orientation))

    function set_start_child!(center_box::CenterBox, child::Widget)
        detail.set_start_child!(center_box._internal, child._internal.cpp_object)
    end
    export set_start_child!

    function set_center_child!(center_box::CenterBox, child::Widget)
        detail.set_center_child!(center_box._internal, child._internal.cpp_object)
    end
    export set_center_child!

    function set_end_child!(center_box::CenterBox, child::Widget)
        detail.set_end_child!(center_box._internal, child._internal.cpp_object)
    end
    export set_end_child!

    @export_function CenterBox remove_start_widget! Cvoid
    @export_function CenterBox remove_center_widget! Cvoid
    @export_function CenterBox remove_end_widget! Cvoid
    @export_function CenterBox get_orientation Orientation
    @export_function CenterBox set_orientation! Cvoid Orientation orientation

    @add_widget_signals CenterBox

####### check_button.jl

    @export_enum CheckButtonState begin
        CHECK_BUTTON_STATE_ACTIVE
        CHECK_BUTTON_STATE_INCONSISTENT
        CHECK_BUTTON_STATE_INACTIVE
    end

    @export_type CheckButton Widget
    CheckButton() = CheckButton(detail._CheckButton())

    @export_function CheckButton set_state! Cvoid CheckButtonState state
    @export_function CheckButton get_state CheckButtonState
    @export_function CheckButton get_is_active Bool

    if detail.GTK_MINOR_VERSION >= 8
        function set_child!(check_button::CheckButton, child::Widget)
            detail.set_child!(check_button._internal, child._internal.cpp_object)
        end
        export set_child!

        @export_function CheckButton remove_child! Cvoid
    end

    @add_widget_signals CheckButton
    @add_signal_toggled CheckButton
    @add_signal_activate CheckButton

####### switch.jl

    @export_type Switch Widget
    Switch() = Switch(detail._Switch())

    @export_function Switch get_is_active Bool
    @export_function Switch set_is_active! Cvoid Bool b

    @add_widget_signals Switch
    @add_signal_activate Switch

####### toggle_button.jl

    @export_type ToggleButton Widget
    ToggleButton() = ToggleButton(detail._ToggleButton())

    @export_function ToggleButton get_is_active Bool
    @export_function ToggleButton set_is_active! Cvoid Bool b

    @add_widget_signals ToggleButton
    @add_signal_activate ToggleButton
    @add_signal_clicked ToggleButton
    @add_signal_toggled ToggleButton

####### viewport.jl

    @export_enum ScrollbarVisibilityPolicy begin
        SCROLLBAR_VISIBILITY_POLICY_NEVER
        SCROLLBAR_VISIBILITY_POLICY_ALWAYS
        SCROLLBAR_VISIBILITY_POLICY_AUTOMATIC
    end

    @export_enum CornerPlacement begin
        CORNER_PLACEMENT_TOP_LEFT
        CORNER_PLACEMENT_TOP_RIGHT
        CORNER_PLACEMENT_BOTTOM_LEFT
        CORNER_PLACEMENT_BOTTOM_RIGHT
    end

    @export_type Viewport Widget
    Viewport() = Viewport(detail._Viewport())

    @export_function Viewport set_propagate_natural_height! Cvoid Bool b
    @export_function Viewport get_propagate_natural_height Bool
    @export_function Viewport set_propagate_natural_width! Cvoid Bool b
    @export_function Viewport get_propagate_natural_width Bool
    @export_function Viewport set_horizontal_scrollbar_policy! Cvoid ScrollbarVisibilityPolicy policy
    @export_function Viewport set_vertical_scrollbar_policy! Cvoid ScrollbarVisibilityPolicy policy
    @export_function Viewport get_horizontal_scrollbar_policy ScrollbarVisibilityPolicy
    @export_function Viewport get_vertical_scrollbar_policy ScrollbarVisibilityPolicy
    @export_function Viewport set_scrollbar_placement! Cvoid CornerPlacement placement
    @export_function Viewport get_scrollbar_placement CornerPlacement
    @export_function Viewport set_has_frame! Cvoid Bool b
    @export_function Viewport get_has_frame Bool
    @export_function Viewport set_kinetic_scrolling_enabled! Cvoid Bool b
    @export_function Viewport get_kinetic_scrolling_enabled Bool

    get_horizontal_adjustment(viewport::Viewport) ::Adjustment = Adjustment(detail.get_horizontal_adjustment(viewport._internal))
    export get_horizontal_adjustment

    get_vertical_adjustment(viewport::Viewport) ::Adjustment = Adjustment(detail.get_vertical_adjustment(viewport._internal))
    export get_vertical_adjustment

    set_child!(viewport::Viewport, child::Widget) = detail.set_child(viewport._internal, child._internal.cpp_object)
    export set_child!

    @export_function Viewport remove_child Cvoid

    @export_enum ScrollType begin
        SCROLL_TYPE_NONE
        SCROLL_TYPE_JUMP
        SCROLL_TYPE_STEP_BACKWARD
        SCROLL_TYPE_STEP_FORWARD
        SCROLL_TYPE_STEP_UP
        SCROLL_TYPE_STEP_DOWN
        SCROLL_TYPE_STEP_LEFT
        SCROLL_TYPE_STEP_RIGHT
        SCROLL_TYPE_PAGE_BACKWARD
        SCROLL_TYPE_PAGE_FORWARD
        SCROLL_TYPE_PAGE_UP
        SCROLL_TYPE_PAGE_DOWN
        SCROLL_TYPE_PAGE_LEFT
        SCROLL_TYPE_PAGE_RIGHT
        SCROLL_TYPE_SCROLL_START
        SCROLL_TYPE_SCROLL_END
    end

    @add_widget_signals Viewport
    @add_signal_scroll_child Viewport

####### color.jl

    abstract type Color end

    struct RGBA <: Color
        r::Cfloat
        g::Cfloat
        b::Cfloat
        a::Cfloat
    end
    export RGBA

    function RGBA(r::AbstractFloat, g::AbstractFloat, b::AbstractFloat, a::AbstractFloat)
        return RBGA(
            convert(Cfloat, r),
            convert(Cfloat, g),
            convert(Cfloat, b),
            convert(Cfloat, a)
        )
    end

    struct HSVA <: Color
        h::Cfloat
        s::Cfloat
        v::Cfloat
        a::Cfloat
    end
    export HSVA

    function HSVA(h::AbstractFloat, s::AbstractFloat, v::AbstractFloat, a::AbstractFloat)
        return HSVA(
            convert(Cfloat, h),
            convert(Cfloat, s),
            convert(Cfloat, v),
            convert(Cfloat, a)
        )
    end

    rgba_to_hsva(rgba::RGBA) = detail.rgba_to_hsva(rgba)
    export rgba_to_hsva

    hsva_to_rgba(hsva::HSVA) = detail.hsva_to_rgba(hsva)
    export hsva_to_rgba

    rgba_to_html_code(rgba::RGBA) = convert(String, detail.rgba_to_html_code(rgba))
    export rgba_to_html_code

    html_code_to_rgba(code::String) ::RGBA = return detail.html_code_to_rgba(code)
    export html_code_to_rgba

####### icon.jl

    @export_type Icon
    Icon() = Icon(detail._Icon())

    @export_type IconTheme
    IconTheme(window::Window) = IconTheme(detail._IconTheme(window._internal))

    const IconID = String
    export IconID

    # Icon

    @export_function Icon create_from_file! Bool String path

    function create_from_theme!(icon::Icon, theme::IconTheme, id::IconID, square_resolution::Integer, scale::Integer = 1)
        detail.create_from_theme!(icon._internal, theme._internal.cpp_object, id, UInt64(square_resolution), UInt64(scale))
    end
    export create_from_theme!

    @export_function Icon get_name IconID

    import Base.==
    ==(a::Icon, b::Icon) = return detail.compare_icons(a._internal, b_internal)

    import Base.!=
    !=(a::Icon, b::Icon) = return !Base.==(a, b)

    @export_function Icon get_size Vector2i

    # IconTheme

    function get_icon_names(theme::IconTheme) ::Vector{String}
        return detail.get_icon_names(theme._internal)
    end
    export get_icon_names

    has_icon(theme::IconTheme, icon::Icon) = detail.has_icon_icon(theme._internal, icon._internal)
    has_icon(theme::IconTheme, id::IconID) = detail.has_icon_id(theme._internal, id)
    export has_icon

    @export_function IconTheme add_resource_path! Cvoid String path
    @export_function IconTheme set_resource_path! Cvoid String path

####### image.jl

    @export_enum InterpolationType begin
        INTERPOLATION_TYPE_NEAREST
        INTERPOLATION_TYPE_TILES
        INTERPOLATION_TYPE_BILINEAR
        INTERPOLATION_TYPE_HYPERBOLIC
    end

    @export_type Image
    Image() = Image(detail._Image())
    Image(path::String) = Image(detail._Image(path))
    Image(width::Integer, height::Integer, color::RGBA = RGBA(0, 0, 0, 1)) = Image(detail._Image(UInt64(width), UInt64(height), color))

    function create!(image::Image, width::Integer, height::Integer, color::RGBA = RGBA(0, 0, 0, 1))
        detail.create!(image._internal, UInt64(width), UInt64(height), color)
    end
    export create!

    @export_function Image create_from_file! Bool String path
    @export_function Image save_to_file Bool String path
    @export_function Image get_n_pixels Int64
    @export_function Image get_size Vector2f

    function as_scaled(image::Image, size_x::Integer, size_y::Integer, interpolation::InterpolationType)
        return Image(detail.as_scaled(image._internal, UInt64(size_x), UInt64(size_y), interpolation))
    end
    export as_scaled

    function as_cropped(image::Image, offset_x::Integer, offset_y::Integer, new_width::Integer, new_height::Integer)
        return Image(detail.as_cropped(image._internal, offset_x, offset_y, UInt64(new_width), UInt64(new_height)))
    end
    export as_cropped

    function set_pixel!(image::Image, x::Integer, y::Integer, color::RGBA)
        detail.set_pixel_rgba!(image._internal, from_julia_index(x), from_julia_index(y), color)
    end
    function set_pixel!(image::Image, x::Integer, y::Integer, color::HSVA)
        detail.set_pixel_hsva!(image._internal, from_julia_index(x), from_julia_index(y), color)
    end
    export set_pixel!

    function get_pixel(image::Image, x::Integer, y::Integer) ::RGBA
        return detail.get_pixel(image._internal, from_julia_index(x), from_julia_index(y))
    end
    export get_pixel

####### key_file.jl

    @export_type KeyFile SignalEmitter
    KeyFile() = KeyFile(detail._KeyFile())
    KeyFile(path::String) = KeyFile(detail._KeyFile(path))

    const GroupID = String
    export GroupID

    const KeyID = String
    export KeyID

    @export_function KeyFile as_string String
    @export_function KeyFile create_from_file! Bool String path
    @export_function KeyFile create_from_string! Bool String file
    @export_function KeyFile save_to_file Bool String path
    @export_function KeyFile get_groups Vector{GroupID}
    @export_function KeyFile get_keys Vector{KeyID} GroupID group
    @export_function KeyFile has_key Bool GroupID group KeyID key
    @export_function KeyFile has_group Bool GroupID group
    @export_function KeyFile set_comment_above_group! Cvoid GroupID group String comment
    @export_function KeyFile set_comment_above_key! Cvoid GroupID group KeyID key String comment
    @export_function KeyFile get_comment_above_group String GroupID group
    @export_function KeyFile get_comment_above_key String GroupID group KeyID key

    export set_value!
    export get_value

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::Bool)
        detail.set_value_as_bool!(file._internal, group, key, value)
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::AbstractFloat)
        detail.set_value_as_double!(file._internal, group, key, convert(Cdouble, value))
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::Signed)
        detail.set_value_as_int!(file._internal, group, key, convert(Cint, value))
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::Unsigned)
        detail.set_value_as_uint!(file._internal, group, key, convert(Cuint, value))
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::String)
        detail.set_value_as_string!(file._internal, group, key, value)
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::RGBA)
        detail.set_value_as_float_list!(file._internal, group, key, Cfloat[value.r, value.g, value.b, value.a])
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::Image)
       detail.set_value_as_image!(file._internal, group, key, value._internal)
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::Vector{Bool})
        detail.set_value_as_bool_list!(file._internal, group, key, value)
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::Vector{<: AbstractFloat})
        vec::Vector{Cdouble} = []
        for x in value
            push!(vec, convert(Cdouble, x))
        end
        detail.set_value_as_double_list!(file._internal, group, key, vec)
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::Vector{<: Signed})
        vec::Vector{Cint} = []
        for x in value
            push!(vec, convert(Cint, x))
        end
        detail.set_value_as_int_list!(file._internal, group, key, vec)
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::Vector{<: Unsigned})
        vec::Vector{Cuint} = []
        for x in value
            push!(vec, convert(Cuint, x))
        end
        detail.set_value_as_uint_list!(file._internal, group, key, vec)
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::Vector{String})
        detail.set_value_as_string_list!(file._internal, group, key, value)
    end

    ##

    function get_value(file::KeyFile, type::Type{Bool}, group::GroupID, key::KeyID)
        return detail.get_value_as_bool(file._internal, group, key)
    end

    function get_value(file::KeyFile, type::Type{<: AbstractFloat}, group::GroupID, key::KeyID)
        return detail.get_value_as_double(file._internal, group, key)
    end

    function get_value(file::KeyFile, type::Type{<: Signed}, group::GroupID, key::KeyID)
        return detail.get_value_as_int(file._internal, group, key)
    end

    function get_value(file::KeyFile, type::Type{<: Unsigned}, group::GroupID, key::KeyID)
        return detail.get_value_as_uint(file._internal, group, key)
    end

    function get_value(file::KeyFile, type::Type{String}, group::GroupID, key::KeyID)
        return detail.get_value_as_string(file._internal, group, key)
    end

    function get_value(file::KeyFile, type::Type{RGBA}, group::GroupID, key::KeyID)
        vec = get_value(file, Vector{Cfloat}, group, key)
        return RGBA(vec[1], vec[2], vec[3], vec[4])
    end

    function get_value(file::KeyFile, type::Type{Image}, group::GroupID, key::KeyID)
        return Image(detail.get_value_as_image(file._internal, group, key))
    end

    function get_value(file::KeyFile, type::Type{Vector{Bool}}, group::GroupID, key::KeyID)
        return convert(Vector{Bool}, detail.get_value_as_bool_list(file._internal, group, key))
    end

    function get_value(file::KeyFile, type::Type{Vector{T}}, group::GroupID, key::KeyID) where T <: AbstractFloat
        return convert(Vector{T}, detail.get_value_as_double_list(file._internal, group, key))
    end

    function get_value(file::KeyFile, type::Type{Vector{T}}, group::GroupID, key::KeyID) where T <: Signed
        return convert(Vector{T}, detail.get_value_as_int_list(file._internal, group, key))
    end

    function get_value(file::KeyFile, type::Type{Vector{T}}, group::GroupID, key::KeyID) where T <: Unsigned
        return convert(Vector{T}, detail.get_value_as_uint_list(file._internal, group, key))
    end

    function get_value(file::KeyFile, type::Type{Vector{String}}, group::GroupID, key::KeyID)
        return convert(Vector{String}, detail.get_value_as_string_list(file._internal, group, key))
    end

####### file_descriptor.jl

    @export_type FileMonitor SignalEmitter
    @export_type FileDescriptor SignalEmitter

    # Monitor

    @export_enum FileMonitorEvent begin
        FILE_MONITOR_EVENT_CHANGED
        FILE_MONITOR_EVENT_CHANGES_DONE_HINT
        FILE_MONITOR_EVENT_DELETED
        FILE_MONITOR_EVENT_CREATED
        FILE_MONITOR_EVENT_ATTRIBUTE_CHANGED
        FILE_MONITOR_EVENT_RENAMED
        FILE_MONITOR_EVENT_MOVED_IN
        FILE_MONITOR_EVENT_MOVED_OUT
    end

    @export_function FileMonitor cancel! Cvoid
    @export_function FileMonitor is_cancelled Bool

    function on_file_changed!(f, monitor::FileMonitor, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (FileMonitor, FileMonitorEvent, FileDescriptor, FileDescriptor, Data_t))
        detail.on_file_changed!(monitor._internal, function(monitor_ref, event, self_descriptor_internal::Ptr{Cvoid}, other_descriptor_internal::Ptr{Cvoid})
            typed_f(FileMonitor(monitor_ref[]), event, FileDescriptor(self_descriptor_internal), FileDescriptor(other_descriptor_internal), data)
        end)
    end
    function on_file_changed!(f, monitor::FileMonitor)
        typed_f = TypedFunction(f, Cvoid, (FileMonitor, FileMonitorEvent, FileDescriptor, FileDescriptor))
        detail.on_file_changed!(monitor._internal, function(monitor_ref, event, self_descriptor_internal::Ptr{Cvoid}, other_descriptor_internal::Ptr{Cvoid})
            typed_f(FileMonitor(monitor_ref[]), event, FileDescriptor(self_descriptor_internal), FileDescriptor(other_descriptor_internal))
        end)
    end
    export on_file_changed!

    # Descriptor

    FileDescriptor(internal::Ptr{Cvoid}) = FileDescriptor(detail._FileDescriptor(internal))
    FileDescriptor(path::String) = FileDescriptor(detail._FileDescriptor(path))

    import Base.==
    ==(a::FileDescriptor, b::FileDescriptor) = detail.file_descriptor_equal(a._internal, b._internal)

    import Base.!=
    !=(a::FileDescriptor, b::FileDescriptor) = return !(a == b)

    @export_function FileDescriptor create_from_path! Bool String path
    @export_function FileDescriptor create_from_uri! Bool String uri
    @export_function FileDescriptor get_name String
    @export_function FileDescriptor get_path String
    @export_function FileDescriptor get_uri String

    get_path_relative_to(self::FileDescriptor, other::FileDescriptor) = detail.get_path_relative_to(self._internal, other._internal)
    export get_path_relative_to

    get_parent(self::FileDescriptor) = FileDescriptor(detail.get_parent(self._internal))
    export get_parent

    @export_function FileDescriptor get_file_extension String
    @export_function FileDescriptor exists Bool
    @export_function FileDescriptor is_folder Bool
    @export_function FileDescriptor is_symlink Bool

    read_symlink(self::FileDescriptor) = FileDescriptor(detail.read_symlink(self._internal))
    export read_symlink

    @export_function FileDescriptor get_content_type String
    @export_function FileDescriptor query_info String

    create_monitor(descriptor::FileDescriptor) ::FileMonitor = FileMonitor(detail._FileMonitor(detail.create_monitor(descriptor._internal)))
    export create_monitor

    function get_children(descriptor::FileDescriptor; recursive::Bool = false) ::Vector{FileDescriptor}
        children::Vector{Ptr{Cvoid}} = detail.get_children(descriptor._internal, recursive)
        return FileDescriptor[FileDescriptor(ptr) for ptr in children]
    end
    export get_children

    # File System

    create_file_at(destination::FileDescriptor, replace::Bool) ::Bool = detail.create_file_at(destination._internal)
    export create_file_at!

    create_directory_at(destination::FileDescriptor) ::Bool = detail.create_directory_at(destination._internal)
    export create_directory_at!

    delete_at(file::FileDescriptor) ::Bool = detail.delete_at(file._internal)
    export delete_at!

    function copy!(from::FileDescriptor, to::FileDescriptor, allow_overwrite::Bool; make_backup::Bool = false, follow_symlink::Bool = false) ::Bool
        detail.copy!(from._internal, to._internal, allow_overwrite, make_backup, follow_symlink)
    end
    export copy!

    function move!(from::FileDescriptor, to::FileDescriptor, allow_overwrite::Bool; make_backup::Bool = false, follow_symlink::Bool = false) ::Bool
        detail.move!(from._internal, to._internal, allow_overwrite, make_backup, follow_symlink)
    end
    export move!

    move_to_trash!(file::FileDescriptor) = detail.move_to_trash!(file._internal)

####### file_chooser.jl

    @export_type FileFilter SignalEmitter
    FileFilter(name::String) = FileFilter(detail._FileFilter(name))

    get_name(filter::FileFilter) ::String = detail.get_name(filter._internal)
    export get_name

    @export_function FileFilter add_allowed_pattern! Cvoid String pattern
    @export_function FileFilter add_allow_all_supported_image_formats! Cvoid
    @export_function FileFilter add_allowed_suffix! Cvoid String suffix
    @export_function FileFilter add_allowed_mime_type Cvoid String mime_type_id

    @export_enum FileChooserAction begin
        FILE_CHOOSER_ACTION_OPEN_FILE
        FILE_CHOOSER_ACTION_OPEN_MULTIPLE_FILES
        FILE_CHOOSER_ACTION_SAVE
        FILE_CHOOSER_ACTION_SELECT_FOLDER
        FILE_CHOOSER_ACTION_SELECT_MULTIPLE_FOLDERS
    end

    @export_type FileChooser SignalEmitter
    FileChooser(action::FileChooserAction; title::String = "") = FileChooser(detail._FileChooser(action, title))

    @export_function FileChooser set_accept_label! Cvoid String label
    @export_function FileChooser get_accept_label String
    @export_function FileChooser present! Cvoid
    @export_function FileChooser cancel! Cvoid
    @export_function FileChooser set_is_modal! Cvoid Bool modal
    @export_function FileChooser get_is_modal Bool

    function on_accept!(f, chooser::FileChooser, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (FileChooser, Vector{FileDescriptor}, Data_t))
        detail.on_accept!(chooser._internal, function(file_chooser_ref, descriptor_ptrs::Vector{Ptr{Cvoid}})
            descriptors = FileDescriptor[FileDescriptor(ptr) for ptr in descriptor_ptrs]
            typed_f(FileChooser(file_chooser_ref[]), descriptors, data)
        end)
    end
    function on_accept!(f, chooser::FileChooser)
        typed_f = TypedFunction(f, Cvoid, (FileChooser, Vector{FileDescriptor}))
        detail.on_accept!(chooser._internal, function(file_chooser_ref, descriptor_ptrs::Vector{Ptr{Cvoid}})
            descriptors = FileDescriptor[FileDescriptor(ptr) for ptr in descriptor_ptrs]
            typed_f(FileChooser(file_chooser_ref[]), descriptors)
        end)
    end
    export on_accept!

    function on_cancel!(f, chooser::FileChooser, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (FileChooser, Data_t))
        detail.on_cancel!(chooser._internal, function(file_chooser_ref)
            typed_f(FileChooser(file_chooser_ref[]), data)
        end)
    end
    function on_cancel!(f, chooser::FileChooser)
        typed_f = TypedFunction(f, Cvoid, (FileChooser,))
        detail.on_cancel!(chooser._internal, function(file_chooser_ref)
            typed_f(FileChooser(file_chooser_ref[]))
        end)
    end
    export on_cancel!

####### image_display.jl

    @export_type ImageDisplay Widget
    ImageDisplay(path::String) = ImageDisplay(detail._ImageDisplay(path))
    ImageDisplay(image::Image) = ImageDisplay(detail._ImageDisplay(image._internal))
    ImageDisplay(icon::Icon) = ImageDisplay(detail._ImageDisplay(icon._internal))

    @export_function ImageDisplay create_from_file! Cvoid String path

    create_from_image!(image_display::ImageDisplay, image::Image) = detail.create_from_image!(image_display._internal, image._internal)
    export create_from_image!

    create_from_icon!(image_display::ImageDisplay, icon::Icon) = detail.create_from_icon!(image_display._internal, icon._internal)
    export create_from_icon!

    create_as_file_preview!(image_display::ImageDisplay, file::FileDescriptor) = detail.create_as_file_preview!(image_display._internal, file._internal)
    export create_as_file_preview!

    @export_function ImageDisplay clear! Cvoid
    @export_function ImageDisplay set_scale! Cvoid Cint scale

    @add_widget_signals ImageDisplay

####### entry.jl

    @export_type Entry Widget
    Entry() = Entry(detail._Entry())

    @export_function Entry get_text String
    @export_function Entry set_text! Cvoid String text
    @export_function Entry set_max_length! Cvoid Integer n
    @export_function Entry get_max_length Int64
    @export_function Entry set_has_frame! Cvoid Bool b
    @export_function Entry get_has_frame Bool
    @export_function Entry set_text_visible! Cvoid Bool b
    @export_function Entry get_text_visible Bool

    function set_primary_icon!(entry::Entry, icon::Icon)
        detail.set_primary_icon!(entry._internal, icon._internal)
    end
    export set_primary_icon!

    @export_function Entry remove_primary_icon! Cvoid

    function set_secondary_icon!(entry::Entry, icon::Icon)
        detail.set_secondary_icon!(entry._internal, icon._internal)
    end
    export set_secondary_icon!

    @export_function Entry remove_secondary_icon! Cvoid

    @add_widget_signals Entry
    @add_signal_activate Entry
    @add_signal_text_changed Entry

####### expander.jl

    @export_type Expander Widget
    Expander() = Expander(detail._Expander())

    function set_child!(expander::Expander, child::Widget)
        detail.set_child!(expander._internal, child._internal.cpp_object)
    end
    export set_child!

    @export_function Expander remove_child! Cvoid

    function set_label_widget!(expander::Expander, child::Widget)
        detail.set_label_widget!(expander._internal, child._internal.cpp_object)
    end
    export set_label_widget!

    @export_function Expander remove_label_widget! Cvoid

    @add_widget_signals Expander
    @add_signal_activate Expander

####### fixed.jl

    @export_type Fixed Widget
    Fixed() = Fixed(detail._Fixed())

    add_child!(fixed::Fixed, child::Widget, position::Vector2f) = detail.add_child!(fixed._internal, child._internal.cpp_object, position)
    export add_child!

    remove_child!(fixed::Fixed, child::Widget) = detail.remove_child!(fixed._internal, child._internal.cpp_object)
    export remove_child!

    set_child_position!(fixed::Fixed, child::Widget, position::Vector2f) = detail.set_child_position!(fixed._internal, child._internal.cpp_object, position)
    export set_child_position!

    get_child_position(fixed::Fixed, child::Widget) ::Vector2f = detail.get_child_position(fixed._internal, child._internal.cpp_object)
    export get_child_position!

    @add_widget_signals Fixed

####### level_bar.jl

    @export_enum LevelBarMode begin
        LEVEL_BAR_MODE_CONTINUOUS
        LEVEL_BAR_MODE_DISCRETE
    end

    @export_type LevelBar Widget
    LevelBar(min::AbstractFloat, max::AbstractFloat) = LevelBar(detail._internal(min, max))

    @export_function LevelBar add_marker! Cvoid String name AbstractFloat value
    @export_function LevelBar remove_marker! Cvoid String name AbstractFloat value
    @export_function LevelBar set_inverted! Cvoid Bool b
    @export_function LevelBar get_inverted Bool
    @export_function LevelBar set_mode! Cvoid LevelBarMode mode
    @export_function LevelBar get_mode LevelBarMode
    @export_function LevelBar set_min_value! Cvoid AbstractFloat value
    @export_function LevelBar get_min_value Cfloat
    @export_function LevelBar set_max_value! Cvoid AbstractFloat value
    @export_function LevelBar set_value! Cvoid AbstractFloat value
    @export_function LevelBar get_value Cfloat
    @export_function LevelBar set_orientation! Cvoid Orientation orientation
    @export_function LevelBar get_orientation Orientation

    @add_widget_signals LevelBar

####### label.jl

    @export_enum JustifyMode begin
        JUSTIFY_MODE_LEFT
        JUSTIFY_MODE_RIGHT
        JUSTIFY_MODE_CENTER
        JUSTIFY_MODE_FILL
    end

    @export_enum EllipsizeMode begin
        ELLIPSIZE_MODE_NONE
        ELLIPSIZE_MODE_START
        ELLIPSIZE_MODE_MIDDLE
        ELLIPSIZE_MODE_END
    end

    @export_enum LabelWrapMode begin
        LABEL_WRAP_MODE_NONE
        LABEL_WRAP_MODE_ONLY_ON_WORD
        LABEL_WRAP_MODE_ONLY_ON_CHAR
        LABEL_WRAP_MODE_WORD_OR_CHAR
    end

    @export_type Label Widget
    Label() = Label(detail._Label())
    Label(formatted_string::String) = Label(detail._Label(formatted_string))

    @export_function Label set_text! Cvoid String text
    @export_function Label get_text String
    @export_function Label set_use_markup! Cvoid Bool b
    @export_function Label get_use_markup Bool
    @export_function Label set_ellipsize_mode! Cvoid EllipsizeMode mode
    @export_function Label get_ellipsize_mode EllipsizeMode
    @export_function Label set_wrap_mode! Cvoid LabelWrapMode mode
    @export_function Label get_wrap_mode LabelWrapMode
    @export_function Label set_justify_mode! Cvoid JustifyMode mode
    @export_function Label get_justify_mode JustifyMode
    @export_function Label set_max_width_chars! Cvoid Unsigned n
    @export_function Label get_max_width_chars UInt64
    @export_function Label set_x_alignment! Cvoid AbstractFloat x
    @export_function Label get_x_alignment Cfloat
    @export_function Label set_y_alignment! Cvoid AbstractFloat x
    @export_function Label get_y_alignment Cfloat
    @export_function Label set_selectable! Cvoid Bool b
    @export_function Label get_selectable Bool

    @add_widget_signals Label

####### text_view.jl

    @export_type TextView Widget

    TextView() = TextView(detail._TextView())

    @export_function TextView get_text String
    @export_function TextView set_text! Cvoid String text
    @export_function TextView set_cursor_visible! Cvoid Bool b
    @export_function TextView get_cursor_visible Bool
    @export_function TextView undo! Cvoid
    @export_function TextView redo! Cvoid
    @export_function TextView set_was_modified! Cvoid Bool b
    @export_function TextView get_was_modified Bool
    @export_function TextView set_editable! Cvoid Bool b
    @export_function TextView get_editable Bool
    @export_function TextView set_justify_mode! Cvoid JustifyMode mode
    @export_function TextView get_justify_mode JustifyMode
    @export_function TextView set_left_margin! Cvoid AbstractFloat margin
    @export_function TextView get_left_margin Cfloat
    @export_function TextView set_right_margin! Cvoid AbstractFloat margin
    @export_function TextView get_right_margin Cfloat
    @export_function TextView set_left_margin! Cvoid AbstractFloat margin
    @export_function TextView get_top_margin Cfloat
    @export_function TextView set_left_margin! Cvoid AbstractFloat margin
    @export_function TextView get_top_margin Cfloat
    @export_function TextView set_bottom_margin! Cvoid AbstractFloat margin
    @export_function TextView get_bottom_margin Cfloat

    @add_widget_signals TextView
    @add_signal_undo TextView
    @add_signal_redo TextView
    @add_signal_text_changed TextView

####### frame.jl

    @export_type Frame
    Frame() = Frame(detail._Frame())

    set_child!(frame::Frame, child::Widget) = detail.set_child!(fixed._internal, child._internal.cpp_object)
    export set_child!

    set_label_widget!(frame::Frame, label::Widget) = detail.set_label_widget!(frame._internal, label._internal.cpp_object)
    export set_label_widget!

    @export_function Frame remove_child! Cvoid
    @export_function Frame remove_label_widget! Cvoid
    @export_function Frame set_label_x_alignment! Cvoid AbstractFloat x
    @export_function Frame get_label_x_alignment! Cfloat

    @add_widget_signals Frame

####### overlay.jl

    @export_type Overlay Widget
    Overlay() = Overlay(detail._Overlay())

    set_child!(overlay::Overlay, child::Widget) = detail.set_child!(overlay._internal, child._internal.cpp_object)
    export set_child!

    function add_overlay!(overlay::Overlay, child::Widget; include_in_measurement::Bool = true, clip::Bool = true)
        detail.add_overlay!(overlay._internal, child._internal.cpp_object, include_in_measurement, clip)
    end
    export add_overlay!

    remove_overlay!(overlay::Overlay, child::Widget) = detail.remove_overlay(overlay._internal, child._internal.cpp_object)
    export remove_overlay!

    @add_widget_signals Overlay

####### relative_position.jl

    @export_enum RelativePosition begin
        RELATIVE_POSITION_ABOVE
        RELATIVE_POSITION_BELOW
        RELATIVE_POSITION_LEFT_OF
        RELATIVE_POSITION_RIGHT_OF
    end

####### menu_model.jl

    @export_type MenuModel SignalEmitter
    MenuModel() = MenuModel(detail._MenuModel())

    add_action!(model::MenuModel, label::String, action::Action) = detail.add_action!(model._internal, label, action._internal)
    export add_action!

    add_widget!(model::MenuModel, widget::Widget) = detail.add_widget!(model._internal, widget._internal.cpp_object)
    export add_widget!

    @export_enum SectionFormat begin
        SECTION_FORMAT_NORMAL
        SECTION_FORMAT_HORIZONTAL_BUTTONS
        SECTION_FORMAT_HORIZONTAL_BUTTONS_LEFT_TO_RIGHT
        SECTION_FORMAT_HORIZONTAL_BUTTONS_RIGHT_TO_LEFT
        SECTION_FORMAT_CIRCULAR_BUTTONS
        SECTION_FORMAT_INLINE_BUTTONS
    end

    function add_section!(model::MenuModel, title::String, to_add::MenuModel, section_format::SectionFormat = SECTION_FORMAT_NORMAL)
        detail.add_section!(model._internal, title, to_add._internal, section_format)
    end
    export add_section!

    add_submenu!(model::MenuModel, label::String, to_add::MenuModel) = detail.add_submenu!(model._internal, label, to_add._internal)
    export add_submenu!

    add_icon!(model::MenuModel, icon::Icon) = detail.add_icon!(model._internal, icon._internal)
    export add_icon!

    @add_signal_items_changed MenuModel

###### menubar.jl

    @export_type MenuBar Widget
    MenuBar(model::MenuModel) = MenuBar(detail._MenuBar(model._internal))

    @add_widget_signals MenuBar

####### popover_menu.jl

    @export_type PopoverMenu Widget
    PopoverMenu(model::MenuModel) = PopoverMenu(detail._PopoverMenu(model._internal))

    @add_widget_signals PopoverMenu
    @add_signal_closed PopoverMenu

###### popover.jl

    @export_type Popover Widget
    Popover() = Popover(detail._Popover())

    @export_function Popover popup! Cvoid
    @export_function Popover popdown! Cvoid
    @export_function Popover present! Cvoid

    function set_child!(popover::Popover, child::Widget)
        detail.set_child!(popover._internal, child._internal.cpp_object)
    end
    export set_child!

    @export_function Popover remove_child! Cvoid

    function attach_to!(popover::Popover, attachment::Widget)
        detail.atach_to!(popover._internal, child._internal.cpp_object)
    end
    export attach_to!

    @export_function Popover set_relative_position! Cvoid RelativePosition position
    @export_function Popover get_relative_position RelativePosition
    @export_function Popover set_autohide! Cvoid Bool b
    @export_function Popover get_autohide Bool
    @export_function Popover set_has_base_arrow! Cvoid Bool b
    @export_function Popover get_has_base_arrow Bool

    @add_widget_signals Popover
    @add_signal_closed Popover

###### popover_button.jl

    @export_type PopoverButton Widget
    PopoverButton() = PopoverButton(detail._PopoverButton())

    set_child!(popover_button::PopoverButton, child::Widget) = detail.set_child!(popover_button._internal, child._internal.cpp_object)
    export set_child!

    @export_function PopoverButton remove_child! Cvoid

    function set_popover!(popover_button::PopoverButton, popover::Popover)
        detail.set_popover!(popover_button._internal, popover._internal)
    end
    export set_popover!

    function set_popover_menu!(popover_button::PopoverButton, popover_menu::PopoverMenu)
        detail.set_popover_menu!(popover_button._internal, popover_menu._internal)
    end
    export set_popover_menu!

    @export_function PopoverButton remove_popover! Cvoid
    @export_function PopoverButton set_popover_position! Cvoid RelativePosition position
    @export_function PopoverButton get_relative_position RelativePosition
    @export_function PopoverButton set_always_show_arrow! Cvoid Bool b
    @export_function PopoverButton get_always_show_arrow Bool
    @export_function PopoverButton set_has_frame Cvoid Bool b
    @export_function PopoverButton get_has_frame Bool
    @export_function PopoverButton popoup! Cvoid
    @export_function PopoverButton popdown! Cvoid
    @export_function PopoverButton set_is_circular! Cvoid Bool b
    @export_function PopoverButton get_is_circular Bool

    @add_widget_signals PopoverButton
    @add_signal_activate PopoverButton

###### drop_down.jl

    @export_type DropDown Widget
    DropDown() = DropDown(detail._DropDown())

    const DropDownItemID = String
    export DropDownItemID

    @export_function DropDown remove! Cvoid DropDownItemID id
    @export_function DropDown set_show_arrow! Cvoid Bool b
    @export_function DropDown get_show_arrow Bool
    @export_function DropDown set_selected Cvoid DropDownItemID id
    @export_function DropDown get_selected DropDownItemID

    get_item_at(drop_down::DropDown, i::Integer) = detail.get_item_at(drop_down._internal, from_julia_index(i))
    export get_item_at

    function push_back!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (DropDown, Data_t))
        detail.push_back!(drop_down._internal, list_widget._internal.cpp_object, label_widget._internal.cpp_object, function (drop_down_internal_ref)
            f(DropDown(drop_down_internal_ref[]), data)
        end)
    end
    function push_back!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget)
        typed_f = TypedFunction(f, Cvoid, (DropDown,))
        detail.push_back!(drop_down._internal, list_widget._internal.cpp_object, label_widget._internal.cpp_object, function (drop_down_internal_ref)
            f(DropDown(drop_down_internal_ref[]))
        end)
    end
    export push_back!

    function push_front!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (DropDown, Data_t))
        detail.push_front!(drop_down._internal, list_widget._internal.cpp_object, label_widget._internal.cpp_object, function (drop_down_internal_ref)
            f(DropDown(drop_down_internal_ref[]), data)
        end)
    end
    function push_front!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget)
        typed_f = TypedFunction(f, Cvoid, (DropDown,))
        detail.push_front!(drop_down._internal, list_widget._internal.cpp_object, label_widget._internal.cpp_object, function (drop_down_internal_ref)
            f(DropDown(drop_down_internal_ref[]))
        end)
    end
    export push_front!

    function insert!(f, drop_down::DropDown, index::Integer, list_widget::Widget, label_widget::Widget, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (DropDown, Data_t))
        detail.insert!(drop_down._internal, from_julia_index(index), list_widget._internal.cpp_object, label_widget._internal.cpp_object, function (drop_down_internal_ref)
            f(DropDown(drop_down_internal_ref[]), data)
        end)
    end
    function insert!(f, drop_down::DropDown, index::Integer, list_widget::Widget, label_widget::Widget)
        typed_f = TypedFunction(f, Cvoid, (DropDown,))
        detail.insert!(drop_down._internal, from_julia_index(index), list_widget._internal.cpp_object, label_widget._internal.cpp_object, function (drop_down_internal_ref)
            f(DropDown(drop_down_internal_ref[]))
        end)
    end
    export insert!

    @add_widget_signals DropDown

###### event_controller.jl

    abstract type EventController end
    export EventController

    abstract type SingleClickGesture <: EventController end
    export SingleClickGesture

    @export_enum PropagationPhase begin
        PROPAGATION_PHASE_NONE
        PROPAGATION_PHASE_CAPTURE
        PROPAGATION_PHASE_BUBBLE
        PROPAGATION_PHASE_TARGET
    end

    set_propagation_phase!(controller::EventController) = detail.set_propagation_phase!(controller._internal.cpp_object)
    export set_propagation_phase!

    get_propagation_phase(controller::EventController) = return detail.get_propagation_phase(controller._internal.cpp_object)
    export get_propagation_phase

    @export_enum ButtonID begin
        BUTTON_ID_NONE
        BUTTON_ID_ANY
        BUTTON_ID_BUTTON_01
        BUTTON_ID_BUTTON_02
        BUTTON_ID_BUTTON_03
        BUTTON_ID_BUTTON_04
        BUTTON_ID_BUTTON_05
        BUTTON_ID_BUTTON_06
        BUTTON_ID_BUTTON_07
        BUTTON_ID_BUTTON_08
        BUTTON_ID_BUTTON_09
    end

    get_current_button(gesture::SingleClickGesture) ::ButtonID = return detail.get_current_button(gesture._internal.cpp_object)
    export get_current_button

    set_only_listens_to_button!(gesture::SingleClickGesture, button::ButtonID) = detail.set_only_listens_to_button!(gesture._internal.cpp_object)
    export set_only_listens_to_button

    get_only_listens_to_button(gesture::SingleClickGesture) = return detail.get_only_listens_to_button(gesture._internal.cpp_object)
    export get_only_listens_to_button

    set_touch_only!(gesture::SingleClickGesture) = detail.set_touch_only!(gesture._internal.cpp_object)
    export set_touch_only!

    get_touch_only(gesture::SingleClickGesture) = detail.get_touch_only(gesture._internal.cpp_object)
    export get_touch_only

###### drag_event_controller.jl

    @export_type DragEventController SingleClickGesture
    DragEventController() = DragEventController(detail._DragEventController())

    get_start_position(controller::DragEventController) = return detail.get_start_position(controller._internal)
    export get_start_position

    get_current_offset(controller::DragEventController) = return detail.get_current_offset(controller._internal)
    export get_current_offset

    @add_signal_drag_begin DragEventController
    @add_signal_drag DragEventController
    @add_signal_drag_end DragEventController

###### click_event_controller.jl

    @export_type ClickEventController SingleClickGesture
    ClickEventController() = ClickEventController(detail._ClickEventController())

    @add_signal_click_pressed ClickEventController
    @add_signal_click_released ClickEventController
    @add_signal_click_stopped ClickEventController

###### focus_event_controller.jl

    @export_type FocusEventController EventController
    FocusEventController() = FocusEventController(detail._FocusEventController())

    @export_function FocusEventController self_or_child_is_focused Bool
    @export_function FocusEventController self_is_focused Bool

    @add_signal_focus_gained FocusEventController
    @add_signal_focus_lost FocusEventController

###### key_event_controller.jl

    @export_type KeyEventController EventController
    KeyEventController() = KeyEventController(detail._KeyEventController())

    @export_function KeyEventController should_shortcut_trigger_trigger Bool String trigger

    const ModifierState = detail._ModifierState
    export ModifierState

    const KeyCode = Cint
    export KeyCode

    const KeyValue = Cint
    export KeyValue

    @add_signal_key_pressed KeyEventController
    @add_signal_key_released KeyEventController
    @add_signal_modifiers_changed KeyEventController

    shift_pressed(modifier_state::ModifierState) ::Bool = return detail.shift_pressed(modifier_state);
    export shift_pressed

    control_pressed(modifier_state::ModifierState) ::Bool = return detail.control_pressed(modifier_state);
    export shift_pressed

    alt_pressed(modifier_state::ModifierState) ::Bool = return detail.alt_pressed(modifier_state);
    export alt_pressed

    shift_pressed(modifier_state::ModifierState) ::Bool = return detail.shift_pressed(modifier_state);
    export shift_pressed

    mouse_button_01_pressed(modifier_state::ModifierState) ::Bool = return detail.mouse_button_01_pressed(modifier_state);
    export mouse_button_01_pressed

    mouse_button_02_pressed(modifier_state::ModifierState) ::Bool = return detail.mouse_button_02_pressed(modifier_state);
    export mouse_button_02_pressed

###### long_press_event_controller.jl

    @export_type LongPressEventController SingleClickGesture
    LongPressEventController() = LongPressEventController(detail._LongPressEventController())

    @export_function LongPressEventController set_delay_factor Cvoid AbstractFloat factor
    @export_function LongPressEventController get_delay_factor Cfloat

    @add_signal_pressed LongPressEventController
    @add_signal_press_cancelled LongPressEventController

###### motion_event_controller.jl

    @export_type MotionEventController EventController
    MotionEventController() = MotionEventController(detail._MotionEventController())

    @add_signal_motion_enter MotionEventController
    @add_signal_motion MotionEventController
    @add_signal_motion_leave MotionEventController

###### pinch_zoom_event_controller.jl

    @export_type PinchZoomEventController EventController
    PinchZoomEventController() = PinchZoomEventController(detail._PinchZoomEventController())

    @export_function PinchZoomEventController get_scale_delta Cfloat

    @add_signal_scale_changed PinchZoomEventController

###### rotate_event_controller.jl

    @export_type RotateEventController EventController
    RotateEventController() = RotateEventController(detail._RotateEventController())

    get_angle_delta(controller::RotateEventController) ::Angle = return radians(detail.get_angle_delta(controller._internal))

    @add_signal_rotation_changed RotateEventController

###### scroll_event_controller.jl

    @export_type ScrollEventController EventController
    ScrollEventController(; emit_vertical = true, emit_horizontal = true) = ScrollEventController(detail._ScrollEventController(emit_vertical, emit_horizontal))

    @add_signal_kinetic_scroll_decelerate ScrollEventController
    @add_signal_scroll_begin ScrollEventController
    @add_signal_scroll ScrollEventController
    @add_signal_scroll_end ScrollEventController

###### shortcut_event_controller.jl

    @export_type ShortcutEventController EventController
    ShortcutEventController() = ShortcutEventController(detail._ShortcutEventController())

    add_action!(shortcut_controller::ShortcutEventController, action::Action) = detail.add_action!(shortcut_controller._internal, action._internal)
    export add_action!

    @export_enum ShortcutScope begin
        SHORTCUT_SCOPE_LOCAL
        SHORTCUT_SCOPE_MANAGED
        SHORTCUT_SCOPE_GLOBAL
    end

    set_scope!(controller::ShortcutEventController, scope::ShortcutScope) = detail.set_scope!(controller._internal, scope)
    export set_scope!

    get_scope(controller::ShortcutEventController) ::ShortcutScope = return detail.get_scope(controller._internal)
    export get_scope

###### stylus_event_controller.jl

    @export_enum ToolType begin
        TOOL_TYPE_UNKNOWN
        TOOL_TYPE_PEN
        TOOL_TYPE_ERASER
        TOOL_TYPE_BRUSH
        TOOL_TYPE_PENCIL
        TOOL_TYPE_AIRBRUSH
        TOOL_TYPE_LENS
        TOOL_TYPE_MOUSE
    end

    @export_enum DeviceAxis begin
        DEVICE_AXIS_X
        DEVICE_AXIS_Y
        DEVICE_AXIS_DELTA_X
        DEVICE_AXIS_DELTA_Y
        DEVICE_AXIS_PRESSURE
        DEVICE_AXIS_X_TILT
        DEVICE_AXIS_Y_TILT
        DEVICE_AXIS_WHEEL
        DEVICE_AXIS_DISTANCE
        DEVICE_AXIS_ROTATION
        DEVICE_AXIS_SLIDER
    end

    device_axis_to_string(axis::DeviceAxis) ::String = detail.device_axis_to_string(axis)
    export device_axis_to_string

    @export_type StylusEventController SingleClickGesture
    StylusEventController() = StylusEventController(detail._StylusEventController())

    @export_function StylusEventController get_hardware_id Csize_t
    @export_function StylusEventController get_tool_type ToolType
    @export_function StylusEventController has_axis Bool DeviceAxis axis

    @add_signal_stylus_up StylusEventController
    @add_signal_stylus_down StylusEventController
    @add_signal_proximity StylusEventController
    @add_signal_motion StylusEventController

###### swipe_event_controller.jl

    @export_type SwipeEventController SingleClickGesture
    SwipeEventController(orientation::Orientation) = SwipeEventController(detail._SwipeEventController(orientation))

    get_velocity(swipe_controller::SwipeEventController) ::Vector2f = return detail.get_velocity(swipe_controller._internal)
    export get_velocity

    @add_signal_swipe SwipeEventController

###### pan_event_controller.jl

    @export_enum PanDirection begin
        PAN_DIRECTION_LEFT
        PAN_DIRECTION_RIGHT
        PAN_DIRECTION_UP
        PAN_DIRECTION_DOWN
    end

    @export_type PanEventController SingleClickGesture
    PanEventController(orientation::Orientation) = PanEventController(detail._PanEventController(orientation))

    set_orientation!(pan_controller::PanEventController) = detail.set_orientation!(pan_controller._internal)
    export set_orientation!

    get_orientation(pan_controller::PanEventController) ::Orientation = detail.get_orientation(pan_controller._internal)
    export get_orientation

    @add_signal_pan PanEventController

###### selection_model.jl

    @export_enum SelectionMode begin
        SELECTION_MODE_NONE
        SELECTION_MODE_SINGLE
        SELECTION_MODE_MULTIPLE
    end

    @export_type SelectionModel SignalEmitter
    SelectionModel(internal::Ptr{Cvoid}) = SelectionModel(detail._SelectionModel(internal))

    function get_selection(model::SelectionModel) ::Vector{Int64}
        selection = detail.get_selection(model._internal)
        return Int64[to_julia_index(x) for x in selection]
    end
    export get_selection

    @export_function SelectionModel select_all! Cvoid
    @export_function SelectionModel unselect_all! Cvoid

    select!(model::SelectionModel, i::Integer, unselect_others::Bool = true) = detail.select!(model._internal, from_julia_index(i), unselect_others)
    export select!

    unselect!(model::SelectionModel, i::Integer) = detail.unselect!(model._internal, from_julia_index(i))
    export unselect!

    @add_signal_selection_changed SelectionModel

###### list_view.jl

    @export_type ListView Widget
    ListView(orientation::Orientation, selection_mode::SelectionMode = SELECTION_MODE_NONE) = ListView(detail._ListView(orientation, selection_mode))

    struct ListViewIterator
        _internal::Ptr{Cvoid}
    end
    export ListViewIterator

    push_back!(list_view::ListView, widget::Widget) = detail.push_back!(list_view._internal, widget._internal.cpp_object, Ptr{Cvoid}())
    push_back!(list_view::ListView, widget::Widget, iterator::ListViewIterator) = detail.push_back!(list_view._internal, widget._internal.cpp_object, iterator._internal)
    export push_back!

    push_front!(list_view::ListView, widget::Widget) = detail.push_front!(list_view._internal, widget._internal.cpp_object, Ptr{Cvoid}())
    push_front!(list_view::ListView, widget::Widget, iterator::ListViewIterator) =detail.push_front!(list_view._internal, widget._internal.cpp_object, iterator._internal)
    export push_front!

    insert!(list_view::ListView, widget::Widget, index::Integer) = detail.insert!(list_view._internal, from_julia_index(index), widget._internal.cpp_object, Ptr{Cvoid}())
    insert!(list_view::ListView, widget::Widget, index::Integer, iterator::ListViewIterator) = detail.insert!(list_view._internal, from_julia_index(index), widget._internal.cpp_object, iterator._internal)
    export insert!

    remove!(list_view::ListView, index::Integer) = detail.remove!(list_view._internal, from_julia_index(index), Ptr{Cvoid}())
    remove!(list_view::ListView, index::Integer, iterator::ListViewIterator) = detail.remove!(list_view._internal, from_julia_index(index), iterator._internal)
    export remove!

    clear!(list_view::ListView) = detail.clear!(list_view._internal,Ptr{Cvoid}())
    clear!(list_view::ListView, iterator::ListViewIterator) = detail.clear!(list_view._internal, iterator._internal)
    export clear!

    set_widget_at!(list_view::ListView, index::Integer, widget::Widget) = detail.set_widget_at!(list_view._internal, from_julia_index(index), widget._internal.cpp_object, Ptr{Cvoid}())
    set_widget_at!(list_view::ListView, index::Integer, widget::Widget, iterator::ListViewIterator) = detail.set_widget_at!(list_view._internal, from_julia_index(index), widget._internal.cpp_object, iterator._internal)
    export set_widget_at!

    get_selection_model(list_view::ListView) ::SelectionModel = SelectionModel(detail.get_selection_model(list_view._internal))
    export get_selection_model

    @export_function ListView set_enable_rubberband_selection Cvoid Bool b
    @export_function ListView get_enabled_rubberband_selection Bool
    @export_function ListView set_show_separators Cvoid Bool b
    @export_function ListView get_show_separators Bool
    @export_function ListView set_single_click_activate Cvoid Bool b
    @export_function ListView get_single_click_activate Bool
    @export_function ListView get_n_items Cuint
    @export_function ListView set_orientation Cvoid Orientation orientation
    @export_function ListView get_orientation Orientation

    @add_widget_signals ListView
    @add_signal_activate ListView

###### grid_view.jl

    @export_type GridView Widget
    GridView(orientation::Orientation, selection_mode::SelectionMode = SELECTION_MODE_NONE) = GridView(detail._GridView(orientation, selection_mode))

    push_back!(grid_view::GridView, widget::Widget) = detail.push_back!(grid_view._internal, widget._internal.cpp_object)
    export push_back!

    push_front!(grid_view::GridView, widget::Widget) = detail.push_ront!(grid_view._internal, widget._internal.cpp_object)
    export push_front!

    insert!(grid_view::GridView, index::Integer, widget::Widget) = detail.insert!(grid_view._internal, from_julia_index(index), widget._internal.cpp_object)
    export insert!

    remove!(grid_view::GridView, widget::Widget) = detail.remove!(grid_view._internal, widget._internal.cpp_object)
    export remove!

    clear!(grid_view::GridView) = detail.clear!(grid_view._internal)
    export clear!

    @export_function GridView get_n_items Int64
    @export_function GridView set_enable_rubberband_selection Cvoid Bool b
    @export_function GridView get_enabled_rubberband_selection Bool

    set_max_n_columns!(grid_view::GridView, n::Integer) = detail.set_max_n_columns!(grid_view._internal, UInt64(n))
    export set_max_n_columns!

    get_max_n_columns(grid_view::GridView) ::Int64 = detail.get_max_n_columns(grid_view._internal)
    export get_max_n_columns

    set_min_n_columns!(grid_view::GridView, n::Integer) = detail.set_min_n_columns!(grid_view._internal, UInt64(n))
    export set_min_n_columns!

    get_min_n_columns(grid_view::GridView) ::Int64 = detail.get_min_n_columns(grid_view._internal)
    export get_min_n_columns

    @export_function GridView set_orientation Cvoid Orientation orientation
    @export_function GridView get_orientation Orientation

    get_selection_model(grid_view::GridView) ::SelectionModel = SelectionModel(detail.get_selection_model(grid_view._internal))
    export get_selection_model

    @add_widget_signals GridView
    @add_signal_activate GridView

###### grid.jl

    @export_type Grid Widget
    Grid() = Grid(detail._Grid())

    function insert!(grid::Grid, widget::Widget, row_i::Signed, column_i::Signed; n_horizontal_cells::Unsigned = Unsigned(1), n_vertical_cells::Unsigned = Unsigned(1))
        detail.insert!(grid._internal, widget._internal.cpp_object, row_i - 1, column_i - 1, n_horizontal_cells, n_vertical_cells)
    end
    export insert!

    remove!(grid::Grid, widget::Widget) = detail.remove!(grid._internal, widget._internal.cpp_object)
    export remove!

    function get_position(grid::Grid, widget::Widget) ::Vector2i
        native_pos::Vector2i = detail.get_position(grid._internal, widget._internal.cpp_object)
        return Vector2i(native_pos.x + 1, native_pos.y + 1)
    end
    export get_position

    get_size(grid::Grid, widget::Widget) ::Vector2i = detail.get_size(grid._internal, widget._internal.cpp_object)
    export get_size

    insert_row_at!(grid::Grid, row_i::Signed) = detail.insert_row_at!(grid._internal, row_i -1)
    export insert_row_at!

    remove_row_at!(grid::Grid, row_i::Signed) = detail.remove_row_at!(grid._internal, row_i -1)
    export remove_row_at!

    insert_column_at!(grid::Grid, column_i::Signed) = detail.insert_column_at!(grid._internal, column_i -1)
    export insert_column_at!

    remove_column_at!(grid::Grid, column_i::Signed) = detail.remove_column_at!(grid._internal, column_i -1)
    export insert_column_at!

    @export_function Grid set_row_spacing! Cvoid AbstractFloat spacing
    @export_function Grid get_column_spacing Cfloat
    @export_function Grid set_column_spacing! Cvoid AbstractFloat spacing
    @export_function Grid get_column_spacing Cfloat
    @export_function Grid set_rows_homogeneous! Cvoid Bool b
    @export_function Grid get_rows_homogeneous Bool
    @export_function Grid set_columns_homogeneous! Cvoid Bool b
    @export_function Grid get_columns_homogeneous Bool
    @export_function Grid set_orientation! Cvoid Orientation orientation
    @export_function Grid get_orientation Orientation

    @add_widget_signals Grid

###### stack.jl

    @export_type Stack Widget
    Stack() = Stack(detail._Stack())

    @export_type StackSidebar Widget
    StackSidebar(stack::Stack) = StackSidebar(detail._StackSidebar(stack._internal))

    @export_type StackSwitcher Widget
    StackSwitcher(stack::Stack) = StackSwitcher(detail._StackSwitcher(stack._internal))

    @export_enum StackTransitionType begin
        STACK_TRANSITION_TYPE_NONE
        STACK_TRANSITION_TYPE_CROSSFADE
        STACK_TRANSITION_TYPE_SLIDE_RIGHT
        STACK_TRANSITION_TYPE_SLIDE_LEFT
        STACK_TRANSITION_TYPE_SLIDE_UP
        STACK_TRANSITION_TYPE_SLIDE_DOWN
        STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT
        STACK_TRANSITION_TYPE_SLIDE_UP_DOWN
        STACK_TRANSITION_TYPE_OVER_UP
        STACK_TRANSITION_TYPE_OVER_DOWN
        STACK_TRANSITION_TYPE_OVER_LEFT
        STACK_TRANSITION_TYPE_OVER_RIGHT
        STACK_TRANSITION_TYPE_UNDER_UP
        STACK_TRANSITION_TYPE_UNDER_DOWN
        STACK_TRANSITION_TYPE_UNDER_LEFT
        STACK_TRANSITION_TYPE_UNDER_RIGHT
        STACK_TRANSITION_TYPE_OVER_UP_DOWN
        STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT
        STACK_TRANSITION_TYPE_ROTATE_LEFT
        STACK_TRANSITION_TYPE_ROTATE_RIGHT
        STACK_TRANSITION_TYPE_ROTATE_LEFT_RIGHT
    end

    get_selection_model(stack::Stack) ::SelectionModel = SelectionModel(detail.get_selection_model(stack._internal))
    export get_selection_model

    const StackID = String
    export StackID

    add_child!(stack::Stack, child::Widget, title::String) ::StackID = detail.add_child!(stack._internal, child._internal.cpp_object, title)
    export add_child!

    remove_child!(stack::Stack, id::StackID) = detail.remove_child!(stack._internal, id)
    export remove_child!

    set_visible_child!(stack::Stack, id::StackID) = detail.set_visible_child!(stack._internal, id)
    export set_visible_child!

    get_visible_child(stack::Stack) ::StackID = detail.get_visible_child(stack._internal)
    export get_visible_child

    @export_function Stack set_transition_type Cvoid StackTransitionType transition
    @export_function Stack get_transition_type StackTransitionType

    set_transition_duration!(stack::Stack, duration::Time) = detail.set_transition_duration!(stack._internal, as_microseconds(duration))
    export set_transition_duration!

    get_transition_duration(stack::Stack) ::Time = microseconds(detail.get_transition_duration(stack._internal))
    export get_transition_duration

    @export_function Stack set_is_horizontally_homogeneous Cvoid Bool b
    @export_function Stack get_is_horizontally_homogeneous Bool
    @export_function Stack set_is_vertically_homogeneous Cvoid Bool b
    @export_function Stack get_is_vertically_homogeneous Bool
    @export_function Stack set_should_interpolate_size Cvoid Bool b
    @export_function Stack get_should_interpolate_size Bool

    @add_widget_signals Stack
    @add_widget_signals StackSidebar
    @add_widget_signals StackSwitcher

###### notebook.jl

    @export_type Notebook Widget
    Notebook() = Notebook(detail._Notebook())

    function push_front!(notebook::Notebook, child_widget::Widget, label_widget::Widget) ::Int64
        return detail.push_front!(notebook._internal, child_widget._internal.cpp_object, label_widget._internal.cpp_object)
    end
    export push_front!

    function push_back!(notebook::Notebook, child_widget::Widget, label_widget::Widget) ::Int64
        return detail.push_back!(notebook._internal, child_widget._internal.cpp_object, label_widget._internal.cpp_object)
    end
    export push_back!

    function insert!(notebook::Notebook, index::Integer, child_widget::Widget, label_widget::Widget) ::Int64
        return detail.insert!(notebook._internal, from_julia_index(index), child_widget._internal.cpp_object, label_widget._internal.cpp_object)
    end
    export insert!

    @export_function Notebook remove! Cvoid Int64 position
    @export_function Notebook next_page! Cvoid
    @export_function Notebook previous_page! Cvoid
    @export_function Notebook goto_page! Cvoid Int64 position

    @export_function Notebook get_current_page Int64
    @export_function Notebook get_n_pages Int64
    @export_function Notebook set_is_scrollable! Cvoid Bool b
    @export_function Notebook get_is_scrollable Bool
    @export_function Notebook set_has_border! Cvoid Bool b
    @export_function Notebook get_has_border Bool
    @export_function Notebook set_tabs_visible! Cvoid Bool b
    @export_function Notebook get_tabs_visible Bool
    @export_function Notebook set_quick_change_menu_enabled! Cvoid Bool b
    @export_function Notebook get_quick_change_menu_enabled Cvoid Bool b
    @export_function Notebook set_tab_position! Cvoid RelativePosition relative_position
    @export_function Notebook get_tab_position RelativePosition
    @export_function Notebook set_tabs_reorderable! Cvoid Bool b
    @export_function Notebook get_tabs_reorderable Bool

    @add_widget_signals Notebook
    @add_notebook_signal Notebook page_added
    @add_notebook_signal Notebook page_reordered
    @add_notebook_signal Notebook page_removed
    @add_notebook_signal Notebook page_selection_changed

###### column_view.jl

    @export_type ColumnViewColumn SignalEmitter
    ColumnViewColumn(internal::Ptr{Cvoid}) = ColumnViewColumn(detail._ColumnViewColumn(internal))

    @export_function ColumnViewColumn set_title Cvoid String title
    @export_function ColumnViewColumn get_title String
    @export_function ColumnViewColumn set_fixed_width Cvoid AbstractFloat width
    @export_function ColumnViewColumn get_fixed_width Cfloat

    set_header_menu!(column::ColumnViewColumn, model::MenuModel) = detail.set_header_menu!(column._internal, model._internal)
    export set_header_menu!

    @export_function ColumnViewColumn set_is_visible! Cvoid Bool b
    @export_function ColumnViewColumn get_is_visible Bool
    @export_function ColumnViewColumn set_is_resizable! Cvoid Bool b
    @export_function ColumnViewColumn get_is_resizable Bool

    @export_type ColumnView Widget
    ColumnView(selection_mode::SelectionMode = SELECTION_MODE_NONE) = ColumnView(detail._ColumnView(selection_mode))

    push_back_column!(column_view::ColumnView, title::String) = detail.push_back_column!(column_view._internal, title)
    export push_back_column!

    push_front_column!(column_view::ColumnView, title::String) = detail.push_front_column!(column_view._internal, title)
    export push_front_column!

    insert_column!(column_view::ColumnView, index::Integer, title::String) = detail.insert_column!(column_view._internal, from_julia_index(index), title)
    export insert_column!

    remove_column!(column_view::ColumnView, column::ColumnViewColumn) = detail.remove_column!(column_view._internal, column._internal)
    export remove_column!

    function get_column_at(column_view::ColumnView, index::Integer) ::ColumnViewColumn
        return ColumnViewColumn(detail.get_column_at(column_view._internal, from_julia_index(index)))
    end
    export get_column_at

    function get_column_with_title(column_view::ColumnView, title::String) ::ColumnViewColumn
        return ColumnViewColumn(detail.get_column_with_title(column_view._internal, title))
    end
    export get_column_with_title

    has_column_with_title(column_view::ColumnView, title::String) ::Bool = return detail.get_column_with_title(column_view._internal, title)
    export has_column_with_title

    function set_widget!(column_view::ColumnView, column::ColumnViewColumn, row_i::Integer, widget::Widget)
        detail.set_widget!(column_view._internal, column._internal, from_julia_index(row_i), widget._internal.cpp_object)
    end
    export set_widget!

    function push_back_row!(column_view::ColumnView, widgets::Widget...)

        if length(widgets) > get_n_columns(column_view)
            @warning MOUSETRAP_DOMAIN "In ColumnView::push_back_rows: Attempting to push $(length(widgets)) widgets, but ColumnView only has $(get_n_columns(column_view)) columns"
        end

        row_i = get_n_rows(column_view)
        for i in 1:get_n_columns(column_view)
            column = get_column_at(column_view, i)
            set_widget!(column_view, column, row_i, widgets[i])
        end
    end
    export push_back_row!

    function push_front_row!(column_view::ColumnView, widgets::Widget...)

        if length(widgets) > get_n_columns(column_view)
            @warning MOUSETRAP_DOMAIN "In ColumnView::push_back_rows: Attempting to push $(length(widgets)) widgets, but ColumnView only has $(get_n_columns(column_view)) columns"
        end

        row_i = 1
        for i in 1:get_n_columns(column_view)
            column = get_column_at(column_view, i)
            set_widget!(column_view, column, row_i, widgets[i])
        end
    end
    export push_front_row!

    function insert_row!(column_view::ColumnView, index::Integer, widgets::Widget...)

        if length(widgets) > get_n_columns(column_view)
            @warning MOUSETRAP_DOMAIN "In ColumnView::push_back_rows: Attempting to push $(length(widgets)) widgets, but ColumnView only has $(get_n_columns(column_view)) columns"
        end

        row_i = index
        for i in 1:get_n_columns(column_view)
            column = get_column_at(column_view, i)
            set_widget!(column_view, column, row_i, widgets[i])
        end
    end
    export push_front_row!

    get_selection_model(column_view::ColumnView) ::SelectionModel = SelectionModel(detail.get_selection_model(column_view._internal))
    export get_selection_model

    @export_function ColumnView set_enable_rubberband_selection Cvoid Bool b
    @export_function ColumnView get_enabled_rubberband_selection Bool
    @export_function ColumnView set_show_row_separators Cvoid Bool b
    @export_function ColumnView get_show_row_separators Bool
    @export_function ColumnView set_show_column_separators Cvoid Bool b
    @export_function ColumnView get_show_column_separators Bool
    @export_function ColumnView set_single_click_activate! Cvoid Bool b
    @export_function ColumnView get_single_click_activate Bool
    @export_function ColumnView get_n_rows Int64
    @export_function ColumnView get_n_columns Int64

###### header_bar.jl

    @export_type HeaderBar Widget
    HeaderBar() = HeaderBar(detail._HeaderBar())
    HeaderBar(layout::String) = HeaderBar(detail._HeaderBar(layout))

    @export_function HeaderBar set_layout! Cvoid String layout
    @export_function HeaderBar get_layout String
    @export_function HeaderBar set_show_title_buttons! Cvoid Bool b
    @export_function HeaderBar get_show_title_buttons Bool

    set_title_widget!(header_bar::HeaderBar, widget::Widget) = detail.set_title_widget!(header_bar._internal, widget._internal.cpp_object)
    export set_title_widget!

    push_front!(header_bar::HeaderBar, widget::Widget) = detail.push_front!(header_bar._internal, widget._internal.cpp_object)
    export push_front!

    push_back!(header_bar::HeaderBar, widget::Widget) = detail.push_back!(header_bar._internal, widget._internal.cpp_object)
    export push_back!

    remove!(header_bar::HeaderBar, widget::Widget) = detail.remove!(header_bar._internal, widget._internal.cpp_object)
    export remove!

    @add_widget_signals HeaderBar

###### paned.jl

    @export_type Paned Widget
    Paned(orientation::Orientation) = Paned(detail._paned(orientation))

    @export_function Paned get_position Cint
    @export_function Paned set_position! Cvoid Integer position

    @export_function Paned set_has_wide_handle Cvoid Bool b
    @export_function Paned get_has_wide_handle Bool
    @export_function Paned set_orientation Cvoid Orientation orientation
    @export_function Paned get_orientation Orientation

    @export_function Paned set_start_child_resizable! Cvoid Bool b
    @export_function Paned get_start_child_resizable Bool
    @export_function Paned set_start_child_shrinkable Cvoid Bool b
    @export_function Paned get_start_child_shrinkable Bool

    set_start_child!(paned::Paned, child::Widget) = detail.set_start_child!(paned._internal, child._internal.cpp_object)
    export set_start_child!

    @export_function Paned remove_start_child Cvoid

    @export_function Paned set_end_child_resizable! Cvoid Bool b
    @export_function Paned get_end_child_resizable Bool
    @export_function Paned set_end_child_shrinkable Cvoid Bool b
    @export_function Paned get_end_child_shrinkable Bool

    set_end_child!(paned::Paned, child::Widget) = detail.set_end_child!(paned._internal, child._internal.cpp_object)
    export set_end_child!

    @export_function Paned remove_end_child Cvoid

###### progress_bar.jl

    @export_type ProgressBar Widget
    ProgressBar() = ProgressBar(detail._ProgressBar())

    @export_enum ProgressBarDisplayMode begin
        PROGRESS_BAR_DISPLAY_MODE_SHOW_TEXT
        PROGRESS_BAR_DISPLAY_MODE_SHOW_PERCENTAGE
    end

    @export_function ProgressBar pulse Cvoid
    @export_function ProgressBar set_fraction! Cvoid AbstractFloat zero_to_one
    @export_function ProgressBar get_fraction Cfloat
    @export_function ProgressBar set_is_inverted! Cvoid Bool b
    @export_function ProgressBar get_is_inverted Bool
    @export_function ProgressBar set_text! Cvoid String text
    @export_function ProgressBar get_text String
    @export_function ProgressBar set_display_mode! Cvoid ProgressBarDisplayMode mode
    @export_function ProgressBar get_display_mode ProgressBarDisplayMode
    @export_function ProgressBar set_orientation! Cvoid Orientation orientation
    @export_function ProgressBar get_orientation Orientation

###### spinner.jl

    @export_type Spinner Widget
    Spinner() = Spinner(detail._Spinner())

    @export_function Spinner set_is_spinning! Cvoid Bool b
    @export_function Spinner get_is_spinning Bool
    @export_function Spinner start! Cvoid
    @export_function Spinner stop! Cvoid

###### revealer.jl

    @export_enum RevealerTransitionType begin
        REVEALER_TRANSITION_TYPE_NONE
        REVEALER_TRANSITION_TYPE_CROSSFADE
        REVEALER_TRANSITION_TYPE_SLIDE_RIGHT
        REVEALER_TRANSITION_TYPE_SLIDE_LEFT
        REVEALER_TRANSITION_TYPE_SLIDE_UP
        REVEALER_TRANSITION_TYPE_SLIDE_DOWN
        REVEALER_TRANSITION_TYPE_SWING_RIGHT
        REVEALER_TRANSITION_TYPE_SWING_LEFT
        REVEALER_TRANSITION_TYPE_SWING_UP
        REVEALER_TRANSITION_TYPE_SWING_DOWN
    end

    @export_type Revealer Widget
    Revealer(transition_type::RevealerTransitionType = REVEALER_TRANSITION_TYPE_CROSSFADE) = Revealer(detail._Revealer(transition_type))

    set_child!(revealer::Revealer, child::Widget) = detail.set_child!(revealer._internal, child._internal.cpp_object)
    export set_child!

    @export_function Revealer remove_child! Cvoid
    @export_function Revealer set_revealed! Cvoid Bool child_visible
    @export_function Revealer get_revealed Bool
    @export_function Revealer set_transition_type! Cvoid RevealerTransitionType type
    @export_function Revealer get_transition_type RevealerTransitionType

    set_transition_duration!(revealer::Revealer, duration::Time) = detail.set_transition_duration!(revealer._internal, as_microseconds(duration))
    export set_transition_duration!

    get_transition_duration(revealer::Revealer) ::Time = microseconds(detail.get_transition_duration(revealer._internal))
    export get_transition_duration

    @add_widget_signals Revealer
    @add_signal_revealed Revealer

###### scale.jl

    @export_type Scale Widget
    function Scale(lower::AbstractFloat, upper::AbstractFloat, step_increment::AbstractFloat, orientation::Orientation = ORIENTATION_HORIZONTAL)
        return Scale(detail._Scale(lower, upper, step_increment, orientation))
    end

    get_adjustment(scale::Scale) ::Adjustment = return Adjustment(detail.get_adjustment(scale._internal))
    export get_adjustment

    @export_function Scale get_lower Cfloat
    @export_function Scale get_upper Cfloat
    @export_function Scale get_step_increment Cfloat
    @export_function Scale get_value Cfloat

    @export_function Scale set_lower! Cvoid AbstractFloat value
    @export_function Scale set_upper! Cvoid AbstractFloat value
    @export_function Scale set_step_increment! Cvoid AbstractFloat value
    @export_function Scale set_value! Cvoid AbstractFloat value

    @add_widget_signals Scale
    @add_signal_value_changed Scale

###### spin_button.jl

    @export_type SpinButton Widget
    function SpinButton(lower::AbstractFloat, upper::AbstractFloat, step_increment::AbstractFloat, orientation::Orientation = ORIENTATION_HORIZONTAL)
        return SpinButton(detail._SpinButton(Cfloat(lower), Cfloat(upper), Cfloat(step_increment), orientation))
    end

    get_adjustment(spin_button::SpinButton) ::Adjustment = return Adjustment(detail.get_adjustment(spin_button._internal))
    export get_adjustment

    @export_function SpinButton get_lower Cfloat
    @export_function SpinButton get_upper Cfloat
    @export_function SpinButton get_step_increment Cfloat
    @export_function SpinButton get_value Cfloat

    @export_function SpinButton set_lower! Cvoid AbstractFloat value
    @export_function SpinButton set_upper! Cvoid AbstractFloat value
    @export_function SpinButton set_step_increment! Cvoid AbstractFloat value
    @export_function SpinButton set_value! Cvoid AbstractFloat value

    @export_function SpinButton set_n_digits! Cvoid Integer n
    @export_function SpinButton get_n_digits Int64
    @export_function SpinButton set_should_wrap! Cvoid Bool b
    @export_function SpinButton get_should_wrap Bool
    @export_function SpinButton set_acceleration_rate! Cvoid AbstractFloat factor
    @export_function SpinButton get_acceleration_rate Cfloat
    @export_function SpinButton set_should_snap_to_ticks! Cvoid Bool b
    @export_function SpinButton get_should_snap_to_ticks Bool
    @export_function SpinButton set_allow_only_numeric! Cvoid Bool b
    @export_function SpinButton get_allow_only_numeric Bool

    function set_text_to_value_function!(f, spin_button::SpinButton, data::Data_t) where Data_t
        typed_f = TypedFunction(f, AbstractFloat, (SpinButton, String, Data_t))
        detail.set_text_to_value_function!(spin_button._internal, function (spin_button_ref, text::String)
            return typed_f(SpinButton(spin_button_ref[]), text, data)
        end)
    end
    function set_text_to_value_function!(f, spin_button::SpinButton)
        typed_f = TypedFunction(f, AbstractFloat, (SpinButton, String))
        detail.set_text_to_value_function!(spin_button._internal, function (spin_button_ref, text::String)
            return typed_f(SpinButton(spin_button_ref[]), text)
        end)
    end
    export set_text_to_value_function!

    @export_function SpinButton reset_value_to_text_function! Cvoid

    function set_value_to_text_function!(f, spin_button::SpinButton, data::Data_t) where Data_t
        typed_f = TypedFunction(f, String, (SpinButton, AbstractFloat, Data_t))
        detail.set_value_to_text_function!(spin_button._internal, function (spin_button_ref, value::Cfloat)
            return typed_f(SpinButton(spin_button_ref[]), value, data)
        end)
    end
    function set_value_to_text_function!(f, spin_button::SpinButton)
        typed_f = TypedFunction(f, String, (SpinButton, AbstractFloat))
        detail.set_value_to_text_function!(spin_button._internal, function (spin_button_ref, value::Cfloat)
            return typed_f(SpinButton(spin_button_ref[]), value)
        end)
    end
    export set_value_to_text_function!

    @export_function SpinButton reset_text_to_value_function! Cvoid

    @add_widget_signals SpinButton
    @add_signal_value_changed SpinButton
    @add_signal_wrapped SpinButton

###### scrollbar.jl

    @export_type Scrollbar Widget
    Scrollbar() = Scrollbar(detail._ScrollBar)

    get_adjustment(scrollbar::Scrollbar) ::Adjustment = return Adjustment(detail.get_adjustment(scrollbar._internal))
    export get_adjustment

    @export_function Scrollbar set_orientation! Cvoid Orientation orientation
    @export_function Scrollbar get_orientation Orientation

    @add_widget_signals Scrollbar

###### separator.jl

    @export_type Separator Widget
    Separator(orientation::Orientation = ORIENTATION_HORIZONTAL; opacity::AbstractFloat = 1) = Separator(detail._Separator(opacity, orientation))

    @export_function Separator set_orientation! Cvoid Orientation orientation
    @export_function Separator get_orientation Orientation

####### frame_clock.jl

    @export_type FrameClock SignalEmitter
    FrameClock(internal::Ptr{Cvoid}) = FrameClock(detail._FrameClock(internal))

    get_time_since_last_frame(frame_clock::FrameClock) ::Time = microseconds(detail.get_time_since_last_frame(frame_clock._internal))
    export get_time_since_last_frame

    get_target_frame_duration(frame_clock::FrameClock) ::Time = microseconds(detal.get_target_frame_duration(frame_clock._internal))
    export get_target_frame_duration

    @add_signal_update FrameClock
    @add_signal_paint FrameClock

####### widget.jl

    macro export_widget_function(name, return_t)

        return_t = esc(return_t)

        mousetrap.eval(:(export $name))
        return :($name(widget::Widget) = Base.convert($return_t, detail.$name(widget._internal.cpp_object)))
    end

    macro export_widget_function(name, return_t, arg1_type, arg1_name)

        return_t = esc(return_t)
        arg1_name = esc(arg1_name)
        arg1_type = esc(arg1_type)

        mousetrap.eval(:(export $name))
        out = :($name(widget::Widget, $arg1_name::$arg1_type) = Base.convert($return_t, detail.$name(widget._internal.cpp_object, $arg1_name)))
        return out
    end

    @export_enum TickCallbackResult begin
        TICK_CALLBACK_RESULT_CONTINUE
        TICK_CALLBACK_RESULT_DISCONTINUE
    end

    @export_widget_function activate! Cvoid
    @export_widget_function get_size_request Vector2f

    @export_widget_function set_margin_top! Cvoid AbstractFloat margin
    @export_widget_function get_margin_top Cfloat
    @export_widget_function set_margin_bottom! Cvoid AbstractFloat margin
    @export_widget_function get_margin_bottom Cfloat
    @export_widget_function set_margin_start! Cvoid AbstractFloat margin
    @export_widget_function get_margin_start Cfloat
    @export_widget_function set_margin_end! Cvoid AbstractFloat margin
    @export_widget_function get_margin_end Cfloat
    @export_widget_function set_margin_horizontal! Cvoid AbstractFloat margin
    @export_widget_function set_margin_vertical! Cvoid AbstractFloat margin
    @export_widget_function set_margin_margin! Cvoid AbstractFloat margin

    @export_widget_function set_expand_horizontally! Cvoid Bool b
    @export_widget_function get_expand_horizontally Bool
    @export_widget_function set_expand_vertically! Cvoid Bool b
    @export_widget_function get_expand_vertically Bool
    @export_widget_function set_expand! Cvoid Bool b

    @export_widget_function set_horizontal_alignment! Cvoid Alignment alignment
    @export_widget_function get_horizontal_alignemtn Alignment
    @export_widget_function set_vertical_alignment! Cvoid Alignment alignment
    @export_widget_function get_vertical_alignment Alignment
    @export_widget_function set_alignment! Cvoid Alignment both

    @export_widget_function set_opacity! Cvoid AbstractFloat opacity
    @export_widget_function get_opacity Cfloat
    @export_widget_function set_is_visible! Cvoid Bool b
    @export_widget_function get_is_visible Bool

    @export_widget_function set_tooltip_text Cvoid String text
    set_tooltip_widget!(widget::Widget, tooltip::Widget) = detail.set_tooltip_widget!(widget._internal.cpp_object, tooltip._internal.cpp_object)
    export set_tooltip_widget

    @export_widget_function remove_tooltip_widget! Cvoid

    @export_widget_function set_cursor! Cvoid CursorType cursor

    function set_cursor_from_image!(widget::Widget, image::Image, offset::Vector2i)
        detail.set_cursor_from_image(widget._internal.cpp_object, image._internal, offset.x, offset.y)
    end
    export set_cursor_from_image!

    @export_widget_function hide! Cvoid
    @export_widget_function show! Cvoid

    function add_controller!(widget::Widget, controller::EventController)
        detail.add_controller(widget._internal.cpp_object, controller._internal.cpp_object)
    end
    export add_controller!

    function remove_controller!(widget::Widget, controller::EventController)
        detail.remove_controller(widget._internal.cpp_object, controller._internal.cpp_object)
    end
    export remove_controller!

    @export_widget_function set_is_focusable! Cvoid Bool b
    @export_widget_function get_is_focusable Bool
    @export_widget_function grab_focus! Cvoid
    @export_widget_function get_has_focus Bool
    @export_widget_function set_focus_on_click! Cvoid Bool b
    @export_widget_function get_focus_on_click Bool
    @export_widget_function set_can_respond_to_input! Cvoid Bool b
    @export_widget_function get_can_respond_to_input Bool

    @export_widget_function get_is_realized Bool
    @export_widget_function get_minimum_size Vector2f
    @export_widget_function get_natural_size Vector2f
    @export_widget_function get_position Vector2f
    @export_widget_function get_allocated_size Vector2f

    @export_widget_function unparent! Cvoid

    @export_widget_function set_hide_on_overflow! Cvoid Bool b
    @export_widget_function get_hide_on_overflow Bool

    get_frame_clock(widget::Widget) = FrameClock(detail.get_frame_clock(widget._internal.cpp_object))
    export get_frame_clock

    # TODO: get_clipboard(widget::Widget) = Clipboard(detail.get_clipboard(widget._internal.cpp_object))
    export get_clipboard

    @export_widget_function remove_tick_callback! Cvoid

    function set_tick_callback!(f, widget::Widget, data::Data_t) where Data_t
        typed_f = TypedFunction(f, TickCallbackResult, (FrameClock, Data_t))
        detail.set_tick_callback!(widget._internal.cpp_object, function(frame_clock_ref)
            typed_f(FrameClock(frame_clock_ref[]), data)
        end)
    end
    function set_tick_callback!(f, widget::Widget)
        typed_f = TypedFunction(f, TickCallbackResult, (FrameClock,))
        detail.set_tick_callback!(widget._internal.cpp_object, function(frame_clock_ref)
            typed_f(FrameClock(frame_clock_ref[]))
        end)
    end
    export set_tick_callback!

####### clipboard.jl

    @export_type Clipboard SignalEmitter
    @export_function Clipboard is_local Bool

    @export_function Clipboard contains_string Bool

    set_string!(clipboard::Clipboard, string::String) = detail.set_string!(clipboard._internal, string)
    export set_string!

    function get_string(f, clipboard::Clipboard, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (Clipboard, String, Data_t))
        detail.get_string(clipboard._internal, function(internal_ref, string)
            typed_f(Clipboard(internal_ref[]), String(string), data)
        end)
    end
    function get_string(f, clipboard::Clipboard)
        typed_f = TypedFunction(f, Cvoid, (Clipboard, String, Data_t))
        detail.get_string(clipboard._internal, function(internal_ref, string)
            typed_f(Clipboard(internal_ref[]), String(string))
        end)
    end
    export get_string

    @export_function Clipboard contains_image Bool

    set_image!(clipboard::Clipboard, image::Image) = detail.set_image!(clipboard._internal, image._internal)
    export set_image!

    function get_image(f, clipboard::Clipboard, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (Clipboard, Image, Data_t))
        detail.get_image(clipboard._internal, function(internal_ref, image_ref)
            typed_f(Clipboard(internal_ref[], Image(image_ref[]), data))
        end)
    end
    function get_image(f, clipboard::Clipboard)
        typed_f = TypedFunction(f, Cvoid, (Clipboard, Image))
        detail.get_image(clipboard._internal, function(internal_ref, image_ref)
            typed_f(Clipboard(internal_ref[], Image(image_ref[])))
        end)
    end
    export get_string

    @export_function Clipboard contains_file Bool

    set_file!(clipboard::Clipboard, file::FileDescriptor) = detail.set_file!(clipboard._internal, file._internal)
    export set_file!

    get_clipboard(widget::Widget) ::Clipboard = Clipboard(detail.get_clipboard(widget._internal.cpp_object))
    export get_clipboard

####### blend_mode.jl

    @export_enum BlendMode begin
        BLEND_MODE_NONE
        BLEND_MODE_ADD
        BLEND_MODE_SUBTRACT
        BLEND_MODE_REVERSE_SUBTRACT
        BLEND_MODE_MULTIPLY
        BLEND_MODE_MIN
        BLEND_MODE_MAX
    end

    function set_current_blend_mode(blend_mode::BlendMode; allow_alpha_blending = true)
        detail.set_current_blend_mode(blend_mode, allow_alpha_blending)
    end
    export set_current_blend_mode

####### gl_transform.jl

    @export_type GLTransform SignalEmitter
    GLTransform() = GLTransform(detail._GLTransform())

    import Base.setindex!
    function Base.setindex!(transform::GLTransform, x::Integer, y::Integer, value::AbstractFloat)
        if x == 0 || x > 4 || y == 0 || y > 4
            throw(BoundsError(transform, (x, y)))
        end

        detail.setindex!(transform._internal, from_julia_index(x), from_julia_index(y), value)
    end

    import Base.getindex
    function Base.getindex(transform::GLTransform, x::Integer, y::Integer) ::Cfloat
        if x == 0 || x > 4 || y == 0 || y > 4
            throw(BoundsError(transform, (x, y)))
        end

        return detail.setindex(transform._internal, from_julia_index(x), from_julia_index(y))
    end

    apply_to(transform::GLTransform, v::Vector2f) ::Vector2f = return detail.apply_to_2f(transform, v.x, v.y)
    apply_to(transform::GLTransform, v::Vector3f) ::Vector3f = return detail.apply_to_3f(transform, v.x, v.y, v.z)
    export apply_to

    combine_with(self::GLTransform, other::GLTransform) = GLTransform(detail.combin_with(self._internal, other._internal))
    export combine_with

    function rotate!(transform::GLTransform, angle::Angle, origin::Vector2f = Vector2f(0, 0))
        detail.rotate!(transform._internal, as_radians(angle), origin.x, origin.y)
    end
    export rotate!

    function tanslate!(transform::GLTransform, offset::Vector2f)
        detail.translate!(transform._internal, offset.x, offset.y)
    end
    export translate!

    function scale!(transform::GLTransform, x_scale::AbstractFloat, y_scale::AbstractFloat)
        detail.scale!(transform._internal, x_scale, y_scale)
    end
    export scale!

    @export_function GLTransform reset! Cvoid

###### shader.jl

    @export_type Shader SignalEmitter
    Shader() = Shader(detail._Shader())

    @export_enum ShaderType begin
        SHADER_TYPE_FRAGMENT
        SHADER_TYPE_VERTEX
    end

    @export_function Shader get_program_id Cuint
    @export_function Shader get_fragment_shader_id Cuint
    @export_function Shader get_vertex_shader_id Cuint

    function create_from_string!(shader::Shader, code::String) ::Bool
        return detail.create_from_string!(shader._internal, code)
    end
    export create_from_string!

    function create_from_file!(shader::Shader, file::String) ::Bool
        return detail.create_from_file!(shader._internal, file)
    end
    export create_from_file!

    @export_function Shader get_uniform_location Cint String name

    @export_function Shader set_uniform_float! Cint String name Cfloat float
    @export_function Shader set_uniform_int! Cint String name Cint float
    @export_function Shader set_uniform_uint! Cint String name Cuint float

    set_uniform_vec2!(shader::Shader, name::String, vec2::Vector2f) = detail.set_uniform_vec2!(shader._internal, name, vec2)
    export set_uniform_vec2!

    set_uniform_vec3!(shader::Shader, name::String, vec2::Vector2f) = detail.set_uniform_vec3!(shader._internal, name, vec2)
    export set_uniform_vec3!

    set_uniform_vec4!(shader::Shader, name::String, vec2::Vector2f) = detail.set_uniform_vec4!(shader._internal, name, vec2)
    export set_uniform_vec4!

    set_uniform_transform!(shader::Shader, name::String, transform::GLTransform) = detail.set_uniform_transform!(shader._internal, name, transform._internal)
    export set_uniform_transform!

    get_vertex_position_location() = return detail.shader_get_vertex_position_location()
    export get_vertex_position_location

    get_vertex_color_location() = return detail.shader_get_vertex_color_location()
    export get_vertex_color_location

    get_vertex_texture_coordinate_location() = return detail.shader_get_vertex_texture_coordinate_location()
    export get_vertex_texture_coordinate_location

###### texture.jl

    abstract type TextureObject <: SignalEmitter end

    @export_enum TextureWrapMode begin
        TEXTURE_WRAP_MODE_ZERO
        TEXTURE_WRAP_MODE_ONE
        TEXTURE_WRAP_MODE_REPEAT
        TEXTURE_WRAP_MODE_MIRROR
        TEXTURE_WRAP_MODE_STRETCH
    end

    @export_enum TextureScaleMode begin
        TEXTURE_SCALE_MODE_NEAREST
        TEXTURE_SCALE_MODE_LINEAR
    end

    @export_type Texture TextureObject
    Texture() = Texture(detail._Texture())

    @export_type RenderTexture TextureObject
    RenderTexture() = RenderTexture(detail._RenderTexture())

    download(texture::TextureObject) ::Image = Image(detail.texture_download(texture._internal.cpp_object))
    export download

    bind(texture::TextureObject) = detail.texture_bind(texture._internal.cpp_object)
    export bind

    unbind(texture::TextureObject) = detail.texture_unbind(texture._internal.cpp_object)
    export unbind

    create_from_image!(texture::TextureObject) = detail::texture_create_from_image!(texture._internal.cpp_object)
    export create_from_image!

    create_from_image!(texture::TextureObject, image::Image) = detail.texture_create_from_image(texture._internal.cpp_object, image._internal)
    export create_from_image!

    set_wrap_mode!(texture::TextureObject, mode::TextureWrapMode) = detail.texture_set_wrap_mode(texture._internal.cpp_object, mode)
    export set_wrap_mode!

    set_scale_mode!(texture::TextureObject, mode::TextureWrapMode) = detail.set_scale_mode(texture._internal.cpp_object, mode)
    export set_scale_mode!

    get_wrap_mode(texture::TextureObject) ::TextureWrapMode = detail.texture_get_wrap_mode(texture._internal.cpp_object)
    export get_wrap_mode

    get_scale_mode(texture::TextureObject) ::TextureScaleMode = detail.texture_get_scale_mode(texture._internal.cpp_object)
    export get_scale_mode

    get_size(texture::TextureObject) ::Vector2i = detail.texture_get_size(texture._internal.cpp_object)
    export get_size

    get_native_handle(texture::TextureObject) ::Cuint = detail.texture_get_native_handle(texture._internal.cpp_object)
    export get_native_handle

###### shape.jl

    @export_type Shape SignalEmitter
    Shape() = Shape(detail._Shape())

    @export_function Shape get_native_handle Cuint

    as_point!(shape::Shape, position::Vector2f) = detail.as_point!(shape._internal, position)
    export as_point!

    function Point(position::Vector2f) ::Shape
        out = Shape()
        as_point!(shape, position)
        return out
    end
    export Point

    function as_points!(shape::Shape, positions::Vector{Vector2f})
        return detail.as_point!(shape._internal, positions)
    end
    export as_points!

    function Points(positions::Vector{Vector2f}) ::Shape
        out = Shape()
        as_points!(shape, position)
        return out
    end
    export Point

    as_triangle!(shape::Shape, a::Vector2f, b::Vector2f, c::Vector2f) = detail.as_triangle!(shape._internal, a, b, c)
    export as_triangle!

    function Triangle(a::Vector2f, b::Vector2f, c::Vector2f) ::Shape
        out = Shape()
        as_triangle!(out, a, b, c)
        return out
    end
    export Triangle

    as_rectangle!(shape::Shape, top_left::Vector2f, size::Vector2f) = detail.as_rectangle!(shape._internal, top_left, size)
    export as_rectangle!

    function Rectangle(top_left::Vector2f, size::Vector2f) ::Shape
        out = Shape()
        as_rectangle!(out, top_left, size)
        return out
    end
    export Rectangle

    as_ellipse!(shape::Shape, center::Vector2f, radius::AbstractFloat, n_outer_vertices::Unsigned) = detail.as_circle!(shape._internal, radius, n_outer_vertices)
    export as_circle!

    function Circle(center::Vector2f, radius::AbstractFloat, n_outer_vertices::Unsigned) ::Shape
        out = Shape()
        as_circle!(out, center, radius, n_outer_vertices)
        return out
    end
    export Circle

    as_ellipse!(shape::Shape, center::Vector2f, x_radius::AbstractFloat, y_radius::AbstractFloat, n_outer_vertices::Unsigned) = detail.as_ellipse!(shape._internal, x_radius, y_radius, n_outer_vertices)
    export as_ellipse!

    function Circle(center::Vector2f, x_radius::AbstractFloat, y_radius::AbstractFloat, n_outer_vertices::Unsigned) ::Shape
        out = Shape()
        as_ellipse!(out, x_radius, y_radius, n_outer_vertices)
        return out
    end
    export Circle

    as_line!(shape::Shape, a::Vector2f, b::Vector2f) = detail.as_line!(shape._internal, a, b)
    export as_line!

    function Line(a::Vector2f, b::Vector2f)
        out = Shape()
        as_line!(out, a, b)
        return out
    end
    export Line

    as_lines!(shape::Shape, points::Vector{Pair{Vector2f, Vector2f}}) = detail.as_lines!(shape._internal, points)
    export as_lines!

    function Lines(points::Vector{Pair{Vector2f, Vector2f}})
        out = Shape()
        as_lines!(out, points)
        return out
    end

    as_line_strip!(shape::Shape, points::Vector{Vector2f}) = detail.as_line_strip!(shape._internal, points)
    export as_line_strip!

    function LineStrip(points::Vector2{Vector2f})
        out = Shape()
        as_line_strip!(out, points)
        return out
    end
    export LineStrip

    as_polygon!(shape::Shape, points::Vector{Vector2f}) = detail.as_polygon!(shape._internal, points)
    export as_polygon!

    function Polygon(points::Vector2{Vector2f})
        out = Shape()
        as_polygon!(out, points)
        return out
    end
    export Polygon

    function as_rectangular_frame!(shape::Shape, top_left::Vector2f, outer_size::Vector2f, x_width::AbstractFloat, y_width::AbstractFloat)
        detail.as_rectangular_frame!(shape._internal, top_left, outer_size, x_width, y_width)
    end
    export as_rectangular_frame!

    function RectangularFrame(top_left::Vector2f, outer_size::Vector2f, x_width::AbstractFloat, y_width::AbstractFloat)
        out = Shape()
        as_rectangular_frame!(out, top_left, outer_size, x_width, y_width)
        return out
    end
    export RectangularFrame

    function as_circular_ring!(shape::Shape, center::Vector2f, outer_radius::AbstractFloat, thickness::AbstractFloat, n_outer_vertices::Unsigned)
        detail.as_circular_ring!(shape._internal, center, outer_radius, thickness, n_outer_vertices)
    end
    export as_circular_ring!

    function CircularRing(center::Vector2f, outer_radius::AbstractFloat, thickness::AbstractFloat, n_outer_vertices::Unsigned)
        out = Shape()
        as_circular_ring!(shape, center, outer_radius, thickness, n_outer_vertices)
        return out
    end
    export CircularRing

    function as_elliptical_ring!(shape::Shape, center::Vector2f, outer_x_radius::AbstractFloat, outer_y_radius::AbstractFloat, x_thickness::AbstractFloat, y_thickness::AbstractFloat, n_outer_vertices::Unsigned)
        detail.as_elliptical_ring!(shape._internal, center, outer_x_radius, outer_y_radius, x_thickness, y_thickness, n_outer_vertices)
    end
    export as_elliptical_ring!

    function EllipticalRing(center::Vector2f, outer_x_radius::AbstractFloat, outer_y_radius::AbstractFloat, x_thickness::AbstractFloat, y_thickness::AbstractFloat, n_outer_vertices::Unsigned) ::Shape
        out = Shape()
        as_elliptical_ring!(out, outer_x_radius, outer_y_radius, x_thickness, y_thickness, n_outer_vertices)
        return out
    end
    export EllipticalRing

    as_wireframe!(shape::Shape, points::Vector{Vector2f}) = detail.as_wireframe!(shape._internal, points)
    export as_wireframe!

    function Wireframe(points::Vector{Vector2f})
        out = Shape()
        as_wireframe!(out, points)
        return out
    end
    export Wireframe

    as_outline!(self::Shape, other::Shape) = detail.as_outline!(self._internal, other._internal)
    export as_outline!

    function Outline(other::Shape)
        out = Shape()
        as_outline!(out, other)
        return out
    end
    export Outline

    render(shape::Shape, shader::Shader, transform::GLTransform) = detail.render(shape._internal, shader._internal, transform._internal)
    export render

    @export_function Shape get_vertex_color RGBA Integer index
    @export_function Shape set_vertex_color! Cvoid Integer index RGBA color

    @export_function Shape get_vertex_texture_coordinate Vector2f Integer index
    @export_function Shape set_vertex_texture_coordinate Cvoid Integer index Vector2f coordinate

    @export_function Shape get_vertex_position Vector3f
    @export_function Shape set_vertex_position! Cvoid Integer index Vector3f position

    @export_function Shape get_n_vertices Int64

    @export_function Shape set_is_visible! Cvoid Bool b
    @export_function Shape get_is_visible Bool

    @export_function Shape get_bounding_box Rectangle
    @export_function Shape get_size Vector2f

    @export_function Shape set_centroid! Cvoid Vector2f centroid
    @export_function Shape get_centroid Vector2f
    @export_function Shape set_top_left! Cvoid Vector2f top_left
    @export_function Shape get_top_left Vector2f

    function rotate!(shape::Shape, angle::Angle, origin::Vector2f = Vector2f(0, 0))
        detail.rotate!(shape._internal, as_radians(angle), origin.x, origin.y)
    end
    export rotate!

    set_texture!(shape::Shape, texture::TextureObject) = detail.set_texture!(shape._internal, texture._internal.cpp_object)
    export set_texture!

###### render_task.jl

    @export_type RenderTask SignalEmitter

    function RenderTask(shape::Shape;
        shader::Union{Shader, Nothing} = nothing,
        transform::Union{GLTransform, Nothing} = nothing,
        blend_mode::BlendMode = BLEND_MODE_NORMAL
    )
        shader_ptr = isnothing(shader) ? Ptr{Cvoid}(0) : shader._internal.cpp_object
        transform_ptr = isnothing(transform) ? Ptr{Cvoid}(0) : transform._internal.cpp_object

        return RenderTask(detail._RenderTask(shape._internal, shader_ptr, transform_ptr, blend_mode))
    end
    export RenderTask

    @export_function RenderTask render Cvoid

    @export_function RenderTask set_uniform_float! Cvoid String name Cfloat v
    @export_function RenderTask get_uniform_float Cfloat String name

    @export_function RenderTask set_uniform_int! Cvoid String name Cint v
    @export_function RenderTask get_uniform_int Cint String name

    @export_function RenderTask set_uniform_uint! Cvoid String name Cuint v
    @export_function RenderTask get_uniform_uint Cuint String name

    set_uniform_vec2!(task::RenderTask, name::String, v::Vector2f) = detail.set_uniform_vec2!(task._internal, name, v)
    export set_uniform_vec2!

    get_uniform_vec2(task::RenderTask, name::String) ::Vector2f = detail.get_uniform_vec2(task._internal, name)
    export get_uniform_vec2

    set_uniform_vec3!(task::RenderTask, name::String, v::Vector3f) = detail.set_uniform_vec3!(task._internal, name, v)
    export set_uniform_vec3!

    get_uniform_vec3(task::RenderTask, name::String) ::Vector3f = detail.get_uniform_vec3(task._internal, name)
    export get_uniform_vec3

    set_uniform_vec4!(task::RenderTask, name::String, v::Vector4f) = detail.set_uniform_vec4!(task._internal, name, v)
    export set_uniform_vec4!

    get_uniform_vec4(task::RenderTask, name::String) ::Vector4f = detail.get_uniform_vec4(task._internal, name)
    export get_uniform_vec4

    set_uniform_rgba!(task::RenderTask, name::String, rgba::RGBA) = detail.set_uniform_rgba!(task._internal, name, rbga)
    export set_uniform_rgba!

    get_uniform_rgba(task::RenderTask, name::String) ::RGBA = detail.get_uniform_rgba(task._internal, name, rgba)
    export get_uniform_rgba

    set_uniform_hsva!(task::RenderTask, name::String, hsva::RGBA) = detail.set_uniform_hsva!(task._internal, name, rbga)
    export set_uniform_hsva!

    get_uniform_hsva(task::RenderTask, name::String) ::HSVA = detail.get_uniform_hsva(task._internal, name, hsva)
    export get_uniform_rgba

    set_uniform_transform!(task::RenderTask, name::String, transform::GLTransform) = detail.set_uniform_transform(task._internal, transform._internal)
    export set_uniform_transform!

    get_uniform_transform(task::RenderTask, name::String) ::GLTransform = GLTransform(detail.get_uniform_transform(task._internal, name))
    export get_uniform_transform

###### render_area.jl

    @export_type RenderArea Widget
    RenderArea() = RenderArea(detail._RenderArea())

    add_render_task!(area::RenderArea, task::RenderTask) = detail.add_render_task!(area._internal, task._internal)
    export add_render_task!

    @export_function RenderArea clear_render_tasks! Cvoid

    @export_function RenderArea make_current Cvoid
    @export_function RenderArea clear Cvoid
    @export_function RenderArea render_render_tasks Cvoid
    @export_function RenderArea flush Cvoid

    function from_gl_coordinates(area::RenderArea, gl_coordinates::Vector2f) ::Vector2f
        return detail.from_gl_coordinates(area._internal, gl_coordinates)
    end
    export from_gl_coordinates

    function to_gl_coordiantes(area::RenderArea, absolute_widget_space_coordinates::Vector2f) ::Vector2f
        return detail.to_gl_coordinates(area._internal, absolute_widget_space_coordinates)
    end
    export to_gl_coordinates

    @add_widget_signals RenderArea
    @add_signal_resize RenderArea
    @add_signal_render RenderArea

###### key_code.jl

    include("./key_codes.jl")

end # module mousetrap

@info "Done (" * string(round(time() - __mousetrap_compile_time_start; digits=2)) * "s)"

mt = mousetrap
mt.main() do app::mt.Application

    window = mt.Window(app)

    spin_button = mt.SpinButton(0.0, 1.0, 0.01)
    mt.connect_signal_value_changed!(spin_button) do x::mt.SpinButton
        println(mt.get_value(x))
    end

    mt.set_child!(window, spin_button)
    mt.present!(window)
end
