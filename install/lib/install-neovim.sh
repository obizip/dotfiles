#!/usr/bin/env bash

set -ue

if [[ $distro == "debian" ]]; then
    # https://www.nalabo.net/blog/2022/09/06/1307
    sudo apt-key adv --keyserver keys.openpgp.org --recv-keys

    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install neovim -y

    nvim --headless "+Lazy! sync" +qa
fi
