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

    # opam
    #source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
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
set -x EDITOR "/usr/bin/nvim"


# save fish log to my custom file
set -gx my_fish_history "$HOME/my_fish_history.txt"
function save_myhistory --on-event fish_prompt -d "Save custom shell log to $my_fish_history"
	set -l prev_status $status
    echo "$(date '+%Y-%m-%d %H:%M:%S') $hostname:$fish_pid $PWD [$prev_status] $(history -1)" \
        >> $my_fish_history
end

# load local patch
source ~/.config/fish/local_patch.fish


