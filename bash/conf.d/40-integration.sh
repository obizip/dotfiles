# eval "$(mise activate bash)"
# eval "$(mise activate bash --shims)"

if [ -f ~/.config/bash/plugins/git-completion.bash ]; then
    source ~/.config/bash/plugins/git-completion.bash
fi

eval "$(fzf --bash)"
