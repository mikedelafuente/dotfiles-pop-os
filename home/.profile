# This file is executed at login and is used to set up the user environment.

# Set environment variables
export EDITOR=nvim
export VISUAL=nvim

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Add custom bin directories to PATH

if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

. "$HOME/.cargo/env"
