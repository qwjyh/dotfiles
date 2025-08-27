local win_pwsh_es_path = '~/scoop/apps/powershell-editorservice/current'
local arch_pwsh_es_path = "/opt/powershell-editor-services/"
---@type vim.lsp.Config
return {
    bundle_path = vim.fn.has('win32') == 1 and win_pwsh_es_path or arch_pwsh_es_path,
}
