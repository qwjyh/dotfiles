-----------------------------------------------------------
-- Installing plugin manager 'lazy.nvim'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
    { "catppuccin/nvim",       name = "catppuccin" }, -- Color scheme
    {
        dir = "./lua/term_powershell.lua",
        cond = function()
            return vim.fn.has('win32') == 1
        end,
        event = "CmdlineEnter",
        config = function()
            require("term_powershell").setup {
                pwsh = true
            }
        end
    },
    {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require('which-key').setup {

            }
        end,
    },
    { 'RRethy/vim-illuminate', }, -- highlight keywords under cursor
    {                             -- comment
        'numToStr/Comment.nvim',
        config = function()
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
        dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
    },
    {
        'shellRaining/hlchunk.nvim',
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require('hlchunk').setup {
                chunk = {
                    enable = true,
                },
                line_num = {
                    enable = true,
                },
            }
        end
    },
    {
        'lervag/vimtex',
        ft = { 'tex', 'latex' },
    },
    {
        'hkupty/iron.nvim',
        ft = { 'julia', 'python', 'ruby', 'lua', },
    },
    { 'lewis6991/gitsigns.nvim', },
    'neovim/nvim-lspconfig',
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',     -- LSP
            'L3MON4D3/LuaSnip',         -- snippets
            'saadparwaiz1/cmp_luasnip', -- nvim-cmp source for LuaSnip
            'hrsh7th/cmp-buffer',       -- nvim-cmp source for buffer words
            'hrsh7th/cmp-path',         -- nvim-cmp source for filesystem paths
            'hrsh7th/cmp-cmdline',      -- command line
            'hrsh7th/cmp-omni',         -- source for omnifunc
            'hrsh7th/cmp-nvim-lua',     -- nvim lua
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'nvim-orgmode/orgmode',
            {
                "mtoohey31/cmp-fish",
                ft = 'fish',
                cond = function()
                    return vim.fn.has('win32') == 0
                end
            },
        },
    },
    {
        'kdheepak/cmp-latex-symbols', -- latex math
        ft = { 'julia', 'typst', },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
    {
        "nvim-treesitter/playground",
        lazy = true,
    },
    {
        "andymass/vim-matchup",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
            require 'nvim-treesitter.configs'.setup {
                matchup = {
                    enable = true,
                }
            }
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
    },
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'folke/trouble.nvim',
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<space>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<space>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<space>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<space>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<space>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<space>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        'Julian/lean.nvim',
        event = { 'BufReadPre *.lean', 'BufNewFile *.lean' },

        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
            'hrsh7th/nvim-cmp',
        },

        -- see Julian/lean.nvim readme
        opts = {
            lsp = {
                on_attach = function(client, bufnr)
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
                end,
            },
            mappings = true,
        },

        -- this currently disables all default settings in lean.nvim
        -- default lean.nvim config overwrites lspconfig
        -- TODO: migrate default settings from lean.nvim
    },
    {
        'nvim-orgmode/orgmode',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter', lazy = true },
        },
        -- event = 'VeryLazy', -- doesn't work with existing comp and treesitter
        config = function()
            -- Setup treesitter
            require('nvim-treesitter.configs').setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { 'org' },
                },
                ensure_installed = { 'org' },
            })

            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = '~/orgfiles/**/*',
                org_default_notes_file = '~/orgfiles/refile.org',
                org_todo_keywords = {
                    "TODO(t)",
                    "PLAN(p)",
                    "NEXT(n)",
                    "|",
                    "DONE(d)",
                    "CANCELED(c)",
                },
                org_todo_keyword_faces = {
                    -- TODO = ":foreground red",
                    PLAN = ":foreground #F0BB61",
                    NEXT = ":background #663333 :foreground #E0A0A0",
                    CANCELED = ":foreground #99AA99",
                },
                org_archive_location = '~/orgfiles/archives/%s_archive::',
                org_adapt_indentation = false,
                org_id_link_to_org_use_id = true,
                org_capture_templates = {
                    t = {
                        description = "Task",
                        template = '* TODO %?\n%u'
                    },
                    l = {
                        description = "Log",
                        template = '* %?\n%U'
                    },
                    j = {
                        description = "Journal",
                        template = '* %?\n%U',
                        target = '~/orgfiles/journal.org',
                    },
                },
            })
        end,
    },
    {
        'chomosuke/typst-preview.nvim',
        ft = 'typst',
        version = 'v1.*',
        build = function()
            require 'typst-preview'.update()
        end,
        config = function()
            require 'typst-preview'.setup {
                -- Setting this true will enable printing debug information with print()
                debug = false,

                -- Custom format string to open the output link provided with %s
                -- Example: open_cmd = 'firefox %s -P typst-preview --class typst-preview'
                open_cmd = nil,

                -- Setting this to 'always' will invert black and white in the preview
                -- Setting this to 'auto' will invert depending if the browser has enable
                -- dark mode
                -- Setting this to '{"rest": "<option>","image": "<option>"}' will apply
                -- your choice of color inversion to images and everything else
                -- separately.
                invert_colors = 'never',

                -- Whether the preview will follow the cursor in the source file
                follow_cursor = true,

                -- Provide the path to binaries for dependencies.
                -- Setting this will skip the download of the binary by the plugin.
                -- Warning: Be aware that your version might be older than the one
                -- required.
                dependencies_bin = {
                    ['tinymist'] = nil,
                    ['websocat'] = nil
                },

                -- A list of extra arguments (or nil) to be passed to previewer.
                -- For example, extra_args = { "--input=ver=draft", "--ignore-system-fonts" }
                extra_args = nil,

                -- This function will be called to determine the root of the typst project
                get_root = function(path_of_main_file)
                    -- Use root of git repository as a --root for typst
                    local rootpath = vim.fs.root(path_of_main_file, '.git')
                    if rootpath then
                        return rootpath
                    else
                        return vim.fn.fnamemodify(path_of_main_file, ':p:h')
                    end
                end,

                -- This function will be called to determine the main file of the typst
                -- project.
                get_main_file = function(path_of_buffer)
                    return path_of_buffer
                end,
            }
        end
    },
})

