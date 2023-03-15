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

    source $current_dir/lib/install-packages.sh
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
