#!/usr/bin/env bash

source "$RUNCOM2_PATH/rc.pyenv"
source "$RUNCOM2_PATH/localenv"

# this allows pyenv to see Homebrew's python version
ln -s /usr/local/Cellar/python/* ~/.pyenv/versions/

# to detect system python:
# sudo ln -s /usr/bin/python3 /usr/bin/python
# or use python3-is-python package
pyenv install 3.7.9

pyenv virtualenv-delete neovim3

pyenv virtualenv 3.7.9 neovim3
