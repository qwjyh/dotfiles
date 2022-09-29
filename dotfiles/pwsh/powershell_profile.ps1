# ==============================================================
#    PSReadLine Settings 
# ==============================================================
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord # like fish
Set-PSReadLineKeyHandler -Chord "Tab" MenuComplete
Set-PSReadLineKeyHandler -Chord "Ctrl+d" DeleteCharOrExit
Set-PSReadLineKeyHandler -Chord "Ctrl+g" -ScriptBlock { Invoke-FzfTabCompletion }

# PsFzf Options
# 'Ctrl+t' for provider path, 'Ctrl+r' for reverse history
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'


# ==============================================================
#     alias and functions
# ==============================================================
function ~ {  cd ~  }
function .. { cd .. }
function epl {explorer.exe .}
Set-Alias touch New-Item
Set-Alias whereis where.exe

# starship
# change window name
function Invoke-Starship-PreCommand {
  $ParentFolder = Split-Path $PWD -Leaf
  $host.ui.Write("`e]0; $ParentFolder `a")
}
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"

# home_util shortcut
$home_util_path = "~\Documents\macro\ahk"
function home_util {
  & (Join-Path -Path $home_util_path -ChildPath "home_util.exe")
}



# --------------------------------------------------------------
#     change encoding
# --------------------------------------------------------------
# ref: https://qiita.com/e4rfx/items/3772ecb58b6918ed5348
# 文字エンコードをUTF8に設定する
function Set-UTF8 {
  <#
  .SYNOPSIS
  Sets powershell encoding to UTF-8.
  
  .DESCRIPTION
  Sets powershell encodings to UTF-8.
  To remove this settings, use Remove-EncodingSettings.
  To set to default, use Reset-EncodingSettings.
  For more details, see https://qiita.com/e4rfx/items/3772ecb58b6918ed5348.
  #>
	$PSDefaultParameterValues['*:Encoding'] = 'utf8'
	$global:OutputEncoding = [System.Text.Encoding]::UTF8
	[console]::OutputEncoding = [System.Text.Encoding]::UTF8
}
# UTF 16 LE
# pwsh default encoding
# best for redirecting to more.exe, Out-File
function Set-UTF16LE {
  <#
  .SYNOPSIS
  Sets powershell encoding to UTF-16 LE.
  
  .DESCRIPTION
  Sets powershell encodings to UTF-16 LE(Little Endian), which is the default of pwsh.
  This function is especially useful when redirecting to more.exe and less and Out-File and etc.
  To remove this settings, use Remove-EncodingSettings.
  To set to default, use Reset-EncodingSettings.
  For more details, see https://qiita.com/e4rfx/items/3772ecb58b6918ed5348.
  #>
	$PSDefaultParameterValues['*:Encoding'] = 'unicode'
	$global:OutputEncoding = [System.Text.Encoding]::Unicode
	[console]::OutputEncoding = [System.Text.Encoding]::Unicode
}
# デフォルトパラメータの文字エンコード指定を解除する
function Remove-EncodingSettings {
  <#
  .SYNOPSIS
  Remove custom encoding settings.
  
  .DESCRIPTION
  Remove custom encoding settings.
  For more details, see https://qiita.com/e4rfx/items/3772ecb58b6918ed5348.
  #>
	$PSDefaultParameterValues.Remove('*:Encoding')
}
# 文字エンコード設定を初期状態に戻す
function Reset-EncodingSettings {
  <#
  .SYNOPSIS
  Sets powershell encoding to default.
  
  .DESCRIPTION
  Sets powershell encodings to default(Shift-JIS).
  For more details, see https://qiita.com/e4rfx/items/3772ecb58b6918ed5348.
  #>
	$PSDefaultParameterValues.Remove('*:Encoding')
	$global:OutputEncoding = [System.Text.Encoding]::ASCII
	[console]::OutputEncoding = [System.Text.Encoding]::Default
}

# shortcut to enable ssh-agent
function Enable-SshAgent {
  <#
  .SYNOPSIS
    starts ssh-agent
    execute ssh-add to add ssh keys

  .DESCRIPTION
    Starts ssh-agent.
    Execute ssh-add to add ssh keys.
    You just need to execute this once after start up.

  .INPUTS
    no inputs

  .OUTPUTS
    no outputs
  #>
	sudo Set-Service -Name ssh-agent -StartupType Manual && Start-Service ssh-agent
}
# auto start ssh-agent and do ssh-add
function Invoke-SshAdd {
  <#
  .SYNOPSIS
    Starts ssh-agent and do ssh-add

  .DESCRIPTION
    Starts ssh-agent as admin and do ssh-add, to add sshkeys to ssh-agent.
  #>
  
  Enable-SshAgent
  ssh-add
}
# execute "ssh-add" to add keys


# less options
$env:LESS = "-i -M -R -S -W -z-4 -x4"



# ==============================================================
#     auto completions for modules
# ==============================================================

# scoop
# enable completion in current shell, use absolute path because PowerShell Core not respect $env:PSModulePath
Import-Module scoop-completion
#Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"

# chezmoi completion
$script = "$HOME\.config\powershell\chezmoi_completion.ps1"
if (Test-Path $script) {
  . $script
}

# git completion
Import-Module posh-git

# winget completion(source:https://docs.microsoft.com/en-us/windows/package-manager/winget/tab-completion)
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
      [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
      $Local:word = $wordToComplete.Replace('"', '""')
      $Local:ast = $commandAst.ToString().Replace('"', '""')
      winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
          [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
      }
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
