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
  docker-desktop
  font-hack-nerd-font
  font-jetbrains-mono-nerd-font
  font-meslo-lg-nerd-font
  font-sf-mono-for-powerline
  font-sf-mono-nerd-font-ligaturized
  font-ubuntu-mono-nerd-font
  ghostty
  jellyfin
  microsoft-teams
  qbittorrent
  rectangle
  slack
  visual-studio-code
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bootstrap.sh"

echo "Installing Homebrew casks..."
for cask in "${CASKS[@]}"; do
  brew install --cask "$cask" || echo "Warning: failed to install cask '$cask' (see above); continuing"
done

echo ""
echo "Done!"
