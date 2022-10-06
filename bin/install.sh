#!/usr/bin/fish

# test working directory


# symlink
#ln -s ~/.config/fish/config.fish dotfiles/fish/config.fish
cp ~/.config/fish/config.fish (pwd)/dotfiles/fish/config.fish
ln -s (pwd)/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -s (pwd)/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -sf (pwd)/dotfiles/neovim/init.lua ~/.config/nvim/init.lua
ln -sf (pwd)/dotfiles/neovim/lua/plugins.lua ~/.config/nvim/lua/plugins.lua

