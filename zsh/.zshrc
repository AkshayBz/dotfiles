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

source ~/.zsh/preload.zsh # To be loaded before all else

source ~/.zsh/bindkeys.zsh

# Load zplug
source ~/.zsh/zplug.zsh

# Load antigen
# source ~/.zsh/antigenrc.zsh

# Enable antigen caching
# antigen init ~/.zsh/antigenrc.zsh

# Load other stuff

source ~/.zsh/history.zsh
source ~/.zsh/sources.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/functions.zsh

# source ~/.zsh/colors.zsh
# source ~/.zsh/motd.zsh

# My precious aliases!
source ~/.zsh/aliases.zsh
if [ -f "$HOME/.zsh/local.zsh" ]; then
    # If local.zsh exists, source it
    source ~/.zsh/local.zsh
fi
