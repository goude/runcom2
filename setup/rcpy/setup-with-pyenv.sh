#!/usr/bin/env bash

# this allows pyenv to see Homebrew's python version
ln -s /usr/local/Cellar/python/* ~/.pyenv/versions/

pyenv virtualenv-delete neovim3

pyenv virtualenv system neovim3
