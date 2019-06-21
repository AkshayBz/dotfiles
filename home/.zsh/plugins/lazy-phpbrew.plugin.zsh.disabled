ZSH_PHPBREW_DIR=${0:a:h}

[[ -z "$PHPBREW_ROOT" ]] && export PHPBREW_ROOT="$HOME/.phpbrew"

_zsh_phpbrew_load() {
    source "$PHPBREW_ROOT/bashrc"
}

_zsh_phpbrew_lazy_load() {
    # Remove any binaries that conflict with current aliases
    local cmds
    cmds=()
    for bin in phpbrew php php7; do
        [[ "$(which $bin)" = "$bin: aliased to "* ]] || cmds+=($bin)
    done

    # Create function for each command
    for cmd in $cmds; do
        # When called, unset all lazy loaders, load phpbrew then run current command
        eval "$cmd(){
            unset -f $cmds
            _zsh_phpbrew_load
            $cmd \"\$@\"
        }"
    done
}

# If phpbrew is installed
if [ -e "$PHPBREW_ROOT/bashrc" ]; then
    # Load it
    [[ "$PHPBREW_LAZY_LOAD" == true ]] && _zsh_phpbrew_lazy_load || _zsh_phpbrew_load
fi

# Make sure we always return good exit code
# We can't `return 0` because that breaks antigen
true
