#
# Author: C. Cords (mail@clemens-cords.com)
# GitHub: https://github.com/clemapfel/mousetrap.jl
# Documentation: https://clemens-cords.com/mousetrap
#
# Copyright © 2023, Licensed under lGPL-3.0
#

"""
# Mousetrap GUI Engine ($(Mousetrap.VERSION))

GitHub: https://github.com/clemapfel/mousetrap.jl
Documentation: http://clemens-cords.com/mousetrap/

Copyright © 2024 C.Cords, Licensed under lGPL-3.0
"""
module Mousetrap

    const VERSION = v"0.3.2"

####### detail.jl

    module detail
        using CxxWrap
        import GTK4_jll, Glib_jll
        function try_update_gsettings_schema_dir()
            # request to use GTK4_jll-supplied settings schema if none are available on the machine
            if !Sys.islinux() && (!haskey(ENV, "GSETTINGS_SCHEMA_DIR") || isempty(ENV["GSETTINGS_SCHEMA_DIR"]))
                ENV["GSETTINGS_SCHEMA_DIR"] = normpath(joinpath(GTK4_jll.libgtk4, "../../share/glib-2.0/schemas"))
            end
        end

        function __init__()
            try_update_gsettings_schema_dir()   # executed on `using Mousetrap`, env needs to be set each time before `adw_init` is called
            @initcxx()
        end

        using mousetrap_jll
        function get_mousetrap_julia_binding()
            return mousetrap_jll.mousetrap_julia_binding
        end

        try_update_gsettings_schema_dir()       # executed on `precompile Mousetrap`, but not on using, silences warning during installation
        @wrapmodule(get_mousetrap_julia_binding)
    end

    const MOUSETRAP_ENABLE_OPENGL_COMPONENT = convert(Bool, detail.MOUSETRAP_ENABLE_OPENGL_COMPONENT)

####### typed_function.jl

    mutable struct TypedFunction

        _apply::Function
        _return_t::Type
        _arg_ts::Tuple

        function TypedFunction(f::Function, return_t::Type, arg_ts::Tuple)

            precompile(f, arg_ts)

            arg_ts_string = "("
            for i in 1:length(arg_ts)
                arg_ts_string = arg_ts_string * string(arg_ts[i]) * ((i < length(arg_ts)) ? ", " : ")")
            end
            signature = arg_ts_string  * " -> $return_t"

            actual_return_ts = Base.return_types(f, arg_ts)

            if isempty(actual_return_ts)
                throw(AssertionError("Object `$f` is not invokable as function with signature `$signature`, because it does not have a method with argument type(s) `$arg_ts_string`"))
            end

            match_found = false
            for type in actual_return_ts
                if type <: return_t #|| return_t == Nothing
                    match_found = true
                    break
                end
            end

            if !match_found
                throw(AssertionError("Object `$f` is not invokable as function with signature `$signature`, because its return type is not `$return_t`"))
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

    abstract type Widget <: SignalEmitter end
    export Widget

####### log.jl

    const LogDomain = String;
    export LogDomain

    const MOUSETRAP_DOMAIN = detail.MOUSETRAP_DOMAIN * ".jl"
    # no export

    """
    See [`log_debug`](@ref).
    """
    macro log_debug(domain, message)
        return :(Mousetrap.detail.log_debug($message, $domain))
    end
    log_debug(domain::LogDomain, message::String) = detail.log_debug(message, domain)
    export @log_debug, log_debug

    """
    See [`log_info`](@ref).
    """
    macro log_info(domain, message)
        return :(Mousetrap.detail.log_info($message, $domain))
    end
    log_info(domain::LogDomain, message::String) = detail.log_info(message, domain)
    export @log_info, log_info

    """
    See [`log_warning`](@ref).
    """
    macro log_warning(domain, message)
        return :(Mousetrap.detail.log_warning($message, $domain))
    end
    log_warning(domain::LogDomain, message::String) = detail.log_warning(message, domain)
    export @log_warning, log_warning

    """
    See [`log_critical`](@ref).
    """
    macro log_critical(domain, message)
        return :(Mousetrap.detail.log_critical($message, $domain))
    end
    log_critical(domain::LogDomain, message::String) = detail.log_critical(message, domain)
    export @log_critical, log_critical

    """
    See [`log_fatal`](@ref).
    """
    macro log_fatal(domain, message)
        return :(Mousetrap.detail.log_fatal($message, $domain))
    end
    log_fatal(domain::LogDomain, message::String) = detail.log_fatal(message, domain)
    export @log_fatal, log_fatal

    set_surpress_debug!(domain::LogDomain, b::Bool) = detail.log_set_surpress_debug(domain, b)
    export set_surpress_debug!

    set_surpress_info!(domain::LogDomain, b::Bool) = detail.log_set_surpress_info(domain, b)
    export set_surpress_info!

    get_surpress_debug(domain::LogDomain) ::Bool = detail.log_get_surpress_debug(domain)
    export get_surpress_debug

    get_surpress_info(domain::LogDomain) ::Bool = detail.log_get_surpress_info(domain)
    export get_surpress_info

    set_log_file!(path::String) ::Bool = detail.log_set_file(path)
    export set_log_file!

####### common.jl

    macro do_not_compile(args...) return :() end

    import Base: *
    *(x::Symbol, y::Symbol) = Symbol(string(x) * string(y))

    function from_julia_index(x::Integer) ::UInt64
        if x <= 0
            throw(AssertionError("Index $x < 1; Indices in Julia are 1-based."))
        end
        return x - 1
    end

    function to_julia_index(x::Integer) ::Int64
        return x + 1
    end

    function safe_call(scope::String, f, args...)
        try
            return f(args...)
        catch exception
            printstyled(stderr, "[ERROR] "; bold = true, color = :red)
            printstyled(stderr, "In " * scope * ": "; bold = true)
            Base.showerror(stderr, exception, catch_backtrace())
            print(stderr, "\n")
            throw(exception) # this causes jl_call to return nullptr C-side, as opposed to jl_nothing
        end
    end

    macro export_function(type, name, return_t)

        return_t = esc(return_t)

        Mousetrap.eval(:(export $name))
        return :($name(x::$type) = Base.convert($return_t, detail.$name(x._internal)))
    end

    macro export_function(type, name, return_t, arg1_type, arg1_name)

        return_t = esc(return_t)

        if arg1_type isa Expr
            arg1_origin_type = arg1_type.args[2]
            arg1_destination_type = arg1_type.args[3]
        else
            arg1_origin_type = arg1_type
            arg1_destination_type = arg1_type
        end
        arg1_name = esc(arg1_name)

        Mousetrap.eval(:(export $name))
        return :($name(
                x::$type,
                $arg1_name::$arg1_origin_type
            ) = Base.convert($return_t, detail.$name(x._internal,
                convert($arg1_destination_type, $arg1_name)
            )))
    end

    macro export_function(type, name, return_t, arg1_type, arg1_name, arg2_type, arg2_name)

        return_t = esc(return_t)

        if arg1_type isa Expr
            arg1_origin_type = arg1_type.args[2]
            arg1_destination_type = arg1_type.args[3]
        else
            arg1_origin_type = arg1_type
            arg1_destination_type = arg1_type
        end
        arg1_name = esc(arg1_name)

        if arg2_type isa Expr
            arg2_origin_type = arg2_type.args[2]
            arg2_destination_type = arg2_type.args[3]
        elseif arg2_type isa Symbol
            arg2_origin_type = arg2_type
            arg2_destination_type = arg2_type
        end
        arg2_name = esc(arg2_name)

        Mousetrap.eval(:(export $name))
        return :($name(
                x::$type,
                $arg1_name::$arg1_origin_type,
                $arg2_name::$arg2_origin_type
            ) = Base.convert($return_t, detail.$name(x._internal,
                convert($arg1_destination_type, $arg1_name),
                convert($arg2_destination_type, $arg2_name)
            )))
    end

    macro export_function(type, name, return_t, arg1_type, arg1_name, arg2_type, arg2_name, arg3_type, arg3_name)

        return_t = esc(return_t)

        if arg1_type isa Expr
            arg1_origin_type = arg1_type.args[2]
            arg1_destination_type = arg1_type.args[3]
        else
            arg1_origin_type = arg1_type
            arg1_destination_type = arg1_type
        end
        arg1_name = esc(arg1_name)

        if arg2_type isa Expr
            arg2_origin_type = arg2_type.args[2]
            arg2_destination_type = arg2_type.args[3]
        elseif arg2_type isa Symbol
            arg2_origin_type = arg2_type
            arg2_destination_type = arg2_type
        end
        arg2_name = esc(arg2_name)

        if arg3_type isa Expr
            arg3_origin_type = arg3_type.args[2]
            arg3_destination_type = arg3_type.args[3]
        else
            arg3_origin_type = arg3_type
            arg3_destination_type = arg3_type
        end
        arg3_name = esc(arg3_name)

        Mousetrap.eval(:(export $name))
        return :($name(
                x::$type,
                $arg1_name::$arg1_origin_type,
                $arg2_name::$arg2_origin_type,
                $arg3_name::$arg3_origin_type
            ) = Base.convert($return_t, detail.$name(x._internal,
                convert($arg1_destination_type, $arg1_name),
                convert($arg2_destination_type, $arg2_name),
                convert($arg3_destination_type, $arg3_name),
            )))
    end

    macro export_function(type, name, return_t, arg1_type, arg1_name, arg2_type, arg2_name, arg3_type, arg3_name, arg4_type, arg4_name)

        return_t = esc(return_t)

        if arg1_type isa Expr
            arg1_origin_type = arg1_type.args[2]
            arg1_destination_type = arg1_type.args[3]
        else
            arg1_origin_type = arg1_type
            arg1_destination_type = arg1_type
        end
        arg1_name = esc(arg1_name)

        if arg2_type isa Expr
            arg2_origin_type = arg2_type.args[2]
            arg2_destination_type = arg2_type.args[3]
        elseif arg2_type isa Symbol
            arg2_origin_type = arg2_type
            arg2_destination_type = arg2_type
        end
        arg2_name = esc(arg2_name)

        if arg3_type isa Expr
            arg3_origin_type = arg3_type.args[2]
            arg3_destination_type = arg3_type.args[3]
        else
            arg3_origin_type = arg3_type
            arg3_destination_type = arg3_type
        end
        arg3_name = esc(arg3_name)

        if arg4_type isa Expr
            arg4_origin_type = arg4_type.args[2]
            arg4_destination_type = arg4_type.args[3]
        else
            arg4_origin_type = arg4_type
            arg4_destination_type = arg4_type
        end
        arg4_name = esc(arg4_name)

        Mousetrap.eval(:(export $name))
        return :($name(
                x::$type,
                $arg1_name::$arg1_origin_type,
                $arg2_name::$arg2_origin_type,
                $arg3_name::$arg3_origin_type,
                $arg4_name::$arg4_origin_type
            ) = Base.convert($return_t, detail.$name(x._internal,
                convert($arg1_destination_type, $arg1_name),
                convert($arg2_destination_type, $arg2_name),
                convert($arg3_destination_type, $arg3_name),
                convert($arg4_destination_type, $arg4_name)
            )))
    end

    @generated function get_top_level_widget(x) ::Widget
        return :(
            throw(AssertionError("Object of type $(typeof(x)) does not fullfill the widget interface. In order for it to be able to be treated as a widget, you need to subtype `Mousetrap.Widget` **and** add a method with signature `(::$(typeof(x))) -> Widget` to `Mousetrap.get_top_level_widget`, which should map an instance of $(typeof(x)) to its top-level widget component."))
        )
    end
    export get_top_level_widget

    @generated function is_native_widget(x::Any)
        :(return false)
    end
    # no export

    macro declare_native_widget(Type)
        out = Expr(:block)
        push!(out.args, esc(
            :(is_native_widget(::$Type) = return true)
        ))
        return out
    end

    macro export_type(name, super)

        super = esc(super)
        internal_name = Symbol("_" * "$name")

        if !isdefined(detail, :($internal_name))
            throw(AssertionError("In Mousetrap.@export_type: detail.$internal_name undefined"))
        end

        out = Expr(:toplevel)
        Mousetrap.eval(:(export $name))
        push!(out.args, :(
            mutable struct $name <: $super
                _internal::detail.$internal_name
            end
        ))
        return out
    end

    macro export_type(name)

        internal_name = Symbol("_" * "$name")

        if !isdefined(detail, :($internal_name))
            throw(AssertionError("In Mousetrap.@export_type: detail.$internal_name undefined"))
        end

        out = Expr(:toplevel)
        Mousetrap.eval(:(export $name))
        push!(out.args, :(
            struct $name
                _internal::detail.$internal_name
            end
        ))
        return out
    end

    macro export_enum(enum, block)

        @assert block isa Expr

        out = Expr(:toplevel)

        push!(out.args, (:(export $enum)))

        detail_enum_name = :_ * enum
        @assert isdefined(detail, detail_enum_name)

        names = Symbol[]
        push!(out.args, :(const $(esc(enum)) = Mousetrap.detail.$detail_enum_name))
        for name in block.args
            if !(name isa Symbol)
                continue
            end

            push!(out.args, :(const $(esc(name)) = detail.$name))
            push!(out.args, :(export $name))

            push!(names, name)
        end

        enum_str = string(enum)
        enum_sym = QuoteNode(enum)
        to_int_name = Symbol(enum) * :_to_int

        #push!(out.args, :(Base.ndigits(x::$enum) = ndigits(Mousetrap.detail.$to_int_name(x))))
        push!(out.args, :(Base.string(x::$enum) = string(Mousetrap.detail.$to_int_name(x))))
        push!(out.args, :(Base.convert(::Type{Integer}, x::$enum) = Integer(Mousetrap.detail.$to_int_name(x))))
        push!(out.args, :(Base.instances(x::Type{$enum}) = [$(names...)]))
        push!(out.args, :(Base.show(io::IO, x::Type{$enum}) = print(io, (isdefined(Main, $enum_sym) ? "" : "Mousetrap.") * $enum_str)))
        push!(out.args, :(Base.show(io::IO, x::$enum) = print(io, string($enum) * "(" * string(convert(Int64, x)) * ")")))
        return out
    end

    function show_aux(io::IO, x::T, fields::Symbol...) where T

        out = string(typeof(x)) * "("
        for i in 1:length(fields)

            field = fields[i]

            get_field = :get_ * field
            value = eval(:($get_field($x)))

            if typeof(value) == String
                out *= "$field = \"$value\""
            else
                out *= "$field = $value"
            end

            if i != length(fields)
                out *= ", "
            end
        end

        out *= ")"
        print(io, out)
    end

###### vector.jl

    mutable struct Vector2{T <: Number}
        x::T
        y::T

        Vector2{T}(all::Number) where T = new{T}(convert(T, all), convert(T, all))
        Vector2{T}(x::Number, y::Number) where T = new{T}(convert(T, x), convert(T, y))
    end
    export Vector2

    Base.:(+)(a::Vector2{T}, b::Vector2{T}) where T = Vector2{T}(a.x + b.x, a.y + b.y)
    Base.:(-)(a::Vector2{T}, b::Vector2{T}) where T = Vector2{T}(a.x - b.x, a.y - b.y)
    Base.:(*)(a::Vector2{T}, b::Vector2{T}) where T = Vector2{T}(a.x * b.x, a.y * b.y)
    Base.:(/)(a::Vector2{T}, b::Vector2{T}) where T = Vector2{T}(a.x / b.x, a.y / b.y)
    Base.:(==)(a::Vector2{T}, b::Vector2{T}) where T = a.x == b.x && a.y == b.y
    Base.:(!=)(a::Vector2{T}, b::Vector2{T}) where T = !(a == b)

    const Vector2f = Vector2{Cfloat}
    const Vector2i = Vector2{Cint}
    const Vector2ui = Vector2{Csize_t}

    export Vector2f, Vector2i, Vector2ui

    mutable struct Vector3{T <: Number}
        x::T
        y::T
        z::T

        Vector3{T}(all::Number) where T = new{T}(convert(T, all), convert(T, all), convert(T, all))
        Vector3{T}(x::Number, y::Number, z::Number) where T = new{T}(convert(T, x), convert(T, y), convert(T, z))
    end
    export Vector3

    Base.:(+)(a::Vector3{T}, b::Vector3{T}) where T = Vector3{T}(a.x + b.x, a.y + b.y, a.z + b.z)
    Base.:(-)(a::Vector3{T}, b::Vector3{T}) where T = Vector3{T}(a.x - b.x, a.y - b.y, a.z - b.z)
    Base.:(*)(a::Vector3{T}, b::Vector3{T}) where T = Vector3{T}(a.x * b.x, a.y * b.y, a.z * b.z)
    Base.:(/)(a::Vector3{T}, b::Vector3{T}) where T = Vector3{T}(a.x / b.x, a.y / b.y, a.z / b.z)
    Base.:(==)(a::Vector3{T}, b::Vector3{T}) where T = a.x == b.x && a.y == b.y && a.z == b.z
    Base.:(!=)(a::Vector3{T}, b::Vector3{T}) where T = !(a == b)

    const Vector3f = Vector3{Cfloat}
    const Vector3i = Vector3{Cint}
    const Vector3ui = Vector3{Csize_t}

    export Vector3f, Vector3i, Vector3ui

    mutable struct Vector4{T <: Number}
        x::T
        y::T
        z::T
        w::T

        Vector4{T}(all::Number) where T = new{T}(convert(T, all), convert(T, all), convert(T, all), convert(T, all))
        Vector4{T}(x::Number, y::Number, z::Number, w::Number) where T = new{T}(convert(T, x), convert(T, y), convert(T, z), convert(T, w))
    end
    export Vector4

    Base.:(+)(a::Vector4{T}, b::Vector4{T}) where T = Vector4{T}(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)
    Base.:(-)(a::Vector4{T}, b::Vector4{T}) where T = Vector4{T}(a.x - b.x, a.y - b.y, a.z - b.z, a.w - b.w)
    Base.:(*)(a::Vector4{T}, b::Vector4{T}) where T = Vector4{T}(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w)
    Base.:(/)(a::Vector4{T}, b::Vector4{T}) where T = Vector4{T}(a.x / b.x, a.y / b.y, a.z / b.z, a.w / b.w)
    Base.:(==)(a::Vector4{T}, b::Vector4{T}) where T = a.x == b.x && a.y == b.y && a.z == b.z && a.w == b.w
    Base.:(!=)(a::Vector4{T}, b::Vector4{T}) where T = !(a == b)

    const Vector4f = Vector4{Cfloat}
    const Vector4i = Vector4{Cint}
    const Vector4ui = Vector4{Csize_t}

    export Vector4f, Vector4i, Vector4ui

    Base.show(io::IO, x::Vector2{T}) where T = print(io, "Vector2{" * string(T) * "}(" * string(x.x) * ", " * string(x.y) * ")")
    Base.show(io::IO, x::Vector3{T}) where T = print(io, "Vector3{" * string(T) * "}(" * string(x.x) * ", " * string(x.y) * ", " * string(x.z) * ")")
    Base.show(io::IO, x::Vector4{T}) where T = print(io, "Vector4{" * string(T) * "}(" * string(x.x) * ", " * string(x.y) * ", " * string(x.z) * ", " * string(x.w) * ")")

####### time.jl

    struct Time
        _ns::Int64
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

    minutes(n::Number) = Time(detail.minutes_to_ns(convert(Cdouble, n)))
    export minutes

    seconds(n::Number) = Time(detail.seconds_to_ns(convert(Cdouble, n)))
    export seconds

    milliseconds(n::Number) = Time(detail.milliseconds_to_ns(convert(Cdouble, n)))
    export milliseconds

    microseconds(n::Number) = Time(detail.microseconds_to_ns(convert(Cdouble, n)))
    export microseconds

    nanoseconds(n::Integer) = Time(n)
    export nanoseconds

    Base.:(+)(a::Time, b::Time) = Time(a._ns + b._ns)
    Base.:(-)(a::Time, b::Time) = Time(a._ns - b._ns)
    Base.:(==)(a::Time, b::Time) = a._ns == b._ns
    Base.:(!=)(a::Time, b::Time) = !(a == b)
    Base.:(<)(a::Time, b::Time) = a._ns < b._ns
    Base.:(>)(a::Time, b::Time) = a._ns > b._ns

    Base.show(io::IO, x::Time) = print(io, "Time($(as_seconds(x))s)")

    @export_type Clock SignalEmitter
    Clock() = Clock(detail._Clock())

    restart!(clock::Clock) ::Time = microseconds(detail.restart!(clock._internal))
    export restart!

    elapsed(clock::Clock) ::Time = microseconds(detail.elapsed(clock._internal))
    export elapsed

    Base.show(io::IO, x::Clock) = print(io, "Clock($(elapsed(x))s)")

