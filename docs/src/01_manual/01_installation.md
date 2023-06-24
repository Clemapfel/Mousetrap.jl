# Chapter 01: Installation

```@eval
using Latexify
mdtable(["Signal ID", "abc", "def"], ["Signature", "(::Int64) -> Cvoid", "(::Float64, ::Float64) -> Int64"]; latex=false)
```

```@eval
using Latexify
mdtable(
    ["Signal ID", `activate`], 
    ["Signature", "`(::T, arg1::Int64, arg2::Float64, ::Vector{FileDescriptor}) -> Cvoid`"],
    ["`Widget::activate` was called or the widget was otherwise activated", ""]
; latex = false)
```

> **activate**   
> ```
> (::T, arg1::Int64, arg2::Float64, ::Vector{FileDescriptor}) -> Cvoid
> ```
> > ``Widget::activate` was called or the widget was otherwise activated

> **other_id**   
> > ```(::T, ::Vector{FileDescriptor}) -> Cvoid```
> alsdhbalhsdbahsdblsabd
