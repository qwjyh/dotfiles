# julia startup file for windows
# use python installed with scoop instead of conda in windows
ENV["PYTHON"] = joinpath(homedir(), raw"scoop\apps\python\current\python.exe")

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

