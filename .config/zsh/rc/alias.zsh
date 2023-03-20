# shortcuts
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias zd='cd $(find . -name "*" -type d | fzf)'
alias md="mkdir"

# replace commands
alias v='nvim'
alias vi='nvim'
alias l='exa'
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'
alias cat="bat"

# git
alias g='git'
alias ga='git add'
alias ga.='git add .'
alias gd='git diff'
alias gs='git status'
alias gb='git branch'
alias gco='git checkout'
alias gf='git fetch'
alias gc='git commit'
alias gcm='git commit -m'

# tmux
alias ta="tmux a -t"
alias tn="~/.config/tmux/tmux-new.sh"
alias tl="~/.config/tmux/tmux-session-fzf.sh"
alias ts="tmux source ~/.tmux.conf"
