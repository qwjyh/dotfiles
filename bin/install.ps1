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