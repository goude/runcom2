#!/usr/bin/env bash
set -e

# echo "Installing starship..."
curl -fsSL https://starship.rs/install.sh | bash -s -- --bin-dir="$HOME/bin"

echo "shellcheck, shfmt for editing (TODO)"
