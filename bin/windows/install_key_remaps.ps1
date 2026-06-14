# Install script for AHK key remapping
# Be sure to install AutoHotKey first


# change working directory to git root
Set-Location (Join-Path $PSScriptRoot "..\..")

# set Ahk2Exe.exe path
# example "C:\Program Files\AutoHotKey\Compiler\Ahk2Exe.exe"
$ahk_path = "$env:LOCALAPPDATA\Programs\AutoHotkey"
$ahk2exe_path = "$ahk_path\Compiler\Ahk2Exe.exe"
$ahk_base_path = "$ahk_path\v2\AutoHotKey64.exe"

## end config

if ($null -eq $ahk2exe_path) {
  exit
}

# compile
& $ahk2exe_path /in .\dotfiles\ahk\key_remaps.ahk /out dotfiles\ahk\key_remaps.exe /base $ahk_base_path

# add to startup folder
$startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\"
Copy-Item .\dotfiles\ahk\key_remaps.exe $startup

Write-Output "Finished!"