-----------------------------------------------------------
-- Adding filetype 'satysfi'
vim.filetype.add {
    extension = {
        saty = 'satysfi',
        satyh = 'satysfi',
        satyg = 'satysfi',
        typ = 'typst',
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
vim.opt.undofile = true                -- Save undo history
vim.o.completeopt = 'menuone,noselect' -- for better completion experience
vim.o.termguicolors = true

vim.keymap.set('n', 'H', '<cmd>tabp<cr>', { desc = 'tab previous' })
vim.keymap.set('n', 'L', '<cmd>tabn<cr>', { desc = 'tab next' })

-- color scheme
require('catppuccin').setup({
    transparent_background = true,
})
vim.cmd.colorscheme "catppuccin-latte"

-----------------------------------------------------------
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- some terminalmode settings
vim.keymap.set('t', '<C-w>h', '<C-\\><C-N><C-w>h',
    { noremap = true, desc = "Exit terminal-mode and move to left window." })
vim.keymap.set('t', '<C-w>j', '<C-\\><C-N><C-w>j',
    { noremap = true, desc = "Exit terminal-mode and move to down window." })
vim.keymap.set('t', '<C-w>k', '<C-\\><C-N><C-w>k', { noremap = true, desc = "Exit terminal-mode and move to up window." })
vim.keymap.set('t', '<C-w>l', '<C-\\><C-N><C-w>l',
    { noremap = true, desc = "Exit terminal-mode and move to right window." })

-----------------------------------------------------------
-- comment setting for satysfi
local ft = require('Comment.ft')
ft.set('satysfi', '%%s')

-----------------------------------------------------------
-- vimtex
vim.g.vimtex_view_method = 'general' -- which is installed on both win and linux

-----------------------------------------------------------
-- iron (repl)
local iron = require('iron.core')
iron.setup {
    config = {
        scratch_repl = true, -- repl should be discarded
        repl_definition = {
            fish = {
                command = { 'fish' },
            },
            julia = {
                command = { 'julia', },
            },
            shell = {
                command = { 'sh', },
            },
        },
        repl_open_cmd = require('iron.view').split.botright('30%'), -- repl view config
    },
    keymaps = {
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_mark = "<space>sm",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
    },
}
-- keymap for iron repl
vim.keymap.set('n', '<C-@>', '<cmd>IronRepl<cr>')

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
        end, { expr = true })
        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })
    end
}

-----------------------------------------------------------
-- lualine
require('lualine_setup')

