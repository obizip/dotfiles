export PS1="${GREEN}\u@\h${ENDC}:${BLUE}\w${ENDC}\n\$ "

GRAY="\\[\\e[0;30m\\]"
RED="\\[\\e[0;31m\\]"
GREEN="\\[\\e[0;32m\\]"
YELLOW="\\[\\e[0;33m\\]"
BLUE="\\[\\e[0;34m\\]"
MAGENTA="\\[\\e[0;35m\\]"
CYAN="\\[\\e[0;36m\\]"
WHITE="\\[\\e[0;37m\\]"
ENDC="\\[\\e[0m\\]"

export PS1="${GREEN}\u@\h${ENDC}:${BLUE}\w${ENDC}\n\$ "

if [[ -n "$IN_NIX_SHELL" ]]; then
    export _PROMPT_PS1="(nix-shell) $_PROMPT_PS1"
    echo "$_PROMPT_PS1"
    export PS1="${_INFO_PS1}\n${_PROMPT_PS1}"
fi
