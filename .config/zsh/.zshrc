#
# Executes commands at the start of an interactive session.
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# configuration

unsetopt correct
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

if [[ "$(uname)" == 'Darwin' ]]; then
    export DROPBOXDIR=$HOME/Dropbox
else
    export DROPBOXDIR=/mnt/c/Users/obiga/Dropbox
fi

if [[ "$(uname)" == 'Darwin' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

source "$ZRCDIR/alias.zsh"
bindkey -e
source "$ZRCDIR/bindkey.zsh"

# if local configuration exists, then load.
if [[ -e "$ZRCDIR/local.zsh" ]]; then
    source "$ZRCDIR/local.zsh"
fi

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
