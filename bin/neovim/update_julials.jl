#!/usr/bin/julia
project_path = joinpath(homedir(), ".julia", "environments", "nvim-lspconfig")
cd(project_path) do
    @info "now at " pwd()
    run(`julia --project=. -e 'using Pkg; Pkg.update()'`)
    # compile_traces = Iterators.filter(eachline("tracecompile.jl")) do line
    #     # Remove anonymous functions from compile trace
    #     !startswith(line, '#') && !occursin(r"\#\d+\#\d+", line) && !occursin(r"\#\#printstyled\#", line)
    # end |> join
    # read("precompile_exec_head.jl", String) * compile_traces |> (b -> write("precompile_exec.jl", b))
    # @info "compiling sysimage..."
    # run(`julia --project=. -e 'using PackageCompiler; create_sysimage(["LanguageServer"], sysimage_path = "sys-ls.so", precompile_execution_file = ["precompile_exec.jl"])'`)
    # @info "post precompile"
    # run(`julia --project=. -J sys-ls.so -e 'using Pkg; Pkg.precompile()'`)
end

