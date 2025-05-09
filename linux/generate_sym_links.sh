#!/usr/bin/env bash

set -euo pipefail

# Directory where this script resides
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Link files under .config
echo "Linking .config files..."
CONFIG_DIR="$HOME/.config"
mkdir -p "$CONFIG_DIR"

# Loop through each entry in $SCRIPT_DIR/.config and link it into $HOME/.config
for item in "$SCRIPT_DIR/.config/"*; do
  target="$CONFIG_DIR/$(basename "$item")"
  if [ -e "$target" ] || [ -L "$target" ]; then
    echo "Skipping existing $target"
  else
    ln -s "$item" "$target"
    echo "Linked $item → $target"
  fi
done

# Link .zshrc
ZSHRC_SOURCE="$SCRIPT_DIR/.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"
if [ -e "$ZSHRC_TARGET" ] || [ -L "$ZSHRC_TARGET" ]; then
  echo "Skipping existing $ZSHRC_TARGET"
else
  ln -s "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
  echo "Linked $ZSHRC_SOURCE → $ZSHRC_TARGET"
fi

# Link .gitconfig
GITCONFIG_SOURCE="$SCRIPT_DIR/.gitconfig"
GITCONFIG_TARGET="$HOME/.gitconfig"
if [ -e "$GITCONFIG_TARGET" ] || [ -L "$GITCONFIG_TARGET" ]; then
  echo "Skipping existing $GITCONFIG_TARGET"
else
  ln -s "$GITCONFIG_SOURCE" "$GITCONFIG_TARGET"
  echo "Linked $GITCONFIG_SOURCE → $GITCONFIG_TARGET"
fi

# Link .inputrc
INPUTRC_SOURCE="$SCRIPT_DIR/.inputrc"
INPUTRC_TARGET="$HOME/.inputrc"
if [ -e "$INPUTRC_TARGET" ] || [ -L "$INPUTRC_TARGET" ]; then
  echo "Skipping existing $INPUTRC_TARGET"
else
  ln -s "$INPUTRC_SOURCE" "$INPUTRC_TARGET"
  echo "Linked $INPUTRC_SOURCE → $INPUTRC_TARGET"
fi

