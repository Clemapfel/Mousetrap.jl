const VERSION = "0.3.0"

function get_most_recent_commit(folder::String)
    current = pwd()
    cd(folder)
    io = IOBuffer()
    run(pipeline(`git rev-parse HEAD`; stdout=io, stderr=devnull))
    cd(current)
    return replace(String(take!(io)), "\n" => "")
end

const mousetrap_commit = get_most_recent_commit("../../mousetrap")
const mousetrap_julia_binding_commit = get_most_recent_commit("../../mousetrap_julia_binding")

# if local, files will be written to ~/.julia/dev/mousetrap_jll
const deploy_local = true
println("local : $deploy_local")

if deploy_local
    @info "Deployment: local"
    repo = "local"
end

## Configure

function configure_file(path_in::String, path_out::String)
    file_in = open(path_in, "r")
    file_out = open(path_out, "w+")

    for line in eachline(file_in)
        write(file_out, replace(line,
            "@MOUSETRAP_COMMIT@" => mousetrap_commit,
            "@MOUSETRAP_JULIA_BINDING_COMMIT@" => mousetrap_julia_binding_commit,
            "@VERSION@" => VERSION
        ) * "\n")
    end

    close(file_in)
    close(file_out)
end

@info "Configuring `build_tarballs.jl.in`"
configure_file("./build_tarballs.jl.in", "./build_tarballs.jl")

path = "/home/clem/.julia/dev/mousetrap_jll"
if isfile(path)
    run(`rm -r $path`)
end

run(`julia -t 8 build_tarballs.jl --debug --verbose --deploy=$repo`)
import Pkg; Pkg.develop(path="/home/clem/.julia/dev/mousetrap_jll")