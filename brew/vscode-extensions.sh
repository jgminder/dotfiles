#!/bin/bash
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  echo "Not macOS. Skipping VSCode extensions."
  exit 0
fi

EXTENSIONS=(
  anthropic.claude-code
  catppuccin.catppuccin-vsc
  catppuccin.catppuccin-vsc-icons
  docker.docker
  eamodio.gitlens
  github.github-vscode-theme
  ms-azuretools.vscode-containers
  ms-azuretools.vscode-docker
  ms-kubernetes-tools.vscode-kubernetes-tools
  ms-python.debugpy
  ms-python.python
  ms-python.vscode-pylance
  ms-python.vscode-python-envs
  ms-vscode-remote.remote-containers
  redhat.java
  redhat.vscode-yaml
  vscjava.migrate-java-to-azure
  vscjava.vscode-gradle
  vscjava.vscode-java-debug
  vscjava.vscode-java-dependency
  vscjava.vscode-java-pack
  vscjava.vscode-java-test
  vscjava.vscode-java-upgrade
  vscjava.vscode-maven
  vscodevim.vim
)

echo "Installing VSCode extensions..."
for extension in "${EXTENSIONS[@]}"; do
  code --install-extension "$extension" || echo "Warning: failed to install extension '$extension' (see above); continuing"
done

echo ""
echo "Done!"
