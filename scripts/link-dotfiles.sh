#!/bin/bash

# --------------------------
# Import Common Header 
# --------------------------

# add header file
CURRENT_FILE_DIR="$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)"

# source header (uses SCRIPT_DIR and loads lib.sh)
if [ -r "$CURRENT_FILE_DIR/dotheader.sh" ]; then
  # shellcheck source=/dev/null
  source "$CURRENT_FILE_DIR/dotheader.sh"
else
  echo "Missing header file: $CURRENT_FILE_DIR/dotheader.sh"
  exit 1
fi

# --------------------------
# End Import Common Header 
# --------------------------

print_tool_setup_start "Linking dotfiles"

# Create symbolic links for dotfiles in the home directory

HOME_DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/home"
CONFIG_DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/.config"


for file in .bashrc .profile .gitconfig .gitignore_global; do
  target="$HOME/$file"
  source_file="$HOME_DOTFILES_DIR/$file"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Warning: $target exists and is not a symlink."
    echo "Backing up existing $target to $target.backup"
    mv "$target" "$target.backup"
  elif [ -L "$target" ]; then
    echo "Overwriting existing symlink $target"
  fi
  ln -sf "$source_file" "$target"
done

# iterate over all files in the .config directory recursively and create symlinks
# Create directories as needed
CONFIG_SOURCE_DIR="$CONFIG_DOTFILES_DIR"
CONFIG_TARGET_DIR="$HOME/.config"
mkdir -p "$CONFIG_TARGET_DIR"

find "$CONFIG_SOURCE_DIR" -type f | while read -r file; do
  relative_path="${file#$CONFIG_SOURCE_DIR/}"
  target="$CONFIG_TARGET_DIR/$relative_path"
  source_file="$file"
  target_dir="$(dirname "$target")"
  mkdir -p "$target_dir"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Warning: $target exists and is not a symlink."
    echo "Backing up existing $target to $target.backup"
    mv "$target" "$target.backup"
  elif [ -L "$target" ]; then
    echo "Overwriting existing symlink $target"
  fi
  ln -sf "$source_file" "$target"
done


print_tool_setup_complete "Linking dotfiles"