####### angle.jl

    struct Angle
        _rads::Cfloat
    end
    export Angle

    degrees(x::Number) = Angle(convert(Cfloat, deg2rad(x)))
    export degrees

    radians(x::Number) = Angle(convert(Cfloat, x))
    export radians

    as_degrees(angle::Angle) ::Cdouble = rad2deg(angle._rads)
    export as_degrees

    as_radians(angle::Angle) ::Cdouble = angle._rads
    export as_radians

    Base.:(+)(a::Angle, b::Angle) = Angle(a._rads + b._rads)
    Base.:(-)(a::Angle, b::Angle) = Angle(a._rads - b._rads)
    Base.:(*)(a::Angle, b::Angle) = Angle(a._rads * b._rads)
    Base.:(/)(a::Angle, b::Angle) = Angle(a._rads / b._rads)
    Base.:(==)(a::Angle, b::Angle) = a._rads == b._rads
    Base.:(!=)(a::Angle, b::Angle) = !(a._rads == b._rads)

    Base.show(io::IO, angle::Angle) = print(io, "Angle($(as_degrees(angle))°)")

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

    macro add_signal_realize(x) return :(@add_signal $x realize Cvoid) end
    macro add_signal_unrealize(x) return :(@add_signal $x unrealize Cvoid) end
    macro add_signal_destroy(x) return :(@add_signal $x destroy Cvoid) end
    macro add_signal_hide(x) return :(@add_signal $x hide Cvoid) end
    macro add_signal_show(x) return :(@add_signal $x show Cvoid) end
    macro add_signal_map(x) return :(@add_signal $x map Cvoid) end
    macro add_signal_unmap(x) return :(@add_signal $x unmap Cvoid) end

    macro add_widget_signals(x)
        return quote
            @add_signal_realize($x)
            @add_signal_unrealize($x)
            @add_signal_destroy($x)
            @add_signal_hide($x)
            @add_signal_show($x)
            @add_signal_map($x)
            @add_signal_unmap($x)
        end
    end

    macro add_signal_activate(x) return :(@add_signal $x activate Cvoid) end
    macro add_signal_shutdown(x) return :(@add_signal $x shutdown Cvoid) end
    macro add_signal_clicked(x) return :(@add_signal $x clicked Cvoid) end
    macro add_signal_toggled(x) return :(@add_signal $x toggled Cvoid) end
    macro add_signal_dismissed(x) return :(@add_signal $x dismissed Cvoid) end
    macro add_signal_button_clicked(x) return :(@add_signal $x button_clicked Cvoid) end
    macro add_signal_activate_default_widget(x) return :(@add_signal $x activate_default_widget Cvoid) end
    macro add_signal_activate_focused_widget(x) return :(@add_signal $x activate_focused_widget Cvoid) end
    macro add_signal_close_request(x) return :(@add_signal $x close_request WindowCloseRequestResult) end
    macro add_signal_items_changed(x) return :(@add_signal $x items_changed Cvoid Integer position Integer n_removed Integer n_added) end
    macro add_signal_closed(x) return :(@add_signal $x closed Cvoid) end
    macro add_signal_text_changed(x) return :(@add_signal $x text_changed Cvoid) end

    macro add_signal_drag_begin(x) return :(@add_signal $x drag_begin Cvoid AbstractFloat start_x AbstractFloat start_y) end
    macro add_signal_drag(x) return :(@add_signal $x drag Cvoid AbstractFloat offset_x AbstractFloat offset_y) end
    macro add_signal_drag_end(x) return :(@add_signal $x drag_end Cvoid AbstractFloat offset_x AbstractFloat offset_y) end

    macro add_signal_click_pressed(x) return :(@add_signal $x click_pressed Cvoid Integer n_press AbstractFloat x AbstractFloat y) end
    macro add_signal_click_released(x) return :(@add_signal $x click_released Cvoid Integer n_press AbstractFloat x AbstractFloat y) end
    macro add_signal_click_stopped(x) return :(@add_signal $x click_stopped Cvoid) end

    macro add_signal_focus_gained(x) return :(@add_signal $x focus_gained Cvoid) end
    macro add_signal_focus_lost(x) return :(@add_signal $x focus_lost Cvoid) end

    macro add_signal_pressed(x) return :(@add_signal $x pressed Cvoid AbstractFloat x AbstractFloat y) end
    macro add_signal_press_cancelled(x) return :(@add_signal $x press_cancelled Cvoid) end

    macro add_signal_motion_enter(x) return :(@add_signal $x motion_enter Cvoid AbstractFloat x AbstractFloat y) end
    macro add_signal_motion(x) return :(@add_signal $x motion Cvoid AbstractFloat x AbstractFloat y) end
    macro add_signal_motion_leave(x) return :(@add_signal $x motion_leave Cvoid) end

    macro add_signal_scale_changed(x) return :(@add_signal $x scale_changed Cvoid AbstractFloat scale) end
    macro add_signal_rotation_changed(x) return :(@add_signal $x rotation_changed Cvoid AbstractFloat angle_absolute_rads AbstractFloat angle_delta_rads) end

    macro add_signal_kinetic_scroll_decelerate(x) return :(@add_signal $x kinetic_scroll_decelerate Cvoid AbstractFloat x_velocity AbstractFloat y_velocity) end
    macro add_signal_scroll_begin(x) return :(@add_signal $x scroll_begin Cvoid) end
    macro add_signal_scroll(x) return :(@add_signal $x scroll Cvoid AbstractFloat delta_x AbstractFloat delta_y) end # sic, jl_unbox_bool(jl_nothing) == true
    macro add_signal_scroll_end(x) return :(@add_signal $x scroll_end Cvoid) end

    macro add_signal_stylus_up(x) return :(@add_signal $x stylus_up Cvoid AbstractFloat x AbstractFloat y) end
    macro add_signal_stylus_down(x) return :(@add_signal $x stylus_down Cvoid AbstractFloat x AbstractFloat y) end
    macro add_signal_proximity(x) return :(@add_signal $x proximity Cvoid AbstractFloat x AbstractFloat y) end

    macro add_signal_swipe(x) return :(@add_signal $x swipe Cvoid AbstractFloat x_velocity AbstractFloat y_velocity) end
    macro add_signal_pan(x) return :(@add_signal $x pan Cvoid PanDirection direction AbstractFloat offset) end

    macro add_signal_paint(x) return :(@add_signal $x paint Cvoid) end
    macro add_signal_update(x) return :(@add_signal $x update Cvoid) end

    macro add_signal_value_changed(x) return :(@add_signal $x value_changed Cvoid) end
    macro add_signal_properties_changed(x) return :(@add_signal $x properties_changed Cvoid) end

    macro add_signal_wrapped(x) return :(@add_signal $x wrapped Cvoid) end

    macro add_signal_scroll_child(x) return :(@add_signal $x scroll_child Cvoid ScrollType type Bool is_horizontal) end
    macro add_signal_resize(x) return :(@add_signal $x resize Cvoid Integer width Integer height) end
    macro add_signal_render(x) return :(@add_signal $x render Bool Ptr{Cvoid} gdk_gl_context_ptr) end

    macro add_signal_modifiers_changed(x) return :(@add_signal $x modifiers_changed Cvoid ModifierState state) end

    macro add_signal_activate_item(T)

        snake_case = :activate_item
        Return_t = Cvoid
        Arg1_t = Integer
        arg1_name = :index

        out = Expr(:block)
        connect_signal_name = :connect_signal_ * snake_case * :!

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), to_julia_index(x[2]))
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), to_julia_index(x[2]), data)
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T, $arg1_name::$Arg1_t) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, from_julia_index($arg1_name)))
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

    macro add_signal_switched(T)

        out = Expr(:block)
        snake_case = :switched
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

    macro add_key_event_controller_signal(T, name, Return_t)

        out = Expr(:block)
        snake_case = name

        connect_signal_name = :connect_signal_ * snake_case * :!

        Arg1_t = Cuint
        Arg2_t = Cuint
        Arg3_t = detail._ModifierState

        arg1_name = :key_code
        arg2_name = :key_value
        arg3_name = :modifiers

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T)
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg3_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2], x[4])
                    return false
                end)
            end
        )))

        push!(out.args, esc(:(
            function $connect_signal_name(f, x::$T, data::Data_t) where Data_t
                typed_f = TypedFunction(f, $Return_t, ($T, $Arg1_t, $Arg3_t, Data_t))
                detail.$connect_signal_name(x._internal, function(x)
                    typed_f($T(x[1][]), x[2], x[4], data)
                    return false
                end)
            end
        )))

        emit_signal_name = :emit_signal_ * snake_case

        push!(out.args, esc(:(
            function $emit_signal_name(x::$T, $arg1_name::$Arg1_t, $arg3_name::$Arg3_t) ::$Return_t
                return convert($Return_t, detail.$emit_signal_name(x._internal, $arg1_name, $arg3_name))
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

####### theme.jl

    @export_enum Theme begin
        THEME_DEFAULT_LIGHT
        THEME_DEFAULT_DARK
        THEME_HIGH_CONTRAST_LIGHT
        THEME_HIGH_CONTRAST_DARK
    end

####### application.jl

    @export_type Application SignalEmitter
    @export_type Action SignalEmitter

    const ApplicationID = String;
    export ApplicationID

    Application(id::String; allow_multiple_instances = false) = Application(detail._Application(id, allow_multiple_instances))

    run!(app::Application) ::Cint = Mousetrap.detail.run!(app._internal)
    export run!

    @export_function Application quit! Cvoid
    @export_function Application hold! Cvoid
    @export_function Application release! Cvoid
    @export_function Application get_is_holding Bool
    @export_function Application mark_as_busy! Cvoid
    @export_function Application unmark_as_busy! Cvoid
    @export_function Application get_is_marked_as_busy Bool
    @export_function Application get_id String
    @export_function Application get_current_theme Theme
    @export_function Application set_current_theme! Cvoid Theme theme

    add_action!(app::Application, action::Action) = detail.add_action!(app._internal, action._internal)
    export add_action!

    get_action(app::Application, id::String) ::Action = Action(detail.get_action(app._internal, id))
    export get_action

    @export_function Application remove_action! Cvoid String id
    @export_function Application has_action Bool String id

    @add_signal_activate Application
    @add_signal_shutdown Application

    function main(f, application_id::String = "com.julia.mousetrap")
        app = Application(application_id)
        typed_f = TypedFunction(f, Any, (Application,))
        connect_signal_activate!(app)  do app::Application
            try
                typed_f(app)
            catch(exception)
                printstyled(stderr, "[ERROR] "; bold = true, color = :red)
                printstyled(stderr, "In Mousetrap.main: "; bold = true)
                Base.showerror(stderr, exception, catch_backtrace())
                print(stderr, "\n")
                quit!(app)
            end
            return nothing
        end
        return run!(app)
    end
    export main

    Base.show(io::IO, x::Application) = show_aux(io, x, :is_holding, :is_marked_as_busy)

####### window.jl

    @export_enum WindowCloseRequestResult begin
        WINDOW_CLOSE_REQUEST_RESULT_ALLOW_CLOSE
        WINDOW_CLOSE_REQUEST_RESULT_PREVENT_CLOSE
    end

    @export_type Window Widget
    @declare_native_widget Window

    Window(app::Application) = Window(detail._Window(app._internal))

    function set_application!(window::Window, app::Application)
        detail.set_application!(window._internal, app._internal)
    end
    export set_application!

    @export_function Window set_maximized! Cvoid Bool b
    @export_function Window set_fullscreen! Cvoid Bool b
    @export_function Window set_minimized! Cvoid Bool b
    @export_function Window present! Cvoid
    @export_function Window set_hide_on_close! Cvoid Bool b
    @export_function Window get_hide_on_close Bool
    @export_function Window close! Cvoid
    @export_function Window destroy! Cvoid
    @export_function Window get_is_closed Bool

    function set_child!(window::Window, child::Widget)
        detail.set_child!(window._internal, as_widget_pointer(child))
    end
    export set_child!

    @export_function Window remove_child! Cvoid
    @export_function Window set_destroy_with_parent! Cvoid Bool n
    @export_function Window get_destroy_with_parent Bool
    @export_function Window set_title! Cvoid String title
    @export_function Window get_title String

    function get_header_bar(window::Window) ::HeaderBar
        return HeaderBar(detail.get_header_bar(window._internal))
    end
    export get_header_bar

    @export_function Window set_is_modal! Cvoid Bool b
    @export_function Window get_is_modal Bool

    function set_transient_for!(self::Window, other::Window)
        detail.set_transient_for!(self._internal, other._internal)
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
        detail.set_default_widget!(window._internal, as_widget_pointer(widget))
    end
    export set_default_widget!

    @add_widget_signals Window
    @add_signal_close_request Window
    @add_signal_activate_default_widget Window
    @add_signal_activate_focused_widget Window

    Base.show(io::IO, x::Window) = show_aux(io, x, :title)

####### action.jl

    const ShortcutTrigger = String
    export ShortcutTrigger

    Action(id::String, app::Application) = Action(detail._Action(id, app._internal.cpp_object))
    function Action(f, id::String, app::Application)
        out = Action(id, app)
        set_function!(f, out)
        return out
    end

    @export_function Action get_id String
    @export_function Action activate! Cvoid
    @export_function Action add_shortcut! Cvoid ShortcutTrigger shortcut

    get_shortcuts(action::Action) ::Vector{String} = detail.get_shortcuts(action._internal)[]
    export get_shortcuts

    @export_function Action clear_shortcuts! Cvoid
    @export_function Action set_enabled! Cvoid Bool b
    @export_function Action get_enabled Bool

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

    @add_signal_activated Action

    Base.show(io::IO, x::Action) = show_aux(io, x, :id, :enabled)

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

    @export_function Adjustment get_lower Cfloat
    @export_function Adjustment get_upper Cfloat
    @export_function Adjustment get_value Cfloat
    @export_function Adjustment get_step_increment Cfloat

    @export_function Adjustment set_lower! Cvoid Number => Cfloat value
    @export_function Adjustment set_upper! Cvoid Number => Cfloat value
    @export_function Adjustment set_value! Cvoid Number => Cfloat value
    @export_function Adjustment set_step_increment! Cvoid Number => Cfloat value

    @add_signal_value_changed Adjustment
    @add_signal_properties_changed Adjustment

    Base.show(io::IO, x::Adjustment) = show_aux(io, x, :value, :lower, :upper, :step_increment)

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

####### color.jl

    abstract type Color end

    mutable struct RGBA <: Color
        r::Cfloat
        g::Cfloat
        b::Cfloat
        a::Cfloat
    end
    export RGBA

    function RGBA(r::AbstractFloat, g::AbstractFloat, b::AbstractFloat, a::AbstractFloat)
        return RGBA(
            convert(Cfloat, r),
            convert(Cfloat, g),
            convert(Cfloat, b),
            convert(Cfloat, a)
        )
    end

    mutable struct HSVA <: Color
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

    Base.isapprox(x::RGBA, y::RGBA) = isapprox(x.r, y.r) && isapprox(x.g, y.g) && isapprox(x.b, y.b) && isapprox(x.a, y.a)
    Base.isapprox(x::HSVA, y::HSVA) = isapprox(x.h, y.h) && isapprox(x.s, y.s) && isapprox(x.v, y.v) && isapprox(x.a, y.a)

    import Base.==
    ==(x::RGBA, y::RGBA) = x.r == y.r && x.g == y.g && x.b == y.b && x.a == y.a
    function ==(x::HSVA, y::HSVA)
        hue_equal = x.h == y.h || abs(x.h - y.h) == 1
        return hue_equal && x.s == y.s && x.v == y.v && x.a == y.a
    end

    import Base.!=
    !=(x::RGBA, y::RGBA) = !(x == y)
    !=(x::HSVA, y::HSVA) = !(x == y)

    rgba_to_hsva(rgba::RGBA) ::HSVA = detail.rgba_to_hsva(rgba)
    export rgba_to_hsva

    hsva_to_rgba(hsva::HSVA) ::RGBA = detail.hsva_to_rgba(hsva)
    export hsva_to_rgba

    Base.convert(::Type{HSVA}, rgba::RGBA) = rgba_to_hsva(rbga)
    Base.convert(::Type{RGBA}, hsva::HSVA) = hsva_to_rgba(hsva)

    rgba_to_html_code(rgba::RGBA) = convert(String, detail.rgba_to_html_code(rgba))
    export rgba_to_html_code

    html_code_to_rgba(code::String) ::RGBA = detail.html_code_to_rgba(code)
    export html_code_to_rgba

    is_valid_html_code(code::String) ::Bool = detail.is_valid_html_code(code)
    export is_valid_html_code

    Base.show(io::IO, x::RGBA) = print(io, "RGBA($(x.r), $(x.g), $(x.b), $(x.a))")
    Base.show(io::IO, x::HSVA) = print(io, "HSVA($(x.h), $(x.s), $(x.v), $(x.a))")

####### icon.jl

    @export_type IconTheme
    IconTheme(window::Window) = IconTheme(detail._IconTheme(window._internal))

    const IconID = String
    export IconID

    @export_type Icon
    Icon() = Icon(detail._Icon())

    function Icon(path::String)
        out = Icon()
        create_from_file!(out, path)
        return out
    end

    function Icon(theme::IconTheme, id::IconID, square_resolution::Integer)
        out = Icon()
        create_from_theme!(out, theme, id, square_resolution)
        return out
    end

    # Icon

    @export_function Icon create_from_file! Bool String path

    function create_from_theme!(icon::Icon, theme::IconTheme, id::IconID, square_resolution::Integer, scale::Integer = 1) ::Bool
        detail.create_from_theme!(icon._internal, theme._internal.cpp_object, id, UInt64(square_resolution), UInt64(scale))
    end
    export create_from_theme!

    @export_function Icon get_name IconID

    import Base.==
    ==(a::Icon, b::Icon) = detail.compare_icons(a._internal, b_internal)

    import Base.!=
    !=(a::Icon, b::Icon) = !(a == b)

    @export_function Icon get_size Vector2i

    Base.show(io::IO, x::Icon) = show_aux(io, x, :name)

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

    Base.show(io::IO, x::IconTheme) = show_aux(io, x)

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
    @export_function Image get_size Vector2i

    function as_scaled(image::Image, size_x::Integer, size_y::Integer, interpolation::InterpolationType = INTERPOLATION_TYPE_TILES)
        return Image(detail.as_scaled(image._internal, UInt64(size_x), UInt64(size_y), interpolation))
    end
    export as_scaled

    function as_cropped(image::Image, offset_x::Signed, offset_y::Signed, new_width::Integer, new_height::Integer)
        return Image(detail.as_cropped(image._internal, offset_x, offset_y, UInt64(new_width), UInt64(new_height)))
    end
    export as_cropped

    function as_flipped(image::Image, flip_horizontally::Bool, flip_vertically::Bool)
        return Image(detail.as_flipped(image._internal, flip_horizontally, flip_vertically))
    end
    export as_flipped

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

    Base.show(io::IO, x::Image) = show_aux(io, x, :size)

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

    set_comment_above!(file::KeyFile, group::GroupID, key::KeyID, comment::String) = detail.set_comment_above_key!(file._internal, group, key, comment)
    set_comment_above!(file::KeyFile, group::GroupID, comment::String) = detail.set_comment_above_group!(file._internal, group, comment)
    export set_comment_above!

    get_comment_above(file::KeyFile, group::GroupID) ::String = detail.get_comment_above_group(file._internal, group)
    get_comment_above(file::KeyFile, group::GroupID, key::KeyID) ::String = detail.get_comment_above_key(file._internal, group, key)
    export get_comment_above

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
        detail.set_value_as_rgba!(file._internal, group, key, value)
    end

    function set_value!(file::KeyFile, group::GroupID, key::KeyID, value::HSVA)
        detail.set_value_as_hsva!(file._internal, group, key, value)
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

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{Bool})
        return detail.get_value_as_bool(file._internal, group, key)
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{<: AbstractFloat})
        return detail.get_value_as_double(file._internal, group, key)
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{<: Signed})
        return detail.get_value_as_int(file._internal, group, key)
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{<: Unsigned})
        return detail.get_value_as_uint(file._internal, group, key)
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{String})
        return detail.get_value_as_string(file._internal, group, key)
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{RGBA})
        return detail.get_value_as_rgba(file._internal, group, key)
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{HSVA})
        return detail.get_value_as_hsva(file._internal, group, key)
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{Image})
        return Image(detail.get_value_as_image(file._internal, group, key))
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{Vector{Bool}})
        return convert(Vector{Bool}, detail.get_value_as_bool_list(file._internal, group, key))
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{Vector{T}}) where T <: AbstractFloat
        return convert(Vector{T}, detail.get_value_as_double_list(file._internal, group, key))
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{Vector{T}}) where T <: Signed
        return convert(Vector{T}, detail.get_value_as_int_list(file._internal, group, key))
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{Vector{T}}) where T <: Unsigned
        return convert(Vector{T}, detail.get_value_as_uint_list(file._internal, group, key))
    end

    function get_value(file::KeyFile, group::GroupID, key::KeyID, ::Type{Vector{String}})
        return convert(Vector{String}, detail.get_value_as_string_list(file._internal, group, key))
    end

    Base.show(io::IO, x::KeyFile) = show_aux(io, x, :groups)

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

    Base.show(io::IO, x::FileMonitor) = print(io, "FileMonitor(cancelled = $(is_cancelled(x)))")

    # Descriptor

    FileDescriptor(internal::Ptr{Cvoid}) = FileDescriptor(detail._FileDescriptor(internal))
    FileDescriptor(path::String) = FileDescriptor(detail._FileDescriptor(path))

    import Base.==
    ==(a::FileDescriptor, b::FileDescriptor) = detail.file_descriptor_equal(a._internal, b._internal)

    import Base.!=
    !=(a::FileDescriptor, b::FileDescriptor) = !(a == b)

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
    @export_function FileDescriptor is_file Bool
    @export_function FileDescriptor is_symlink Bool

    read_symlink(self::FileDescriptor) = FileDescriptor(detail.read_symlink(self._internal))
    export read_symlink

    @export_function FileDescriptor is_executable Bool
    @export_function FileDescriptor get_content_type String
    @export_function FileDescriptor query_info String String info_id

    create_monitor(descriptor::FileDescriptor) ::FileMonitor = FileMonitor(detail._FileMonitor(detail.create_monitor(descriptor._internal)))
    export create_monitor

    function get_children(descriptor::FileDescriptor; recursive::Bool = false) ::Vector{FileDescriptor}
        children::Vector{Ptr{Cvoid}} = detail.get_children(descriptor._internal, recursive)
        return FileDescriptor[FileDescriptor(ptr) for ptr in children]
    end
    export get_children

    # File System

    create_file_at!(destination::FileDescriptor; replace::Bool = false) ::Bool = detail.create_file_at!(destination._internal, replace)
    export create_file_at!

    create_directory_at!(destination::FileDescriptor) ::Bool = detail.create_directory_at!(destination._internal)
    export create_directory_at!

    delete_at!(file::FileDescriptor) ::Bool = detail.delete_at!(file._internal)
    export delete_at!

    function copy!(from::FileDescriptor, to::FileDescriptor, allow_overwrite::Bool; make_backup::Bool = false, follow_symlink::Bool = false) ::Bool
        detail.copy!(from._internal, to._internal, allow_overwrite, make_backup, follow_symlink)
    end
    export copy!

    function move!(from::FileDescriptor, to::FileDescriptor, allow_overwrite::Bool; make_backup::Bool = false, follow_symlink::Bool = false) ::Bool
        detail.move!(from._internal, to._internal, allow_overwrite, make_backup, follow_symlink)
    end
    export move!

    move_to_trash!(file::FileDescriptor) ::Bool = detail.move_to_trash!(file._internal)
    export move_to_trash!

    open_file(file::FileDescriptor) ::Cvoid = detail.open_file(file._internal)
    export open_file

    show_in_file_explorer(file::FileDescriptor) ::Cvoid = detail.show_in_file_explorer(file._internal)
    export show_in_file_explorer

    open_url(file::FileDescriptor) ::Cvoid = detail.open_url(file._internal)
    export open_url

    Base.show(io::IO, x::FileDescriptor) = show_aux(io, x, :path)

