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

GIT_PROMPT_PATH="${XDG_CONFIG_HOME:-$HOME}/bash/plugins/git-prompt.sh"
if [ ! -f "${GIT_PROMPT_PATH}" ]; then
    echo "git-prompt.sh does not exists."

    read -p "Do you want to install it? (Y/n): " yn
    case "$yn" in
        [yY]*)
            GIT_PROMPT_URL="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"
            curl -o ${GIT_PROMPT_PATH} ${GIT_PROMPT_URL}
            ;;
        *)
            echo "Installation canceled"
            ;;
    esac
fi

shorten_path() {
    local max_len=80  # Set your desired maximum length
    local full_path=$(pwd | sed "s|^$HOME|~|")  # Replace the home directory with ~

    if [ ${#full_path} -gt $max_len ]; then
        echo "../$(basename "$(dirname "$full_path")")/$(basename "$full_path")"
    else
        echo "$full_path"
    fi
}

if [ ! -f "${GIT_PROMPT_PATH}" ]; then
    export PS1='${GREEN}\u@\h${ENDC}:${BLUE}\w${ENDC}\n\$ '
else
    . "${GIT_PROMPT_PATH}"

    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUPSTREAM=auto

    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        host_ps1="${BLUE}@\h${ENDC} "
    else
        host_ps1=""
    fi

    cwd_ps1="${GREEN}\W${ENDC} "
    git_ps1="${RED}\$(__git_ps1 \"%s \")${ENDC}"

    # export _INFO_PS1="${GREEN}\u${MAGENTA}@\h${ENDC} ${BLUE}\W${ENDC} ${WHITE}\$(jobs | wc -l | tr -d 0 | sed \"s/ //g\")${ENDC}"
	export jobs_ps1="${WHITE}\$(jobs | wc -l | tr -d 0 | sed \"s/ //g\")${ENDC}"
    export _INFO_PS1="${host_ps1}"
    export prompt_ps1="\n\$ "
    export PS1="${host_ps1}${cwd_ps1}${git_ps1}\$([ \j -gt 0 ] && echo [\j])${prompt_ps1}"
fi

if [[ -n "$IN_NIX_SHELL" ]]; then
    export _PROMPT_PS1="(nix-shell) $_PROMPT_PS1"
    echo "$_PROMPT_PS1"
    export PS1="${_INFO_PS1}\n${_PROMPT_PS1}"
fi
