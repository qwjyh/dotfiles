try
    using OhMyREPL
    enable_autocomplete_brackets(false)
catch e
    @warn "Failed to load OhMyREPL"
end
try
    using Revise
catch e
    @warn "Failed to load Revise"
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

