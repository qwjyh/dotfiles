# How to manage Julia Language Server
This config use sysimage built with PackageCompiler to make language server starts faster.
Scripts in this directory are for management of the sysimage.

# description
all related process is done in project at `~/.julia/environments/nvim-lspconfig/`.

## install (or minor update of Julia)
```sh
julia ./setup_julials.jl
```
Run Language Server with `--tracecompile` option from any editor.

## update
```sh
julia ./update_julials.sh
```
which updates project, compile sysimage, then do precompile.
To use the sysimage, run Language Server with `-J ~/.julia/environments/nvim-lspconfig/` option.

# effect
Start up got about x3 - x4 faster.
It still takes some time to load packages though.

