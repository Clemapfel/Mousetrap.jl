using Documenter, Pkg

Pkg.activate(".")
using mousetrap

run(`cp docs/docgen.jl docs/build/manual/docgen.jl`)

makedocs(sitename="mousetrap")
