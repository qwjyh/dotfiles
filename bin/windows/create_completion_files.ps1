# create completion scripts file

$script_location = "$HOME\.config\powershell\completions"
if (!(Test-Path $script_location)) {
    echo "No existing completions"
    echo "Creating ~/.config/powershell/completions..."
    mkdir $script_location
}

# write
Get-ChildItem $script_location | Remove-Item
rclone completion powershell > (Join-Path $script_location "rclone_completion.ps1")
rustup completions powershell > (Join-Path $script_location "rustup_completion.ps1")
wezterm shell-completion --shell power-shell > (Join-Path $script_location "wezterm_completion.ps1")
chezmoi completion powershell > (Join-Path $script_location "chezmoi_completion.ps1")

