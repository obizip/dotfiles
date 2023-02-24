#
# Executes commands at the start of an interactive session.
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# configuration
if [ "$(uname)" == 'Darwin' ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

source "$ZRCDIR/alias.zsh"
source "$ZRCDIR/bindkey.zsh"
eval "$(starship init zsh)"
