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
