#!/usr/bin/env bash

# this allows pyenv to see Homebrew's python version
ln -s /usr/local/Cellar/python/* ~/.pyenv/versions/

# to detect system python:
# sudo ln -s /usr/bin/python3 /usr/bin/python
# or use python3-is-python package

pyenv virtualenv-delete neovim3

pyenv virtualenv system neovim3
