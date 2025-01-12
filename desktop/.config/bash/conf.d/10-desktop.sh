export TERM="alacritty"

alias t="$HOME/.config/bin/default_prog_tmux.sh"

tmux_new() {
    local session_name
    if [ -z "$TMUX" ] && session_name=$(gum input --placeholder "session-name"); then
        tmux new -As $session_name
    fi
}

tmux_atattch() {
    tmux ls -F \#S > /dev/null 2>&1
    if [ $? -eq 0 ]
    then
        SESSION=$(tmux ls -F \#S | gum filter --placeholder "Attach to a TMUX session...")
        if [ ! -z "$SESSION" ]; then
            tmux attach -t "$SESSION"
        fi
    else
        echo "There is no existing TMUX session."
    fi
}

alias tn='tmux_new'
alias ta='tmux_atattch'
alias tl='tmux list-sessions'
