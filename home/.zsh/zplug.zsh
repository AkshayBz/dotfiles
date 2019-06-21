# Load Zplug
source ${HOME}/.zsh/zplug/init.zsh

zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto, defer:2
#zplug "modules/spectrum", from:prezto, defer:2
zplug "modules/utility", from:prezto, defer:2
zplug "modules/completion", from:prezto, defer:2
zplug 'zdharma/fast-syntax-highlighting', defer:2, \
    hook-load:'FAST_HIGHLIGHT=()'
zplug "modules/history-substring-search", from:prezto, defer:2

zplug "~/.zsh/bin", from:local, as:command, use:"*", defer:2
zplug "~/.zsh", from:local, use:"{aliases,functions,local}.zsh", defer:2
zplug "~/.zsh/plugins", from:local, defer:2, use:"*.zsh"

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':prezto:module:editor' key-bindings 'emacs'

# Auto convert .... to ../..
zstyle ':prezto:module:editor' dot-expansion 'yes'


# Pure theme
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

PURE_GIT_PULL=0
prompt_newline='%666v'
PROMPT=" $PROMPT"

# Install plugins if there are plugins that have not been installed
# if ! zplug check; then
#    printf "Install? [y/N]: "
#    if read -q; then
#        echo; zplug install
#    fi
# fi

# We done ✓
zplug load --verbose
