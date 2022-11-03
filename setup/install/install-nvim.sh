#!/usr/bin/env bash
set -e

cd ~/tmp/

wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb
sudo dpkg -i nvim-linux64.deb

rm -rf ~/.local/share/nvim

cd ~/.config/nvim
~/.config/nvim/install_packer.sh

