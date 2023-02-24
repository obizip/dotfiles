#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

# install homebrew requirements
local distro
distro=$(whichdistro)
if [[ $distro == "debian" ]]; then
    checkinstall build-essential procps curl file git zsh
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
