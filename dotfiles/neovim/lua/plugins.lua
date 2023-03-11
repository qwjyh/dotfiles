vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- fzf
    use { 'ibhagwan/fzf-lua',
        -- optional icon
        --requires = { 'kyazdan142/nvim-web/devicons' } -- not found
    }

    -- lualine(statusline)
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- LSP
    use 'neovim/nvim-lspconfig'
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/vim-vsnip"

    -- Julia
    use "JuliaEditorSupport/julia-vim"

end)
