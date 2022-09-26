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
Install-Module -Name posh-git
Install-Module -Name Pscx -AllowPrerelease
Install-Module -Name z
Install-Module -Name PSFzf -RequiredVersion 2.5.10

# install scoop
if(!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Output "Installing scoop..."
  irm get.scoop.sh | iex
}
# install basic scoop apps
# import from exported json file
# to update the json file, execute ./bin/scoop_apps/update_scoop_list.ps1
scoop import .\bin\scoop_apps\scoop_apps.json


# make symbolic links
# neovim
New-Item -ItemType SymbolicLink -Path ~\AppData\Local\nvim\init.vim -Target (Resolve-Path .\dotfiles\neovim\init.vim) -Force
# pwsh
New-Item -ItemType SymbolicLink -Path $PROFILE -Target (Resolve-Path .\dotfiles\pwsh\powershell_profile.ps1) -Force
New-Item -ItemType SymbolicLink -Path ~\.config\powershell\chezmoi_completion.ps1 -Target (Resolve-Path .\dotfiles\pwsh\chezmoi_completion.ps1) -Force
# starship
New-Item -ItemType SymbolicLink -Path ~\.config\starship.toml -Target (Resolve-Path .\dotfiles\starship\starship.toml) -Force