####### file_chooser.jl

    @export_type FileFilter SignalEmitter
    FileFilter(name::String) = FileFilter(detail._FileFilter(name))

    get_name(filter::FileFilter) ::String = detail.get_name(filter._internal)
    export get_name

    @export_function FileFilter add_allowed_pattern! Cvoid String pattern
    @export_function FileFilter add_allow_all_supported_image_formats! Cvoid
    @export_function FileFilter add_allowed_suffix! Cvoid String suffix
    @export_function FileFilter add_allowed_mime_type! Cvoid String mime_type_id

    @export_enum FileChooserAction begin
        FILE_CHOOSER_ACTION_OPEN_FILE
        FILE_CHOOSER_ACTION_OPEN_MULTIPLE_FILES
        FILE_CHOOSER_ACTION_SAVE
        FILE_CHOOSER_ACTION_SELECT_FOLDER
        FILE_CHOOSER_ACTION_SELECT_MULTIPLE_FOLDERS
    end

    @export_type FileChooser SignalEmitter
    FileChooser(action::FileChooserAction = FILE_CHOOSER_ACTION_OPEN_FILE, title::String = "") = FileChooser(detail._FileChooser(action, title))

    @export_function FileChooser set_accept_label! Cvoid String label
    @export_function FileChooser get_accept_label String
    @export_function FileChooser present! Cvoid
    @export_function FileChooser cancel! Cvoid
    @export_function FileChooser set_is_modal! Cvoid Bool modal
    @export_function FileChooser get_is_modal Bool
    @export_function FileChooser set_title! Cvoid String title
    @export_function FileChooser get_title String

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

    @export_function FileChooser set_file_chooser_action! Cvoid FileChooserAction action
    @export_function FileChooser get_file_chooser_action FileChooserAction

    add_filter!(chooser::FileChooser, filter::FileFilter) = detail.add_filter!(chooser._internal, filter._internal)
    export add_filter!

    clear_filters!(chooser::FileChooser) = detail.clear_filters!(chooser._internal)
    export clear_filters!

    set_initial_filter!(chooser::FileChooser, filter::FileFilter) = detail.set_initial_filter!(chooser._internal, filter._internal)
    export set_initial_filter!

    set_initial_file!(chooser::FileChooser, file::FileDescriptor) = detail.set_initial_file!(chooser._internal, file._internal)
    export set_initial_file!

    set_initial_folder!(chooser::FileChooser, folder::FileDescriptor) = detail.set_initial_file!(chooser._internal, folder._internal)
    export set_initial_folder!

    set_initial_name!(chooser::FileChooser, name::String) = detail.set_initial_name!(chooser._internal, name)
    export set_initial_name!

    Base.show(io::IO, x::FileChooser) = show_aux(io, x)

####### alert_dialog.jl

    @export_type AlertDialog SignalEmitter
    AlertDialog(message::String, detailed_message::String = "") = AlertDialog(detail._AlertDialog(message, detailed_message))

    function add_button!(alert_dialog::AlertDialog, label::String) ::Integer
        return to_julia_index(detail.add_button!(alert_dialog._internal, label))
    end
    export add_button!

    function set_default_button!(alert_dialog::AlertDialog, id::Integer)
        detail.set_default_button!(alert_dialog.AlertDialog, from_julia_index(id))
    end
    export set_default_button!

    function set_button_label!(alert_dialog::AlertDialog, id::Integer, label::String)
        detail.set_button_label!(alert_dialog._internal, from_julia_index(id), label)
    end
    export set_button_label!

    function get_button_label(alert_dialog::AlertDialog, id::Integer) ::String
        return detail.get_button_label(alert_dialog._internal, from_julia_index(id))
    end
    export get_button_label

    function set_extra_widget!(alert_dialog::AlertDialog, widget::Widget)
        detail.set_extra_widget!(alert_dialog._internal, as_widget_pointer(widget))
    end
    export set_extra_widget!

    @export_function AlertDialog remove_extra_widget! Cvoid
    @export_function AlertDialog get_n_buttons Integer
    @export_function AlertDialog get_message String
    @export_function AlertDialog set_message! Cvoid String message
    @export_function AlertDialog get_detailed_description String
    @export_function AlertDialog set_detailed_description! Cvoid String message
    @export_function AlertDialog set_is_modal! Cvoid Bool b
    @export_function AlertDialog get_is_modal Bool
    @export_function AlertDialog present! Cvoid
    @export_function AlertDialog close! Cvoid

    function on_selection!(f, dialog::AlertDialog, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (AlertDialog, Integer, Data_t))
        detail.on_selection!(dialog._internal, function(dialog_ref, index)
        typed_f(AlertDialog(dialog_ref[]), convert(UInt32, to_julia_index(index)), data)
        end)
    end
    function on_selection!(f, dialog::AlertDialog)
        typed_f = TypedFunction(f, Cvoid, (AlertDialog, Signed))
        detail.on_selection!(dialog._internal, function(dialog_ref, index)
            typed_f(AlertDialog(dialog_ref[]), convert(UInt32, to_julia_index(index)))
        end)
    end
    export on_selection!

    Base.show(io::IO, x::AlertDialog) = show_aux(io, x)

####### popup_message.jl

    @export_type PopupMessage SignalEmitter
    PopupMessage(title::String) = PopupMessage(detail._PopupMessage(title, ""))
    PopupMessage(title::String, button_label::String) = PopupMessage(detail._PopupMessage(title, button_label))

    @export_function PopupMessage set_title! Cvoid String title
    @export_function PopupMessage get_title String
    @export_function PopupMessage set_button_label! Cvoid String title
    @export_function PopupMessage get_button_label String

    set_button_action!(popup_message::PopupMessage, action::Action) = detail.set_button_action!(popup_message._internal, action._internal)
    export set_button_action!

    @export_function PopupMessage get_button_action_id String
    @export_function PopupMessage set_is_high_priority! Cvoid Bool b
    @export_function PopupMessage get_is_high_priority Bool

    set_timeout!(popup_message::PopupMessage, duration::Time) = detail.set_timeout!(popup_message._internal, convert(Cfloat, as_microseconds(duration)))
    export set_timeout!

    get_timeout(popup_message::PopupMessage) ::Time = microseconds(detail.get_timeout(popup_message._internal))
    export get_timeout

    @add_signal_dismissed PopupMessage
    @add_signal_button_clicked PopupMessage

    Base.show(io::IO, x::PopupMessage) = show_aux(io, x, :title, :button_label, :is_high_priority, :timeout)

####### popup_message_overlay.jl

    @export_type PopupMessageOverlay Widget
    @declare_native_widget PopupMessageOverlay

    PopupMessageOverlay() = PopupMessageOverlay(detail._PopupMessageOverlay())

    function set_child!(overlay::PopupMessageOverlay, child::Widget)
        detail.set_child!(overlay._internal, as_widget_pointer(child))
    end
    export set_child!

    @export_function PopupMessageOverlay remove_child! Cvoid

    function show_message!(overlay::PopupMessageOverlay, popup_message::PopupMessage)
        detail.show_message!(overlay._internal, popup_message._internal)
    end
    export show_message!

    @add_widget_signals PopupMessageOverlay

    Base.show(io::IO, x::PopupMessageOverlay) = show_aux(io, x)

####### color_chooser.jl

    if detail.GTK_MINOR_VERSION >= 10

    @export_type ColorChooser SignalEmitter
    ColorChooser(title::String = "") = ColorChooser(detail._ColorChooser(title))

    get_color(color_chooser::ColorChooser) ::RGBA = detail.get_color(color_chooser._internal)
    export get_color

    present!(color_chooser::ColorChooser) = detail.present!(color_chooser._internal)
    export present!

    @export_function ColorChooser set_is_modal! Cvoid Bool b
    @export_function ColorChooser get_is_modal Bool
    @export_function ColorChooser set_title! Cvoid String title
    @export_function ColorChooser get_title String

    function on_accept!(f, chooser::ColorChooser, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (ColorChooser, RGBA, Data_t))
        detail.on_accept!(chooser._internal, function(color_chooser_ref, rgba::RGBA)
            typed_f(ColorChooser(color_chooser_ref[]), rgba, data)
        end)
    end
    function on_accept!(f, chooser::ColorChooser)
        typed_f = TypedFunction(f, Cvoid, (ColorChooser, RGBA))
        detail.on_accept!(chooser._internal, function(color_chooser_ref, rgba::RGBA)
            typed_f(ColorChooser(color_chooser_ref[]), rgba)
        end)
    end
    export on_accept!

    function on_cancel!(f, chooser::ColorChooser, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (ColorChooser, Data_t))
        detail.on_cancel!(chooser._internal, function(color_chooser_ref)
            typed_f(ColorChooser(color_chooser_ref[]), data)
        end)
    end
    function on_cancel!(f, chooser::ColorChooser)
        typed_f = TypedFunction(f, Cvoid, (ColorChooser,))
        detail.on_cancel!(chooser._internal, function(color_chooser_ref)
            typed_f(ColorChooser(color_chooser_ref[]))
        end)
    end
    export on_cancel!

    Base.show(io::IO, x::ColorChooser) = show_aux(io, x, :color)

    end # GTK_MINOR_VERSION >= 10

####### image_display.jl

    @export_type ImageDisplay Widget
    @declare_native_widget ImageDisplay

    ImageDisplay() = ImageDisplay(detail._ImageDisplay())
    ImageDisplay(path::String) = ImageDisplay(detail._ImageDisplay(path))
    ImageDisplay(image::Image) = ImageDisplay(detail._ImageDisplay(image._internal))
    ImageDisplay(icon::Icon) = ImageDisplay(detail._ImageDisplay(icon._internal))

    @export_function ImageDisplay create_from_file! Bool String path

    create_from_image!(image_display::ImageDisplay, image::Image) = detail.create_from_image!(image_display._internal, image._internal)
    export create_from_image!

    create_from_icon!(image_display::ImageDisplay, icon::Icon) = detail.create_from_icon!(image_display._internal, icon._internal)
    export create_from_icon!

    create_as_file_preview!(image_display::ImageDisplay, file::FileDescriptor) ::Bool = detail.create_as_file_preview!(image_display._internal, file._internal)
    export create_as_file_preview!

    @export_function ImageDisplay clear! Cvoid
    @export_function ImageDisplay set_scale! Cvoid Integer scale
    @export_function ImageDisplay get_scale Int64
    @export_function ImageDisplay get_size Vector2i

    @add_widget_signals ImageDisplay

    Base.show(io::IO, x::ImageDisplay) = show_aux(io, x, :size)

####### aspect_frame.jl

    @export_type AspectFrame Widget
    @declare_native_widget AspectFrame

    function AspectFrame(ratio::Number; child_x_alignment::AbstractFloat = 0.5, child_y_alignment::AbstractFloat = 0.5)
        return AspectFrame(detail._AspectFrame(convert(Cfloat, ratio), convert(Cfloat, child_x_alignment), convert(Cfloat, child_y_alignment)))
    end

    function AspectFrame(ratio::Number, child::Widget)
        out = AspectFrame(ratio)
        set_child!(out, child)
        return out
    end

    @export_function AspectFrame set_ratio! Cvoid AbstractFloat => Cfloat ratio
    @export_function AspectFrame get_ratio Cfloat
    @export_function AspectFrame set_child_x_alignment! Cvoid AbstractFloat => Cfloat alignment
    @export_function AspectFrame set_child_y_alignment! Cvoid AbstractFloat => Cfloat alignment
    @export_function AspectFrame get_child_x_alignment Cfloat
    @export_function AspectFrame get_child_y_alignment Cfloat

    @export_function AspectFrame remove_child! Cvoid

    set_child!(aspect_frame::AspectFrame, child::Widget) = detail.set_child!(aspect_frame._internal, as_widget_pointer(child))
    export set_child!

    Base.show(io::IO, x::AspectFrame) = show_aux(io, x, :ratio)

####### clamp_frame.jl

    @export_type ClampFrame Widget
    @declare_native_widget ClampFrame

    function ClampFrame(size::Number, orientation::Orientation = ORIENTATION_HORIZONTAL)
        out = ClampFrame(detail._ClampFrame(orientation))
        set_maximum_size!(out, size)
        return out
    end

    @export_function ClampFrame set_orientation! Cvoid Orientation orientation
    @export_function ClampFrame get_orientation Orientation
    @export_function ClampFrame set_maximum_size! Cvoid Number => Cfloat px
    @export_function ClampFrame get_maximum_size Cfloat

    @export_function ClampFrame remove_child! Cvoid

    set_child!(clamp_frame::ClampFrame, child::Widget) = detail.set_child!(clamp_frame._internal, as_widget_pointer(child))
    export set_child!

    Base.show(io::IO, x::ClampFrame) = show_aux(io, x, :maximum_size)

####### box.jl

    @export_type Box Widget
    @declare_native_widget Box

    Box(orientation::Orientation) = Box(detail._Box(orientation))

    function hbox(widgets::Widget...)
        out = Box(ORIENTATION_HORIZONTAL)
        for widget in widgets
            push_back!(out, widget)
        end
        return out
    end
    export hbox

    function vbox(widgets::Widget...)
        out = Box(ORIENTATION_VERTICAL)
        for widget in widgets
            push_back!(out, widget)
        end
        return out
    end
    export vbox

    function push_back!(box::Box, widget::Widget)
        detail.push_back!(box._internal, as_widget_pointer(widget))
    end
    export push_back!

    function push_front!(box::Box, widget::Widget)
        detail.push_front!(box._internal, as_widget_pointer(widget))
    end
    export push_front!

    function insert_after!(box::Box, to_append::Widget, after::Widget)
        detail.insert_after!(box._internal, as_widget_pointer(to_append), as_widget_pointer(after))
    end
    export insert_after!

    function remove!(box::Box, widget::Widget)
        detail.remove!(box._internal, as_widget_pointer(widget))
    end
    export remove!

    @export_function Box clear! Cvoid
    @export_function Box set_homogeneous! Cvoid Bool b
    @export_function Box get_homogeneous Bool

    function set_spacing!(box::Box, spacing::Number)
        detail.set_spacing!(box._internal, convert(Cfloat, spacing))
    end
    export set_spacing!

    @export_function Box get_spacing Cfloat
    @export_function Box get_n_items Cint
    @export_function Box get_orientation Orientation
    @export_function Box set_orientation! Cvoid Orientation orientation

    @add_widget_signals Box

    Base.show(io::IO, x::Box) = show_aux(io, x, :n_items)

