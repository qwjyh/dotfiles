# load .bashrc
# bass source ~/.bashrc

if status is-interactive
end

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

# opam
# source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
opam env --shell fish | source

# key bindings
bind \b backward-kill-word


# env
set -x LESS '-i -r -M -R -S -W -z-4 -x4'
