-- https://qiita.com/uhooi/items/99aeff822d4870a8e269
local lsp_names = function ()
    local clients = {}
    for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0})) do
        table.insert(clients, client.name)
    end
    return ' ' .. table.concat(clients, ', ')
end

local navic = require('nvim-navic')

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
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
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {lsp_names, 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {
      lualine_c = {
          {
              "navic",
              color_correction = nil,
              navic_opts = nil,
          },
      },
  },
  inactive_winbar = {},
  extensions = {}
}
