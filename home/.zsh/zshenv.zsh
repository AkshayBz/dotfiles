#
# Defines environment variables.
# Should be as small as possible
#

export ON_UBUNTU=false
export ON_OSX=false
if [[ "$OSTYPE" == "linux"* && "$(. /etc/os-release; echo $NAME)" == "Ubuntu" ]]; then
    ON_UBUNTU=true
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ON_OSX=true
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprofile"
fi

if $ON_OSX; then
    export HOMEBREW_NO_ANALYTICS=1
fi

export COMPOSE_CONVERT_WINDOWS_PATHS=1
