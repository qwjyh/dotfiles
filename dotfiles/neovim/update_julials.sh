#!/usr/bin/bash -x
cd ~/.julia/environments/nvim-lspconfig/ || return 1
julia --project=. -e 'using Pkg; Pkg.update()'
cat precompile_exec_head.jl tracecompile.jl > precompile_exec.jl
julia --project=. -e 'using PackageCompiler; create_sysimage(["LanguageServer"], sysimage_path="sys-ls.so", precompile_execution_file=["precompile_exec.jl"])'
julia --project=. -J sys-ls.so -e 'using Pkg; Pkg.precompile()'

