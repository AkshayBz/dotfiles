#                   ██
#                  ░██
#    ██████  ██████░██      ██████  █████
#   ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#      ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░
#     ██    ░░░░░██░██  ░██ ░██   ░██   ██
#    ██████ ██████ ░██  ░██░███   ░░█████
#   ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░

export ZPLUG_HOME=${HOME}/.zsh/zplug
export NVM_LAZY_LOAD=true
export PHPBREW_LAZY_LOAD=true

#zmodload zsh/zprof
source ${HOME}/.zsh/zplug.zsh

[ -f "${HOME}/.zsh/functions.zsh" ] && source ${HOME}/.zsh/functions.zsh
[ -f "${HOME}/.zsh/aliases.zsh" ] && source ${HOME}/.zsh/aliases.zsh

# Get rid of conflicting aliases
unalias d 2> /dev/null

[ -f "${HOME}/.zsh/local.zsh" ] && source ~/.zsh/local.zsh
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# Enable comments in command line
setopt INTERACTIVE_COMMENTS
#zprof > ~/zprof.log
