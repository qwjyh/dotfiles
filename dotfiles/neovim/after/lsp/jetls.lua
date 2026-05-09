---@brief
---
---A new language server for Julia
---https://github.com/aviatesk/JETLS.jl

local root_files = { 'Project.toml', 'JuliaProject.toml' }
local nvim_pid = vim.uv.os_getpid()

---Run juliac compiled executable of jetls without bundling.
---@param julia_path string
---@param jetls_path string
---@param jetls_opts string[]?
---@return { cmd: string[], cmd_env: table }
local function run_executable(julia_path, jetls_path, jetls_opts)
    local default_cmd = {
        jetls_path,
    }
    vim.list_extend(default_cmd, { '--clientProcessId=' .. vim.uv.os_getpid() })
    vim.list_extend(default_cmd, jetls_opts or {})

    local cmd_env = {
        LD_LIBRARY_PATH = table.concat({ julia_path .. "/lib/", julia_path .. "/lib/julia/" }, ':'),
        JULIA_NUM_THREADS = '12,2',
    }

    return { cmd = default_cmd, cmd_env = cmd_env }
end

local default_cmd = {
    'jetls',
    '--threads=12,2',
    '--',
    'serve',
    -- '--clientProcessId=' .. nvim_pid,
}

---@diagnostic disable-next-line: unused-local
local jetls_compiled_opts = run_executable(
    vim.uv.os_homedir() .. '/.julia/juliaup/julia-1.12.2+0.x64.linux.gnu/',
    '/home/qwjyh/work/julia/JETLS.jl/jetls'
)

---@type vim.lsp.Config
return {
    cmd = default_cmd,
    -- cmd = jetls_compiled_opts.cmd,
    -- cmd_env = jetls_compiled_opts.cmd_env,
    filetypes = { 'julia' },
    root_markers = root_files,
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
        code_lens = {
            references = true,
        },
    },
    commands = {
        ["editor.action.showReferences"] = function(command, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
            local file_uri, position, references =
                unpack(command.arguments)
            local items = vim.lsp.util.locations_to_items(
                references, client.offset_encoding)
            vim.fn.setqflist({}, " ", {
                title = command.title, items = items })
            vim.lsp.util.show_document({
                uri = file_uri,
                range = { start = position, ["end"] = position },
            }, client.offset_encoding)
            vim.cmd("botright copen")
        end,
    },
}
