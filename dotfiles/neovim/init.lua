--print("init.lua loaded")
-----------------------------------------------------------
-- basic configurations
vim.o.number = true
vim.o.relativenumber = true
vim.cmd([[
highlight LineNr cterm=none ctermfg=243 
highlight CursorLineNr cterm=none ctermfg=250 
]])
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.cmd([[
highlight cursorline term=reverse cterm=none ctermbg=239
highlight cursorcolumn ctermbg=235
]])
vim.o.mouse = 'a'
vim.o.signcolumn = 'yes'
vim.o.ignorecase = true
vim.o.smartcase = true

-----------------------------------------------------------
-- to use PowerShell on Windows
-- original code from :h powershell
-- vim script func returns 1/0, while lua evals false only if gets false or nil
-- so be sure to compare with 1/0
if vim.fn.has('win32') == 1 then
    if vim.fn.executable('pwsh') == 1 then
        vim.opt.shell = 'pwsh'
    else
        vim.opt.shell = 'powershell'
    end
    vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    vim.opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
    vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.opt.shellquote = ''
    vim.opt.shellxquote = ''
end


-----------------------------------------------------------
-- Plugins
require 'plugins'
--vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

-----------------------------------------------------------
-- LSP config

-- Mapping for language server
-- See `:help vim.diagnostic.* for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    -- See `:help vim.lsp.*` for documentation on any of the below function
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'g1', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
}


-- Lua
require'lspconfig'.lua_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}







-----------------------------------------------------------
-- Ctrl + P to invoke fzf file search
vim.api.nvim_set_keymap('n', '<c-P>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })


-----------------------------------------------------------
-- lualine
require('lualine_setup')

