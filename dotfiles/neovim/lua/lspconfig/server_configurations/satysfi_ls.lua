-- https://zenn.dev/monaqa/articles/2021-12-10-satysfi-language-server
local configs = require 'lspconfig.configs'

configs.satysfi_ls = {
    default_config = {
        cmd = { 'satysfi-language-server' },
        filetypes = { 'satysfi' },
        root_dir = vim.fs.root(0, ".git"),
        single_file_support = true,
    },
    docs = {
        description = [[
        https://github.com/monaqa/satysfi-language-server
        Language server for SATySFi.
        ]],
        default_config = {
            root_dir = [[root_pattern(".git")]],
        },
    },
}
