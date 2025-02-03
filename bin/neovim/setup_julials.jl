#!/usr/bin/julia
project_path = joinpath(homedir(), ".julia", "environments", "nvim-lspconfig")
if !ispath(project_path)
    mkdir(project_path)
    @info "Created $(project_path)"
    touch(joinpath(project_path, "tracecompile.jl"))
end

using Pkg
Pkg.activate(project_path)
include("$(@__DIR__)/add_dependencies.jl")

