atreplinit() do repl
    try
        @eval using Revise
    catch err
        @warn "Failed to load Revise" err
    end
end

if isinteractive()
    if VERSION < v"1.13-DEV"
        try
            @eval using Pkg
            @eval using OhMyREPL
            @eval begin
                enable_autocomplete_brackets(false)
                include((@__DIR__) * "/catppuccin.jl")
                OhMyREPL.colorscheme!("CatppuccinMocha")
                # OhMyREPL.colorscheme!("CatppuccinLatte")
            end
        catch err
            @warn "Failed to load OhMyREPL" err
        end
    end
end
# try
#     using InteractiveCodeSearch
#     InteractiveCodeSearch.CONFIG.interactive_matcher = `fzf`
# catch e
#     @warn "Failed to load InteractiveCodeSearch"
# end

#=
 TerminalPager
=#

