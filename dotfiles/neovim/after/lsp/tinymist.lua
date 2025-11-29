---@type lsp.Handler
vim.lsp.handlers["tinymist/compileStatus"] = require("tinymist_status").compile_status_handler

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == "tinymist" then
            vim.api.nvim_buf_create_user_command(
                ev.buf,
                "TinymistShowCompileStatus",
                require('tinymist_status').show_status_detail(ev.buf),
                { desc = "Get compile status and words/character count", }
            )
        end
    end
})

---@type vim.lsp.Config
return {
    settings = {
        compileStatus = 'enable',
        formatterMode = 'typstyle',
    },
}
