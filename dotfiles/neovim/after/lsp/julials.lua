-- use sysimage only if it exists
local julials_so = vim.env.HOME .. "/.julia/environments/nvim-lspconfig/sys-ls.so"
local julials_so_option = { "", "" }
local julials_so_file = io.open(julials_so)
if julials_so_file then -- if sysimage doesn't exist, julials_so_file == nil
    julials_so_option = {
        "-J", julials_so
    }
    julials_so_file:close()
end

---@type vim.lsp.Config
return {
    on_attach = function(client, bufnr)
        require("lsp_config").on_attach(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    cmd = { "julia", "--startup-file=no", "--history-file=no",
        julials_so_option[1], julials_so_option[2],
        -- use below 2 lines to collect script to be included in sysimage
        '--trace-compile',
        vim.env.HOME .. "/.julia/environments/nvim-lspconfig/tracecompile.jl",
        "-t4",
        "-e",
        [[
            # Load LanguageServer.jl: attempt to load from ~/.julia/environments/nvim-lspconfig
            # with the regular load path as a fallback
            ls_install_path = joinpath(
                get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")),
                "environments", "nvim-lspconfig"
            )
            pushfirst!(LOAD_PATH, ls_install_path)
            using LanguageServer
            popfirst!(LOAD_PATH)
            depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
            project_path = let
                dirname(something(
                    ## 1. Finds an explicitly set project (JULIA_PROJECT)
                    Base.load_path_expand((
                        p = get(ENV, "JULIA_PROJECT", nothing);
                        p === nothing ? nothing : isempty(p) ? nothing : p
                    )),
                    ## 2. Look for a Project.toml file in the current working directory,
                    ##    or parent directories, with $HOME as an upper boundary
                    Base.current_project(),
                    ## 3. First entry in the load path
                    get(Base.load_path(), 1, nothing),
                    ## 4. Fallback to default global environment,
                    ##    this is more or less unreachable
                    Base.load_path_expand("@v#.#"),
                ))
            end
            ENV["JULIA_DEBUG"] = "LanguageServer"
            @info "Running language server" VERSION pwd() project_path depot_path
            server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
            server.runlinter = true
            run(server)
        ]] }
}
