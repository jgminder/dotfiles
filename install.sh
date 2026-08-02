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
# stow only overlays our config (stow/nvim/.config/nvim/lua) on top.
if [[ ! -d "$HOME/.config/nvim" ]]; then
  git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
  rm -rf "$HOME/.config/nvim/.git"
fi

# This repo is the source of truth: any real (non-symlink) file already
# sitting at a path one of our stow packages wants to own - e.g. a
# pre-existing ~/.zshrc, or the LazyVim starter's stub keymaps.lua - would
# make stow refuse to link. Move those aside instead of deleting them, so
# nothing is lost but the repo's version always wins.
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
for pkg in zsh nvim tmux ghostty; do
  while IFS= read -r -d '' src; do
    rel="${src#"$DOTFILES_DIR/stow/$pkg/"}"
    target="$HOME/$rel"
    if [[ -e "$target" || -L "$target" ]] && ! [[ "$target" -ef "$src" ]]; then
      mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
      mv "$target" "$BACKUP_DIR/$rel"
      echo "Backed up existing $target -> $BACKUP_DIR/$rel"
    fi
  done < <(find "$DOTFILES_DIR/stow/$pkg" -type f -print0)
done
rmdir "$BACKUP_DIR" 2>/dev/null || echo "Conflicting files backed up to $BACKUP_DIR"

echo "Linking dotfiles with stow..."
stow --dir="$DOTFILES_DIR/stow" --target="$HOME" --restow zsh nvim tmux ghostty

# TPM comes from the tpm brew formula (see brew/formulae.sh) rather than a
# git clone; it reads plugins from the stowed .tmux.conf, so it must run
# after stow above.
"$BREW_PREFIX/opt/tpm/share/tpm/bin/install_plugins"

echo "Done!"
