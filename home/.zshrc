# .zshrc

# Zsh configuration file

# Set the default editor
export EDITOR='nvim'

# Enable command auto-correction
setopt correct

# Enable syntax highlighting
source $ZSH/oh-my-zsh.sh

# Aliases
alias ll='ls -la'
alias gs='git status'
alias gp='git pull'
alias gc='git commit'
alias gco='git checkout'

# Custom prompt
autoload -Uz promptinit
promptinit
prompt adam1

# Load custom scripts
for script in $HOME/bin/custom-scripts/*; do
    [ -f "$script" ] && source "$script"
done

# Add user-specific bin directory to PATH
export PATH="$HOME/bin:$PATH"