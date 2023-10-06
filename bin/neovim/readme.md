# How to manage Julia Language Server
This config use sysimage built with PackageCompiler to make language server startup faster.
Scripts in this directory is for management of sysimage.

# description
all related process is done in project at `~/.julia/environments/nvim-lspconfig/`.

## startup
```sh
$ ./setup_julials.sh
```
which executes `add_dependencies.jl` internally.

## update
```sh
$ ./update_julials.sh
```
which updates project, compile sysimage, then do precompile.

# effect
Start up got about x3 - x4 faster.
It still takes some time to load packages though.

# TODO
- [ ] Not sure all necessary packages are listed in add_dependencies.jl
- [ ] Maybe it's better to set up different sysimages for each projects

