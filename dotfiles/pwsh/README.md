# PowerShell PROFILE description
some notable features

## Key-Bindings
- tab completion like fish
- `Ctrl + D` to exit
- `Ctrl + G` to Invoke-FzfTabCompletion
- `Ctrl + t` to select providers with fzf
- `Ctrl + r` to fzf history

## Aliases
- `~`, `..`
- `epl` = `explorer.exe .`
- `whereis` = `where.exe`

## Change Encodings Instantly
You can change PowerShell encodings instantly.
Especially useful for piping into linux commands like `less`
- `Set-UTF8`, `Set-UTF16LE`
- `Remove-EncodingSettings`
- `Reset-EncodingSettings`

## ssh-agent
- `Invoke-SshAdd`

## `$env:`
- `$env:LESS`

## Auto Completions
- scoop
- chezmoi
- git
- winget
- chocolatey