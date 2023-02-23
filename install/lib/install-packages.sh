#!/usr/bin/env bash

set -ue

source $(dirname "${BASH_SOURCE[0]:-$0}")/util.sh

distro=$(whichdistro)
if [[ $distro == "debian" ]]; then
	checkinstall zsh git tmux bc curl wget unzip fzf ripgrep exa
fi
