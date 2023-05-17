# update scoop list

# scoop need to be installed
if(!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Output "scoop does not exists!"
  exit 1
}

# change working directory to git root
Set-Location (Join-Path $PSScriptRoot "../../..")

Write-Output (pwd).Path

# export to JSON
scoop export | Out-File .\bin\windows\scoop_apps\scoop_apps.json -Encoding utf8

# create minimal JSON
$minimal_list = @("7zip", "aria2", "bat", "fzf", "grep", "hexyl", "less", "python", "rclone", "recycle-bin", "rga", "scoop-completion", "shasum", "sudo", "tree-sitter", "ugrep")
$parsed_json = Get-Content -Path .\bin\windows\scoop_apps\scoop_apps.json | ConvertFrom-Json
$buckets = ($parsed_json | Select-Object buckets).buckets
$apps = ($parsed_json | Select-Object apps).apps
$selected_apps = $apps | Where-Object Name -In $minimal_list
$new_json = [PSCustomObject]@{
  "apps" = $selected_apps
  "buckets" = $buckets
}
ConvertTo-Json -InputObject $new_json | Out-File .\bin\windows\scoop_apps\scoop_minimal_apps.json -Encoding utf8