-----------------------------------------------------------
-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', function() builtin.find_files { sort_lastused = true } end, { desc = "find files" })
vim.keymap.set('n', '<leader>fw', builtin.lsp_workspace_symbols, { desc = "lsp workspace symbols" })
vim.keymap.set('n', '<leader>fd', builtin.lsp_document_symbols, { desc = "lsp document symbols" })
vim.keymap.set('n', '<leader>flr', builtin.lsp_references, { desc = "lsp references for word" })
vim.keymap.set('n', '<leader>fli', builtin.lsp_incoming_calls, { desc = "lsp incoming calls" })
vim.keymap.set('n', '<leader>flo', builtin.lsp_outgoing_calls, { desc = "lsp outgoing calls" })
vim.keymap.set('n', '<leader>fll', builtin.lsp_implementations, { desc = "lsp implementations" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "buffers" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "grep" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "help tags" })
vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = "git commit" })
vim.keymap.set('n', '<leader>fgc', builtin.git_commits, { desc = "git commit" })
vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = "git status" })
vim.keymap.set('n', '<leader>fgs', builtin.git_status, { desc = "git status" })

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
require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        'c', 'cpp', 'lua', 'julia', 'satysfi',
    },
    sync_install = false,
    auto_install = true, -- requires tree-sitter cli in local
    ignore_install = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org' },
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
        enable = false,
    },
    matchup = {
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
    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
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
                globals = { 'vim' },
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
-- use sysimage only if it exists
local julials_so = vim.env.HOME .. "/.julia/environments/nvim-lspconfig/sys-ls.so"
local julials_so_option = { "", "" }
local julials_so_file = io.open(julials_so)
if julials_so_file then -- if sysimage doesn't exist, julials_so_file == nil
    julials_so_option = {
        "-J", julials_so
    }
    julials_so_file:close()
end
-- main
lspconfig.julials.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "julia", "--startup-file=no", "--history-file=no",
        julials_so_option[1], julials_so_option[2],
        -- use below 2 lines to collect script to be included in sysimage
        -- '--trace-compile',
        -- vim.env.HOME .. "/.julia/environments/nvim-lspconfig/tracecompile.jl",
        "-t4",
        "-e",
        [[
            # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig
            # with the regular load path as a fallback
            ls_install_path = joinpath(
                get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),
                "environments", "nvim-lspconfig"
            )
            pushfirst!(LOAD_PATH, ls_install_path)
            using LanguageServer
            popfirst!(LOAD_PATH)
            depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
            project_path = let
                dirname(something(
                    ## 1. Finds an explicitly set project (JULIA_PROJECT)
                    Base.load_path_expand((
                        p = get(ENV, "JULIA_PROJECT", nothing);
                        p === nothing ? nothing : isempty(p) ? nothing : p
                    )),
                    ## 2. Look for a Project.toml file in the current working directory,
                    ##    or parent directories, with $HOME as an upper boundary
                    Base.current_project(),
                    ## 3. First entry in the load path
                    get(Base.load_path(), 1, nothing),
                    ## 4. Fallback to default global environment,
                    ##    this is more or less unreachable
                    Base.load_path_expand("@v#.#"),
                ))
            end
            @info "Running language server" VERSION pwd() project_path depot_path
            server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
            server.runlinter = true
            run(server)
        ]] }
}
-- SATySFi
require 'lspconfig.server_configurations.satysfi_ls'
lspconfig.satysfi_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    autostart = true,
}
-- bash
lspconfig.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}
-- pwsh
local win_pwsh_es_path = '~/scoop/apps/powershell-editorservice/current'
local arch_pwsh_es_path = "/opt/powershell-editor-services/"
lspconfig.powershell_es.setup {
    bundle_path = vim.fn.has('win32') == 1 and win_pwsh_es_path or arch_pwsh_es_path,
    capabilities = capabilities,
}
-- ccls
-- -- csharp
-- lspconfig.omnisharp.setup {
--     cmd = {'omnisharp'},
-- }

-- lspconfig.typst_lsp.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     single_file_support = true,
-- }

lspconfig.tinymist.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    single_file_support = true,
}

lspconfig.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy",
            }
        }
    }
}

local lss = { "pyright", "texlab", --[[ "ccls", ]] "clangd", "ts_ls", --[["tailwindcss"]] "hls", "cmake",
    "csharp_ls", "html", "r_language_server", "cssls", "jsonls", "sqls", "vhdl_ls", "ruff", "lemminx" }
for _, ls in pairs(lss) do
    lspconfig[ls].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

-- none-ls
local null_ls = require('null-ls')
null_ls.setup {
    sources = {
        null_ls.builtins.diagnostics.fish,
    }
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
luasnip.config.setup {
    enable_autosnippets = true,
    store_selection_key = "<Tab>",
}
require 'luasnip.loaders.from_lua'.load({ paths = './luasnippets' })

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = false,
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
    sorting = {
        priority_weight = 10,
    },
    sources = {
        { name = 'luasnip',                max_item_count = 10 },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
        {
            name = 'latex_symbols',
            option = {
                strategy = 0, -- mixed (show the comand and insert the symbol)
            },
        },
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'orgmode' },
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
