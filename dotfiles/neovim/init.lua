-----------------------------------------------------------
-- Installing plugin manager 'lazy.nvim'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Installing plugins
require('lazy').setup({
    { "catppuccin/nvim", name = "catppuccin" }, -- Color scheme
    { -- comment
        'numToStr/Comment.nvim',
        config = function ()
            require('Comment').setup()
        end,
    },
    { -- auto pair
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {
                check_ts = true, -- use treesitter
            }
        end,
        event = "InsertEnter",
    },
    { -- lualine(statusline)
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true }
    },
    {
        'lervag/vimtex',
        ft = { 'tex', 'latex' },
    },
    { 'lewis6991/gitsigns.nvim', },
    'neovim/nvim-lspconfig',
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp', -- LSP
            'L3MON4D3/LuaSnip', -- snippets
            'saadparwaiz1/cmp_luasnip', -- nvim-cmp source for LuaSnip
            'hrsh7th/cmp-buffer', -- nvim-cmp source for buffer words
            {
                'kdheepak/cmp-latex-symbols', -- latex math
                ft = { 'julia', },
            },
            'hrsh7th/cmp-path', -- nvim-cmp source for filesystem paths
            'hrsh7th/cmp-cmdline', -- command line
            'hrsh7th/cmp-omni', -- source for omnifunc
            'hrsh7th/cmp-nvim-lua', -- nvim lua
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    },
})

-----------------------------------------------------------
-- Adding filetype 'satysfi'
vim.filetype.add {
    extension = {
        saty = 'satysfi',
        satyh = 'satysfi',
        satyg = 'satysfi',
    },
    pattern = {
        ['.*%.satyh%-%a+'] = 'satysfi',
    },
}

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
vim.o.ignorecase = true -- keep signcolumn on
vim.o.smartcase = true
vim.o.errorbells = true
-- vim.o.visualbell = false -- this is default
vim.opt.undofile = true -- Save undo history
vim.o.completeopt = 'menuone,noselect' -- for better completion experience
vim.o.termguicolors = true

-- color scheme
require('catppuccin').setup({
    transparent_background = true,
})
vim.cmd.colorscheme "catppuccin"

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
-- comment setting for satysfi
local ft = require('Comment.ft')
ft.set('satysfi', '%%s')

-----------------------------------------------------------
-- vimtex
vim.g.vimtex_view_method = 'general' -- which is installed on both win and linux

-----------------------------------------------------------
-- gitsigns
require('gitsigns').setup {
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        ---custom mapping func
        ---@param mode string|string[]
        ---@param l string
        ---@param r any
        ---@param opts table?
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, {expr=true})
        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, {expr=true})
    end
}

-----------------------------------------------------------
-- lualine
require('lualine_setup')

-----------------------------------------------------------
-- telescope
vim.keymap.set('n', '<c-P>', function() require('telescope.builtin').find_files { sort_lastused = true } end) -- fd?

-----------------------------------------------------------
-- Treesitter
-- manually install parsers with `:TSInstall <language>`

-- satysfi (https://github.com/monaqa/tree-sitter-satysfi)
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.satysfi = {
    install_info = {
        url = "https://github.com/monaqa/tree-sitter-satysfi",
        files = { "src/parser.c", "src/scanner.c" }
    },
    filetype = 'satysfi',
}

-- setup
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'satysfi',
    },
    highlight = {
        enable = true,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['aa'] = '@parameter.outer',
                ['ia'] = '@parameter.inner',
                ['af'] = '@function.outer',
                ['if'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = '@class.inner',
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<space>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<space>A'] = '@parameter.inner',
            },
        },
    },
}


-----------------------------------------------------------
-- LSP config

local lspconfig = require 'lspconfig'

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
    --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

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
    vim.keymap.set('n', 'grf', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- cmp_nvim_lsp supports additional LSP completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()



-- Lua
lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
-- Julia
lspconfig.julials.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- SATySFi
lspconfig.satysfi_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = true,
}
-- bash
lspconfig.bashls.setup {}
-- python
lspconfig.pyright.setup {}
-- rust
lspconfig.rust_analyzer.setup {}
-- tex
lspconfig.texlab.setup {}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        {
            name = 'latex_symbols',
            option = {
                strategy = 0, -- mixed (show the comand and insert the symbol)
            },
        },
        { name = 'path' },
        { name = 'nvim_lua' },
    },
}
-- cmdline completions
-- `/` cmdline setup.
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
-- ':'
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        {
            name = 'cmdline',
            option = {
                ignore_cmds = { 'Man', '!' }
            }
        }
    })
})

