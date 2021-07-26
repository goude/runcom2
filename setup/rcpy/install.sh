#!/usr/bin/env bash
set -e

echo "Setting up virtualenv for neovim3 aka runcom-py aka rcpy..."
echo "Now using python -m venv because pyenv is broken."

./setup-neovim3-venv.sh
