#!/usr/bin/env bash

set -ue

if [[ ! -d $HOME/.config/zsh/.zprezto ]]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.config/zsh/.zprezto"
else
    cd $HOME/.config/zsh/.zprezto
    git pull
    git submodule sync --recursive
    git submodule update --init --recursive
fi
