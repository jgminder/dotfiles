#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash "$SCRIPT_DIR/formulae.sh"
bash "$SCRIPT_DIR/macos.sh"
bash "$SCRIPT_DIR/casks.sh"
bash "$SCRIPT_DIR/vscode-extensions.sh"
