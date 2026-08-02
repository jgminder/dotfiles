#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash "$DOTFILES_DIR/brew/install.sh"

if [[ "$(uname)" == "Darwin" ]]; then
  BREW_PREFIX="/opt/homebrew"
else
  BREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi
eval "$("$BREW_PREFIX/bin/brew" shellenv)"

# LazyVim starter isn't tracked in this repo since it's unmodified upstream;
# stow only overlays our config (stow/nvim/.config/nvim/lua) on top. Starter
# ships placeholder stub files at some of those same paths, so remove ours'
# targets first or stow can't replace them with symlinks.
if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
  rm -f "$HOME/.config/nvim/lua/config/keymaps.lua"
fi

echo "Linking dotfiles with stow..."
stow --dir="$DOTFILES_DIR/stow" --target="$HOME" --restow zsh nvim tmux

# TPM comes from the tpm brew formula (see brew/formulae.sh) rather than a
# git clone; it reads plugins from the stowed .tmux.conf, so it must run
# after stow above.
"$BREW_PREFIX/opt/tpm/share/tpm/bin/install_plugins"

echo "Done!"
