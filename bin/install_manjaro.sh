#!/usr/bin/bash
set -eu

# alacritty config
ln -sf $(pwd)/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/wezterm
ln -sf $(pwd)/dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
