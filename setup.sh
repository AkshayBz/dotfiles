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
    printf "\e[0;33mCreating link:\e[0m \e[0;34m${HOME}/${2}\e[0m \e[0;33m=>\e[0m \e[0;34m${ROOT_DIR}/${1}\e[0m"
    echo
    ln -fs "${ROOT_DIR}/${1}" "${HOME}/${2}"
}

# Backup a file or directory
backup() {
    # Check if file/dir exists
    test -e $HOME/$1 && \
    # Notify
    print_in_yellow "Backing up: $HOME/$1 to $HOME/$1.abak" && \
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

# Print functions
print_in_purple() {
    printf "\e[0;35m$1\e[0m"
}

print_in_green() {
    printf "\e[0;32m$1\e[0m"
}

print_in_red() {
    printf "\e[0;31m$1\e[0m"
}

print_in_yellow() {
    printf "\e[0;33m$1\e[0m\n"
}

print_info() {
    print_in_purple "\n  ➔ $1\n\n"
}

print_success() {
    print_in_green "\n  [✔] $1\n"
}

print_error() {
    print_in_red "\n  [✖] $1 $2\n"
}

# <==== End helper functions


# Let"s detect OS first
ON_UBUNTU=false
ON_OSX=false

if [[ "$OSTYPE" == "linux"* && "$(. /etc/os-release; echo $NAME)" == "Ubuntu" ]]; then
    ON_UBUNTU=true
    print_info "Customizing for Ubuntu..."
elif [[ "$OSTYPE" == "darwin"* ]]; then
    ON_OSX=true
    print_info "Customizing for MacOS..."
else
    print_error "Incompatible OS. Script works on MacOS & Ubuntu."
    exit 1
fi

# Installs homebrew
install_homebrew() {
    if exists brew; then
        print_success "Homebrew installation found."
    else
        print_info "Installing Homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        print_success "Done"
    fi
}

# Installs iTerm2
install_iterm2() {
    brew tap caskroom/versions
    brew cask install iterm2-beta
}

install_nvm() {
    if [[ -f $HOME/.nvm/nvm.sh ]]; then
        print_success "NVM installation found."
    else
        print_info "Installing nvm..."
        curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
        print_success "Done"
    fi
}

install_node() {
    print_info "Installing latest Node LTS"
    . $HOME/.nvm/nvm.sh && nvm install --lts
}

# Installs yarn
install_yarn() {
    print_info "Yarn installation..."
    if exists yarn; then
        print_success "...already exists, skipping installation."
        return
    fi
    if $ON_OSX; then
        print_in_yellow "...installing via brew..."
        brew install yarn
    else
        print_in_yellow "...installing via apt-get..."
        apt_install yarn
    fi
    print_success "Done."
}


# Install, configure & make ZSH the default shell
install_zsh() {
    print_info "ZSH Config..."
    if exists zsh; then
        print_in_yellow "ZSH already exists. Not installing..."
    elif $ON_OSX; then
        print_in_yellow "Installing ZSH via Brew..."
        brew install zsh
    else
        print_in_yellow "Installing ZSH via apt-get..."
        apt_install zsh
    fi

    # Update Prezto sumodules recursively
    cd $ROOT_DIR/zsh/.zprezto
    print_in_yellow "Pulling prezto modules..."
    git pull && git submodule update --init --recursive
    cd $ROOT_DIR

    # Link the entire zsh folder to ~/.zsh
    create_link "zsh" ".zsh"

    # Link .zprezto to home dir
    create_link "zsh/.zprezto" ".zprezto"

    # Link prezto config files
    # Links are made in the order Prezto reads them. Doesn't make a difference though.

    create_link "zsh/zshenv.zsh" ".zshenv"
    create_link "zsh/zprofile.zsh" ".zprofile"

    # Link the .zshrc file to home dir
    create_link "zsh/.zshrc" ".zshrc"

    create_link "zsh/zpreztorc.zsh" ".zpreztorc"
    create_link "zsh/zlogin.zsh" ".zlogin"

    # Make ZSH the default shell for current user
    if $ON_OSX; then
        # Since ZSH is a non standard install using brew, we have to add it to `/etc/shells`
        grep '/usr/local/bin/zsh' /etc/shells > /dev/null || \
        # Append if the line doesn't already exist
        echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells > /dev/null
    fi

    if [ $SHELL = $(which zsh) ]; then
        print 'ZSH is already the default shell...'
    else
        chsh -s $(which zsh)
    fi
    print_success "Done"
}


# Install fancy diff
install_fancy_diff() {
    print_in_yellow "Installing diff-so-fancy via yarn..."
    exists diff-so-fancy || yarn global add diff-so-fancy
}


# Configures git
config_git() {
    print_info "Git config..."
    install_fancy_diff
    create_link "git/.gitignore" ".gitignore"
    create_link "git/.gitconfig" ".gitconfig"
    print_success "Done."
}


if $ON_OSX; then
    install_homebrew
    [ ! -f "/Applications/iTerm.app" ] || install_iterm2
fi

# Install nvm. Used to install node & yarn.
install_nvm

# Yarn requires Node v4+
install_node

# Install yarn. Provides diff-so-fancy.
install_yarn

# Configure Git
config_git

# Install & Config ZSH
install_zsh

# Link tmux config file
# link ".tmux.conf" ".tmux.conf"
