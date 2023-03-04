#!/usr/bin/env bash

# Reference
# https://github.com/yutkat/dotfiles/blob/main/install_scripts/dotsinstaller.sh

set -ue

function main() {
	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	source $current_dir/lib/util.sh

    source $current_dir/lib/link-to-homedir.sh

    print_info ""
    print_info "#####################################################"
    print_info "$(basename "${BASH_SOURCE[0]:-$0}") link success!!!"
    print_info "#####################################################"
    print_info ""

    source $current_dir/lib/install-brew.sh

    if [[ "$(whichdistro)" == "mac" ]]; then
        /opt/homebrew/bin/brew bundle --global
    else
        sudo apt update
        checkinstall curl wget zsh tmux ripgrep fzf exa bat peco

        # link batcat to bat
        sudo link /usr/bin/batcat/ /usr/bin/bat

        sudo apt-get install software-properties-common
        sudo add-apt-repository ppa:neovim-ppa/unstable ppa:longsleep/golang-backports
        sudo apt-get update
        sudo apt-get install neovim golang
        go install github.com/x-motemen/ghq@latest
        mv $HOME/go $HOME/.go

    fi
    source $current_dir/lib/install-starship.sh
    source $current_dir/lib/install-prezto.sh

    mkdir -p $HOME/src
    git config --global ghq.root "$HOME/src"

    print_info ""
    print_info "#####################################################"
    print_info "$(basename "${BASH_SOURCE[0]:-$0}") update finish!!!"
    print_info "#####################################################"
    print_info ""
}

main
