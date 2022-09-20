# auto completion
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadlineOption -HistoryNoDuplicates
Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord # like fish
Set-PSReadLineKeyHandler -Chord "Tab" MenuComplete
Set-PSReadLineKeyHandler -Chord "Ctrl+d" DeleteCharOrExit

function ~ {  cd ~  }
function .. { cd .. }
function epl {explorer.exe .}
Set-Alias touch New-Item


# starship
# change window name
function Invoke-Starship-PreCommand {
  $ParentFolder = Split-Path $PWD -Leaf
  $host.ui.Write("`e]0; $ParentFolder `a")
}
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"

# for chezmoi
$Editor = "C:\Users\Owner\AppData\Local\Programs\Microsoft VS Code\Code.exe"

# oh my posh
# oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/capr4n.omp.json | Invoke-Expression

# shortcut to enable ssh-agent
function Enable-SshAgent {
	sudo Set-Service -Name ssh-agent -StartupType Manual && Start-Service ssh-agent
}
# execute "ssh-add" to add keys

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
