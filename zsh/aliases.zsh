# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Symfony
alias sf="app/console"
alias sfcc="sf cache:cl"
alias sfmig="sf doc:mig:mig -n"

# Git, most aliases are in ~/.gitconfig
alias g="git"
alias gp="g pull"
alias gs="git stash"
alias gu="gs && gp && gs pop" # Git update.
alias gcm="g commit -m"
alias gpo="g push origin HEAD"

# Virtualenv
alias activate=". venv/bin/activate"

# OS Specific aliases

if $ON_OSX; then
    # Mac specific alias
    alias pubkey="pbcopy < ~/.ssh/id_rsa.pub | printf '=> Public key copied to pasteboard.\n'";
fi
