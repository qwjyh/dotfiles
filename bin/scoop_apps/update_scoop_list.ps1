# update scoop list
if(!(Get-Command scoop -ErrorAction SilentlyContinue)) {
  Write-Output "scoop does not exists!"
  exit 1
}

scoop export | Out-File scoop_apps.json -Encoding utf8
