# generate completion for tree.com
# output help with UTF-8

"tree", "tree.com" | Foreach-Object {
    Register-ArgumentCompleter -Native -CommandName $_ -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)

        $commands = @{
            cmd = "/F"; desc = "Display the names of the files in each folder."
        }, @{
            cmd = "/A"; desc = "Use ASCII instead of extended characters."
        }

        # [string[]]$list = if ([string]$wordToComplete -eq "") {
        #     $commands
        # } else {
        #     $commands | Where-Object {
        #         $_.cmd -match $wordToComplete 
        #     }
        # }

        $commands | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_.cmd, $_.cmd, 'ParameterValue', $_.desc)
        }
    }
}