####### flow_box.jl

    @export_type FlowBox Widget
    @declare_native_widget FlowBox

    FlowBox(orientation::Orientation) = FlowBox(detail._FlowBox(orientation))

    function push_back!(box::FlowBox, widget::Widget)
        detail.push_back!(box._internal, as_widget_pointer(widget))
    end
    export push_back!

    function push_front!(box::FlowBox, widget::Widget)
        detail.push_front!(box._internal, as_widget_pointer(widget))
    end
    export push_front!

    insert_at!(box::FlowBox, index::Integer, widget::Widget) = detail.insert!(box._internal, from_julia_index(index), as_widget_pointer(widget))
    export insert_at!

    function remove!(box::FlowBox, widget::Widget)
        detail.remove!(box._internal, as_widget_pointer(widget))
    end
    export remove!

    @export_function FlowBox clear! Cvoid
    @export_function FlowBox set_homogeneous! Cvoid Bool b
    @export_function FlowBox get_homogeneous Bool

    function set_row_spacing!(box::FlowBox, spacing::Number)
        detail.set_row_spacing!(box._internal, convert(Cfloat, spacing))
    end
    export set_row_spacing!

    @export_function FlowBox get_row_spacing Cfloat

    function set_column_spacing!(box::FlowBox, spacing::Number)
        detail.set_column_spacing!(box._internal, convert(Cfloat, spacing))
    end
    export set_column_spacing!

    @export_function FlowBox get_column_spacing Cfloat

    @export_function FlowBox get_n_items Cint
    @export_function FlowBox get_orientation Orientation
    @export_function FlowBox set_orientation! Cvoid Orientation orientation

    @add_widget_signals FlowBox

    Base.show(io::IO, x::FlowBox) = show_aux(io, x, :n_items)

####### button.jl

    @export_type Button Widget
    @declare_native_widget Button

    Button() = Button(detail._Button())

    function Button(label::Widget)
        out = Button()
        set_child!(out, label)
        return out
    end

    function Button(icon::Icon)
        out = Button()
        set_icon!(out, icon)
        return out
    end

    @export_function Button set_has_frame! Cvoid Bool b
    @export_function Button get_has_frame Bool
    @export_function Button set_is_circular! Cvoid Bool b
    @export_function Button get_is_circular Bool

    function set_child!(button::Button, child::Widget)
        detail.set_child!(button._internal, as_widget_pointer(child))
    end
    export set_child!

    function set_icon!(button::Button, icon::Icon)
        detail.set_icon!(button._internal, icon._internal)
    end
    export set_icon!

    @export_function Button remove_child! Cvoid

    function set_action!(button::Button, action::Action)
        detail.set_action!(button._internal, action._internal)
    end
    export set_action!

    @add_widget_signals Button
    @add_signal_clicked Button

    Base.show(io::IO, x::Button) = show_aux(io, x)

####### center_box.jl

    @export_type CenterBox Widget
    @declare_native_widget CenterBox

    CenterBox(orientation::Orientation) = CenterBox(detail._CenterBox(orientation))

    function CenterBox(orientation::Orientation, left::Widget, center::Widget, right::Widget) ::CenterBox
        out = CenterBox(orientation)
        set_start_child!(out, left)
        set_center_child!(out, center)
        set_end_child!(out, right)
        return out
    end

    function set_start_child!(center_box::CenterBox, child::Widget)
        detail.set_start_child!(center_box._internal, as_widget_pointer(child))
    end
    export set_start_child!

    function set_center_child!(center_box::CenterBox, child::Widget)
        detail.set_center_child!(center_box._internal, as_widget_pointer(child))
    end
    export set_center_child!

    function set_end_child!(center_box::CenterBox, child::Widget)
        detail.set_end_child!(center_box._internal, as_widget_pointer(child))
    end
    export set_end_child!

    @export_function CenterBox remove_start_child! Cvoid
    @export_function CenterBox remove_center_child! Cvoid
    @export_function CenterBox remove_end_child! Cvoid
    @export_function CenterBox get_orientation Orientation
    @export_function CenterBox set_orientation! Cvoid Orientation orientation

    @add_widget_signals CenterBox

    Base.show(io::IO, x::CenterBox) = show_aux(io, x)

####### check_button.jl

    @export_enum CheckButtonState begin
        CHECK_BUTTON_STATE_ACTIVE
        CHECK_BUTTON_STATE_INCONSISTENT
        CHECK_BUTTON_STATE_INACTIVE
    end

    @export_type CheckButton Widget
    @declare_native_widget CheckButton

    CheckButton() = CheckButton(detail._CheckButton())

    @export_function CheckButton set_state! Cvoid CheckButtonState state
    @export_function CheckButton get_state CheckButtonState
    @export_function CheckButton get_is_active Bool

    set_is_active!(button::CheckButton, b::Bool) = set_state!(button, b ? CHECK_BUTTON_STATE_ACTIVE : CHECK_BUTTON_STATE_INACTIVE)
    export set_is_active!

    if detail.GTK_MINOR_VERSION >= 8
        function set_child!(check_button::CheckButton, child::Widget)
            detail.set_child!(check_button._internal, as_widget_pointer(child))
        end
        export set_child!

        @export_function CheckButton remove_child! Cvoid
    end

    @add_widget_signals CheckButton
    @add_signal_toggled CheckButton

    Base.show(io::IO, x::CheckButton) = show_aux(io, x, :state)

####### switch.jl

    @export_type Switch Widget
    @declare_native_widget Switch

    Switch() = Switch(detail._Switch())

    @export_function Switch get_is_active Bool
    @export_function Switch set_is_active! Cvoid Bool b

    @add_widget_signals Switch
    @add_signal_switched Switch

    Base.show(io::IO, x::Switch) = show_aux(io, x, :is_active)

####### toggle_button.jl

    @export_type ToggleButton Widget
    @declare_native_widget ToggleButton

    ToggleButton() = ToggleButton(detail._ToggleButton())
    function ToggleButton(label::Widget)
        out = ToggleButton()
        set_child!(out, label)
        return out
    end

    function ToggleButton(icon::Icon)
        out = ToggleButton()
        set_icon!(out, icon)
        return out
    end

    @export_function ToggleButton set_is_active! Cvoid Bool b
    @export_function ToggleButton get_is_active Bool
    @export_function ToggleButton set_is_circular! Cvoid Bool b
    @export_function ToggleButton get_is_circular Bool

    function set_child!(toggle_button::ToggleButton, child::Widget)
        detail.set_child!(toggle_button._internal, as_widget_pointer(child))
    end
    export set_child!

    function set_icon!(toggle_button::ToggleButton, icon::Icon)
        detail.set_icon!(toggle_button._internal, icon._internal)
    end
    export set_icon!

    @export_function ToggleButton remove_child! Cvoid

    @add_widget_signals ToggleButton
    @add_signal_clicked ToggleButton
    @add_signal_toggled ToggleButton

    Base.show(io::IO, x::ToggleButton) = show_aux(io, x, :is_active)

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
    @declare_native_widget Viewport

    Viewport() = Viewport(detail._Viewport())

    function Viewport(child::Widget) ::Viewport
        out = Viewport()
        set_child!(out, child)
        return out
    end

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

    set_child!(viewport::Viewport, child::Widget) = detail.set_child!(viewport._internal, as_widget_pointer(child))
    export set_child!

    @export_function Viewport remove_child! Cvoid

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

    Base.show(io::IO, x::Viewport) = show_aux(io, x,
        :propagate_natural_height,
        :propagate_natural_width
    )

####### entry.jl

    @export_type Entry Widget
    @declare_native_widget Entry

    Entry() = Entry(detail._Entry())

    @export_function Entry get_text String
    @export_function Entry set_text! Cvoid String text
    @export_function Entry set_max_width_chars! Cvoid Integer n
    @export_function Entry get_max_width_chars Signed
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
    @add_signal_text_changed Entry
    @add_signal_activate Entry

    Base.show(io::IO, x::Entry) = show_aux(io, x, :text)

####### expander.jl

    @export_type Expander Widget
    @declare_native_widget Expander

    Expander() = Expander(detail._Expander())
    function Expander(child::Widget, label::Widget) ::Expander
        out = Expander()
        set_child!(out, child)
        set_label_widget!(out, label)
        return out
    end

    function set_child!(expander::Expander, child::Widget)
        detail.set_child!(expander._internal, as_widget_pointer(child))
    end
    export set_child!

    @export_function Expander remove_child! Cvoid

    function set_label_widget!(expander::Expander, child::Widget)
        detail.set_label_widget!(expander._internal, as_widget_pointer(child))
    end
    export set_label_widget!

    @export_function Expander remove_label_widget! Cvoid
    @export_function Expander set_is_expanded! Cvoid Bool b
    @export_function Expander get_is_expanded Bool

    @add_widget_signals Expander
    @add_signal_activate Expander

    Base.show(io::IO, x::Expander) = show_aux(io, x, :is_expanded)

####### fixed.jl

    @export_type Fixed Widget
    @declare_native_widget Fixed

    Fixed() = Fixed(detail._Fixed())

    add_child!(fixed::Fixed, child::Widget, position::Vector2f) = detail.add_child!(fixed._internal, as_widget_pointer(child), position)
    export add_child!

    remove_child!(fixed::Fixed, child::Widget) = detail.remove_child!(fixed._internal, as_widget_pointer(child))
    export remove_child!

    set_child_position!(fixed::Fixed, child::Widget, position::Vector2f) = detail.set_child_position!(fixed._internal, as_widget_pointer(child), position)
    export set_child_position!

    @add_widget_signals Fixed

    Base.show(io::IO, x::Fixed) = show_aux(io, x)

####### level_bar.jl

    @export_enum LevelBarMode begin
        LEVEL_BAR_MODE_CONTINUOUS
        LEVEL_BAR_MODE_DISCRETE
    end

    @export_type LevelBar Widget
    @declare_native_widget LevelBar

    LevelBar(min::Number, max::Number) = LevelBar(detail._LevelBar(convert(Cfloat, min), convert(Cfloat, max)))

    @export_function LevelBar add_marker! Cvoid String name Number => Cfloat value
    @export_function LevelBar remove_marker! Cvoid String name
    @export_function LevelBar set_inverted! Cvoid Bool b
    @export_function LevelBar get_inverted Bool
    @export_function LevelBar set_mode! Cvoid LevelBarMode mode
    @export_function LevelBar get_mode LevelBarMode
    @export_function LevelBar set_min_value! Cvoid Number => Cfloat value
    @export_function LevelBar get_min_value Cfloat
    @export_function LevelBar set_max_value! Cvoid Number => Cfloat value
    @export_function LevelBar get_max_value Cfloat
    @export_function LevelBar set_value! Cvoid Number => Cfloat value
    @export_function LevelBar get_value Cfloat
    @export_function LevelBar set_orientation! Cvoid Orientation orientation
    @export_function LevelBar get_orientation Orientation

    @add_widget_signals LevelBar

    Base.show(io::IO, x::LevelBar) = show_aux(io, x, :orientation, :value, :min_value, :max_value)

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
    @declare_native_widget Label

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
    @export_function Label set_max_width_chars! Cvoid Integer n
    @export_function Label get_max_width_chars Int64
    @export_function Label set_x_alignment! Cvoid AbstractFloat => Cfloat x
    @export_function Label get_x_alignment Cfloat
    @export_function Label set_y_alignment! Cvoid AbstractFloat => Cfloat x
    @export_function Label get_y_alignment Cfloat
    @export_function Label set_is_selectable! Cvoid Bool b
    @export_function Label get_is_selectable Bool

    @add_widget_signals Label

    Base.show(io::IO, x::Label) = show_aux(io, x,
        :text,
        :ellipsize_mode,
        :wrap_mode,
        :justify_mode
    )

####### text_view.jl

    @export_type TextView Widget
    @declare_native_widget TextView

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
    @export_function TextView set_left_margin! Cvoid Number => Cfloat margin
    @export_function TextView get_left_margin Cfloat
    @export_function TextView set_right_margin! Cvoid Number => Cfloat margin
    @export_function TextView get_right_margin Cfloat
    @export_function TextView set_top_margin! Cvoid Number => Cfloat margin
    @export_function TextView get_top_margin Cfloat
    @export_function TextView set_bottom_margin! Cvoid Number => Cfloat margin
    @export_function TextView get_bottom_margin Cfloat

    @add_widget_signals TextView
    @add_signal_text_changed TextView

    Base.show(io::IO, x::TextView) = show_aux(io, x, :text, :was_modified)

####### frame.jl

    @export_type Frame Widget
    @declare_native_widget Frame

    Frame() = Frame(detail._Frame())

    function Frame(child::Widget) ::Frame
        out = Frame()
        set_child!(out, child)
        return out
    end

    set_child!(frame::Frame, child::Widget) = detail.set_child!(frame._internal, as_widget_pointer(child))
    export set_child!

    set_label_widget!(frame::Frame, label::Widget) = detail.set_label_widget!(frame._internal, as_widget_pointer(label))
    export set_label_widget!

    @export_function Frame remove_child! Cvoid
    @export_function Frame remove_label_widget! Cvoid
    @export_function Frame set_label_x_alignment! Cvoid AbstractFloat => Cfloat x
    @export_function Frame get_label_x_alignment Cfloat

    @add_widget_signals Frame

    Base.show(io::IO, x::Frame) = show_aux(io, x)

####### overlay.jl

    @export_type Overlay Widget
    @declare_native_widget Overlay

    Overlay() = Overlay(detail._Overlay())
    function Overlay(base::Widget, overlays::Widget...) ::Overlay
        out = Overlay()
        set_child!(out, base)
        for overlay in overlays
            add_overlay!(out, overlay)
        end
        return out
    end

    set_child!(overlay::Overlay, child::Widget) = detail.set_child!(overlay._internal, as_widget_pointer(child))
    export set_child!

    remove_child!(overlay::Overlay) = detail.remove_child!(overlay._internal)
    export remove_child!

    function add_overlay!(overlay::Overlay, child::Widget; include_in_measurement::Bool = true, clip::Bool = false)
        detail.add_overlay!(overlay._internal, as_widget_pointer(child), include_in_measurement, clip)
    end
    export add_overlay!

    remove_overlay!(overlay::Overlay, child::Widget) = detail.remove_overlay!(overlay._internal, as_widget_pointer(child))
    export remove_overlay!

    @add_widget_signals Overlay

    Base.show(io::IO, x::Overlay) = show_aux(io, x)

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

    add_widget!(model::MenuModel, widget::Widget) = detail.add_widget!(model._internal, as_widget_pointer(widget))
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

    add_icon!(model::MenuModel, icon::Icon, action::Action) = detail.add_icon!(model._internal, icon._internal, action._internal)
    export add_icon!

    @add_signal_items_changed MenuModel

    function set_menubar(app::Application, model::MenuModel)
        if !Sys.isapple() 
            log_warning(MOUSETRAP_DOMAIN, "In set_menubar: setting an application-wide menubar is only supported on macOS. Use `Sys.isapple()` to verify the users system before calling this function")
        end
        Mousetrap.detail.set_menubar(app._internal, model._internal)
    end

    Base.show(io::IO, x::MenuModel) = show_aux(io, x)

###### menubar.jl

    @export_type MenuBar Widget
    @declare_native_widget MenuBar

    MenuBar(model::MenuModel) = MenuBar(detail._MenuBar(model._internal))

    @add_widget_signals MenuBar

    Base.show(io::IO, x::MenuBar) = show_aux(io, x)

####### popover_menu.jl

    @export_type PopoverMenu Widget
    @declare_native_widget PopoverMenu

    PopoverMenu(model::MenuModel) = PopoverMenu(detail._PopoverMenu(model._internal))

    @add_widget_signals PopoverMenu
    @add_signal_closed PopoverMenu

    Base.show(io::IO, x::PopoverMenu) = show_aux(io, x)

###### popover.jl

    @export_type Popover Widget
    @declare_native_widget Popover

    Popover() = Popover(detail._Popover())

    @export_function Popover popup! Cvoid
    @export_function Popover popdown! Cvoid

    function set_child!(popover::Popover, child::Widget)
        detail.set_child!(popover._internal, as_widget_pointer(child))
    end
    export set_child!

    @export_function Popover remove_child! Cvoid

    @export_function Popover set_relative_position! Cvoid RelativePosition position
    @export_function Popover get_relative_position RelativePosition
    @export_function Popover set_autohide! Cvoid Bool b
    @export_function Popover get_autohide Bool
    @export_function Popover set_has_base_arrow! Cvoid Bool b
    @export_function Popover get_has_base_arrow Bool

    @add_widget_signals Popover
    @add_signal_closed Popover

    Base.show(io::IO, x::Popover) = show_aux(io, x)

###### popover_button.jl

    @export_type PopoverButton Widget
    @declare_native_widget PopoverButton

    PopoverButton(popover::Popover) = PopoverButton(detail._PopoverButton(popover._internal))
    PopoverButton(popover_menu::PopoverMenu) = PopoverButton(detail._PopoverButton(popover_menu._internal))

    set_child!(popover_button::PopoverButton, child::Widget) = detail.set_child!(popover_button._internal, as_widget_pointer(child))
    export set_child!

    set_icon!(popover_button::PopoverButton, icon::Icon) = detail.set_icon!(popover_button._internal, icon._internal)
    export set_icon!

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
    @export_function PopoverButton set_relative_position! Cvoid RelativePosition position
    @export_function PopoverButton get_relative_position RelativePosition
    @export_function PopoverButton set_always_show_arrow! Cvoid Bool b
    @export_function PopoverButton get_always_show_arrow Bool
    @export_function PopoverButton set_has_frame! Cvoid Bool b
    @export_function PopoverButton get_has_frame Bool
    @export_function PopoverButton popup! Cvoid
    @export_function PopoverButton popdown! Cvoid
    @export_function PopoverButton set_is_circular! Cvoid Bool b
    @export_function PopoverButton get_is_circular Bool

    @add_widget_signals PopoverButton
    @add_signal_activate PopoverButton

    Base.show(io::IO, x::PopoverButton) = show_aux(io, x)

###### drop_down.jl

    @export_type DropDown Widget
    @declare_native_widget DropDown

    DropDown() = DropDown(detail._DropDown())

    const DropDownItemID = UInt64
    export DropDownItemID

    @export_function DropDown remove! Cvoid DropDownItemID id
    @export_function DropDown set_always_show_arrow! Cvoid Bool b
    @export_function DropDown get_always_show_arrow Bool
    @export_function DropDown set_selected! Cvoid DropDownItemID id
    @export_function DropDown get_selected DropDownItemID

    get_item_at(drop_down::DropDown, i::Integer) = detail.get_item_at(drop_down._internal, from_julia_index(i))
    export get_item_at

    function push_back!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (DropDown, Data_t))
        return detail.push_back!(drop_down._internal, as_widget_pointer(list_widget), as_widget_pointer(label_widget), function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]), data)
        end)
    end
    function push_back!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget)
        typed_f = TypedFunction(f, Cvoid, (DropDown,))
        return detail.push_back!(drop_down._internal, as_widget_pointer(list_widget), as_widget_pointer(label_widget), function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]))
        end)
    end
    function push_back!(f, drop_down::DropDown, label::String, data::Data_t) where Data_t
        return detail.push_back!(drop_down._internal, detail._Label(label).cpp_object, detail._Label(label).cpp_object, function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]), data)
        end)
    end
    function push_back!(f, drop_down::DropDown, label::String)
        typed_f = TypedFunction(f, Cvoid, (DropDown,))
        return detail.push_back!(drop_down._internal, detail._Label(label).cpp_object, detail._Label(label).cpp_object, function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]))
        end)
    end

    push_back!(drop_down::DropDown, list_widget::Widget, label_widget::Widget) = push_back!((_::DropDown) -> nothing, drop_down, list_widget, label_widget)
    push_back!(drop_down::DropDown, label::String) = push_back!((_::DropDown) -> nothing, drop_down, label)
    export push_back!

    function push_front!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget, data::Data_t) where Data_t
        return detail.push_front!(drop_down._internal, as_widget_pointer(list_widget), as_widget_pointer(label_widget), function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]), data)
        end)
    end
    function push_front!(f, drop_down::DropDown, list_widget::Widget, label_widget::Widget)
        typed_f = TypedFunction(f, Cvoid, (DropDown,))
        return detail.push_front!(drop_down._internal, as_widget_pointer(list_widget), as_widget_pointer(label_widget), function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]))
        end)
    end
    function push_front!(f, drop_down::DropDown, label::String, data::Data_t) where Data_t
        return detail.push_front!(drop_down._internal, detail._Label(label).cpp_object, detail._Label(label).cpp_object, function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]), data)
        end)
    end
    function push_front!(f, drop_down::DropDown, label::String)
        typed_f = TypedFunction(f, Cvoid, (DropDown,))
        return detail.push_front!(drop_down._internal, detail._Label(label).cpp_object, detail._Label(label).cpp_object, function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]))
        end)
    end

    push_front!(drop_down::DropDown, list_widget::Widget, label_widget::Widget) = push_front!((_::DropDown) -> nothing, drop_down, list_widget, label_widget)
    push_front!(drop_down::DropDown, label::String) = push_front!((_::DropDown) -> nothing, drop_down, label)
    export push_front!

    function insert_at!(f, drop_down::DropDown, index::Integer, list_widget::Widget, label_widget::Widget, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (DropDown, Data_t))
        return detail.insert!(drop_down._internal, from_julia_index(index), as_widget_pointer(list_widget), as_widget_pointer(label_widget), function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]), data)
        end)
    end
    function insert_at!(f, drop_down::DropDown, index::Integer, list_widget::Widget, label_widget::Widget)
        typed_f = TypedFunction(f, Cvoid, (DropDown,))
        return detail.insert!(drop_down._internal, from_julia_index(index), as_widget_pointer(list_widget), as_widget_pointer(label_widget), function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]))
        end)
    end
    function insert_at!(f, drop_down::DropDown, index::Integer, label::String, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (DropDown, Data_t))
        return detail.insert!(drop_down._internal, from_julia_index(index), detail._Label(label).cpp_object, detail._Label(label).cpp_object, function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]), data)
        end)
    end
    function insert_at!(f, drop_down::DropDown, index::Integer, label::String)
        typed_f = TypedFunction(f, Cvoid, (DropDown,))
        return detail.insert!(drop_down._internal, from_julia_index(index), detail._Label(label).cpp_object, detail._Label(label).cpp_object, function (drop_down_internal_ref)
            typed_f(DropDown(drop_down_internal_ref[]))
        end)
    end

    insert_at!(drop_down::DropDown, index::Integer, list_widget::Widget, label_widget::Widget) = insert_at!((_::DropDown) -> nothing, drop_down, index, list_widget, label_widget)
    insert_at!(drop_down::DropDown, index::Integer, label::String) = insert_at!((_::DropDown) -> nothing, drop_down, index, label)
    export insert_at!

    @add_widget_signals DropDown

    Base.show(io::IO, x::DropDown) = show_aux(io, x, :selected)

