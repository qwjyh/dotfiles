---@brief
---
---https://github.com/monaqa/satysfi-language-server
---Language server for SATySFi.

-- https://zenn.dev/monaqa/articles/2021-12-10-satysfi-language-server

---@type vim.lsp.Config
return {
    cmd = { 'satysfi-language-server' },
    filetypes = { 'satysfi' },
    root_markers = { '.git' },
}
