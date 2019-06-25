function zsh-reload {
    # exec zsh
    source ~/.zshrc
}

# Helper function to check if a program exists
function exists {
    command -v "$1" >/dev/null 2>&1
}

# Use less as pager for httpie
function httpp {
    http --pretty=all --print=hb "$@" | less -R;
}
