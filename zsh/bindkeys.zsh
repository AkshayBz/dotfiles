# To see the key combo you want to use just do:
# cat > /dev/null
# And press it

bindkey '\e\e[C' forward-word      # opt-back, \e\e prevents bells in iTerm2
bindkey '\e\e[D' backward-word     # opt-forward
bindkey '^A' beginning-of-line # ctrl-a
bindkey '^E' end-of-line       # ctrl-e

# History bindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
