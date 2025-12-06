local M = {}

-- https://github.com/Myriad-Dreamin/tinymist/blob/main/editors/vscode/src/ui-extends.ts

---@class TinymistCompileStatus
---@field pageCount integer
---@field path string
---@field status "compiling" | "compileSuccess" | "compileError"
---@field wordsCount TinymistWordsCount?

---@class TinymistWordsCount
---@field chars integer
---@field cjkChars integer
---@field spaces integer
---@field words integer

---@type TinymistCompileStatus
local ex = {
    pageCount = 1,
    path = "/main.typ",
    status = "compileSuccess",
    wordsCount = {
        chars = 59,
        cjkChars = 26,
        spaces = 5,
        words = 31
    }
}

---@type table<integer, TinymistCompileStatus>
M.storage = {}

---Custom compileStatus handler
---@param err lsp.ResponseError?
---@param result TinymistCompileStatus
---@param ctx lsp.HandlerContext
M.compile_status_handler = function(err, result, ctx)
    if not result then return end
    local bufnr = ctx.bufnr or vim.fn.bufnr()
    M.storage[bufnr] = result
end

M.show_status = function()
    ---@type TinymistCompileStatus
    local result = M.storage[vim.fn.bufnr()]
    ---@type string
    local status
    if result.status == "compiling" then
        status = ''
    elseif result.status == "compileSuccess" then
        status = ''
    elseif result.status == "compileError" then
        status = ''
    end
    return status .. " " .. result.wordsCount.words .. " words"
end
M.show_status_color = function()
    local result = M.storage[vim.fn.bufnr()]
    if not result then
        return "DiagnosticUnnecessary"
    end
    if result.status == "compileError" then
        return "DiagnosticError"
    else
        return "DiagnosticUnnecessary"
    end
end

---@param bufnr integer
M.show_status_detail = function(bufnr)
    ---@param opts vim.api.keyset.create_user_command.command_args
    return function(opts)
        local result = M.storage[bufnr]
        vim.print(vim.inspect(result))
    end
end

return M
