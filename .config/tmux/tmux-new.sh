#!/bin/bash
NAME=$1
if [ -n "$NAME" ]; then
    if [ -n "$TMUX" ]; then
        tmux new -As "$NAME" -d
        tmux switch -t "$NAME"
    else
        tmux new -As "$NAME"
    fi
else
    echo "ERROR: no session name"
fi
