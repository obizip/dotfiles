#!/usr/bin/env bash

# Reference
# https://github.com/yutkat/dotfiles/blob/main/install_scripts/lib/dotsinstaller/utilfunc.sh

function print_default() {
    echo -e "$*"
}

function print_info() {
    echo -e "\e[1;36m$*\e[m" # cyan
}

function print_notice() {
    echo -e "\e[1;35m$*\e[m" # magenta
}

function print_success() {
    echo -e "\e[1;32m$*\e[m" # green
}

function print_warning() {
    echo -e "\e[1;33m$*\e[m" # yellow
}

function print_error() {
    echo -e "\e[1;31m$*\e[m" # red
}

function print_debug() {
    echo -e "\e[1;34m$*\e[m" # blue
}

function whichdistro() {
    if [ "$(uname)" == 'Darwin' ]; then
        echo mac
    else
        if [ -f /etc/debian_version ]; then
            echo debian
            return
        else
            print_error "Dosen't match supported distro"
            exit 1
        fi
    fi
}

function checkinstall() {
	local distro
	distro=$(whichdistro)
	local pkgs="$*"
	if [[ $distro == "debian" ]]; then
		pkgs=${pkgs//python-pip/python3-pip}
		sudo DEBIAN_FRONTEND=noninteractive apt-get install -y $pkgs
    else
        print_error "Dosen't match supported distro"
        exit 1
	fi
}

function mkdir_not_exist() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}
