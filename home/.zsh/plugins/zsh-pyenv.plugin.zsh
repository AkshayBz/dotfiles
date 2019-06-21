[[ -z "$PYENV_ROOT" ]] && export PYENV_ROOT="$HOME/.pyenv"

_zsh_pyenv_install() {
    echo "Installing pyenv..."
    git clone "https://github.com/pyenv/pyenv" "${PYENV_HOME}"
}

_zsh_pyenv_load() {
    path=($PYENV_ROOT/bin $path)
    eval "$(pyenv init -)"
}

if [[ -f "$PYENV_ROOT/libexec/pyenv" ]]; then
    _zsh_pyenv_load
fi
