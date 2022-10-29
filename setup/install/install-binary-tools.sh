#!/usr/bin/env bash
set -e

echo "Installing starship..."
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --bin-dir="$HOME/bin"

echo "Installing shfmt..."
curl -L https://github.com/mvdan/sh/releases/download/v3.3.1/shfmt_v3.3.1_linux_amd64 -o "$HOME/bin/shfmt"
chmod a+x "$HOME/bin/shfmt"

echo "Installing rust-analyzer..."
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/bin/rust-analyzer
chmod +x ~/bin/rust-analyzer

echo "Installing charm stuff..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install glow skate gum vhs
