#!/usr/bin/bash
set -eu

# =========================================================
# check executing location
# =========================================================
if [ ! -d "bin" -a ! -d "dotfiles" ]; then
	echo "Wrong execution location"
	echo "Please run this script on dotfiles root folder."
	exit 1
fi


# =========================================================
# links
# =========================================================
ln -sf $(pwd)/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -sf $(pwd)/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -sf $(pwd)/dotfiles/tmux.conf ~/.tmux.conf


ln -sf $(pwd)/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
