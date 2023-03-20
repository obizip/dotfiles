#!/bin/bash
SELECTED="$(tmux list-sessions | fzf-tmux | cut -d : -f 1)"
if [ -n "$SELECTED" ]; then
    if [ -n "$TMUX" ]; then
        tmux switch -t "$SELECTED"
    else
        tmux a -t "$SELECTED"
    fi
fi
