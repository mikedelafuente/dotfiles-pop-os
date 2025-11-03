# This file is executed at login and is used to set up the user environment.

# Set environment variables
export EDITOR=nvim
export VISUAL=nvim

# Add custom bin directory to PATH
export PATH="$HOME/bin:$PATH"

# Load additional shell configurations
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

if [ -f "$HOME/.zshrc" ]; then
    . "$HOME/.zshrc"
fi