# dotfiles
my dotfiles

# Environments
- Windows 11
  - pwsh
  - AHK macro
  - wezterm
  - etc
- Arch
  - fish
  - tmux
  - neovim
  - keyboard config(xremap)
  - wezterm
- Ubuntu 22.04 on WSL
  - fish
- Termux

## extra
- qpdfview
- okular

# Installing
## Windows
1. update winget (via MS store)
2. install Git for Windows via winget
3. install pwsh via winget
4. set execution policy
5. install [scoop](https://scoop.sh/) (see scoop website)
6. run `bin/install.ps1`

### note
* manually install lean

## Linux
1. run install.sh

# Neovim

## Julia
### Initial setup
- `./bin/neovim/setup_julials.jl` to set up environment with LanguageServer.jl
<!-- - Edit `init.lua` not to use sysimage and edit some julia code -->
- `./bin/neovim/update_julials.jl` to generate sysimage for faster startup time

Edit `init.lua` to change arguments for julials.

# TODO
- Iron.nvim doesn't work for julia on Windows
- JET.nvim doesn't work on windows
- add rc files of Manjaro
- raspi dotfiles

