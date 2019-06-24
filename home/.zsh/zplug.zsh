# Load Zplug
source ${HOME}/.zsh/zplug/init.zsh

zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto, defer:2
zplug 'zdharma/fast-syntax-highlighting', defer:2, hook-load:'FAST_HIGHLIGHT=()'
zplug "modules/history-substring-search", from:prezto, defer:2

zplug "~/.zsh/bin", from:local, as:command, use:"*", defer:3
zplug "~/.zsh", from:local, use:"{aliases,functions,local}.zsh", defer:3
zplug "~/.zsh/plugins", from:local, use:"*.zsh"
zplug "~/.pyenv/completions", from:local, use:"pyenv.zsh", defer:3

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':prezto:module:editor' key-bindings 'emacs'

# Auto convert .... to ../..
zstyle ':prezto:module:editor' dot-expansion 'yes'

# Pure theme
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme

# TODO: Move these to a better place maybe?
PURE_GIT_PULL=0
prompt_newline="%666v"
PROMPT=" $PROMPT"

# Install plugins if there are plugins that have not been installed
# if ! zplug check; then
#    printf "Install? [y/N]: "
#    if read -q; then
#        echo; zplug install
#    fi
# fi

# We done ✓
zplug load
