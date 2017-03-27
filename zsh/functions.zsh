zsh-reload() {
    # Clear Antigen cache
    # exists antigen && antigen reset
    # exists zplug && zplug clear
    # Reread zshrc
    source $HOME/.zshrc
}

# Helper function to check if a program exists
exists() {
    command -v "$1" >/dev/null 2>&1
}

gdiff() {
    if exists diff-so-fancy; then
        git diff | diff-so-fancy
    else
        git diff
    fi
}