###### event_controller.jl

    abstract type EventController <: SignalEmitter end
    export EventController

    abstract type SingleClickGesture <: EventController end
    export SingleClickGesture

    @export_enum PropagationPhase begin
        PROPAGATION_PHASE_NONE
        PROPAGATION_PHASE_CAPTURE
        PROPAGATION_PHASE_BUBBLE
        PROPAGATION_PHASE_TARGET
    end

    set_propagation_phase!(controller::EventController, phase::PropagationPhase) = detail.set_propagation_phase!(controller._internal.cpp_object, phase)
    export set_propagation_phase!

    get_propagation_phase(controller::EventController) ::PropagationPhase = detail.get_propagation_phase(controller._internal.cpp_object)
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

    get_current_button(gesture::SingleClickGesture) ::ButtonID = detail.get_current_button(gesture._internal.cpp_object)
    export get_current_button

    set_only_listens_to_button!(gesture::SingleClickGesture, button::ButtonID) = detail.set_only_listens_to_button!(gesture._internal.cpp_object, button)
    export set_only_listens_to_button!

    get_only_listens_to_button(gesture::SingleClickGesture) = detail.get_only_listens_to_button(gesture._internal.cpp_object)
    export get_only_listens_to_button

    set_touch_only!(gesture::SingleClickGesture, b::Bool) = detail.set_touch_only!(gesture._internal.cpp_object, b)
    export set_touch_only!

    get_touch_only(gesture::SingleClickGesture) = detail.get_touch_only(gesture._internal.cpp_object)
    export get_touch_only

###### drag_event_controller.jl

    @export_type DragEventController SingleClickGesture
    DragEventController() = DragEventController(detail._DragEventController())

    get_start_position(controller::DragEventController) ::Vector2f = detail.get_start_position(controller._internal)
    export get_start_position

    get_current_offset(controller::DragEventController) ::Vector2f = detail.get_current_offset(controller._internal)
    export get_current_offset

    @add_signal_drag_begin DragEventController
    @add_signal_drag DragEventController
    @add_signal_drag_end DragEventController

    Base.show(io::IO, x::DragEventController) = show_aux(io, x)

###### click_event_controller.jl

    @export_type ClickEventController SingleClickGesture
    ClickEventController() = ClickEventController(detail._ClickEventController())

    @add_signal_click_pressed ClickEventController
    @add_signal_click_released ClickEventController
    @add_signal_click_stopped ClickEventController

    Base.show(io::IO, x::ClickEventController) = show_aux(io, x)

###### focus_event_controller.jl

    @export_type FocusEventController EventController
    FocusEventController() = FocusEventController(detail._FocusEventController())

    @export_function FocusEventController self_or_child_is_focused Bool
    @export_function FocusEventController self_is_focused Bool

    @add_signal_focus_gained FocusEventController
    @add_signal_focus_lost FocusEventController

    Base.show(io::IO, x::FocusEventController) = show_aux(io, x)

###### key_event_controller.jl

    const KeyCode = Cuint
    export KeyCode

    const ModifierState = detail._ModifierState
    export ModifierState

    @export_type KeyEventController EventController
    KeyEventController() = KeyEventController(detail._KeyEventController())

    @export_function KeyEventController should_shortcut_trigger_trigger Bool String trigger

    @add_key_event_controller_signal KeyEventController key_pressed Cvoid
    @add_key_event_controller_signal KeyEventController key_released Cvoid
    @add_signal_modifiers_changed KeyEventController

    shift_pressed(modifier_state::ModifierState) ::Bool = detail.shift_pressed(modifier_state);
    export shift_pressed

    control_pressed(modifier_state::ModifierState) ::Bool = detail.control_pressed(modifier_state);
    export control_pressed

    alt_pressed(modifier_state::ModifierState) ::Bool = detail.alt_pressed(modifier_state);
    export alt_pressed

    mouse_button_01_pressed(modifier_state::ModifierState) ::Bool = detail.mouse_button_01_pressed(modifier_state);
    export mouse_button_01_pressed

    mouse_button_02_pressed(modifier_state::ModifierState) ::Bool = detail.mouse_button_02_pressed(modifier_state);
    export mouse_button_02_pressed

    Base.show(io::IO, x::KeyEventController) = show_aux(io, x)

###### long_press_event_controller.jl

    @export_type LongPressEventController SingleClickGesture
    LongPressEventController() = LongPressEventController(detail._LongPressEventController())

    @export_function LongPressEventController set_delay_factor! Cvoid Number => Cfloat factor
    @export_function LongPressEventController get_delay_factor Cfloat

    @add_signal_pressed LongPressEventController
    @add_signal_press_cancelled LongPressEventController

    Base.show(io::IO, x::LongPressEventController) = show_aux(io, x)

###### motion_event_controller.jl

    @export_type MotionEventController EventController
    MotionEventController() = MotionEventController(detail._MotionEventController())

    @add_signal_motion_enter MotionEventController
    @add_signal_motion MotionEventController
    @add_signal_motion_leave MotionEventController

    Base.show(io::IO, x::MotionEventController) = show_aux(io, x)

###### pinch_zoom_event_controller.jl

    @export_type PinchZoomEventController EventController
    PinchZoomEventController() = PinchZoomEventController(detail._PinchZoomEventController())

    @export_function PinchZoomEventController get_scale_delta Cfloat

    @add_signal_scale_changed PinchZoomEventController

    Base.show(io::IO, x::PinchZoomEventController) = show_aux(io, x)

###### rotate_event_controller.jl

    @export_type RotateEventController EventController
    RotateEventController() = RotateEventController(detail._RotateEventController())

    get_angle_delta(controller::RotateEventController) ::Angle = radians(detail.get_angle_delta(controller._internal))
    export get_angle_delta

    @add_signal_rotation_changed RotateEventController

    Base.show(io::IO, x::RotateEventController) = show_aux(io, x)

###### scroll_event_controller.jl

    @export_type ScrollEventController EventController
    ScrollEventController(kinetic_scrolling_enabled::Bool = false) = ScrollEventController(detail._ScrollEventController(kinetic_scrolling_enabled))

    @export_function ScrollEventController get_kinetic_scrolling_enabled Bool
    @export_function ScrollEventController set_kinetic_scrolling_enabled! Cvoid Bool b

    @add_signal_kinetic_scroll_decelerate ScrollEventController
    @add_signal_scroll_begin ScrollEventController
    @add_signal_scroll ScrollEventController
    @add_signal_scroll_end ScrollEventController

    Base.show(io::IO, x::ScrollEventController) = show_aux(io, x)

###### shortcut_event_controller.jl

    @export_type ShortcutEventController EventController
    ShortcutEventController() = ShortcutEventController(detail._ShortcutEventController())

    add_action!(shortcut_controller::ShortcutEventController, action::Action) = detail.add_action!(shortcut_controller._internal, action._internal)
    export add_action!

    remove_action!(shortcut_controller::ShortcutEventController, action::Action) = detail.remove_action!(shortcut_controller._internal, action._internal)
    export remove_action!

    @export_enum ShortcutScope begin
        SHORTCUT_SCOPE_LOCAL
        SHORTCUT_SCOPE_GLOBAL
        #SHORTCUT_SCOPE_MANAGED
    end

    set_scope!(controller::ShortcutEventController, scope::ShortcutScope) = detail.set_scope!(controller._internal, scope)
    export set_scope!

    get_scope(controller::ShortcutEventController) ::ShortcutScope = detail.get_scope(controller._internal)
    export get_scope

    Base.show(io::IO, x::ShortcutEventController) = show_aux(io, x, :scope)

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
    @export_function StylusEventController get_axis_value Float64 DeviceAxis axis

    @add_signal_stylus_up StylusEventController
    @add_signal_stylus_down StylusEventController
    @add_signal_proximity StylusEventController
    @add_signal_motion StylusEventController

    Base.show(io::IO, x::StylusEventController) = show_aux(io, x, :hardware_id)

###### swipe_event_controller.jl

    @export_type SwipeEventController SingleClickGesture
    SwipeEventController() = SwipeEventController(detail._SwipeEventController())

    get_velocity(swipe_controller::SwipeEventController) ::Vector2f = detail.get_velocity(swipe_controller._internal)
    export get_velocity

    @add_signal_swipe SwipeEventController

    Base.show(io::IO, x::SwipeEventController) = show_aux(io, x)

###### pan_event_controller.jl

    @export_enum PanDirection begin
        PAN_DIRECTION_LEFT
        PAN_DIRECTION_RIGHT
        PAN_DIRECTION_UP
        PAN_DIRECTION_DOWN
    end

    @export_type PanEventController SingleClickGesture
    PanEventController(orientation::Orientation) = PanEventController(detail._PanEventController(orientation))

    set_orientation!(pan_controller::PanEventController, orientation::Orientation) = detail.set_orientation!(pan_controller._internal, orientation)
    export set_orientation!

    get_orientation(pan_controller::PanEventController) ::Orientation = detail.get_orientation(pan_controller._internal)
    export get_orientation

    @add_signal_pan PanEventController

    Base.show(io::IO, x::PanEventController) = show_aux(io, x, :orientation)

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
    @export_function SelectionModel get_n_items Int64

    @export_function SelectionModel get_selection_mode SelectionMode

    select!(model::SelectionModel, i::Integer, unselect_others::Bool = true) = detail.select!(model._internal, from_julia_index(i), unselect_others)
    export select!

    unselect!(model::SelectionModel, i::Integer) = detail.unselect!(model._internal, from_julia_index(i))
    export unselect!

    @add_signal_selection_changed SelectionModel

    Base.show(io::IO, x::SelectionModel) = show_aux(io, x, :selection_mode)

###### list_view.jl

    @export_type ListView Widget
    @declare_native_widget ListView

    ListView(orientation::Orientation, selection_mode::SelectionMode = SELECTION_MODE_NONE) = ListView(detail._ListView(orientation, selection_mode))

    struct ListViewIterator
        _internal::Ptr{Cvoid}
    end
    export ListViewIterator

    push_back!(list_view::ListView, widget::Widget) = ListViewIterator(detail.push_back!(list_view._internal, as_widget_pointer(widget), Ptr{Cvoid}()))
    push_back!(list_view::ListView, widget::Widget, iterator::ListViewIterator) = ListViewIterator(detail.push_back!(list_view._internal, as_widget_pointer(widget), iterator._internal))
    export push_back!

    push_front!(list_view::ListView, widget::Widget) = ListViewIterator(detail.push_front!(list_view._internal, as_widget_pointer(widget), Ptr{Cvoid}()))
    push_front!(list_view::ListView, widget::Widget, iterator::ListViewIterator) = ListViewIterator(detail.push_front!(list_view._internal, as_widget_pointer(widget), iterator._internal))
    export push_front!

    insert_at!(list_view::ListView, index::Integer, widget::Widget) = ListViewIterator(detail.insert!(list_view._internal, from_julia_index(index), as_widget_pointer(widget), Ptr{Cvoid}()))
    insert_at!(list_view::ListView, index::Integer, widget::Widget, iterator::ListViewIterator) = ListViewIterator(detail.insert!(list_view._internal, from_julia_index(index), as_widget_pointer(widget), iterator._internal))
    export insert_at!

    remove!(list_view::ListView, index::Integer) = detail.remove!(list_view._internal, from_julia_index(index), Ptr{Cvoid}())
    remove!(list_view::ListView, index::Integer, iterator::ListViewIterator) = detail.remove!(list_view._internal, from_julia_index(index), iterator._internal)
    export remove!

    clear!(list_view::ListView) = detail.clear!(list_view._internal,Ptr{Cvoid}())
    clear!(list_view::ListView, iterator::ListViewIterator) = detail.clear!(list_view._internal, iterator._internal)
    export clear!

    set_widget_at!(list_view::ListView, index::Integer, widget::Widget) = detail.set_widget_at!(list_view._internal, from_julia_index(index), as_widget_pointer(widget), Ptr{Cvoid}())
    set_widget_at!(list_view::ListView, index::Integer, widget::Widget, iterator::ListViewIterator) = detail.set_widget_at!(list_view._internal, from_julia_index(index), as_widget_pointer(widget), iterator._internal)
    export set_widget_at!

    function find(list_view::ListView, widget::Widget, iterator::ListViewIterator) ::Signed
        i = detail.find(list_view._internal, as_widget_pointer(widget), iterator._internal)
        return i == -1 ? -1 : to_julia_index(i)
    end
    function find(list_view::ListView, widget::Widget) ::Signed
        i = detail.find(list_view._internal, as_widget_pointer(widget), Ptr{Cvoid}())
        return i == -1 ? -1 : to_julia_index(i)
    end
    export find

    get_selection_model(list_view::ListView) ::SelectionModel = SelectionModel(detail.get_selection_model(list_view._internal))
    export get_selection_model

    @export_function ListView set_enable_rubberband_selection! Cvoid Bool b
    @export_function ListView get_enable_rubberband_selection Bool
    @export_function ListView set_show_separators! Cvoid Bool b
    @export_function ListView get_show_separators Bool
    @export_function ListView set_single_click_activate! Cvoid Bool b
    @export_function ListView get_single_click_activate Bool
    @export_function ListView get_n_items Int64
    @export_function ListView set_orientation! Cvoid Orientation orientation
    @export_function ListView get_orientation Orientation

    @add_widget_signals ListView
    @add_signal_activate_item ListView

    Base.show(io::IO, x::ListView) = show_aux(io, x, :selection_model, :orientation)

###### grid_view.jl

    @export_type GridView Widget
    @declare_native_widget GridView

    GridView(orientation::Orientation = ORIENTATION_VERTICAL, selection_mode::SelectionMode = SELECTION_MODE_NONE) = GridView(detail._GridView(orientation, selection_mode))
    GridView(selection_mode::SelectionMode) = GridView(ORIENTATION_VERTICAL, selection_mode)

    push_back!(grid_view::GridView, widget::Widget) = detail.push_back!(grid_view._internal, as_widget_pointer(widget))
    export push_back!

    push_front!(grid_view::GridView, widget::Widget) = detail.push_front!(grid_view._internal, as_widget_pointer(widget))
    export push_front!

    insert_at!(grid_view::GridView, index::Integer, widget::Widget) = detail.insert!(grid_view._internal, from_julia_index(index), as_widget_pointer(widget))
    export insert_at!

    remove!(grid_view::GridView, index::Integer) = detail.remove!(grid_view._internal, from_julia_index(index))
    export remove!

    clear!(grid_view::GridView) = detail.clear!(grid_view._internal)
    export clear!

    function find(grid_view::GridView, widget::Widget) ::Signed
        i = detail.find(grid_view._internal, as_widget_pointer(widget))
        return i == -1 ? -1 : to_julia_index(i)
    end
    export find

    @export_function GridView get_n_items Int64
    @export_function GridView set_enable_rubberband_selection! Cvoid Bool b
    @export_function GridView get_enable_rubberband_selection Bool
    @export_function GridView get_single_click_activate Bool
    @export_function GridView set_single_click_activate! Cvoid Bool b

    set_max_n_columns!(grid_view::GridView, n::Integer) = detail.set_max_n_columns!(grid_view._internal, UInt64(n))
    export set_max_n_columns!

    get_max_n_columns(grid_view::GridView) ::Int64 = detail.get_max_n_columns(grid_view._internal)
    export get_max_n_columns

    set_min_n_columns!(grid_view::GridView, n::Integer) = detail.set_min_n_columns!(grid_view._internal, UInt64(n))
    export set_min_n_columns!

    get_min_n_columns(grid_view::GridView) ::Int64 = detail.get_min_n_columns(grid_view._internal)
    export get_min_n_columns

    @export_function GridView set_orientation! Cvoid Orientation orientation
    @export_function GridView get_orientation Orientation

    get_selection_model(grid_view::GridView) ::SelectionModel = SelectionModel(detail.get_selection_model(grid_view._internal))
    export get_selection_model

    @add_widget_signals GridView
    @add_signal_activate_item GridView

    Base.show(io::IO, x::GridView) = show_aux(io, x, :selection_model)

###### grid.jl

    @export_type Grid Widget
    @declare_native_widget Grid

    Grid() = Grid(detail._Grid())

    function insert_at!(grid::Grid, widget::Widget, row_i::Signed, column_i::Signed, n_horizontal_cells::Integer = 1, n_vertical_cells::Integer = 1)
        detail.insert!(grid._internal, as_widget_pointer(widget), row_i - 1, column_i - 1, n_horizontal_cells, n_vertical_cells)
    end
    export insert_at!

    function insert_next_to!(grid::Grid, to_insert::Widget, already_in_grid::Widget, position::RelativePosition, n_horizontal_cells::Integer = 1, n_vertical_cells::Integer = 1)
        detail.insert_next_to!(grid._internal, as_widget_pointer(to_insert), as_widget_pointer(already_in_grid), position, n_horizontal_cells, n_vertical_cells)
    end
    export insert_next_to!

    remove!(grid::Grid, widget::Widget) = detail.remove!(grid._internal, as_widget_pointer(widget))
    export remove!

    function get_position(grid::Grid, widget::Widget) ::Vector2i
        native_pos::Vector2i = detail.get_position(grid._internal, as_widget_pointer(widget))
        return Vector2i(native_pos.x + 1, native_pos.y + 1)
    end
    export get_position

    get_size(grid::Grid, widget::Widget) ::Vector2i = detail.get_size(grid._internal, as_widget_pointer(widget))
    export get_size

    insert_row_at!(grid::Grid, row_i::Signed) = detail.insert_row_at!(grid._internal, row_i -1)
    export insert_row_at!

    remove_row_at!(grid::Grid, row_i::Signed) = detail.remove_row_at!(grid._internal, row_i -1)
    export remove_row_at!

    insert_column_at!(grid::Grid, column_i::Signed) = detail.insert_column_at!(grid._internal, column_i -1)
    export insert_column_at!

    remove_column_at!(grid::Grid, column_i::Signed) = detail.remove_column_at!(grid._internal, column_i -1)
    export remove_column_at!

    @export_function Grid get_column_spacing Cfloat
    @export_function Grid set_column_spacing! Cvoid Number => Cfloat spacing
    @export_function Grid get_row_spacing Cfloat
    @export_function Grid set_row_spacing! Cvoid Number => Cfloat spacing
    @export_function Grid set_rows_homogeneous! Cvoid Bool b
    @export_function Grid get_rows_homogeneous Bool
    @export_function Grid set_columns_homogeneous! Cvoid Bool b
    @export_function Grid get_columns_homogeneous Bool
    @export_function Grid set_orientation! Cvoid Orientation orientation
    @export_function Grid get_orientation Orientation

    @add_widget_signals Grid

    Base.show(io::IO, x::Grid) = show_aux(io, x, :orientation)

