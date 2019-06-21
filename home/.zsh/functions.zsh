zsh-reload() {
    # exec zsh
    source ~/.zshrc
}

# Helper function to check if a program exists
exists() {
    command -v "$1" >/dev/null 2>&1
}
