-- -- https://qiita.com/uhooi/items/99aeff822d4870a8e269
-- local lsp_names = function ()
--     local clients = {}
--     for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0})) do
--         table.insert(clients, client.name)
--     end
--     return ' ' .. table.concat(clients, ', ')
-- end


require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = {
            {
                require("tinymist-clientfeatures.tinymist_status").show_status,
                cond = function()
                    return vim.bo.filetype == "typst"
                end,
                color = require("tinymist-clientfeatures.tinymist_status").show_status_color,
            },
            'lsp_status',
            'filetype'
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}
