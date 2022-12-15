#!/usr/bin/bash
set -eu

# =========================================================
# check executing location
# =========================================================
if [ ! -d "bin" -a ! -d "dotfiles" ]; then
	echo "Wrong execution location"
	echo "Please run this script on dotfiles root folder."
	exit 1
fi


# =========================================================
# links
# =========================================================
mkdir -p ~/.config/powershell
ln -sb $(pwd)/dotfiles/pwsh/powershell_profile.ps1 ~/.config/powershell/Microsoft.PowerShell_profile.ps1

