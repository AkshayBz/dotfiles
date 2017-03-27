###### DISABLED! #######
# To enable:
# $ git submodule add https://github.com/zplug/zplug.git zsh/.zplug
# Then enable in `.zshrc`:
# source ~/.zsh/zplug.zsh
########################

# Load Zplug
source ~/.zsh/.zplug/init.zsh

# Needs to be before zsh-history-substring-search
zplug "zsh-users/zsh-syntax-highlighting"

# Load zsh-autosuggestions from develop branch
zplug "zsh-users/zsh-autosuggestions", at:develop

zplug "zsh-users/zsh-history-substring-search"

# Load my local plugins
zplug "~/.zsh/plugins", from:local

# Load spaceship theme
zplug '~/.zsh/themes', from:local, as:theme, use:"spaceship.zsh-theme"

# Customize: https://github.com/denysdovhan/spaceship-zsh-theme

SPACESHIP_PREFIX_ENV_DEFAULT=" "

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_PREFIX_DIR="@"
SPACESHIP_PREFIX_HOST=":"

SPACESHIP_DOCKER_SHOW=false
SPACESHIP_RUBY_SHOW=false
SPACESHIP_SWIFT_SHOW_GLOBAL=false
SPACESHIP_SWIFT_SHOW_LOCAL=false
SPACESHIP_GOLANG_SHOW=false

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# We done ✓
zplug load --verbose
