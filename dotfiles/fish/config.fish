# load .bashrc
bass source ~/.bashrc

# ssh-agent
if status --is-interactive
	set -x SHELL fish
	keychain --eval --quiet -Q id_rsa, id_ed25519 | source
	set -x SHELL bash
end

# opam configuration
#source /home/urata/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
# deleted 

# key bindings
bind \b backward-kill-word

# starship
starship init fish | source
#function set_win_title
#   echo -ne "\033]0; (basename "$PWD") \007"
#end
#set tarship_precmd_uesr_func "set_win_title"
