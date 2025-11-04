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

print_tool_setup_start "Fonts"

# Update this array to install different fonts if desired
NERD_FONTS=("Meslo" "Ubuntu" "FiraCode" "JetBrainsMono" "Hack")

# iterate through the array and install each font
for FONT in "${NERD_FONTS[@]}"; do
    if [ ! -d "$HOME/.local/share/fonts/NerdFonts/$FONT" ]; then
        print_info_message "Installing $FONT Nerd Font"
        mkdir -p "$HOME/.local/share/fonts/NerdFonts/$FONT"
        cd "$HOME/.local/share/fonts/NerdFonts/$FONT" || exit 1
        wget "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$FONT.zip"
        unzip "$FONT.zip"
        rm "$FONT.zip"
    fi
done

# Refresh font cache
fc-cache -fv

print_tool_setup_complete "Fonts"