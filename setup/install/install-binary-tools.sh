#!/usr/bin/env bash
set -e

echo "Installing starship..."
# curl -fsSL https://starship.rs/install.sh | bash -s -- --bin-dir="$HOME/bin"
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --bin-dir="$HOME/bin"

echo "Installing shfmt..."
curl -L https://github.com/mvdan/sh/releases/download/v3.3.1/shfmt_v3.3.1_linux_amd64 -o "$HOME/bin/shfmt"
chmod a+x "$HOME/bin/shfmt"
