#!/bin/bash

# --- Import Common Header --- 

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

# --- End Import Common Header ---
print_tool_setup_start "Bash"
# Install Bash if not already installed
if ! command -v bash &> /dev/null; then
    print_info_message "Installing Bash"
    sudo apt install -y bash
else
    print_info_message "Bash is already installed. Skipping installation."
fi  


# Set Bash as the default shell
if [ "$SHELL" != "$(which bash)" ]; then
    print_info_message "Changing default shell to bash"
    chsh -s "$(which bash)"
else
    print_info_message "Bash is already the default shell. Skipping change."
fi

print_tool_setup_complete "Bash"