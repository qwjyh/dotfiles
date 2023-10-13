#!/usr/bin/julia
project_path = joinpath(homedir(), ".julia", "environments", "nvim-lspconfig")
if !ispath(project_path)
    try
        mkdir(project_path)
        @info "Created $(project_path)"
    catch e
        @error e
        @error dump(e)
        throw(e)
    end
end
cmd = `julia --project=$(project_path) $(@__DIR__)/add_dependencies.jl`
@info cmd
run(cmd)

