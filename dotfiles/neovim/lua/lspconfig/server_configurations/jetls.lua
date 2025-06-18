local configs = require 'lspconfig.configs'
local util = require 'lspconfig.util'

local root_files = { 'Project.toml', 'JuliaProject.toml' }

configs.jetls = {
    default_config = {
        cmd = {
            'julia',
            '+beta',
            '--project=' .. vim.env.HOME .. '/work/julia/JETLS.jl',
            '--startup-file=no',
            '--history-file=no',
            '-e',
            [[
                using JETLS
                runserver(stdin, stdout)
            ]]
        },
        filetypes = { 'julia' },
        root_dir = function(fname)
            return util.root_pattern(unpack(root_files))(fname)
                or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true, })[1])
        end,
        single_file_support = true,
    },
    commands = {
        -- JuliaActivateEnv = {
        --     activate_env
        -- }
    },
    docs = {
        description = [[
JETLS: https://github.com/aviatesk/JETLS.jl
        ]],
    },
}
