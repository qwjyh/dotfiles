#!/usr/bin/julia
project_path = joinpath(homedir(), ".julia", "environments", "nvim-lspconfig")
if !ispath(project_path)
    mkdir(project_path)
    @info "Created $(project_path)"
    touch(joinpath(project_path, "tracecompile.jl"))
end
cmd = `julia --project=$(project_path) $(@__DIR__)/add_dependencies.jl`
@info cmd
run(cmd)

