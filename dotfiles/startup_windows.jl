# julia startup file for windows
# use python installed with scoop instead of conda in windows
ENV["PYTHON"] = joinpath(homedir(), raw"scoop\apps\python\current\python.exe")

atreplinit() do repl
    try
        @eval using Revise
    catch err
        @warn "Failed to load Revise" err
    end
end
