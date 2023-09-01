#!/usr/bin/env bash
set -e

mkdir -p ~/.nvim/
cd ~/.nvim/

wget https://github.com/neovim/neovim/releases/download/v0.9.1/nvim-linux64.tar.gz
#sudo dpkg -i nvim-linux64.deb
tar xvzf nvim-linux64.tar.gz

rm nvim-linux64.tar.gz
rm ~/bin/nvim
rm -rf ~/.local/share/nvim

ln -s ~/.nvim/nvim-linux64/bin/nvim ~/bin/

cd ~/.config/nvim
~/.config/nvim/install_packer.sh
~/.config/nvim/install_lang_servers.sh

echo "Hint: :TSUpdate may fix treesitter problems."
