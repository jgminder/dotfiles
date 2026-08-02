#!/bin/bash
set -euo pipefail

bash "$HOME/dotfiles/install.sh"
exec "$@"
