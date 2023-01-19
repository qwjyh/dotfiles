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


-- LSP
-- https://zenn.dev/botamotch/articles/21073d78bc68bf
-- 1. LSP Sever management
--require('mason').setup()
--require('mason-lspconfig').setup_handlers({ function(server)
--	local opt = {
--		-- -- Function executed when the LSP server startup
--		-- on_attach = function(client, bufnr)
--		--   local opts = { noremap=true, silent=true }
--		--   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--		--   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)'
--		-- end,
--		capabilities = require('cmp_nvim_lsp').update_capabilities(
--			vim.lsp.protocol.make_client_capabilities()
--		)
--	}
--	require('lspconfig')[server].setup(opt)
--end })
--
---- 2. build-in LSP function
---- keyboard shortcut
--vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
--vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
--vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
--vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
--vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
--vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
--vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
--vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
--vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
--vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
--vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
--vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
---- LSP handlers
--vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--	vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
--)
---- Reference highlight
--vim.cmd [[
--set updatetime=500
--highlight LspReferenceText  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
--highlight LspReferenceRead  cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
--highlight LspReferenceWrite cterm=underline ctermfg=1 ctermbg=8 gui=underline guifg=#A00000 guibg=#104040
--augroup lsp_document_highlight
--  autocmd!
--  autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.document_highlight()
--  autocmd CursorMoved,CursorMovedI * lua vim.lsp.buf.clear_references()
--augroup END
--]]
--
---- 3. completion (hrsh7th/nvim-cmp)
--local cmp = require("cmp")
--cmp.setup({
--	snippet = {
--		expand = function(args)
--			vim.fn["vsnip#anonymous"](args.body)
--		end,
--	},
--	sources = {
--		{ name = "nvim_lsp" },
--		-- { name = "buffer" },
--		-- { name = "path" },
--	},
--	mapping = cmp.mapping.preset.insert({
--		["<C-p>"] = cmp.mapping.select_prev_item(),
--		["<C-n>"] = cmp.mapping.select_next_item(),
--		['<C-l>'] = cmp.mapping.complete(),
--		['<C-e>'] = cmp.mapping.abort(),
--		["<CR>"] = cmp.mapping.confirm { select = true },
--	}),
--	experimental = {
--		ghost_text = true,
--	},
--})
---- cmp.setup.cmdline('/', {
----   mapping = cmp.mapping.preset.cmdline(),
----   sources = {
----     { name = 'buffer' }
----   }
---- })
---- cmp.setup.cmdline(":", {
----   mapping = cmp.mapping.preset.cmdline(),
----   sources = {
----     { name = "path" },
----     { name = "cmdline" },
----   },
---- })

-- satysfi language server
--require('lspconfig')['satysfi-ls'].setup{
--  autostart = true
--}

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
