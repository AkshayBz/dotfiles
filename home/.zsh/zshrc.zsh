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

zmodload zsh/zprof
source ${HOME}/.zsh/zplug.zsh

# Get rid of conflicting aliases
unalias d 2> /dev/null

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

zprof >! ~/zprof.log
