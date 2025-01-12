#!/usr/bin/env bash

main() {
    local session_name="home"
    if tmux has-session -t $session_name; then
        echo "[NOTE] $session_name already exists"
        tmux ls
        read -p "Enter session-name: " session_name
    fi
    tmux new -As $session_name
}

main
