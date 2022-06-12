#!/bin/bash
source "$HOME/.nvm/nvm.sh"
nvm use node

npm install -g npm@latest jsonlint eslint eslint-plugin-react tern neovim prettier stylelint stylelint-config-recommended yarn textlint live-server

# remark-preset-lint-markdown-style-guide for hyphens instead of asterixii

#npm install -g npm@latest htmlhint jsonlint base16-builder-node eslint eslint-plugin-react tern tldr neovim prettier stylelint

# TODO: check https://github.com/sindresorhus/awesome-nodejs

# build base16
#mkdir -p $HOME/.local/share/base16
#cd $HOME/.local/share/base16
#base16 builder
