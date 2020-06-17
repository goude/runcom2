#!/usr/bin/env bash
echo "Setting up pipenv using system pip3..."

SYSTEM_PIP=/usr/local/bin/pip3

$SYSTEM_PIP install --user pipenv
ln -sf /usr/local/bin/pipenv ~/bin/pipenv
