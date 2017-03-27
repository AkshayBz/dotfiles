###### DISABLED! #######
# To enable:
# $ git submodule add https://github.com/zsh-users/antigen.git zsh/.antigen
# Then enable in `.zshrc`:
# source ~/.zsh/antigenrc.zsh
########################

# Add antigen defaults
# export _ANTIGEN_CACHE_ENABLED=true
source ~/.zsh/.antigen/antigen.zsh

# Load my custom plugins
# antigen bundle $HOME/.zsh/completions/zsh --no-local-clone

# Add Oh-My-ZSH as an API for plugins and theme
antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
colored-man-pages
command-not-found
git
nvm
zsh-users/zsh-syntax-highlighting # Needs to be before zsh-history-substring-search
zsh-users/zsh-autosuggestions --branch=develop
zsh-users/zsh-completions
zsh-users/zsh-history-substring-search
EOBUNDLES

# More bundles:
# docker
# rupa/z
# EOBUNDLES
# tmux


# Load OS specific bundles
if $ON_OSX; then
    antigen bundle brew
    antigen bundle brew-cask
    antigen bundle osx
    antigen bundle vagrant

    # Add This will add the stt command, to open an entire directory in Sublime Text.
    # Also, `subl` and `st` aliases to edit a single file.
    antigen bundle sublime
elif $ON_UBUNTU; then
    antigen bundle symfony2
fi

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

antigen theme denysdovhan/spaceship-zsh-theme spaceship

# More themes:
# antigen theme frmendes/geometry

# Done with antigen
antigen apply
