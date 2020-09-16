#!/usr/bin/env bash
set -e

source "$RUNCOM2_PATH/rc.pyenv"
source "$RUNCOM2_PATH/localenv"

pyenv activate 3.7.9/envs/neovim3

ln -sf "$(pyenv which python3)" ~/bin/neovim-python3
ln -sf "$(pyenv which pip3)" ~/bin/neovim-pip3
ln -sf "$(pyenv which pip)" ~/bin/neovim-pip

pip_cmd="$(pyenv which pip)"

$pip_cmd install --upgrade pip wheel

$pip_cmd install --upgrade \
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

pyenv rehash

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
  "yamllint"
)

for i in "${pyenv_symlinks[@]}"
do
  echo "Symlinking $i to ~/bin/..."
  ln -sf "$(pyenv which $i)" "$HOME/bin/$i"
done
