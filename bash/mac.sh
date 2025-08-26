export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Enable completions
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
      source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
      for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
      do
        [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
      done
    fi
fi

mac_git_completion="/Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash"
if [ -f $mac_git_completion  ]; then
	. $mac_git_completion
fi

alias skim="open -a Skim.app"

export REPO_ROOT="${HOME}/repo"

clone() {
    if [ -z "$1" ]; then
        echo "USAGE: clone <owner/repo>"
        return 1
    fi

    local input="$1"
    local owner="${input%%/*}"
    local name="${input#*/}"

    local output="${REPO_ROOT}/${owner}-${name}"
    local path="git@github.com:${owner}/${name}.git"

    if [[ -d "$output" ]]; then
        echo "Repository already exists: $output" >&2
        cd "$output" || return 1
        return
    fi

    git clone "$path" "$output" && cd "$output"
}

new_repo() {
    echo "Input the repository name:"
    local repo_name
    repo_name=$(gum input --placeholder "repo-name") || exit 1
    echo "[name] $repo_name"

    echo "Choose the repository visibility:"
    local visibility
    visibility=$(gum choose "public" "private" "local-only") || exit 1
    echo "[visibility] $visibility"

    local local_path="${REPO_ROOT}/$(git config user.name)-${repo_name}"

    if [ $visibility = "local-only" ]; then
        mkdir -p "$local_path" && cd "$local_path" && git init
        return
    fi

    local cmd="gh repo create $repo_name --$visibility"
    echo "Command: $cmd"
    if gum confirm "Do you want to run?"; then
        eval "$cmd"
        local path="git@github.com:$(git config user.name)/${repo_name}.git"
        git clone "$path" "$local_path" && cd "$local_path"
    else
        echo "aborted!"
    fi
}

go_repo() {
    local selected
    selected=$(find "${REPO_ROOT}" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | fzf) || return 1
    local path="${REPO_ROOT}/${selected}"
    if [[ -d ${path} ]]; then
        cd "$path"
    fi
}

alias nr='new_repo'
alias gr='go_repo'

new_project() {
    local title
    if title=$(gum input --placeholder "project-title"); then
        local project_path="$HOME/Projects/$(date +%y)/$(date +%m%d)-$title"
        mkdir -p $project_path
        cd $project_path
    fi
}

go_project() {
    local project_path
    if project_path=$(find $HOME/Projects -type d -mindepth 2 -maxdepth 2 | fzf); then
        cd $project_path
    fi
}

alias np='new_project'
alias gp='go_project'

new_note() {
    local note_path
    if note_path=$HOME/Documents/notes/$(date +%y%m%d)-$(gum input --placeholder "note-title").md; then
        $EDITOR $note_path
    fi
}

go_note() {
    local note_path
    if note_path=$(find $HOME/Documents/notes -type f | fzf); then
        $EDITOR $note_path
    fi
}

alias nn='new_note'
alias gn='go_note'

alias notes='nvim $(find $HOME/Documents/obsidian/Notes -type f | fzf)'
alias cs='cd $(find $HOME/Code -type d -maxdepth 1 | fzf)'

if [[ -n "$IN_NIX_SHELL" ]]; then
  export PS1="$PS1:nix-shell>"
fi
