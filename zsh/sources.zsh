# Add Node Version Manager
export NVM_ROOT="$HOME/.nvm"
[ -f "$NVM_ROOT/nvm.sh" ] && source "$NVM_ROOT/nvm.sh"

if $ON_OSX; then
    export HOMEBREW_NO_ANALYTICS=1
    # homebrew path
    export PATH="/usr/local/sbin:$PATH"
else
    # I don't use phpbrew on MacOS
    export PHPBREW_ROOT="$HOME/.phpbrew"
    if [ -d "${PHPBREW_ROOT}" ]; then
        source $PHPBREW_ROOT/bashrc
    fi
fi

export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Add our custom scripts to path
PATH=${PATH}:$HOME/.zsh/bin
PATH=${PATH}:"$HOME"/.composer/vendor/bin

export PATH=${PATH}
