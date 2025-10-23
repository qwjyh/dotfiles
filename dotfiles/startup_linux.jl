atreplinit() do repl
    if VERSION < v"1.13-DEV"
        try
            @eval using OhMyREPL
            @eval enable_autocomplete_brackets(false)
            @eval include((@__DIR__) * "/catppuccin.jl")
            @eval OhMyREPL.colorscheme!("CatppuccinMocha")
            # @eval OhMyREPL.colorscheme!("CatppuccinLatte")
        catch err
            @warn "Failed to load OhMyREPL" err
        end
    end

    try
        @eval using Revise
    catch err
        @warn "Failed to load Revise" err
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

