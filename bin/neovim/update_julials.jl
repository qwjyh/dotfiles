#!/usr/bin/julia
project_path = joinpath(homedir(), ".julia", "environments", "nvim-lspconfig")
cd(project_path)
@info "now at " pwd()
run(`julia --project=. -e 'using Pkg; Pkg.update()'`)
read("precompile_exec_head.jl", String) * read("tracecompile.jl", String) |> (b -> write("precompile_exec.jl", b))
@info "compiling sysimage..."
run(`julia --project=. -e 'using PackageCompiler; create_sysimage(["LanguageServer"], sysimage_path = "sys-ls.so", precompile_execution_file = ["precompile_exec.jl"])'`)
@info "post precompile"
run(`julia --project=. -J sys-ls.so -e 'using Pkg; Pkg.precompile()'`)

