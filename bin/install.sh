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
mkdir -p ~/.config/fish
ln -sf $(pwd)/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -sf $(pwd)/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -sf $(pwd)/dotfiles/tmux.conf ~/.tmux.conf

mkdir -p ~/.config/nvim
ln -sf $(pwd)/dotfiles/neovim/init.lua ~/.config/nvim/init.lua
mkdir -p ~/.config/nvim/lua
ln -sf $(pwd)/dotfiles/neovim/lua/plugins.lua ~/.config/nvim/lua/plugins.lua
ln -sf $(pwd)/dotfiles/neovim/lua/lualine_setup.lua ~/.config/nvim/lua/lualine_setup.lua

