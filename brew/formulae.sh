#!/bin/bash
set -euo pipefail

FORMULAE=(
  awscli
  bat
  eza
  fd
  flex
  fzf
  git
  gradle
  herdr
  lazygit
  maven
  neovim
  opencode
  starship
  stow
  tmux
  tree
  tree-sitter-cli
  uv
  watch
  zoxide
  zsh
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bootstrap.sh"

echo "Installing Homebrew formulae..."
if [[ ${#FORMULAE[@]} -gt 0 ]]; then
  brew install "${FORMULAE[@]}"
fi

echo ""
echo "Done!"
