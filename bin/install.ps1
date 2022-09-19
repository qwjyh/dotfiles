#!/usr/bin/pwsh

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


# make symbolic links
# neovim
$neovim_directory 
New-Item -ItemType SymbolicLink -Path ~\AppData\Local\nvim\init.vim -Target (Resolve-Path .\dotfiles\neovim\init.vim) -Force