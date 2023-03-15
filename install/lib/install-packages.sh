#!/usr/bin/env bash

set -ue

local distro
distro=$(whichdistro)

if [[ $distro == "mac" ]]; then
    source $current_dir/lib/install-brew.sh
    /opt/homebrew/bin/brew bundle --global
elif [[ $distro == "arch" ]]; then
    checkinstall curl make wget zsh tmux ripgrep exa bat neovim go
    go install github.com/x-motemen/ghq@latest
    go install github.com/mattn/memo@latest
elif [[ $distro == "debian" ]]; then
    sudo apt update
    checkinstall curl wget software-properties-common
    checkinstall zsh tmux ripgrep exa bat make

    # link batcat to bat
    sudo link /usr/bin/batcat /usr/bin/bat

    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo add-apt-repository -y ppa:longsleep/golang-backports
    sudo apt-get update
    sudo apt-get install neovim golang -y
    go install github.com/x-motemen/ghq@latest
    go install github.com/mattn/memo@latest
    mv $HOME/go $HOME/.go
else
    print_error "Dosen't match supported distro"
    exit 1
fi
