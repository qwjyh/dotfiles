# Add dependencies to Language Server project
# TODO: automatically list up necessary packages
using Pkg

# add LanguageServer.jl
Pkg.add("LanguageServer")

# add dependencies of LanguageServer.jl
pkg_ls = Pkg.project().dependencies["LanguageServer"]
pkg_ls_deps = Pkg.dependencies()[pkg_ls].dependencies |> keys
foreach(Pkg.add, pkg_ls_deps)

# add extra dependencies
foreach(Pkg.add, ["Logging", "Sockets", "DataStructures"]) # these packages are manually collected

