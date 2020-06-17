#!/usr/bin/env bash
set -e

source "$RUNCOM2_PATH/rc.pyenv"
source "$RUNCOM2_PATH/localenv"

$RUNCOM2_PIPENV_CMD --python 3
ln -sf "$($RUNCOM2_PIPENV_CMD run pyenv which python3)" ~/bin/neovim-python3
ln -sf "$($RUNCOM2_PIPENV_CMD run pyenv which pip3)" ~/bin/neovim-pip3

$RUNCOM2_PIPENV_CMD install --skip-lock \
  autopep8 \
  black \
  docker-compose \
  flake8 \
  httpie \
  icdiff \
  isort \
  jedi \
  mypy \
  pipx \
  neovim \
  pynvim \
  pytest \
  pydocstyle \
  reorder-python-imports \
  requests \
  tmuxp \
  topydo \
  vim-vint \
  visidata \
  yamllint \
  yapf

$RUNCOM2_PIPENV_CMD run pyenv rehash

pyenv_symlinks=(
  "black"
  "docker-compose"
  "flake8"
  "git-icdiff"
  "http"
  "icdiff"
  "isort"
  "mypy"
  "pipx"
  "pydocstyle"
  "reorder-python-imports"
  "tmuxp"
  "topydo"
  "vd"
  "yapf"
)

for i in "${pyenv_symlinks[@]}"
do
  echo "Symlinking $i to ~/bin/..."
  ln -sf "$($RUNCOM2_PIPENV_CMD run pyenv which $i)" "$HOME/bin/$i"
done
