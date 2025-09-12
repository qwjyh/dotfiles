-- TODO: use settings on :h lspconfig-all lua_ls one?
---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT', },
        },
        diagnostics = {
            globals = { 'vim' },
        },
        workspace = {
            library = vim.env.VIMRUNTIME,
        },
    },
}
