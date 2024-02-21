# load .bashrc
# bass source ~/.bashrc

if status is-interactive
    # starship
    starship init fish | source
    
    function set_win_title
      echo -ne "\033]0; (basename "$PWD") \007"
    end
    set starship_precmd_uesr_func "set_win_title"

    # # keychain
    # set -x SHELL fish
    # keychain --eval --quiet -Q id_rsa, id_ed25519 | source
    # set -x SHELL bash

    # abbr (from 3.6, --universal is removed)
    abbr -a -- l less
    abbr -a -- ll 'eza -la --icons --git'

    zoxide init fish | source

    # opam
    #source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
end

# starship
starship init fish | source

function set_win_title
    echo -ne "\033]0; (basename "$PWD") \007"
end
set starship_precmd_uesr_func "set_win_title"


# opam
# source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
opam env --shell fish | source

# key bindings
bind \b backward-kill-word


# env
set -x LESS '-i -r -M -R -S -W -z-4 -x4'
set -x EDITOR "/usr/bin/nvim"
# julia sysimage
set -x JL_SYSIMG_PATH "$HOME/dotfiles/julia-sysimages"
set -x JL_SYSIMG_PLT "$HOME/dotfiles/julia-sysimages/sys-plotsmakie.so"
set -x JL_SYSIMG_ETC "$HOME/dotfiles/julia-sysimages/sys-etc.so"


# save fish log to my custom file
set -gx my_fish_history "$HOME/my_fish_history.txt"
function save_myhistory --on-event fish_prompt -d "Save custom shell log to $my_fish_history"
    set -l prev_status $status
    echo "$(date '+%Y-%m-%d %H:%M:%S') $hostname:$fish_pid $PWD [$prev_status] $(history -1)" \
        >> $my_fish_history
end
# starting sign
echo "$(date '+%Y-%m-%d %H:%M:%S') $hostname:$fish_pid [START]" \
    >> $my_fish_history
# exit sign
function save_myhistory_exit --on-event fish_exit -d "Add exit sign to $my_fish_history"
    echo "$(date '+%Y-%m-%d %H:%M:%S') $hostname:$fish_pid [EXIT]" \
        >> $my_fish_history
end


# load local patch
source ~/.config/fish/local_patch.fish


