if status is-interactive
    # Commands to run in interactive sessions can go here
    # starship
    starship init fish | source
end


# opam configuration
source /home/qwjyh/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# julia
# to solve Graphic Card driver problem
export LD_PRELOAD=/usr/lib64/libstdc++.so.6