###### stack.jl

    @export_type Stack Widget
    @declare_native_widget Stack
    Stack() = Stack(detail._Stack())

    @export_type StackSidebar Widget
    @declare_native_widget StackSidebar
    StackSidebar(stack::Stack) = StackSidebar(detail._StackSidebar(stack._internal))

    @export_type StackSwitcher Widget
    @declare_native_widget StackSwitcher
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

    add_child!(stack::Stack, child::Widget, title::String) ::StackID = detail.add_child!(stack._internal, as_widget_pointer(child), title)
    export add_child!

    remove_child!(stack::Stack, id::StackID) = detail.remove_child!(stack._internal, id)
    export remove_child!

    set_visible_child!(stack::Stack, id::StackID) = detail.set_visible_child!(stack._internal, id)
    export set_visible_child!

    get_visible_child(stack::Stack) ::StackID = detail.get_visible_child(stack._internal)
    export get_visible_child

    get_child_at(stack::Stack, index::Integer) ::StackID = detail.get_child_at(stack._internal, from_julia_index(convert(Csize_t, index)))
    export get_child_at

    @export_function Stack set_transition_type! Cvoid StackTransitionType transition
    @export_function Stack get_transition_type StackTransitionType

    set_transition_duration!(stack::Stack, duration::Time) = detail.set_transition_duration!(stack._internal, convert(Cfloat, as_microseconds(duration)))
    export set_transition_duration!

    get_transition_duration(stack::Stack) ::Time = microseconds(detail.get_transition_duration(stack._internal))
    export get_transition_duration

    @export_function Stack set_is_horizontally_homogeneous! Cvoid Bool b
    @export_function Stack get_is_horizontally_homogeneous Bool
    @export_function Stack set_is_vertically_homogeneous! Cvoid Bool b
    @export_function Stack get_is_vertically_homogeneous Bool
    @export_function Stack set_should_interpolate_size! Cvoid Bool b
    @export_function Stack get_should_interpolate_size Bool

    @add_widget_signals Stack
    @add_widget_signals StackSidebar
    @add_widget_signals StackSwitcher

    Base.show(io::IO, x::Stack) = show_aux(io, x, :selection_model, :transition_type)

###### notebook.jl

    @export_type Notebook Widget
    @declare_native_widget Notebook

    Notebook() = Notebook(detail._Notebook())

    function push_front!(notebook::Notebook, child_widget::Widget, label_widget::Widget) ::Int64
        return detail.push_front!(notebook._internal, as_widget_pointer(child_widget), as_widget_pointer(label_widget))
    end
    export push_front!

    function push_back!(notebook::Notebook, child_widget::Widget, label_widget::Widget) ::Int64
        return detail.push_back!(notebook._internal, as_widget_pointer(child_widget), as_widget_pointer(label_widget))
    end
    export push_back!

    function insert_at!(notebook::Notebook, index::Integer, child_widget::Widget, label_widget::Widget) ::Int64
        return detail.insert!(notebook._internal, from_julia_index(index), as_widget_pointer(child_widget), as_widget_pointer(label_widget))
    end
    export insert_at!

    function move_page_to!(notebook::Notebook, current_index::Integer, new_index::Integer) ::Cvoid
        detail.move_page_to!(notebook._internal, from_julia_index(current_index), from_julia_index(new_index))
    end
    export move_page_to!

    remove!(notebook::Notebook, index::Integer) = detail.remove!(notebook._internal, from_julia_index(index))
    export remove!

    @export_function Notebook next_page! Cvoid
    @export_function Notebook previous_page! Cvoid

    goto_page!(notebook::Notebook, index::Integer) = detail.goto_page!(notebook._internal, from_julia_index(index))
    export goto_page!

    get_current_page(notebook::Notebook) ::Int64 = to_julia_index(detail.get_current_page(notebook._internal))
    export get_current_page

    @export_function Notebook get_n_pages Int64
    @export_function Notebook set_is_scrollable! Cvoid Bool b
    @export_function Notebook get_is_scrollable Bool
    @export_function Notebook set_has_border! Cvoid Bool b
    @export_function Notebook get_has_border Bool
    @export_function Notebook set_tabs_visible! Cvoid Bool b
    @export_function Notebook get_tabs_visible Bool
    @export_function Notebook set_quick_change_menu_enabled! Cvoid Bool b
    @export_function Notebook get_quick_change_menu_enabled Bool
    @export_function Notebook set_tab_position! Cvoid RelativePosition relative_position
    @export_function Notebook get_tab_position RelativePosition
    @export_function Notebook set_tabs_reorderable! Cvoid Bool b
    @export_function Notebook get_tabs_reorderable Bool

    @add_widget_signals Notebook
    @add_notebook_signal Notebook page_added
    @add_notebook_signal Notebook page_reordered
    @add_notebook_signal Notebook page_removed
    @add_notebook_signal Notebook page_selection_changed

    Base.show(io::IO, x::Notebook) = show_aux(io, x, :current_page, :n_pages)

###### column_view.jl

    @export_type ColumnViewColumn SignalEmitter

    ColumnViewColumn(internal::Ptr{Cvoid}) = ColumnViewColumn(detail._ColumnViewColumn(internal))

    @export_function ColumnViewColumn set_title! Cvoid String title
    @export_function ColumnViewColumn get_title String
    @export_function ColumnViewColumn set_fixed_width! Cvoid Number => Cfloat width
    @export_function ColumnViewColumn get_fixed_width Cfloat

    set_header_menu!(column::ColumnViewColumn, model::MenuModel) = detail.set_header_menu!(column._internal, model._internal)
    export set_header_menu!

    @export_function ColumnViewColumn set_is_visible! Cvoid Bool b
    @export_function ColumnViewColumn get_is_visible Bool
    @export_function ColumnViewColumn set_is_resizable! Cvoid Bool b
    @export_function ColumnViewColumn get_is_resizable Bool

    function set_expand!(column::ColumnViewColumn, should_expand::Bool)
        @ccall detail.GTK4_jll.libgtk4.gtk_column_view_column_set_expand(Mousetrap.as_internal_pointer(column)::Ptr{Cvoid}, should_expand::Bool)::Cvoid
        return nothing
    end
    export set_expand!

    function get_expand(column::ColumnViewColumn) ::Bool 
        return @ccall detail.GTK4_jll.libgtk4.gtk_column_view_column_get_expand(Mousetrap.as_internal_pointer(column)::Ptr{Cvoid})::Bool
    end
    export get_expand

    @export_type ColumnView Widget
    @declare_native_widget ColumnView

    ColumnView(selection_mode::SelectionMode = SELECTION_MODE_NONE) = ColumnView(detail._ColumnView(selection_mode))

    function push_back_column!(column_view::ColumnView, title::String) ::ColumnViewColumn
        return ColumnViewColumn(detail.push_back_column!(column_view._internal, title))
    end
    export push_back_column!

    function push_front_column!(column_view::ColumnView, title::String) ::ColumnViewColumn
        return ColumnViewColumn(detail.push_front_column!(column_view._internal, title))
    end
    export push_front_column!

    function insert_column_at!(column_view::ColumnView, index::Integer, title::String) ::ColumnViewColumn
        return ColumnViewColumn(detail.insert_column!(column_view._internal, from_julia_index(index), title))
    end
    export insert_column_at!

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

    has_column_with_title(column_view::ColumnView, title::String) ::Bool = detail.has_column_with_title(column_view._internal, title)
    export has_column_with_title

    function set_widget_at!(column_view::ColumnView, column::ColumnViewColumn, row_i::Integer, widget::Widget)
        detail.set_widget_at!(column_view._internal, column._internal, from_julia_index(row_i), as_widget_pointer(widget))
    end
    export set_widget_at!

    function push_back_row!(column_view::ColumnView, widgets::Widget...)

        if length(widgets) > get_n_columns(column_view)
            @log_warning MOUSETRAP_DOMAIN "In ColumnView.push_back_row!: Attempting to push $(length(widgets)) widgets, but ColumnView only has $(get_n_columns(column_view)) columns"
        end

        row_i = get_n_rows(column_view) + 1
        for i in 1:get_n_columns(column_view)
            column = get_column_at(column_view, i)
            set_widget_at!(column_view, column, row_i, widgets[i])
        end
    end
    export push_back_row!

    function push_front_row!(column_view::ColumnView, widgets::Widget...)

        @log_critical MOUSETRAP_DOMAIN "In ColumnView.push_front_row!: This method was deprecated in v0.3.2, use `insert_row_at!` instead"

        if length(widgets) > get_n_columns(column_view)
            @log_warning MOUSETRAP_DOMAIN "In ColumnView.push_front_row!: Attempting to push $(length(widgets)) widgets, but ColumnView only has $(get_n_columns(column_view)) columns"
        end

        row_i = 1
        for i in 1:get_n_columns(column_view)
            column = get_column_at(column_view, i)
            set_widget_at!(column_view, column, row_i, widgets[i])
        end
    end
    export push_front_row!

    function insert_row_at!(column_view::ColumnView, index::Integer, widgets::Widget...)

        if length(widgets) > get_n_columns(column_view)
            @log_warning MOUSETRAP_DOMAIN "In ColumnView.insert_row_at!: Attempting to push $(length(widgets)) widgets, but ColumnView only has $(get_n_columns(column_view)) columns"
        end

        row_i = index
        for i in 1:get_n_columns(column_view)
            column = get_column_at(column_view, i)
            set_widget_at!(column_view, column, row_i, widgets[i])
        end
    end
    export push_front_row!

    get_selection_model(column_view::ColumnView) ::SelectionModel = SelectionModel(detail.get_selection_model(column_view._internal))
    export get_selection_model

    @export_function ColumnView set_enable_rubberband_selection! Cvoid Bool b
    @export_function ColumnView get_enable_rubberband_selection Bool
    @export_function ColumnView set_show_row_separators Cvoid Bool b
    @export_function ColumnView get_show_row_separators Bool
    @export_function ColumnView set_show_column_separators Cvoid Bool b
    @export_function ColumnView get_show_column_separators Bool
    @export_function ColumnView set_single_click_activate! Cvoid Bool b
    @export_function ColumnView get_single_click_activate Bool
    @export_function ColumnView get_n_rows Int64
    @export_function ColumnView get_n_columns Int64

    @add_widget_signals ColumnView
    @add_signal_activate ColumnView

    Base.show(io::IO, x::ColumnView) = show_aux(io, x, :n_rows, :n_columns)

###### header_bar.jl

    @export_type HeaderBar Widget
    @declare_native_widget HeaderBar

    HeaderBar() = HeaderBar(detail._HeaderBar())
    HeaderBar(internal::Ptr{Cvoid}) = HeaderBar(detail._HeaderBar(internal))
    HeaderBar(layout::String) = HeaderBar(detail._HeaderBar(layout))

    @export_function HeaderBar set_layout! Cvoid String layout
    @export_function HeaderBar get_layout String
    @export_function HeaderBar set_show_title_buttons! Cvoid Bool b
    @export_function HeaderBar get_show_title_buttons Bool

    set_title_widget!(header_bar::HeaderBar, widget::Widget) = detail.set_title_widget!(header_bar._internal, as_widget_pointer(widget))
    export set_title_widget!

    @export_function HeaderBar remove_title_widget! Cvoid

    push_front!(header_bar::HeaderBar, widget::Widget) = detail.push_front!(header_bar._internal, as_widget_pointer(widget))
    export push_front!

    push_back!(header_bar::HeaderBar, widget::Widget) = detail.push_back!(header_bar._internal, as_widget_pointer(widget))
    export push_back!

    remove!(header_bar::HeaderBar, widget::Widget) = detail.remove!(header_bar._internal, as_widget_pointer(widget))
    export remove!

    @add_widget_signals HeaderBar

    Base.show(io::IO, x::HeaderBar) = show_aux(io, x, :layout)

###### paned.jl

    @export_type Paned Widget
    @declare_native_widget Paned

    Paned(orientation::Orientation) = Paned(detail._Paned(orientation))

    function Paned(orientation::Orientation, start_child::Widget, end_child::Widget) ::Paned
        out = Paned(orientation)
        set_start_child!(out, start_child)
        set_end_child!(out, end_child)
        return out
    end

    @export_function Paned get_position Cint
    @export_function Paned set_position! Cvoid Integer position

    @export_function Paned set_has_wide_handle! Cvoid Bool b
    @export_function Paned get_has_wide_handle Bool
    @export_function Paned set_orientation! Cvoid Orientation orientation
    @export_function Paned get_orientation Orientation

    @export_function Paned set_start_child_resizable! Cvoid Bool b
    @export_function Paned get_start_child_resizable Bool
    @export_function Paned set_start_child_shrinkable! Cvoid Bool b
    @export_function Paned get_start_child_shrinkable Bool

    set_start_child!(paned::Paned, child::Widget) = detail.set_start_child!(paned._internal, as_widget_pointer(child))
    export set_start_child!

    @export_function Paned remove_start_child! Cvoid

    @export_function Paned set_end_child_resizable! Cvoid Bool b
    @export_function Paned get_end_child_resizable Bool
    @export_function Paned set_end_child_shrinkable! Cvoid Bool b
    @export_function Paned get_end_child_shrinkable Bool

    set_end_child!(paned::Paned, child::Widget) = detail.set_end_child!(paned._internal, as_widget_pointer(child))
    export set_end_child!

    @export_function Paned remove_end_child! Cvoid

    Base.show(io::IO, x::Paned) = show_aux(io, x, :start_child_resizable, :start_child_shrinkable, :end_child_resizable, :end_child_shrinkable)

###### progress_bar.jl

    @export_type ProgressBar Widget
    @declare_native_widget ProgressBar

    ProgressBar() = ProgressBar(detail._ProgressBar())

    @export_function ProgressBar pulse Cvoid
    @export_function ProgressBar set_fraction! Cvoid AbstractFloat => Cfloat zero_to_one
    @export_function ProgressBar get_fraction Cfloat
    @export_function ProgressBar set_is_inverted! Cvoid Bool b
    @export_function ProgressBar get_is_inverted Bool
    @export_function ProgressBar set_text! Cvoid String text
    @export_function ProgressBar get_text String
    @export_function ProgressBar set_show_text! Cvoid Bool b
    @export_function ProgressBar get_show_text Bool
    @export_function ProgressBar set_orientation! Cvoid Orientation orientation
    @export_function ProgressBar get_orientation Orientation

    Base.show(io::IO, x::ProgressBar) = show_aux(io, x, :fraction, :orientation, :show_text, :text)

###### spinner.jl

    @export_type Spinner Widget
    @declare_native_widget Spinner

    Spinner() = Spinner(detail._Spinner())

    @export_function Spinner set_is_spinning! Cvoid Bool b
    @export_function Spinner get_is_spinning Bool
    @export_function Spinner start! Cvoid
    @export_function Spinner stop! Cvoid

    Base.show(io::IO, x::Spinner) = show_aux(io, x)

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
    @declare_native_widget Revealer

    Revealer(transition_type::RevealerTransitionType = REVEALER_TRANSITION_TYPE_CROSSFADE) = Revealer(detail._Revealer(transition_type))
    function Revealer(widget::Widget, transition_type::RevealerTransitionType = REVEALER_TRANSITION_TYPE_CROSSFADE) :: Revealer
        out = Revealer(transition_type)
        set_child!(out, widget)
        return out
    end

    set_child!(revealer::Revealer, child::Widget) = detail.set_child!(revealer._internal, as_widget_pointer(child))
    export set_child!

    @export_function Revealer remove_child! Cvoid
    @export_function Revealer set_is_revealed! Cvoid Bool child_visible
    @export_function Revealer get_is_revealed Bool
    @export_function Revealer set_transition_type! Cvoid RevealerTransitionType type
    @export_function Revealer get_transition_type RevealerTransitionType

    set_transition_duration!(revealer::Revealer, duration::Time) = detail.set_transition_duration!(revealer._internal, as_microseconds(duration))
    export set_transition_duration!

    get_transition_duration(revealer::Revealer) ::Time = microseconds(detail.get_transition_duration(revealer._internal))
    export get_transition_duration

    @add_widget_signals Revealer
    @add_signal_revealed Revealer

    Base.show(io::IO, x::Revealer) = show_aux(io, x, :is_revealed, :transition_type)

###### action_bar.jl

    @export_type ActionBar Widget
    @declare_native_widget ActionBar

    function push_back!(action_bar::ActionBar, widget::Widget)
        detail.push_back!(action_bar._internal, as_widget_pointer(widget))
    end
    export push_back!

    function push_front!(action_bar::ActionBar, widget::Widget)
        detail.push_front!(action_bar._internal, as_widget_pointer(widget))
    end
    export push_front!

    function set_center_widget(action_bar::ActionBar, widget::Widget)
        detail.set_center_widget!(action_bar._internal, as_widget_pointer(widget))
    end
    export insert_after!

    function remove!(action_bar::ActionBar, widget::Widget)
        detail.remove!(action_bar._internal, as_widget_pointer(widget))
    end
    export remove!

    @export_function ActionBar remove_center_child! Cvoid
    @export_function ActionBar set_is_revealed! Cvoid Bool b
    @export_function ActionBar get_is_revealed Bool

    @add_widget_signals ActionBar

    Base.show(io::IO, x::ActionBar) = show_aux(io, x, :is_revealed)

###### scale.jl

    @export_type Scale Widget
    @declare_native_widget Scale

    function Scale(lower::Number, upper::Number, step_increment::Number, orientation::Orientation = ORIENTATION_HORIZONTAL)
        return Scale(detail._Scale(
            convert(Cfloat, lower),
            convert(Cfloat, upper),
            convert(Cfloat, step_increment),
            orientation
        ))
    end

    get_adjustment(scale::Scale) ::Adjustment = Adjustment(detail.get_adjustment(scale._internal))
    export get_adjustment

    @export_function Scale get_lower Cfloat
    @export_function Scale get_upper Cfloat
    @export_function Scale get_step_increment Cfloat
    @export_function Scale get_value Cfloat

    @export_function Scale set_lower! Cvoid Number => Cfloat value
    @export_function Scale set_upper! Cvoid Number => Cfloat value
    @export_function Scale set_step_increment! Cvoid Number => Cfloat value
    @export_function Scale set_value! Cvoid Number => Cfloat value

    @export_function Scale set_should_draw_value! Cvoid Bool b
    @export_function Scale get_should_draw_value Bool
    @export_function Scale set_has_origin! Cvoid Bool b
    @export_function Scale get_has_origin Bool
    @export_function Scale set_orientation! Cvoid Orientation orientation
    @export_function Scale get_orientation Orientation

    function add_mark!(scale::Scale, value::Number, position::RelativePosition, label::String = "")
        detail.add_mark!(scale._internal, convert(Cfloat, value), position, label)
    end
    export add_mark!

    @export_function Scale clear_marks! Cvoid

    @add_widget_signals Scale
    @add_signal_value_changed Scale

    Base.show(io::IO, x::Scale) = show_aux(io, x, :value, :lower, :upper, :step_increment)

