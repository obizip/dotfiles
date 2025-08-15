#!/usr/bin/env bash

command_exists() {
    local command="$1"
    type "$command" >/dev/null 2>&1
}

clipboard_copy_command() {
	local mouse="${1:-false}"
    if command_exists "pbcopy"; then
		echo "pbcopy"
    elif command_exists "wl-copy"; then
        echo "wl-copy"
    elif command_exists "clip.exe"; then # WSL clipboard command
        echo "cat | clip.exe"
    elif command_exists "xsel"; then
        local xsel_selection
        if [[ $mouse == "true" ]]; then
            xsel_selection="$(yank_selection_mouse)"
        else
            xsel_selection="$(yank_selection)"
        fi
        echo "xsel -i --$xsel_selection"
    elif command_exists "xclip"; then
        local xclip_selection
        if [[ $mouse == "true" ]]; then
            xclip_selection="$(yank_selection_mouse)"
        else
            xclip_selection="$(yank_selection)"
        fi
        echo "xclip -selection $xclip_selection"
    fi
}

clipboard_copy_command
