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
ln -sf $(pwd)/dotfiles/neovim/lua/lualine_setup.lua ~/.config/nvim/lua/lualine_setup.lua
mkdir -p ~/.config/nvim/lua/lspconfig/server_configurations
ln -sf $(pwd)/dotfiles/neovim/lua/lspconfig/server_configurations/satysfi_ls.lua ~/.config/nvim/lua/lspconfig/server_configurations/satysfi_ls.lua
mkdir -p ~/.config/nvim/after/ftplugin
ln -sf $(pwd)/dotfiles/neovim/after/ftplugin/satysfi.lua ~/.config/nvim/after/ftplugin/satysfi.lua
ln -sf $(pwd)/dotfiles/neovim/after/ftplugin/tex.lua ~/.config/nvim/after/ftplugin/tex.lua
mkdir -p ~/.config/nvim/after/queries/satysfi
curl -o ~/.config/nvim/after/queries/satysfi/highlights.scm https://raw.githubusercontent.com/monaqa/tree-sitter-satysfi/master/queries/highlights.scm
curl -o ~/.config/nvim/after/queries/satysfi/indents.scm https://raw.githubusercontent.com/monaqa/tree-sitter-satysfi/master/queries/indents.scm
curl -o ~/.config/nvim/after/queries/satysfi/matchup.scm https://raw.githubusercontent.com/monaqa/tree-sitter-satysfi/master/queries/matchup.scm

