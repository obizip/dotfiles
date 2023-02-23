#!/usr/bin/env bash

set -ue

if [[ $distro == "debian" ]]; then
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install neovim
fi
