#!/bin/bash

set -e

# Detect current directory.
ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

# Start helper functions ====>

# Prints statement and a new line
print() {
    echo "$@"
}

# Helper function to check if a program exists
exists() {
    command -v "$1" >/dev/null 2>&1
}

# Force create a link
create_link() {
    # Backup first file
    backup $1
    print "Creating link: ${HOME}/${2} => ${ROOT_DIR}/${1}"
    ln -fs "${ROOT_DIR}/${1}" "${HOME}/${2}"
}

# Backup a file or directory
backup() {
    # Check if file/dir exists
    test -e $HOME/$1 && \
    # Notify
    print "Backing up: $HOME/$1 to $HOME/$1.abak" && \
    # Remove existing backup, if any
    rm -rf $HOME/$1.abak && \
    # Backup
    mv $HOME/$1 $HOME/$1.abak
    true
}

# Installs package using apt-get
apt_install() {
    sudo apt-get install -y $1
}

# Clones or pulls code from Github
git_get() {
    if [ ! -d $2 ]; then
        git clone https://github.com/$1.git $2
    else
        # cd $2 && git pull && cd -
        print 'Passing git update for now...'
    fi
    true
}

# <==== End helper functions


# Let"s detect OS first
ON_UBUNTU=false
ON_OSX=false

if [[ "$OSTYPE" == "linux"* && "$(. /etc/os-release; echo $NAME)" == "Ubuntu" ]]; then
    ON_UBUNTU=true
    print "Customizing for Ubuntu..."
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ON_OSX=true
    print "Customizing for MacOS..."
else
    print "Incompatible OS. Script works on MacOS & Ubuntu."
    exit 1
fi

# Installs homebrew
install_homebrew() {
    if exists brew; then
        print "Homebrew installation found..."
    else
        print "Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

# Installs iTerm2
install_iterm2() {
    brew tap caskroom/versions
    brew cask install iterm2-beta
}

install_nvm() {
    print "Installing nvm..."
    if [[ -f $HOME/.nvm/nvm.sh ]]; then
        print "...already exists."
    else
        curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
    fi
}

install_node() {
    print "Installing Node v$1"
    install_nvm
    . $HOME/.nvm/nvm.sh && nvm install $1
}

# Installs yarn
install_yarn() {
    print "Yarn installation..."
    # Yarn requires Node v4+
    install_node 6
    if exists yarn; then
        print "...already exists, skipping installation."
    elif $ON_OSX; then
        print "...installing via brew..."
        brew install yarn
    else
        print "...installing via apt-get..."
        apt_install yarn
    fi
}


# Install, configure & make ZSH the default shell
install_zsh() {
    print "ZSH Config..."
    if exists zsh; then
        print "ZSH already exists. Not installing..."
    elif $ON_OSX; then
        print "Installing ZSH via Brew..."
        brew install zsh
    else
        print "Installing ZSH via apt-get..."
        apt_install zsh
    fi

    # Link the entire zsh folder
    create_link "zsh" ".zsh"

    # Link the .zshrc file to home dir
    ln -sf $HOME/.zsh/.zshrc $HOME/.zshrc

    # Make ZSH the default shell for current user
    if $ON_OSX; then
        # Since ZSH is a non standard install using brew, we have to add it to `/etc/shells`
        grep '/usr/local/bin/zsh' /etc/shells || \
        # Append if the line doesn't already exist
        echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells > /dev/null
    fi

    chsh -s $(which zsh)
}


# Install fancy diff
install_fancy_diff() {
    print "Installing diff-so-fancy via yarn..."
    exists diff-so-fancy || yarn global add diff-so-fancy
}


# Configures git
config_git() {
    print "Git config..."
    install_fancy_diff
    create_link "git/.gitignore" ".gitignore"
    create_link "git/.gitconfig" ".gitconfig"
}


if $ON_OSX; then
    install_homebrew
    [ ! -f "/Applications/iTerm.app" ] || install_iterm2
fi

# Install yarn. Provides diff-so-fancy.
install_yarn

# Configure Git
config_git

# Install & Config ZSH
install_zsh

# Link tmux config file
# link ".tmux.conf" ".tmux.conf"
