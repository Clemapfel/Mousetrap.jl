using Documenter

# push!(LOAD_PATH, "../src")
# using mousetrap

const ROW1 = "| id | ad | def |\n"
const ROW2 = "| x | a | f |\n"
const SIGNAL_HEADER = "| a | b | d |\n|---|---|---|\n"



test() = return x
@doc SIGNAL_HEADER * ROW1 * ROW2 test

makedocs(sitename="DOCS")