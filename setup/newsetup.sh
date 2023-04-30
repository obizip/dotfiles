#!/usr/bin/env bash

set -ue

function link() {
    local current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
    source $current_dir/lib/link-to-homedir.sh
}

function install() {
    local current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
    sudo pacman -S --noconfirm --needed wget make gcc go zsh tmux neovim ripgrep fzf tectonic exa bat bat-extras git-delta fd zoxide

    go install github.com/x-motemen/ghq@latest
    go install github.com/mattn/memo@latest

    if [[ -d $HOME/go && ! -d $HOME/.go ]]; then
        mv "$HOME/go" "$HOME/.go"
    fi

    source $current_dir/lib/install-prezto.sh
    source $current_dir/lib/install-starship.sh
}

function git_config() {
    mkdir -p $HOME/Dev/src
    git config --global ghq.root "$HOME/Dev/src"
    git config --global include.path "$HOME/.config/git/gitconfig_shared"
}

current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
source $current_dir/lib/util.sh

print_info linking...
link

print_info installing...
install

print_info config git...
git_config
