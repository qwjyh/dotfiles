# Add dependencies to Language Server project
# TODO: automatically list up necessary packages
using Pkg
@info "project path" Pkg.project().path

# add LanguageServer.jl
Pkg.add("LanguageServer")

# add dependencies of LanguageServer.jl
pkg_ls = Pkg.project().dependencies["LanguageServer"]
pkg_ls_deps = Pkg.dependencies()[pkg_ls].dependencies |> keys
foreach(Pkg.add, pkg_ls_deps)

# add extra dependencies
# these packages are manually collected
pkg_extra = ["Logging", "Sockets", "DataStructures", "Tar", "ArgTools", "Dates", "Downloads"]
foreach(Pkg.add, pkg_extra)
@info "dependency added"

# save pkgs to be used for precompile functions with traced script
out_path = joinpath(Pkg.project().path |> dirname, "precompile_exec_head.jl")
@info "writing $(out_path)"
open(out_path, "w") do io
    println(io, "using LanguageServer")
    println(io, "using " * join(pkg_ls_deps, ", "))
    println(io, "using " * join(pkg_extra, ", "))
end
@info "finished writing precompile head file"

