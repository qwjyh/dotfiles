#!/usr/bin/pwsh
# dotfiles install script for Windows

# check administration role
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$bool_admin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!$bool_admin) {
  Write-Warning -Message "require Admin privilage
  please run as Administrator"
  exit 1
}

# check pwsh version
# ≧ 7
if ($PSVersionTable.PSVersion.Major -lt 7) {
  Write-Warning -Message "pwsh version must be greater than 7
  please install powershell 7 (Core)
  you can install via winget"
  exit 1
}

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
Install-Module -Name z


# make symbolic links
# neovim
New-Item -ItemType SymbolicLink -Path ~\AppData\Local\nvim\init.vim -Target (Resolve-Path .\dotfiles\neovim\init.vim) -Force
# pwsh
New-Item -ItemType SymbolicLink -Path $PROFILE -Target (Resolve-Path .\dotfiles\pwsh\powershell_profile.ps1) -Force
New-Item -ItemType SymbolicLink -Path ~\.config\powershell\chezmoi_completion.ps1 -Target (Resolve-Path .\dotfiles\pwsh\chezmoi_completion.ps1) -Force
# starship
New-Item -ItemType SymbolicLink -Path ~\.config\starship.toml -Target (Resolve-Path .\dotfiles\starship\starship.toml) -Force