###### spin_button.jl

    @export_type SpinButton Widget
    @declare_native_widget SpinButton

    function SpinButton(lower::Number, upper::Number, step_increment::Number, orientation::Orientation = ORIENTATION_HORIZONTAL)
        return SpinButton(detail._SpinButton(
            convert(Cfloat, lower),
            convert(Cfloat, upper),
            convert(Cfloat, step_increment),
            orientation
        ))
    end

    get_adjustment(spin_button::SpinButton) ::Adjustment = Adjustment(detail.get_adjustment(spin_button._internal))
    export get_adjustment

    @export_function SpinButton get_lower Cfloat
    @export_function SpinButton get_upper Cfloat
    @export_function SpinButton get_step_increment Cfloat
    @export_function SpinButton get_value Cfloat

    @export_function SpinButton set_lower! Cvoid Number => Cfloat value
    @export_function SpinButton set_upper! Cvoid Number => Cfloat value
    @export_function SpinButton set_step_increment! Cvoid Number => Cfloat value
    @export_function SpinButton set_value! Cvoid Number => Cfloat value

    @export_function SpinButton set_n_digits! Cvoid Integer n
    @export_function SpinButton get_n_digits Int64
    @export_function SpinButton set_should_wrap! Cvoid Bool b
    @export_function SpinButton get_should_wrap Bool
    @export_function SpinButton set_acceleration_rate! Cvoid Number => Cfloat factor
    @export_function SpinButton get_acceleration_rate Cfloat
    @export_function SpinButton set_should_snap_to_ticks! Cvoid Bool b
    @export_function SpinButton get_should_snap_to_ticks Bool
    @export_function SpinButton set_allow_only_numeric! Cvoid Bool b
    @export_function SpinButton get_allow_only_numeric Bool
    @export_function SpinButton set_orientation! Cvoid Orientation orientation
    @export_function SpinButton get_orientation Orientation

    function set_text_to_value_function!(f, spin_button::SpinButton, data::Data_t) where Data_t
        set_allow_only_numeric!(spin_button, false)
        typed_f = TypedFunction(f, AbstractFloat, (SpinButton, String, Data_t))
        detail.set_text_to_value_function!(spin_button._internal, function (spin_button_ref, text::String)
            return typed_f(SpinButton(spin_button_ref[]), text, data)
        end)
    end
    function set_text_to_value_function!(f, spin_button::SpinButton)
        set_allow_only_numeric!(spin_button, false)
        typed_f = TypedFunction(f, AbstractFloat, (SpinButton, String))
        detail.set_text_to_value_function!(spin_button._internal, function (spin_button_ref, text::String)
            return typed_f(SpinButton(spin_button_ref[]), text)
        end)
    end
    export set_text_to_value_function!

    @export_function SpinButton reset_value_to_text_function! Cvoid

    function set_value_to_text_function!(f, spin_button::SpinButton, data::Data_t) where Data_t
        set_allow_only_numeric!(spin_button, false)
        typed_f = TypedFunction(f, String, (SpinButton, AbstractFloat, Data_t))
        detail.set_value_to_text_function!(spin_button._internal, function (spin_button_ref, value::Cfloat)
            return typed_f(SpinButton(spin_button_ref[]), value, data)
        end)
    end
    function set_value_to_text_function!(f, spin_button::SpinButton)
        set_allow_only_numeric!(spin_button, false)
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

    Base.show(io::IO, x::SpinButton) = show_aux(io, x, :value, :lower, :upper, :step_increment, :orientation)

###### scrollbar.jl

    @export_type Scrollbar Widget
    @declare_native_widget Scrollbar

    Scrollbar(orientation::Orientation, adjustment::Adjustment) = Scrollbar(detail._Scrollbar(orientation, adjustment._internal))

    get_adjustment(scrollbar::Scrollbar) ::Adjustment = Adjustment(detail.get_adjustment(scrollbar._internal))
    export get_adjustment

    @export_function Scrollbar set_orientation! Cvoid Orientation orientation
    @export_function Scrollbar get_orientation Orientation

    @add_widget_signals Scrollbar
    Base.show(io::IO, x::Scrollbar) = show_aux(io, x, :orientation, :adjustment)

###### separator.jl

    @export_type Separator Widget
    @declare_native_widget Separator

    Separator(orientation::Orientation = ORIENTATION_HORIZONTAL; opacity = 1.0) = Separator(detail._Separator(orientation))

    @export_function Separator set_orientation! Cvoid Orientation orientation
    @export_function Separator get_orientation Orientation

    @add_widget_signals Separator
    Base.show(io::IO, x::Separator) = show_aux(io, x)

####### frame_clock.jl

    @export_type FrameClock SignalEmitter
    FrameClock(internal::Ptr{Cvoid}) = FrameClock(detail._FrameClock(internal))

    get_time_since_last_frame(frame_clock::FrameClock) ::Time = microseconds(detail.get_time_since_last_frame(frame_clock._internal))
    export get_time_since_last_frame

    get_target_frame_duration(frame_clock::FrameClock) ::Time = microseconds(detail.get_target_frame_duration(frame_clock._internal))
    export get_target_frame_duration

    @add_signal_update FrameClock
    @add_signal_paint FrameClock

    Base.show(io::IO, x::FrameClock) = show_aux(io, x, :time_since_last_frame)

####### widget.jl

    function as_widget_pointer(widget::Widget)
        as_native::Widget = widget
        seen = Set{Type}()
        while !is_native_widget(as_native)
            if typeof(as_native) in seen
                detail.log_critical("In as_widget_pointer: Type `$(typeof(as_native))`` has a malformed `as_widget` definition, this usually means `get_top_level_widget(x)` returns x itself, as opposed to the top-level widget component of x.", MOUSETRAP_DOMAIN)
                return Separator(opacity = 0.0)._internal.cpp_object # return placeholder to prevent segfault
            else
                push!(seen, typeof(as_native))
            end
            as_native = get_top_level_widget(as_native)
        end
        return as_native._internal.cpp_object
    end
    # no export

    macro export_widget_function(name, return_t)

        return_t = esc(return_t)

        Mousetrap.eval(:(export $name))
        return :(function $name(widget::Widget)
            return Base.convert($return_t, detail.$name(as_widget_pointer(widget)))
        end)
        return out
    end

    macro export_widget_function(name, return_t, arg1_type, arg1_name)

        return_t = esc(return_t)

        if arg1_type isa Expr
            arg1_origin_type = arg1_type.args[2]
            arg1_destination_type = arg1_type.args[3]
        else
            arg1_origin_type = arg1_type
            arg1_destination_type = arg1_type
        end
        arg1_name = esc(arg1_name)

        Mousetrap.eval(:(export $name))
        out = Expr(:toplevel)
        return :(function $name(widget::Widget, $arg1_name::$arg1_origin_type)
            return Base.convert($return_t, detail.$name(as_widget_pointer(widget), convert($arg1_destination_type, $arg1_name)))
        end)
        return out
    end

    @export_enum TickCallbackResult begin
        TICK_CALLBACK_RESULT_CONTINUE
        TICK_CALLBACK_RESULT_DISCONTINUE
    end

    @export_widget_function activate! Cvoid
    @export_widget_function set_size_request! Cvoid Vector2f size
    @export_widget_function get_size_request Vector2f

    @export_widget_function set_margin_top! Cvoid Number => Cfloat margin
    @export_widget_function get_margin_top Cfloat
    @export_widget_function set_margin_bottom! Cvoid Number => Cfloat margin
    @export_widget_function get_margin_bottom Cfloat
    @export_widget_function set_margin_start! Cvoid Number => Cfloat margin
    @export_widget_function get_margin_start Cfloat
    @export_widget_function set_margin_end! Cvoid Number => Cfloat margin
    @export_widget_function get_margin_end Cfloat
    @export_widget_function set_margin_horizontal! Cvoid Number => Cfloat margin
    @export_widget_function set_margin_vertical! Cvoid Number => Cfloat margin
    @export_widget_function set_margin! Cvoid Number => Cfloat margin

    @export_widget_function set_expand_horizontally! Cvoid Bool b
    @export_widget_function get_expand_horizontally Bool
    @export_widget_function set_expand_vertically! Cvoid Bool b
    @export_widget_function get_expand_vertically Bool
    @export_widget_function set_expand! Cvoid Bool b

    @export_widget_function set_horizontal_alignment! Cvoid Alignment alignment
    @export_widget_function get_horizontal_alignment Alignment
    @export_widget_function set_vertical_alignment! Cvoid Alignment alignment
    @export_widget_function get_vertical_alignment Alignment
    @export_widget_function set_alignment! Cvoid Alignment both

    @export_widget_function set_opacity! Cvoid Number => Cfloat opacity
    @export_widget_function get_opacity Cfloat
    @export_widget_function set_is_visible! Cvoid Bool b
    @export_widget_function get_is_visible Bool

    @export_widget_function set_tooltip_text! Cvoid String text

    set_tooltip_widget!(widget::Widget, tooltip::Widget) = detail.set_tooltip_widget!(as_widget_pointer(widget), as_widget_pointer(tooltip))
    export set_tooltip_widget!

    @export_widget_function remove_tooltip_widget! Cvoid

    @export_widget_function set_cursor! Cvoid CursorType cursor

    function set_cursor_from_image!(widget::Widget, image::Image, offset::Vector2i = Vector2i(0, 0))
        detail.set_cursor_from_image!(as_widget_pointer(widget), image._internal, offset.x, offset.y)
    end
    export set_cursor_from_image!

    @export_widget_function hide! Cvoid
    @export_widget_function show! Cvoid

    function add_controller!(widget::Widget, controller::EventController)
        detail.add_controller!(as_widget_pointer(widget), controller._internal.cpp_object)
    end
    export add_controller!

    function remove_controller!(widget::Widget, controller::EventController)
        detail.remove_controller!(as_widget_pointer(widget), controller._internal.cpp_object)
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
    @export_widget_function calculate_monitor_dpi Cfloat
    @export_widget_function get_scale_factor Cfloat

    @export_widget_function unparent! Cvoid

    @export_widget_function set_hide_on_overflow! Cvoid Bool b
    @export_widget_function get_hide_on_overflow Bool

    function set_tick_callback!(f, widget::Widget, data::Data_t) where Data_t
        typed_f = TypedFunction(f, TickCallbackResult, (FrameClock, Data_t))
        detail.set_tick_callback!(as_widget_pointer(widget), function(frame_clock_ref)
            typed_f(FrameClock(frame_clock_ref[]), data)
        end)
    end
    function set_tick_callback!(f, widget::Widget)
        typed_f = TypedFunction(f, TickCallbackResult, (FrameClock,))
        detail.set_tick_callback!(as_widget_pointer(widget), function(frame_clock_ref)
            typed_f(FrameClock(frame_clock_ref[]))
        end)
    end
    export set_tick_callback!

    @export_widget_function remove_tick_callback! Cvoid

    function set_listens_for_shortcut_action!(widget::Widget, action::Action) ::Cvoid
        detail.set_listens_for_shortcut_action!(as_widget_pointer(widget), action._internal)
    end
    export set_listens_for_shortcut_action!

    Base.hash(x::Widget) = UInt64(Mousetrap.detail.as_native_widget(Mousetrap.as_widget_pointer(x)))

####### clipboard.jl

    @export_type Clipboard SignalEmitter

    function Clipboard(internal::Ptr{Cvoid})
        out = Clipboard(detail._Clipboard(internal))
    end

    @export_function Clipboard get_is_local Bool
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
        typed_f = TypedFunction(f, Cvoid, (Clipboard, String))
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
            typed_f(Clipboard(internal_ref[]), Image(image_ref[], data))
        end)
    end
    function get_image(f, clipboard::Clipboard)
        typed_f = TypedFunction(f, Cvoid, (Clipboard, Image))
        detail.get_image(clipboard._internal, function(internal_ref, image_ref)
            typed_f(Clipboard(internal_ref[]), Image(image_ref[]))
        end)
    end
    export get_image

    @export_function Clipboard contains_file Bool

    set_file!(clipboard::Clipboard, file::FileDescriptor) = detail.set_file!(clipboard._internal, file._internal)
    export set_file!

    get_clipboard(widget::Widget) ::Clipboard = Clipboard(detail.get_clipboard(as_widget_pointer(widget)))
    export get_clipboard

    Base.show(io::IO, x::Clipboard) = show_aux(io, x)

### opengl_common.jl

    macro define_opengl_error_type(name)
        message =  "In Mousetrap::$name(): `$name` cannot be instantiated, because the Mousetrap OpenGL component is disabled for MacOS. It and any function operating on it cannot be used in any way.\n\nSee the manual chapter on native rendering for more information."
        return :(struct $name
            function $name()
                Mousetrap.log_fatal(Mousetrap.MOUSETRAP_DOMAIN, $message)
                return new()
            end
        end)
    end

@static if MOUSETRAP_ENABLE_OPENGL_COMPONENT

####### blend_mode.jl

    @export_enum BlendMode begin
        BLEND_MODE_NONE
        BLEND_MODE_NORMAL
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
    function Base.setindex!(transform::GLTransform, x::Integer, y::Integer, value::Number)
        if x == 0 || x > 4 || y == 0 || y > 4
            throw(BoundsError(transform, (x, y)))
        end

        detail.setindex!(transform._internal, from_julia_index(x), from_julia_index(y), convert(Float32, value))
    end

    import Base.getindex
    function Base.getindex(transform::GLTransform, x::Integer, y::Integer) ::Cfloat
        if x == 0 || x > 4 || y == 0 || y > 4
            throw(BoundsError(transform, (x, y)))
        end

        return detail.getindex(transform._internal, from_julia_index(x), from_julia_index(y))
    end

    apply_to(transform::GLTransform, v::Vector2f) ::Vector2f = detail.apply_to_2f(transform, v.x, v.y)
    apply_to(transform::GLTransform, v::Vector3f) ::Vector3f = detail.apply_to_3f(transform, v.x, v.y, v.z)
    export apply_to

    combine_with(self::GLTransform, other::GLTransform) = GLTransform(detail.combine_with(self._internal, other._internal))
    export combine_with

    function rotate!(transform::GLTransform, angle::Angle, origin::Vector2f = Vector2f(0, 0))
        detail.rotate!(transform._internal, convert(Float32, as_radians(angle)), origin.x, origin.y)
    end
    export rotate!

    function translate!(transform::GLTransform, offset::Vector2f)
        detail.translate!(transform._internal, offset.x, offset.y)
    end
    export translate!

    function scale!(transform::GLTransform, x_scale::AbstractFloat, y_scale::AbstractFloat)
        detail.scale!(transform._internal, convert(Float32, x_scale), convert(Float32, y_scale))
    end
    export scale!

    @export_function GLTransform reset! Cvoid

    function Base.:(==)(a::GLTransform, b::GLTransform)
        for i in 1:4
            for j in 1:4
                if a[i, j] != b[i, j]
                    return false
                end
            end
        end
        return true
    end

    Base.:(!=)(a::GLTransform, b::GLTransform) = !(a == b)
    Base.show(io::IO, x::GLTransform) = show_aux(io, x)

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

    function create_from_string!(shader::Shader, type::ShaderType, glsl_code::String) ::Bool
        return detail.create_from_string!(shader._internal, type, glsl_code)
    end
    export create_from_string!

    function create_from_file!(shader::Shader, type::ShaderType, path::String) ::Bool
        return detail.create_from_file!(shader._internal, type, path)
    end
    export create_from_file!

    @export_function Shader get_uniform_location Cint String name

    @export_function Shader set_uniform_float! Cvoid String name Cfloat float
    @export_function Shader set_uniform_int! Cvoid String name Cint float
    @export_function Shader set_uniform_uint! Cvoid String name Cuint float

    set_uniform_vec2!(shader::Shader, name::String, vec2::Vector2f) = detail.set_uniform_vec2!(shader._internal, name, vec2)
    export set_uniform_vec2!

    set_uniform_vec3!(shader::Shader, name::String, vec3::Vector3f) = detail.set_uniform_vec3!(shader._internal, name, vec3)
    export set_uniform_vec3!

    set_uniform_vec4!(shader::Shader, name::String, vec4::Vector4f) = detail.set_uniform_vec4!(shader._internal, name, vec4)
    export set_uniform_vec4!

    set_uniform_transform!(shader::Shader, name::String, transform::GLTransform) = detail.set_uniform_transform!(shader._internal, name, transform._internal)
    export set_uniform_transform!

    get_vertex_position_location() = detail.shader_get_vertex_position_location()
    export get_vertex_position_location

    get_vertex_color_location() = detail.shader_get_vertex_color_location()
    export get_vertex_color_location

    get_vertex_texture_coordinate_location() = detail.shader_get_vertex_texture_coordinate_location()
    export get_vertex_texture_coordinate_location

    Base.show(io::IO, x::Shader) = show_aux(io, x)

###### texture.jl

    abstract type TextureObject <: SignalEmitter end
    export TextureObject

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

    create!(texture::TextureObject, width::Integer, height::Integer) = detail.texture_create!(texture._internal.cpp_object, width, height)
    export create!

    create_from_image!(texture::TextureObject, image::Image) = detail.texture_create_from_image!(texture._internal.cpp_object, image._internal)
    export create_from_image!

    set_wrap_mode!(texture::TextureObject, mode::TextureWrapMode) = detail.texture_set_wrap_mode!(texture._internal.cpp_object, mode)
    export set_wrap_mode!

    set_scale_mode!(texture::TextureObject, mode::TextureScaleMode) = detail.texture_set_scale_mode!(texture._internal.cpp_object, mode)
    export set_scale_mode!

    get_wrap_mode(texture::TextureObject) ::TextureWrapMode = detail.texture_get_wrap_mode(texture._internal.cpp_object)
    export get_wrap_mode

    get_scale_mode(texture::TextureObject) ::TextureScaleMode = detail.texture_get_scale_mode(texture._internal.cpp_object)
    export get_scale_mode

    get_size(texture::TextureObject) ::Vector2i = detail.texture_get_size(texture._internal.cpp_object)
    export get_size

    get_native_handle(texture::TextureObject) ::Cuint = detail.texture_get_native_handle(texture._internal.cpp_object)
    export get_native_handle

    bind_as_render_target(render_texture::RenderTexture) = detail.render_texture_bind_as_render_target(render_texture._internal.cpp_object)
    export bind_as_render_target

    unbind_as_render_target(render_texture::RenderTexture) = detail.render_texture_unbind_as_render_target(render_texture._internal.cpp_object)
    export unbind_as_render_target

    Base.show(io::IO, x::TextureObject) = show_aux(io, x, :native_handle)

