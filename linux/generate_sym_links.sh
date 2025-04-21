#!/usr/bin/env bash

set -euo pipefail

# Directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Link files under .config
echo "Linking .config files..."
CONFIG_DIR="$HOME/.config"
mkdir -p "$CONFIG_DIR"

find "$SCRIPT_DIR/.config" -mindepth 1 -type d | while read -r dir; do
    target="$CONFIG_DIR/$(realpath --relative-to="$SCRIPT_DIR/.config" "$dir")"
    mkdir -p "$target"
done

find "$SCRIPT_DIR/.config" -type f | while read -r file; do
    rel_path="$(realpath --relative-to="$SCRIPT_DIR/.config" "$file")"
    target="$CONFIG_DIR/$rel_path"
    ln -sf "$file" "$target"
    echo "Linked $target"
done

# Link top-level dotfiles (e.g. .zshrc, init_linux_configs.sh)
echo "Linking top-level dotfiles..."
find "$SCRIPT_DIR" -maxdepth 1 -type f \( -name ".*" -o -name "*.sh" \) | while read -r file; do
    filename="$(basename "$file")"
    ln -sf "$file" "$HOME/$filename"
    echo "Linked $HOME/$filename"
done
