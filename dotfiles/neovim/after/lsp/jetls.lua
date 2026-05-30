---@brief
---
---A new language server for Julia
---https://github.com/aviatesk/JETLS.jl

local root_files = { 'Project.toml', 'JuliaProject.toml' }

local default_cmd = {
    'jetls',
    '--threads=12,2',
    '--',
    'serve',
    -- '--clientProcessId=' .. nvim_pid,
}

---Determines if the file belongs to external package.
---Return existing client's root dir for an external package, or nil for the other.
---
---Based on `rust_analyzer` lspconfig.
---@param filename string
---@return string?
local function is_library(filename)
    local user_home = vim.fs.normalize(vim.env.HOME)
    local julia_home = os.getenv "JULIA_DEPOT_PATH" or user_home .. "/.julia"
    if vim.fs.relpath(julia_home, filename) then
        local clients = vim.lsp.get_clients { name = "jetls" }
        return #clients > 0 and clients[#clients].config.root_dir or nil
    end
end

---@type vim.lsp.Config
return {
    cmd = default_cmd,
    -- cmd = jetls_compiled_opts.cmd,
    -- cmd_env = jetls_compiled_opts.cmd_env,
    filetypes = { 'julia' },
    ---@param bufnr integer
    ---@param on_dir fun(root_dir?: string)
    root_dir = function(bufnr, on_dir)
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local reused_dir = is_library(filename)
        if reused_dir then
            on_dir(reused_dir)
            return
        end

        local julia_project = os.getenv "JULIA_PROJECT"
        if julia_project then
            on_dir(julia_project)
            return
        end

        --TODO: workspace?
        on_dir(vim.fs.root(filename, root_files))
    end,
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
