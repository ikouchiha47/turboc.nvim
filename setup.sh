#!/bin/bash

set -e

# Define variables
NVIM_DIR="${NVIM_APPNAME:-nvim}"
BRANCH_NAME="${BRANCH_NAME:-master}"
REPO_URL="https://github.com/ikouchiha47/turboc.nvim"

echo "Neovim directory is set to: $NVIM_DIR"

COLORS_TARGET_DIR="$HOME/.config/$NVIM_DIR/colors"
TMP_DIR="/tmp/theme"
GIT_TARGET_DIR="$COLORS_TARGET_DIR/turbovision"

# Ensure ~/.config/nvim/colors/ exists
mkdir -p "$COLORS_TARGET_DIR"

# cleanup temp
rm -rf "$TMP_DIR"

# Clone the repository if it doesn't exist
if [ ! -d "$GIT_TARGET_DIR" ]; then
  echo "Cloning the repository from $REPO_URL..."
  git clone -b "$BRANCH_NAME" "$REPO_URL" "$TMP_DIR"

  mv "${TMP_DIR}/turbovision" "$COLORS_TARGET_DIR/"
else
  echo "Repository already exists at $GIT_TARGET_DIR. Pulling latest changes..."
  git -C "$GIT_TARGET_DIR" pull
fi

echo "$GIT_TARGET_DIR/lua/turboc/init.lua"

tree -L 7 "$GIT_TARGET_DIR"

# Check if init.lua exists in the cloned repo
if [ -f "$GIT_TARGET_DIR/lua/turboc/init.lua" ]; then
  echo "Copying colorschemes to $COLORS_TARGET_DIR ..."
  cp "${GIT_TARGET_DIR}"/lua/turboc/colors/*.lua "$COLORS_TARGET_DIR"
else
  echo "Error: init.lua not found in the repository. Exiting."
  exit 1
fi

echo "Setup complete. You can now use ':colorscheme turboc' in Neovim."

