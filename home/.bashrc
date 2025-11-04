# ~/.bashrc

# User-specific shell configuration for bash

# Set up environment variables
export EDITOR=nvim
export VISUAL=nvim
export PATH="$HOME/bin:$PATH"

# Aliases
alias ll='ls -la'
alias gs='git status'
alias gp='git pull'
alias gc='git commit'
alias gco='git checkout'

# Enable color support for ls and grep
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagacad

# Load additional scripts if they exist
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

# Source the profile
if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

eval "$(starship init bash)"