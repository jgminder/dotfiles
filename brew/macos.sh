#!/bin/bash
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  echo "Not macOS. Skipping macOS formulae."
  exit 0
fi

FORMULAE=(
  ast-grep
  autoconf
  bash
  binutils
  coreutils
  curl
  diffutils
  ed
  findutils
  gawk
  gnu-indent
  gnu-sed
  gnu-tar
  gnu-which
  gpatch
  grep
  gzip
  less
  make
  wdiff
  wget
  zip
)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/bootstrap.sh"

echo "Installing macOS Homebrew formulae..."
if [[ ${#FORMULAE[@]} -gt 0 ]]; then
  brew install "${FORMULAE[@]}"
fi

echo ""
echo "Done!"
