-- restore completion order of nvim-cmp
-- source from `:help vimtex-complete-nvim-cmp`
local cmp = require'cmp'
cmp.setup.buffer {
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                    omni = (vim.inspect(vim_item.menu):gsub('%"', "")),
                    buffer = "[Buffer]",
                    -- formatting for other sources
                })[entry.source.name]
            return vim_item
        end,
    },
    sources = cmp.config.sources{
        { name = 'omni' },
        { name = 'buffer' },
        -- { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    },
}
