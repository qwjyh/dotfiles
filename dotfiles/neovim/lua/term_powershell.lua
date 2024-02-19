-- use PowerShell on Windows
-- original code from :h powershell

local M = {}

---@class TermPwshConfig
---@field pwsh? boolean Whether to use pwsh instead of windows powershell.

---Entry.
---@param option TermPwshConfig
M.setup = function(option)
    if vim.fn.has('win32') == 1 then
        option = option or {}
        if option.pwsh then
            vim.opt.shell = 'pwsh'
        else
            -- this evaluation is so slow
            -- vim script func returns 1/0, while lua evals false only if gets false or nil
            -- so be sure to compare with 1/0
            if vim.fn.executable('pwsh') == 1 then
                vim.opt.shell = 'powershell'
            else
                vim.opt.shell = 'pwsh'
            end
        end
        -- adding option to disable colored output
        -- (ref: https://stackoverflow.com/questions/65735639/powershell-disable-colored-command-output)
        vim.opt.shellcmdflag =
        '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;$PSStyle.OutputRendering=[System.Management.Automation.OutputRendering]::PlainText;'
        vim.opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
        vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        vim.opt.shellquote = ''
        vim.opt.shellxquote = ''
    end
end

return M
