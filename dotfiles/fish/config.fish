# load .bashrc
# bass source ~/.bashrc

if status is-interactive
    # starship
    starship init fish | source
    
    function set_win_title
      echo -ne "\033]0; (basename "$PWD") \007"
    end
    set starship_precmd_uesr_func "set_win_title"

    # keychain
    set -x SHELL fish
    keychain --eval --quiet -Q id_rsa, id_ed25519 | source
    set -x SHELL bash
end

# opam
# source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# key bindings
bind \b backward-kill-word