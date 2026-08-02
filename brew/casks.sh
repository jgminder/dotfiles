#!/bin/bash
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  echo "Not macOS. Skipping casks."
  exit 0
fi

CASKS=(
  # Add casks here
  chatgpt
  claude
  claude-code
  docker
  font-hack-nerd-font
  font-jetbrains-mono-nerd-font
  font-meslo-lg-nerd-font
  font-sf-mono-for-powerline
  font-sf-mono-nerd-font-ligaturized
  font-ubuntu-mono-nerd-font
  ghostty
  microsoft-teams
  rectangle
  visual-studio-code
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bootstrap.sh"

echo "Installing Homebrew casks..."
if [[ ${#CASKS[@]} -gt 0 ]]; then
  brew install --cask "${CASKS[@]}"
fi

echo ""
echo "Done!"
