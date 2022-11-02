#!/usr/bin/env bash
set -e

cd ~/tmp/

wget https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.deb
dpkg -i nvim-linux64.deb

cd ~/.config/nvim
~/.config/nvim/install_packer.sh

