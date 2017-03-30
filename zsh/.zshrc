#                   ██
#                  ░██
#    ██████  ██████░██      ██████  █████
#   ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#      ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#     ██    ░░░░░██░██  ░██ ░██   ░██   ██
#    ██████ ██████ ░██  ░██░███   ░░█████
#   ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░

source ~/.zsh/bindkeys.zsh

# Non-Prezto plugins!
export NVM_LAZY_LOAD=true
source ~/.zsh/plugins/zsh-nvm.plugin.zsh

export PHPBREW_LAZY_LOAD=true
source ~/.zsh/plugins/lazy-phpbrew.plugin.zsh

# Prezto time!
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Custom functions
source ~/.zsh/functions.zsh

# My precious aliases!
source ~/.zsh/aliases.zsh

# Get rid of conflicting aliases
unalias d

# Add our custom scripts to path, if it's not there already
export -U PATH="${PATH}:${HOME}/.zsh/bin"

# Non-Prezto plugins
if $ON_OSX; then
    source ~/.zsh/plugins/sublime.plugin.zsh
    export HOMEBREW_NO_ANALYTICS=1
    export -U PATH="/usr/local/sbin:${PATH}" # homebrew path
fi

if [ -f "${HOME}/.zsh/local.zsh" ]; then
    # If local.zsh exists, source it
    source ~/.zsh/local.zsh
fi

# Enable comments in command line
setopt INTERACTIVE_COMMENTS
