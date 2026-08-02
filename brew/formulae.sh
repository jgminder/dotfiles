#!/bin/bash
set -euo pipefail

FORMULAE=(
  awscli
  bat
  cmake
  eza
  fd
  flex
  fzf
  gh
  git
  gradle
  herdr
  hunk
  jj
  lazygit
  maven
  neovim
  opencode
  rust
  starship
  stow
  tmux
  tpm
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
for formula in "${FORMULAE[@]}"; do
  brew install "$formula" || echo "Warning: failed to install formula '$formula' (see above); continuing"
done

echo ""
echo "Done!"
