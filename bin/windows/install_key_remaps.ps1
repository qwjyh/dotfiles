# Install script for AHK key remapping
# Be sure to install AutoHotKey first


# change working directory to git root
Set-Location (Join-Path $PSScriptRoot "..\..")

# set Ahk2Exe.exe path
# example "C:\Program Files\AutoHotKey\Compiler\Ahk2Exe.exe"
$ahk2exe_path = "C:\Program Files\AutoHotKey\Compiler\Ahk2Exe.exe"

## end config

if ($null -eq $ahk2exe_path) {
  exit
}

# compile
& $ahk2exe_path /in .\dotfiles\ahk\key_remaps.ahk /out dotfiles\ahk\key_remaps.exe

# add to startup folder
$startup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\"
Copy-Item .\dotfiles\ahk\key_remaps.exe $startup

Write-Output "Finished!"