###### shape.jl

    @export_type Shape SignalEmitter
    Shape() = Shape(detail._Shape())

    @export_function Shape get_native_handle Cuint

    as_point!(shape::Shape, position::Vector2f) = detail.as_point!(shape._internal, position)
    export as_point!

    function Point(position::Vector2f) ::Shape
        out = Shape()
        as_point!(out, position)
        return out
    end
    export Point

    function as_points!(shape::Shape, positions::Vector{Vector2f})
        if isempty(positions)
            @log_critical MOUSETRAP_DOMAIN "In as_points!: Vector `positions` is empty."
        end

        return detail.as_points!(shape._internal, positions)
    end
    export as_points!

    function Points(positions::Vector{Vector2f}) ::Shape
        out = Shape()
        as_points!(out, positions)
        return out
    end
    export Points

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

    as_circle!(shape::Shape, center::Vector2f, radius::Number, n_outer_vertices::Integer) = detail.as_circle!(shape._internal, center, convert(Cfloat, radius), n_outer_vertices)
    export as_circle!

    function Circle(center::Vector2f, radius::Number, n_outer_vertices::Integer) ::Shape
        out = Shape()
        as_circle!(out, center, radius, n_outer_vertices)
        return out
    end
    export Circle

    as_ellipse!(shape::Shape, center::Vector2f, x_radius::Number, y_radius::Number, n_outer_vertices::Integer) = detail.as_ellipse!(shape._internal, center, convert(Cfloat, x_radius), convert(Cfloat, y_radius), n_outer_vertices)
    export as_ellipse!

    function Ellipse(center::Vector2f, x_radius::Number, y_radius::Number, n_outer_vertices::Integer) ::Shape
        out = Shape()
        as_ellipse!(out, center, x_radius, y_radius, n_outer_vertices)
        return out
    end
    export Ellipse

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
    export Lines

    as_line_strip!(shape::Shape, points::Vector{Vector2f}) = detail.as_line_strip!(shape._internal, points)
    export as_line_strip!

    function LineStrip(points::Vector{Vector2f})
        out = Shape()
        as_line_strip!(out, points)
        return out
    end
    export LineStrip

    as_polygon!(shape::Shape, points::Vector{Vector2f}) = detail.as_polygon!(shape._internal, points)
    export as_polygon!

    function Polygon(points::Vector{Vector2f})
        out = Shape()
        as_polygon!(out, points)
        return out
    end
    export Polygon

    function as_rectangular_frame!(shape::Shape, top_left::Vector2f, outer_size::Vector2f, x_width::Number, y_width::Number)
        detail.as_rectangular_frame!(shape._internal, top_left, outer_size, convert(Cfloat, x_width), convert(Cfloat, y_width))
    end
    export as_rectangular_frame!

    function RectangularFrame(top_left::Vector2f, outer_size::Vector2f, x_width::Number, y_width::Number)
        out = Shape()
        as_rectangular_frame!(out, top_left, outer_size, x_width, y_width)
        return out
    end
    export RectangularFrame

    function as_circular_ring!(shape::Shape, center::Vector2f, outer_radius::Number, thickness::Number, n_outer_vertices::Integer)
        detail.as_circular_ring!(shape._internal, center, convert(Cfloat, outer_radius), convert(Cfloat, thickness), n_outer_vertices)
    end
    export as_circular_ring!

    function CircularRing(center::Vector2f, outer_radius::Number, thickness::Number, n_outer_vertices::Integer)
        out = Shape()
        as_circular_ring!(out, center, outer_radius, thickness, n_outer_vertices)
        return out
    end
    export CircularRing

    function as_elliptical_ring!(shape::Shape, center::Vector2f, outer_x_radius::Number, outer_y_radius::Number, x_thickness::Number, y_thickness::Number, n_outer_vertices::Integer)
        detail.as_elliptical_ring!(shape._internal, center, convert(Cfloat, outer_x_radius), convert(Cfloat, outer_y_radius), convert(Cfloat, x_thickness), convert(Cfloat, y_thickness), n_outer_vertices)
    end
    export as_elliptical_ring!

    function EllipticalRing(center::Vector2f, outer_x_radius::Number, outer_y_radius::Number, x_thickness::Number, y_thickness::Number, n_outer_vertices::Integer) ::Shape
        out = Shape()
        as_elliptical_ring!(out, center, outer_x_radius, outer_y_radius, x_thickness, y_thickness, n_outer_vertices)
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

    function get_vertex_color(shape::Shape, index::Integer) ::RGBA
        return detail.get_vertex_color(shape._internal, from_julia_index(index))
    end
    export get_vertex_color

    function set_vertex_color!(shape::Shape, index::Integer, color::RGBA)
        detail.set_vertex_color!(shape._internal, from_julia_index(index), color)
    end
    export set_vertex_color!

    function get_vertex_texture_coordinate(shape::Shape, index::Integer) ::Vector2f
        return detail.get_vertex_texture_coordinate(shape._internal, from_julia_index(index))
    end
    export get_vertex_texture_coordinate

    function set_vertex_texture_coordinate!(shape::Shape, index::Integer, coordinate::Vector2f)
        detail.set_vertex_texture_coordinate!(shape._internal, from_julia_index(index), coordinate)
    end
    export set_vertex_texture_coordinate!

    function get_vertex_position(shape::Shape, index::Integer) ::Vector3f
        detail.get_vertex_position(shape._internal, from_julia_index(index))
    end
    export get_vertex_position

    function set_vertex_position!(shape::Shape, index::Integer, coordinate::Vector3f)
        detail.set_vertex_position!(shape._internal, from_julia_index(index), coordinate)
    end
    export set_vertex_position!

    @export_function Shape get_n_vertices Int64

    @export_function Shape set_is_visible! Cvoid Bool b
    @export_function Shape get_is_visible Bool

    struct AxisAlignedRectangle
        top_left::Vector2f
        size::Vector2f
    end
    export AxisAlignedRectangle

    @export_function Shape get_bounding_box AxisAlignedRectangle
    @export_function Shape get_size Vector2f

    @export_function Shape set_centroid! Cvoid Vector2f centroid
    @export_function Shape get_centroid Vector2f
    @export_function Shape set_top_left! Cvoid Vector2f top_left
    @export_function Shape get_top_left Vector2f

    function rotate!(shape::Shape, angle::Angle, origin::Vector2f = Vector2f(0, 0))
        detail.rotate!(shape._internal, convert(Cfloat, as_radians(angle)), origin.x, origin.y)
    end
    export rotate!

    set_texture!(shape::Shape, texture::TextureObject) = detail.set_texture!(shape._internal, texture._internal.cpp_object)
    export set_texture!

    remove_texture!(shape::Shape) = detail.set_texture!(shape._internal, Ptr{Cvoid}())
    export remove_texture!

    set_color!(shape::Shape, color::RGBA) = detail.set_color!(shape._internal, color)
    set_color!(shape::Shape, color::HSVA) = detail.set_color!(shape._internal, hsva_to_rgba(color))
    export set_color!

    Base.show(io::IO, x::Shape) = show_aux(io, x, :native_handle)

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

    set_uniform_rgba!(task::RenderTask, name::String, rgba::RGBA) = detail.set_uniform_rgba!(task._internal, name, rgba)
    export set_uniform_rgba!

    get_uniform_rgba(task::RenderTask, name::String) ::RGBA = detail.get_uniform_rgba(task._internal, name)
    export get_uniform_rgba

    set_uniform_hsva!(task::RenderTask, name::String, hsva::HSVA) = detail.set_uniform_hsva!(task._internal, name, hsva)
    export set_uniform_hsva!

    get_uniform_hsva(task::RenderTask, name::String) ::HSVA = detail.get_uniform_hsva(task._internal, name)
    export get_uniform_hsva

    set_uniform_transform!(task::RenderTask, name::String, transform::GLTransform) = detail.set_uniform_transform!(task._internal, name, transform._internal)
    export set_uniform_transform!

    get_uniform_transform(task::RenderTask, name::String) ::GLTransform = GLTransform(detail.get_uniform_transform(task._internal, name))
    export get_uniform_transform

    Base.show(io::IO, x::RenderTask) = show_aux(io, x)

###### render_area.jl

    @export_enum AntiAliasingQuality begin
        ANTI_ALIASING_QUALITY_OFF
        ANTI_ALIASING_QUALITY_MINIMAL
        ANTI_ALIASING_QUALITY_GOOD
        ANTI_ALIASING_QUALITY_BETTER
        ANTI_ALIASING_QUALITY_BEST
    end

    @export_type RenderArea Widget
    @declare_native_widget RenderArea

    RenderArea(msaa_quality::AntiAliasingQuality = ANTI_ALIASING_QUALITY_OFF) = RenderArea(detail._RenderArea(msaa_quality))

    add_render_task!(area::RenderArea, task::RenderTask) = detail.add_render_task!(area._internal, task._internal)
    export add_render_task!

    @export_function RenderArea clear_render_tasks! Cvoid

    @export_function RenderArea make_current Cvoid
    @export_function RenderArea queue_render Cvoid
    @export_function RenderArea clear Cvoid
    @export_function RenderArea render_render_tasks Cvoid
    @export_function RenderArea flush Cvoid

    function from_gl_coordinates(area::RenderArea, gl_coordinates::Vector2f) ::Vector2f
        return detail.from_gl_coordinates(area._internal, gl_coordinates)
    end
    export from_gl_coordinates

    function to_gl_coordinates(area::RenderArea, absolute_widget_space_coordinates::Vector2f) ::Vector2f
        return detail.to_gl_coordinates(area._internal, absolute_widget_space_coordinates)
    end
    export to_gl_coordinates

    @add_widget_signals RenderArea
    @add_signal_resize RenderArea
    @add_signal_render RenderArea

    Base.show(io::IO, x::RenderArea) = show_aux(io, x)

else # if MOUSETRAP_ENABLE_OPENGL_COMPONENT

    @define_opengl_error_type BlendMode
    export BlendMode

    @define_opengl_error_type GLTransform
    export GLTransform

    @define_opengl_error_type Shape
    export Shape

    @define_opengl_error_type Shader
    export Shader

    @define_opengl_error_type ShaderType
    export ShaderType

    @define_opengl_error_type TextureWrapMode
    export TextureWrapMode

    @define_opengl_error_type TextureScaleMode
    export TextureScaleMode

    @define_opengl_error_type Texture
    export Texture

    @define_opengl_error_type RenderTexture
    export RenderTexture

    @define_opengl_error_type RenderTask
    export RenderTask

    @define_opengl_error_type RenderArea
    export RenderArea

end # else MOUSETRAP_ENABLE_OPENGL_COMPONENT

###### animation.jl

    @export_enum AnimationState begin
        ANIMATION_STATE_IDLE
        ANIMATION_STATE_PAUSED
        ANIMATION_STATE_PLAYING
        ANIMATION_STATE_DONE
    end

    @export_enum AnimationTimingFunction begin
        ANIMATION_TIMING_FUNCTION_LINEAR
        ANIMATION_TIMING_FUNCTION_EXPONENTIAL_EASE_IN
        ANIMATION_TIMING_FUNCTION_EXPONENTIAL_EASE_OUT
        ANIMATION_TIMING_FUNCTION_EXPONENTIAL_SIGMOID
        ANIMATION_TIMING_FUNCTION_SINE_EASE_IN
        ANIMATION_TIMING_FUNCTION_SINE_EASE_OUT
        ANIMATION_TIMING_FUNCTION_SINE_SIGMOID
        ANIMATION_TIMING_FUNCTION_CIRCULAR_EASE_IN
        ANIMATION_TIMING_FUNCTION_CIRCULAR_EASE_OUT
        ANIMATION_TIMING_FUNCTION_CIRCULAR_SIGMOID
        ANIMATION_TIMING_FUNCTION_OVERSHOOT_EASE_IN
        ANIMATION_TIMING_FUNCTION_OVERSHOOT_EASE_OUT
        ANIMATION_TIMING_FUNCTION_OVERSHOOT_SIGMOID
        ANIMATION_TIMING_FUNCTION_ELASTIC_EASE_IN
        ANIMATION_TIMING_FUNCTION_ELASTIC_EASE_OUT
        ANIMATION_TIMING_FUNCTION_ELASTIC_SIGMOID
        ANIMATION_TIMING_FUNCTION_BOUNCE_EASE_IN
        ANIMATION_TIMING_FUNCTION_BOUNCE_EASE_OUT
        ANIMATION_TIMING_FUNCTION_BOUNCE_SIGMOID
    end

    @export_type Animation SignalEmitter
    function Animation(target::Widget, duration::Time)
        return Animation(detail._Animation(as_widget_pointer(target), convert(Float32, as_microseconds(duration))))
    end

    @export_function Animation get_state AnimationState
    @export_function Animation play! Cvoid
    @export_function Animation pause! Cvoid
    @export_function Animation reset! Cvoid

    set_duration!(animation::Animation, duration::Time) = detail.set_duration(animation._internal, as_microseconds(duration))
    export set_duration!

    get_duration(animation::Animation) ::Time = microseconds(detail.get_duration(animation._internal))
    export get_duration

    @export_function Animation set_lower! Cvoid Number => Cdouble lower
    @export_function Animation get_lower Cdouble
    @export_function Animation set_upper! Cvoid Number => Cdouble upper
    @export_function Animation get_upper Cdouble
    @export_function Animation get_value Cdouble

    @export_function Animation get_repeat_count Csize_t
    @export_function Animation set_repeat_count! Cvoid Integer => Csize_t n

    @export_function Animation get_is_reversed Bool
    @export_function Animation set_is_reversed! Cvoid Bool is_reversed

    @export_function Animation set_timing_function! Cvoid AnimationTimingFunction tweening_mode
    @export_function Animation get_timing_function AnimationTimingFunction

    function on_tick!(f, animation::Animation, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (Animation, AbstractFloat, Data_t))
        detail.on_tick!(animation._internal, function(animation_ref, value::Cdouble )
            typed_f(Animation(animation_ref[]), value, data)
        end)
    end
    function on_tick!(f, animation::Animation)
        typed_f = TypedFunction(f, Cvoid, (Animation, AbstractFloat))
        detail.on_tick!(animation._internal, function(animation_ref, value::Cdouble)
            typed_f(Animation(animation_ref[]), value)
        end)
    end
    export on_tick!

    function on_done!(f, animation::Animation, data::Data_t) where Data_t
        typed_f = TypedFunction(f, Cvoid, (Animation, Data_t))
        detail.on_done!(animation._internal, function(animation_ref)
            typed_f(Animation(animation_ref[]), data)
        end)
    end
    function on_done!(f, animation::Animation)
        typed_f = TypedFunction(f, Cvoid, (Animation,))
        detail.on_done!(animation._internal, function(animation_ref)
            typed_f(Animation(animation_ref[]))
        end)
    end
    export on_done!

    Base.show(io::IO, x::Animation) = show_aux(io, x, :value, :lower, :upper, :state, :timing_function)

###### transform_bin.jl

    @export_type TransformBin Widget
    @declare_native_widget TransformBin

    TransformBin() = TransformBin(detail._TransformBin())
    function TransformBin(child::Widget)
        out = TransformBin()
        set_child!(out, child)
        return out
    end

    set_child!(transform_bin::TransformBin, child::Widget) = detail.set_child!(transform_bin._internal, as_widget_pointer(child))
    export set_child!

    @export_function TransformBin remove_child! Cvoid
    @export_function TransformBin reset! Cvoid

    rotate!(bin::TransformBin, angle::Angle) = detail.rotate!(bin._internal, convert(Float32, as_degrees(angle)))
    export rotate!

    translate!(bin::TransformBin, offset::Vector2f) = detail.translate!(bin._internal, convert(Float32, offset.x), convert(Float32, offset.y))
    export translate!

    @export_function TransformBin scale! Cvoid Number => Cfloat x Number => Cfloat y
    scale!(bin::TransformBin, both::Number) = scale!(bin, both, both)

    @export_function TransformBin skew! Cvoid Number => Cfloat x Number => Cfloat y

    @add_widget_signals TransformBin
    Base.show(io::IO, x::TransformBin) = show_aux(io, x)

###### style.jl

    add_css_class!(widget::Widget, class::String) = detail.add_css_class!(as_widget_pointer(widget), class)
    export add_css_class!

    remove_css_class!(widget::Widget, class::String) = detail.remove_css_class!(as_widget_pointer(widget), class)
    export remove_css_class!

    get_css_classes(widget::Widget) ::Vector{String} = detail.get_css_classes(as_widget_pointer(widget))
    export get_css_classes

    add_css!(code::String) = detail.style_manager_add_css!(code)
    export add_css!

    serialize(color::RGBA) ::String = detail.style_manager_color_to_css_rgba(color.r, color.g, color.b, color.a)
    serialize(color::HSVA) ::String = detail.style_manager_color_to_css_hsva(color.h, color.s, color.v, color.a)
    export serialize

###### gl_canvas.jl

    @export_type GLArea Widget
    @declare_native_widget GLArea

    GLArea() = GLArea(detail._GLArea())

    @add_widget_signals GLArea
    @add_signal_resize GLArea
    @add_signal_render GLArea

    @export_function GLArea make_current Cvoid
    @export_function GLArea queue_render Cvoid
    @export_function GLArea get_auto_render Bool
    @export_function GLArea set_auto_render! Cvoid Bool b

    Base.show(io::IO, x::GLArea) = show_aux(io, x)

###### key_codes.jl

    include("./key_codes.jl")

###### documentation

    include("./docs.jl")

###### compound_widget.jl

    macro define_compound_widget_signals()
        out = Expr(:block)
        for (signal, _) in Mousetrap.signal_descriptors
            connect_signal_name = :connect_signal_ * signal * :!
            push!(out.args, esc(:(
                function Mousetrap.$connect_signal_name(f, x::Widget)
                    if Mousetrap.is_native_widget(x) 
                        log_critical(Mousetrap.MOUSETRAP_DOMAIN, "In " * $(string(connect_signal_name)) * ": object of type `$(typeof(x))` has no signal with ID `" * $(string(signal)) * "`")
                    else
                        $connect_signal_name(f, Mousetrap.get_top_level_widget(x))
                    end
                end
            )))

            push!(out.args, esc(:(
                function Mousetrap.$connect_signal_name(f, x::Widget, data::Data_t) where Data_t
                    if Mousetrap.is_native_widget(x) 
                        log_critical(Mousetrap.MOUSETRAP_DOMAIN, "In " * $(string(connect_signal_name)) * ": object of type `$(typeof(x))` has no signal with ID `" * $(string(signal)) * "`")
                    else
                        $connect_signal_name(f, Mousetrap.get_top_level_widget(x), data)
                    end
                end
            )))

            emit_signal_name = :emit_signal_ * signal

            push!(out.args, esc(:(
                function $emit_signal_name(x::Widget, args...)
                    if Mousetrap.is_native_widget(x) 
                        log_critical(Mousetrap.MOUSETRAP_DOMAIN, "In " * $(string(emit_signal_name)) * ": object of type `$(typeof(x))` has no signal with ID `" * $(string(signal)) * "`")
                    else
                        $emit_signal_name(Mousetrap.get_top_level_widget(x), args)
                    end
                end
            )))

            disconnect_signal_name = :disconnect_signal_ * signal * :!

            push!(out.args, esc(:(
                function $disconnect_signal_name(x::Widget)
                    if Mousetrap.is_native_widget(x) 
                        log_critical(Mousetrap.MOUSETRAP_DOMAIN, "In " * $(string(disconnect_signal_name)) * ": object of type `$(typeof(x))` has no signal with ID `" * $(string(signal)) * "`")
                    else
                        $disconnect_signal_name(Mousetrap.get_top_level_widget(x))
                    end
                end
            )))

            set_signal_blocked_name = :set_signal_ * signal * :_blocked * :!

            push!(out.args, esc(:(
                function $set_signal_blocked_name(x::Widget, b)
                    if Mousetrap.is_native_widget(x) 
                        log_critical(Mousetrap.MOUSETRAP_DOMAIN, "In " * $(string(set_signal_blocked_name)) * ": object of type `$(typeof(x))` has no signal with ID `" * $(string(signal)) * "`")
                    else
                        $set_signal_blocked_name(Mousetrap.get_top_level_widget(x), b)
                    end
                end
            )))

            get_signal_blocked_name = :get_signal_ * signal * :_blocked

            push!(out.args, esc(:(
                function $get_signal_blocked_name(x::Widget)
                    if Mousetrap.is_native_widget(x) 
                        log_critical(Mousetrap.MOUSETRAP_DOMAIN, "In " * $(string(get_signal_blocked_name)) * ": object of type `$(typeof(x))` has no signal with ID `" * $(string(signal)) * "`")
                        return false
                    else
                        return $get_signal_blocked_name(Mousetrap.get_top_level_widget(x))
                    end
                end
            )))
        end
        return out
    end
    @define_compound_widget_signals()

###### internal.jl

    function as_gobject_pointer(x::T) where T <: Union{SignalEmitter, Widget} #::Ptr{Cvoid}
        return Mousetrap.detail.as_gobject(x._internal.cpp_object)
    end

    function as_internal_pointer(x::T) where T <: Union{SignalEmitter, Widget} #::Ptr{Cvoid}
        return Mousetrap.detail.as_internal(x._internal.cpp_object)
    end

    function as_internal_pointer(column::ColumnViewColumn) 
        return @ccall detail.mousetrap_jll.mousetrap._ZNK9mousetrap10ColumnView6Column12get_internalEv(column._internal.cpp_object::Ptr{Cvoid})::Ptr{Cvoid}
    end

    function as_native_widget(x::Widget) 
        return Mousetrap.detail.as_native_widget(Mousetrap.as_widget_pointer(x))
    end
end