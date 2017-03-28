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

# Colored man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        PAGER="${commands[less]:-$PAGER}" \
        _NROFF_U=1 \
        PATH="$HOME/bin:$PATH" \
            man "$@"
}
