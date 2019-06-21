# ls
alias ls='ls --color=auto --group-directories-first -F'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Symfony
alias sf="app/console"
alias sfcc="sf cache:cl"
alias sfmig="sf doc:mig:mig -n"

# Git, most aliases are in ~/.gitconfig
alias g="git"
alias gg="git grep"
alias gp="git pull"
alias gs="git stash"
alias gu="git stash && git pull && git stash pop" # Git update.
alias gcm="git commit -m"
alias gpo="git push origin HEAD"

# Virtualenv
alias activate=". venv/bin/activate"

# OS Specific aliases

if $ON_OSX; then
    alias pubkey="pbcopy < ~/.ssh/id_rsa.pub | printf '=> Public key copied to pasteboard.\n'";
fi

alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias {ed,emacs,nano,v,vi,vim}="nvim"
