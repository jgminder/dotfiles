#!/bin/bash
set -euo pipefail

if command -v brew &>/dev/null; then
  return 0 2>/dev/null || true
fi

echo "Homebrew not found. Installing..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [[ "$(uname)" == "Darwin" ]]; then
  BREW_BIN="/opt/homebrew/bin/brew"
  BREW_SHELLENV="eval \"\$(${BREW_BIN} shellenv)\""
else
  BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
  BREW_SHELLENV="eval \"\$(${BREW_BIN} shellenv)\""
fi

eval "${BREW_SHELLENV}"

ZSHRC="$HOME/.zshrc"
if [[ -f "$ZSHRC" ]] && ! grep -qF "$BREW_SHELLENV" "$ZSHRC"; then
  echo "" >>"$ZSHRC"
  echo "# Homebrew" >>"$ZSHRC"
  echo "$BREW_SHELLENV" >>"$ZSHRC"
  echo "Added Homebrew to .zshrc"
fi
