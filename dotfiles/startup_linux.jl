try
    using OhMyREPL
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
try
    using AbbreviatedStackTraces
catch e
    @warn "Failed to load AbbreviatedStackTraces"
end

#=
 TerminalPager
=#
# using JuliaSyntax
#
# if v"1.9" ≤ VERSION < v"1.10"
#     JuliaSyntax.enable_in_core!()
# end

