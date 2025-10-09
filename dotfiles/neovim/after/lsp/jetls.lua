---@brief
---
---A new language server for Julia
---https://github.com/aviatesk/JETLS.jl

local jetls_location = vim.env.HOME .. '/work/julia/JETLS.jl'
local root_files = { 'Project.toml', 'JuliaProject.toml' }

---@type vim.lsp.Config
return {
    cmd = {
        'julia',
        -- '+beta', -- 1.12 released so this might not necessary
        '--project=' .. jetls_location,
        '--startup-file=no',
        '--history-file=no',
        '-e',
        [[
            using JETLS
            runserver(stdin, stdout)
        ]]
    },
    filetypes = { 'julia' },
    root_markers = root_files,
}
