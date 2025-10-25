# Add dependencies to Language Server project
# TODO: automatically list up necessary packages
using Pkg
@info "project path" Pkg.project().path

# add LanguageServer.jl
Pkg.add("LanguageServer")

# add PackageCompiler.jl
Pkg.add("PackageCompiler")

# add extra dependencies
# these packages are manually collected
pkg_extra = ["Logging", "Sockets", "DataStructures", "Tar", "ArgTools", "Dates", "Downloads", "TOML", "JSONRPC", "SymbolServer", "CSTParser", "StaticLint", "JSON", "JuliaFormatter"]
Pkg.add(pkg_extra)
@info "added dependencies"

# Extra package to be executed in precompiled code
pkg_precompiled = ["Pkg"]

# save pkgs to be used for precompile functions with traced script
out_path = joinpath(Pkg.project().path |> dirname, "precompile_exec_head.jl")
@info "writing $(out_path)"
open(out_path, "w") do io
    println(io, "using LanguageServer")
    println(io, "using " * join(pkg_extra, ", "))
    println(io, "using " * join(pkg_precompiled, ", "))
    println(io, "import FileWatching")
end
@info "finished writing precompile head file"

