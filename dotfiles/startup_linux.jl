try
    using OhMyREPL
    enable_autocomplete_brackets(false)
    include("catppuccin.jl")
    OhMyREPL.colorscheme!("CatppuccinMocha")
    # OhMyREPL.colorscheme!("CatppuccinLatte")
catch err
    @warn "Failed to load OhMyREPL" err
end
try
    using Revise
catch err
    @warn "Failed to load Revise" err
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

