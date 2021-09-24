#
# Executes commands at login pre-zshrc.

# Browser
#

if $ON_OSX; then
    export BROWSER='open'
fi

#
# Editors
#

export EDITOR='nvim'
export VISUAL='nano'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path


# Set the list of directories that Zsh searches for programs.
path=(
    /usr/local/{bin,sbin}
    $HOME/bin
    $ZDOTDIR/bin
    $path
)

#
# Less
#

# Set the default Less options.
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
    export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
    export TMPDIR="/tmp/$LOGNAME"
    mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"


# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
if [[ -f "$PYENV_ROOT/libexec/pyenv" ]]; then
    path=($PYENV_ROOT/bin $path)
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export VIRTUAL_ENV_DISABLE_PROMPT=1
    eval "$(pyenv init - zsh)"
    eval "$(pyenv virtualenv-init - zsh)"
fi

# Direnv
(type direnv &> /dev/null) && eval "$(direnv hook zsh)"

# Auto start X server on tty 1
if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
