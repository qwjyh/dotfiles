# load .bashrc
# bass source ~/.bashrc

if status is-interactive
    # starship
    starship init fish | source

    # save fish log to my custom file
    set -gx my_fish_history "$HOME/my_fish_history.txt"
    function save_myhistory --on-event fish_prompt -d "Save custom shell log to $my_fish_history"
        set -l prev_status $status
        echo "$(date '+%Y-%m-%d %H:%M:%S') $hostname:$fish_pid $PWD [$prev_status] $(history -1)" >>$my_fish_history
    end
    # starting sign
    echo "$(date '+%Y-%m-%d %H:%M:%S') $hostname:$fish_pid [START]" >>$my_fish_history
    # exit sign
    function save_myhistory_exit --on-event fish_exit -d "Add exit sign to $my_fish_history"
        echo "$(date '+%Y-%m-%d %H:%M:%S') $hostname:$fish_pid [EXIT]" >>$my_fish_history
    end

    function set_win_title
        echo -ne "\033]0; (basename "$PWD") \007"
    end
    set starship_precmd_uesr_func set_win_title

    # # keychain
    # set -x SHELL fish
    # keychain --eval --quiet -Q id_rsa, id_ed25519 | source
    # set -x SHELL bash

    # abbr (from 3.6, --universal is removed)
    abbr --add -- l less
    abbr --add -- ll 'eza -la --icons --git'
    abbr --add -- qpv 'qpdfview --unique'
    abbr --add -- lf yazi

    zoxide init fish | source

    # opam
    #source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

    function y --description "yazi with jump"
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    function rga-fzf
        set RG_PREFIX 'rga --files-with-matches'
        if test (count $argv) -gt 1
            set RG_PREFIX "$RG_PREFIX $argv[1..-2]"
        end
        set -l file $file
        set file (
            FZF_DEFAULT_COMMAND="$RG_PREFIX '$argv[-1]'" \
            fzf --sort \
                --preview='test ! -z {} && \
                    rga --pretty --context 5 {q} {}' \
                --phony -q "$argv[-1]" \
                --bind "change:reload:$RG_PREFIX {q}" \
                --preview-window='50%:wrap'
        ) && echo "opening $file" && open "$file"
    end
end

# opam
# source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
opam env --shell fish | source

# key bindings
bind \b backward-kill-word
bind ctrl-\] forward-jump
bind ctrl-alt-\] backward-jump

# env
set -x LESS '-i -M -R -S -W -z-4 -x4'
set -x EDITOR /usr/bin/nvim
# julia sysimage
set -x JL_SYSIMG_PATH "$HOME/dotfiles/julia-sysimages"
set -x JL_SYSIMG_PLT "$HOME/dotfiles/julia-sysimages/sys-plotsmakie.so"
set -x JL_SYSIMG_ETC "$HOME/dotfiles/julia-sysimages/sys-etc.so"

# load local patch
source ~/.config/fish/local_patch.fish
