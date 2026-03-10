vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == "tinymist" then
        end
    end
})

vim.keymap.set('n', '<leader>fo', require("telescope").extensions["tinymist-clientfeatures"].tinymist_outline,
    { desc = "Show outline of tinymist preview" })

---@type vim.lsp.Config
return {
    settings = {
        formatterMode = 'typstyle',
        ["lint.enabled"] = true,
    },
    handlers = {
    }
}
