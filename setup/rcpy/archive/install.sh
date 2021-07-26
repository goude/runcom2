#!/usr/bin/env bash
set -e

echo "Setting up rcpy..."

./setup-pyenv.sh
./setup-pyenv-environment.sh
./setup-neovim3.sh
