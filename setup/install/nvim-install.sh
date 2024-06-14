#!/usr/bin/env bash
set -e

mkdir -p ~/.nvim/
rm -rf ~/.nvim/nvim-linux64
cd ~/.nvim/

wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
tar xvzf nvim-linux64.tar.gz

rm nvim-linux64.tar.gz
rm -f ~/bin/nvim

ln -s ~/.nvim/nvim-linux64/bin/nvim ~/bin/
