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
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

-----------------------------------------------------------
-- Ctrl + P to invoke fzf file search
vim.api.nvim_set_keymap('n', '<c-P>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })


-----------------------------------------------------------
-- lualine
require('lualine_setup')
lualine = require('lualine')
lualine.setup({
    options = { theme = 'iceberg_dark' }
})
lualine.setup()
