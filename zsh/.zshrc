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

# Enable custom themes
fpath=(${HOME}/.zsh/themes $fpath)

# Prezto time!
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Custom functions
source ~/.zsh/functions.zsh

# My precious aliases!
source ~/.zsh/aliases.zsh

# Get rid of conflicting aliases
unalias d 2> /dev/null

# Add our custom scripts to path
path=(${HOME}/.zsh/bin $path)

# Non-Prezto plugins
if $ON_OSX; then
    source ~/.zsh/plugins/sublime.plugin.zsh
    export HOMEBREW_NO_ANALYTICS=1
fi

if [ -f "${HOME}/.zsh/local.zsh" ]; then
    # If local.zsh exists, source it
    source ~/.zsh/local.zsh
fi

# Enable comments in command line
setopt INTERACTIVE_COMMENTS
