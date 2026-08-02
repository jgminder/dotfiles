#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash "$DOTFILES_DIR/brew/install.sh"

if [[ "$(uname)" == "Darwin" ]]; then
  BREW_BIN="/opt/homebrew/bin/brew"
else
  BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
fi
eval "$("$BREW_BIN" shellenv)"

# LazyVim starter isn't tracked in this repo since it's unmodified upstream;
# stow only overlays our plugin config (stow/nvim/.config/nvim/lua/plugins) on top.
if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
fi

echo "Linking dotfiles with stow..."
stow --dir="$DOTFILES_DIR/stow" --target="$HOME" --restow zsh nvim tmux

# TPM isn't tracked in this repo since it's unmodified upstream; it reads
# plugins from the stowed .tmux.conf, so it must run after stow above.
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
"$HOME/.tmux/plugins/tpm/bin/install_plugins"

echo "Done!"
