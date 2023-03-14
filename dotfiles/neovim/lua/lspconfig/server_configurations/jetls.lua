-- local cmd = {
--     'julia',
--     '--startup-file=no',
--     '--history-file=no',
--     '-e',
--     [[
--     # Load JETLS.jl: attempt to load from ~/.julia/environments/nvim-lspconfig
--     # with the regular load path as a fallback
--     jet_install_path = joinpath(
--         get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),
--         "environments", "nvim-lspconfig"
--     )
--     pushfirst!(LOAD_PATH, jet_install_path)
--     using JETLS
--     popfirst!(LOAD_PATH)
--     depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
--     project_path = let
--         dirname(something(
--             ## 1. Finds an explicitly set project (JULIA_PROJECT)
--             Base.load_path_expand((
--                 p = get(ENV, "JULIA_PROJECT", nothing);
--                 p === nothing ? nothing : isempty(p) ? nothing : p
--             )),
--             ## 2. Look for a Project.toml file in the current working directory,
--             ##    or parent directories, with $HOME as an upper boundary
--             Base.current_project(),
--             ## 3. First entry in the load path
--             get(Base.load_path(), 1, nothing),
--             ## 4. Fallback to default global environment,
--             ##    this is more or less unreachable
--             Base.load_path_expand("@v#.#"),
--         ))
--     end
--     @info "Running JETLS language server" VERSION pwd() project_path
--     @info "not running yet"
--     JETLS.runserver(stdin, stdout)
--   ]],
-- }
local cmd = {
    'julia',
    '--startup-file=no',
    '--history-file=no',
    '-e',
    [[
        println("===STARTING JETLS===")
        using JETLS
        JETLS.runserver(stdin, stdout)
        @info "Running JETLS" VERSION pwd() project_path
        @info "============================"
    ]],
}

return {
    default_config = {
        cmd = cmd,
        filetypes = { 'julia' },
        root_dir = function(fname)
            local util = require 'lspconfig.util'
            return util.root_pattern 'Project.toml' (fname) or util.find_git_ancestor(fname) or
                util.path.dirname(fname)
        end,
    },
    docs = {
        description = [[
TBW
    ]],
    },
}
