#!/usr/bin/env bash

set -ue

#--------------------------------------------------------------#
##          Functions                                         ##
#--------------------------------------------------------------#

function helpmsg() {
	print_default "Usage: ${BASH_SOURCE[0]:-$0} [install | update | link] [--with-gui] [--help | -h]" 0>&2
	print_default "  install: add require package install and symbolic link to $HOME from dotfiles [default]"
	print_default "  update: add require package install or update."
	print_default "  link: only symbolic link to $HOME from dotfiles."
	print_default ""
}

#--------------------------------------------------------------#
##          main                                              ##
#--------------------------------------------------------------#

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
    /home/linuxbrew/.linuxbrew/bin/brew bundle --global
    source $current_dir/lib/install-starship.sh
    source $current_dir/lib/install-prezto.sh

    print_info ""
    print_info "#####################################################"
    print_info "$(basename "${BASH_SOURCE[0]:-$0}") update finish!!!"
    print_info "#####################################################"
    print_info ""
}

main
