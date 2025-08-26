#!/usr/bin/bash
set -eu

# =========================================================
# check executing location
# =========================================================
# if [ ! -d "bin" -a ! -d "dotfiles" ]; then
# 	echo "Wrong execution location"
# 	echo "Please run this script on dotfiles root folder."
# 	exit 1
# fi
# TODO: check git in path
cd "$(git rev-parse --show-toplevel)"

# =========================================================
# links
# =========================================================
mkdir -p ~/.config/fish
ln -sf "$(pwd)/dotfiles/fish/config.fish" ~/.config/fish/config.fish
ln -sf "$(pwd)/dotfiles/starship/starship.toml" ~/.config/starship.toml
ln -sf "$(pwd)/dotfiles/tmux.conf" ~/.tmux.conf

# ln -s $(pwd)/dotfiles/neovim ~/.config/nvim
mkdir -p ~/.config/nvim
ln -sf "$(pwd)/dotfiles/neovim/init.lua" ~/.config/nvim/init.lua
mkdir -p ~/.config/nvim/lua
ln -sf "$(pwd)/dotfiles/neovim/lua/lualine_setup.lua" ~/.config/nvim/lua/lualine_setup.lua
ln -sf "$(pwd)/dotfiles/neovim/lua/term_powershell.lua" ~/.config/nvim/lua/term_powershell.lua
ln -sf "$(pwd)/dotfiles/neovim/lua/lsp_config.lua" ~/.config/nvim/lua/lsp_config.lua
ln -sf "$(pwd)/dotfiles/neovim/lua/pluto_nvim.lua" ~/.config/nvim/lua/pluto_nvim.lua
ln -sf "$(pwd)/dotfiles/neovim/lua/local_settings.lua" ~/.config/nvim/lua/local_settings.lua
mkdir -p ~/.config/nvim/lua/lspconfig/server_configurations
ln -sf "$(pwd)/dotfiles/neovim/lua/lspconfig/server_configurations/satysfi_ls.lua" ~/.config/nvim/lua/lspconfig/server_configurations/satysfi_ls.lua
ln -sf "$(pwd)/dotfiles/neovim/lua/lspconfig/server_configurations/jetls.lua" ~/.config/nvim/lua/lspconfig/server_configurations/jetls.lua
mkdir -p ~/.config/nvim/after/ftplugin
ln -sf "$(pwd)/dotfiles/neovim/after/ftplugin/satysfi.lua" ~/.config/nvim/after/ftplugin/satysfi.lua
ln -sf "$(pwd)/dotfiles/neovim/after/ftplugin/tex.lua" ~/.config/nvim/after/ftplugin/tex.lua
ln -sf "$(pwd)/dotfiles/neovim/after/ftplugin/typst.lua" ~/.config/nvim/after/ftplugin/typst.lua
ln -sf "$(pwd)/dotfiles/neovim/after/ftplugin/org.lua" ~/.config/nvim/after/ftplugin/org.lua
mkdir -p ~/.config/nvim/after/queries/satysfi
curl -o ~/.config/nvim/after/queries/satysfi/highlights.scm https://raw.githubusercontent.com/monaqa/tree-sitter-satysfi/master/queries/highlights.scm
curl -o ~/.config/nvim/after/queries/satysfi/indents.scm https://raw.githubusercontent.com/monaqa/tree-sitter-satysfi/master/queries/indents.scm
curl -o ~/.config/nvim/after/queries/satysfi/matchup.scm https://raw.githubusercontent.com/monaqa/tree-sitter-satysfi/master/queries/matchup.scm
mkdir -p ~/.config/nvim/after/queries/julia
ln -sf "$(pwd)/dotfiles/neovim/after/queries/julia/injections.scm" ~/.config/nvim/after/queries/julia/injections.scm
mkdir -p ~/.config/nvim/luasnippets
ln -sf "$(pwd)/dotfiles/neovim/luasnippets/all.lua" ~/.config/nvim/luasnippets/all.lua
mkdir -p ~/.config/nvim/luasnippets/satysfi
ln -sf "$(pwd)/dotfiles/neovim/luasnippets/satysfi/math.lua" ~/.config/nvim/luasnippets/satysfi/math.lua

mkdir -p ~/.julia/config
ln -sf "$(pwd)/dotfiles/startup_linux.jl" ~/.julia/config/startup.jl
curl -o ~/.julia/config/catppuccin.jl https://raw.githubusercontent.com/catppuccin/ohmyrepl/refs/heads/main/catppuccin.jl

mkdir -p ~/.config/lf
ln -sf "$(pwd)/dotfiles/lf/lfrc" ~/.config/lf/lfrc

ln -sf "$(pwd)/dotfiles/bat/config" "$(bat --config-file)"

mkdir -p ~/.config/yazi/
ln -sf "$(pwd)/dotfiles/yazi/init.lua" ~/.config/yazi/init.lua
ln -sf "$(pwd)/dotfiles/yazi/yazi.toml" ~/.config/yazi/yazi.toml
