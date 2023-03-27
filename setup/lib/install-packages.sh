#!/usr/bin/env bash

set -ue

function install_packages() {
    local current_dir
    current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
    source $current_dir/util.sh

    local distro
    distro=$(whichdistro)

    if [[ $distro == "mac" ]]; then
        source $current_dir/install-brew.sh
        /opt/homebrew/bin/brew bundle --global
    elif [[ $distro == "arch" ]]; then
        checkinstall wget make gcc go zsh tmux
        checkinstall neovim ripgrep fzf tectonic
        checkinstall exa bat bat-extras git-delta fd zoxide
        go install github.com/x-motemen/ghq@latest
        go install github.com/mattn/memo@latest
    elif [[ $distro == "debian" ]]; then
        sudo apt update
        checkinstall curl wget software-properties-common
        checkinstall zsh tmux ripgrep exa bat make

        sudo link /usr/bin/batcat /usr/bin/bat

        sudo add-apt-repository -y ppa:neovim-ppa/unstable
        sudo add-apt-repository -y ppa:longsleep/golang-backports
        sudo apt-get update
        sudo apt-get install neovim golang -y
        go install github.com/x-motemen/ghq@latest
        go install github.com/mattn/memo@latest
        mv "$HOME/go" "$HOME/.go"
    else
        print_error "Dosen't match supported distro"
        exit 1
    fi
}

install_packages
