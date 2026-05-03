#!/usr/bin/env bash

set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is required but was not found in PATH." >&2
    exit 1
fi

brew_packages=(
    bash-language-server
    docker-language-server
    fd
    ghostscript
    go
    gopls
    hadolint
    imagemagick
    lua-language-server
    pyright
    ruff
    shfmt
    stylua
    tectonic
    terraform-ls
    tflint
    tree-sitter-cli
    yamlfmt
    yaml-language-server
    yarn
)

echo "Installing Neovim dependencies with Homebrew..."
brew install "${brew_packages[@]}"

echo "Installing Go tools..."
go install golang.org/x/tools/cmd/goimports@latest

python_venv="$HOME/.venvs/nvim"
if [[ ! -x "$python_venv/bin/python" ]]; then
    echo "Creating Python host virtualenv at $python_venv"
    python3 -m venv "$python_venv"
fi

"$python_venv/bin/pip" install -U pip pynvim

echo "Done. Restart Neovim after installation."
