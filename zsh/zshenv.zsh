#
# Defines environment variables.
# Should be as small as possible
#

# Let"s detect OS first
export ON_UBUNTU=false
export ON_OSX=false

if [[ "$OSTYPE" == "linux"* && "$(. /etc/os-release; echo $NAME)" == "Ubuntu" ]]; then
    ON_UBUNTU=true
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ON_OSX=true
fi

if [[ `uname` == "Linux" ]]; then
    # Support more than 256 colors
    export TERM="xterm-256color"
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# Use vim
export EDITOR=vi
