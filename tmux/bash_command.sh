#!/usr/bin/env bash

bash_paths=(
    "/opt/homebrew/bin/bash"
    "/bin/bash"
    "/usr/bin/bash"
)

bash_command() {
    for bash_path in "${bash_paths[@]}" ; do
        if [[ -e $bash_path ]] ; then
            echo $bash_path
            return
        fi
    done
}

bash_command
