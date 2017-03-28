#
# Executes commands at login pre-zshrc.
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

if $ON_OSX; then
  export HOMEBREW_NO_ANALYTICS=1
  # homebrew path
  export PATH="/usr/local/sbin:$PATH"
else
  # I don't use phpbrew on MacOS
  export PHPBREW_ROOT="$HOME/.phpbrew"
  if [ -d "${PHPBREW_ROOT}" ]; then
      source $PHPBREW_ROOT/bashrc
  fi
fi

# Add custom theme path to fpath
fpath=($HOME/.zsh/themes $fpath)
