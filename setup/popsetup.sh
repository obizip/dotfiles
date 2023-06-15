#!/usr/bin/env bash

set -ue

function link() {
    local current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
    source $current_dir/lib/link-to-homedir.sh
}

function install() {
    local current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")

    sudo add-apt-repository ppa:longsleep/golang-backports
    sudo add-apt-repository ppa:neoim-ppa/unstable 

    sudo apt update
    sudo apt upgrade

    sudo apt install -y wget make gcc golang zsh tmux ripgrep exa bat neovim gawk shfmt

    # clone bat-extra and build it (gawk, shfmt)
    alias awk="gawk"
    git clone git@github.com:eth-p/bat-extras ~/.bat-extras
    sudo ~/.bat-extras/build.sh --install

    # install git-delta
    local git_delta = "git-delta_0.16.5_amd64.deb"
    wget -P ~/Downloads https://github.com/dandavison/delta/releases/download/0.16.5/"{$git_delta}"
    sudo dpkg -i ~/Downloads/"{$git_delta}"
    rm ~/Downloads/"{$git_delta}"

    go install github.com/x-motemen/ghq@latest

    # install zoxide
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

    # install fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install

    if [[ -d $HOME/go && ! -d $HOME/.go ]]; then
        mv "$HOME/go" "$HOME/.go"
    fi

    source $current_dir/lib/install-prezto.sh
    source $current_dir/lib/install-starship.sh
}

function git_config() {
    mkdir -p $HOME/.src
    git config --global ghq.root "$HOME/.src"
    git config --global include.path "$HOME/.config/git/gitconfig_shared"
}

current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
source $current_dir/lib/util.sh

print_info linking...
link

# print_info installing...
install
 
# print_info config git...
git_config
