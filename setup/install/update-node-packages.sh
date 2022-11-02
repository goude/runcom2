#!/bin/bash
source "$HOME/.nvm/nvm.sh"
nvm use node

npm install -g npm@latest jsonlint eslint eslint-plugin-react tern neovim prettier stylelint stylelint-config-recommended yarn textlint live-server

../../home/.config/nvim/install_lang_servers.sh
