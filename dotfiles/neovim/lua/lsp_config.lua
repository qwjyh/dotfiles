local M = {}

---Add `desc` to bufopts table.
---@param bufopts vim.keymap.set.Opts
---@param desc string
---@return vim.keymap.set.Opts
local function with_desc(bufopts, desc)
    return vim.tbl_extend("error", bufopts, { desc = desc })
end

---@param client vim.lsp.Client
---@param bufnr integer
M.on_attach_keymap = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    -- See `:help vim.lsp.*` for documentation on any of the below function
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, with_desc(bufopts, "goto declaration"))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, with_desc(bufopts, "goto definition"))
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, with_desc(bufopts, "goto type definition"))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, with_desc(bufopts, "lsp hover"))
    vim.keymap.set('n', 'g1', vim.lsp.buf.implementation, with_desc(bufopts, "lsp implementations"))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, with_desc(bufopts, "lsp signature help"))
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, with_desc(bufopts, "lsp add_workspace_folder"))
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder,
        with_desc(bufopts, "lsp remove_workspace_folder"))
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, with_desc(bufopts, "lsp list_workspace_folders"))
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, with_desc(bufopts, "lsp type definition"))
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, with_desc(bufopts, "lsp rename"))
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, with_desc(bufopts, "lsp code_action"))
    vim.keymap.set('n', '<space>cc', vim.lsp.codelens.run, with_desc(bufopts, "lsp run codelens"))
    vim.keymap.set('n', '<space>cC', vim.lsp.codelens.refresh, with_desc(bufopts, "lsp refresh codelens"))
    vim.keymap.set('n', 'grf', vim.lsp.buf.references, with_desc(bufopts, "lsp references"))
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, with_desc(bufopts, "lsp format"))
end

---https://github.com/neovim/neovim/discussions/24791
---@param client vim.lsp.Client
---@param bufnr any
M.on_attach_codelens = function(client, bufnr)
    if client:supports_method("textDocument/codeLens") then
        vim.lsp.codelens.refresh()
        vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
            desc = "refresh codelens",
        })
    end
end

return M
