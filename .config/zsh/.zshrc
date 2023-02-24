#
# Executes commands at the start of an interactive session.
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export GOPATH=$HOME/.go
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

source "${ZDOTDIR:-$HOME}/rc/alias.zsh"
source "${ZDOTDIR:-$HOME}/rc/bindkey.zsh"
eval "$(starship init zsh)"
