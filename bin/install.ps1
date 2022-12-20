#!/usr/bin/pwsh
# dotfiles install script for Windows
# Execute
#  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# first to run pwsh scripts

# check administration role
#Requires -RunAsAdministrator

# check pwsh version
# ≧ 7
#Requires -Version 7

# check working directory
if (!(
    (Test-Path bin) -and (Test-Path dotfiles)
  )) {
  Write-Warning -Message "wrong current path
  please execute at repo root"
  exit 1
}

# install powershell modules
Write-Output "posh git"
Install-Module -Name posh-git
Write-Output "Pscx"
Install-Module -Name Pscx -AllowPrerelease
Write-Output "z"
Install-Module -Name ZLocation
Write-Output "PSFzf"
Install-Module -Name PSFzf -RequiredVersion 2.5.10
Write-Output "Latest PSReadLine"
Install-Module -Name PSReadLine -Force  # Override default version to get the latest one
Write-Output "CompletionPredictor"
Install-Module -Name CompletionPredictor
Write-Output "npm"
Install-Module -Name npm-completion



# install scoop
if(!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Output "Installing scoop..."
  irm get.scoop.sh | iex
}
# install basic scoop apps
# import from exported json file
# to update the json file, execute ./bin/windows/scoop_apps/update_scoop_list.ps1
scoop import .\bin\windows\scoop_apps\scoop_minimal_apps.json


# make symbolic links
# neovim
New-Item -ItemType SymbolicLink -Path ~\AppData\Local\nvim\init.lua -Target (Resolve-Path .\dotfiles\neovim\init.lua) -Force
New-Item -ItemType SymbolicLink -Path ~\AppData\Local\nvim\lua\plugins.lua -Target (Resolve-Path .\dotfiles\neovim\lua\plugins.lua) -Force
New-Item -ItemType SymbolicLink -Path ~\AppData\Local\nvim\lua\lualine_setup.lua -Target (Resolve-Path .\dotfiles\neovim\lua\lualine_setup.lua) -Force
New-Item -ItemType SymbolicLink -Path ~\AppData\Local\nvim\lua\lsp_client_config.lua -Target (Resolve-Path .\dotfiles\neovim\lua\lsp_client_config.lua) -Force
# pwsh
New-Item -ItemType SymbolicLink -Path $PROFILE -Target (Resolve-Path .\dotfiles\pwsh\powershell_profile.ps1) -Force
New-Item -ItemType SymbolicLink -Path ~\.config\powershell\chezmoi_completion.ps1 -Target (Resolve-Path .\dotfiles\pwsh\chezmoi_completion.ps1) -Force
New-Item -ItemType SymbolicLink -Path ~\.config\powershell\rustup_completion.ps1 -Target (Resolve-Path .\dotfiles\pwsh\rustup_completion.ps1) -Force
# starship
New-Item -ItemType SymbolicLink -Path ~\.config\starship.toml -Target (Resolve-Path .\dotfiles\starship\starship.toml) -Force
