---@type vim.lsp.Config
return {
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                features = "all",
            },
            check = {
                command = "clippy",
            },
        },
    },
}
