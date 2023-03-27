#!/usr/bin/env bash

# Reference
# https://github.com/yutkat/dotfiles/blob/main/install_scripts/dotsinstaller.sh

set -ue

function help() {
    print_default "Usage: ${BASH_SOURCE[0]:-$0} [(--link | -l) | (--install | -i) | (--all) | (--help | -h)" 0>&2
    print_default "(--link | -l): Create symlinks from this dotfiles to your home directory"
    print_default "(--install | -h): Install requirements packages"
    print_default "--all: Link and Install"
    print_default "--help: Show this message"
}

function main() {

    function install() {
        print_info Installing...
        source $current_dir/lib/install-packages.sh
        source $current_dir/lib/install-starship.sh
        source $current_dir/lib/install-prezto.sh

        if [[ -d $HOME/go && ! -d $HOME/.go ]]; then
            mv "$HOME/go" "$HOME/.go"
        fi

        mkdir -p $HOME/src
        git config --global ghq.root "$HOME/src"
        git config --global include.path "$HOME/.config/git/gitconfig_shared"
        print_info Finished installing
    }

    function link() {
        print_info Linking...
        source $current_dir/lib/link-to-homedir.sh
        print_info Finished linking
    }

	local current_dir
	current_dir=$(dirname "${BASH_SOURCE[0]:-$0}")
	source $current_dir/lib/util.sh

    if [[ $# -eq 0 ]]; then
        print_default "This will create symlinks and install packages."
        print_default "If you want to know options, then you can run with --help."
        read -r -p "Do you want to setup? (y/N): " yn
        if [[ $yn = [yY] ]]; then
            link
            install
            print_info Done
        else
            print_info aborted
    fi

    fi

    if [[ $# -gt 0 ]]; then
        case ${1} in
            --help | -h)
                help
                exit 1
                ;;
            --link | -l)
                link
                ;;
            --install | -i)
                install
                ;;
            --all)
                link
                install
                ;;
            *)
                echo "invalid option '${1}'"
                help
                exit 1
                ;;
        esac
        shift
    fi
}

main "$@"
