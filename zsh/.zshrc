#                   ██
#                  ░██
#    ██████  ██████░██      ██████  █████
#   ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#      ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#     ██    ░░░░░██░██  ░██ ░██   ░██   ██
#    ██████ ██████ ░██  ░██░███   ░░█████
#   ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░

# Commonly Changed settings
# motd_mode='updates'
# multiline_prompt='true'
# show_if_system='false'

source ~/.zsh/bindkeys.zsh

# Prezto time!
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Custom functions
source ~/.zsh/functions.zsh

# My precious aliases!
source ~/.zsh/aliases.zsh

# Add our custom scripts to path
export PATH=${PATH}:$HOME/.zsh/bin

if [ -f "$HOME/.zsh/local.zsh" ]; then
    # If local.zsh exists, source it
    source ~/.zsh/local.zsh
fi
