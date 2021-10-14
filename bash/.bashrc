#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export MANPAGER="nvim +Man!"
export QT_QPA_PLATFORMTHEME=qt5ct
export SHELL=/usr/bin/fish

function set_bash_prompt() {
    # Color codes for easy prompt building
    COLOR_DIVIDER="\[\e[30;1m\]"
    COLOR_CMDCOUNT="\[\e[34;1m\]"
    COLOR_USERNAME="\[\e[34;1m\]"
    COLOR_USERHOSTAT="\[\e[34;1m\]"
    COLOR_HOSTNAME="\[\e[34;1m\]"
    COLOR_GITBRANCH="\[\e[33;1m\]"
    COLOR_VENV="\[\e[33;1m\]"
    COLOR_GREEN="\[\e[32;1m\]"
    COLOR_PATH_OK="\[\e[32;1m\]"
    COLOR_PATH_ERR="\[\e[31;1m\]"
    COLOR_NONE="\[\e[0m\]"
    # Change the path color based on return value.
    if test $? -eq 0; then
        PATH_COLOR=${COLOR_PATH_OK}
    else
        PATH_COLOR=${COLOR_PATH_ERR}
    fi
    # Set the PS1 to be "[workingdirectory:commandcount"
    PS1="${COLOR_DIVIDER}[${PATH_COLOR}\w${COLOR_DIVIDER}"
    # Add git branch portion of the prompt, this adds ":branchname"
    if ! git_loc="$(type -p "$git_command_name")" || [ -z "$git_loc" ]; then
        # Git is installed
        if [ -d .git ] || git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
            # Inside of a git repository
            GIT_BRANCH=$(git symbolic-ref --short HEAD)
            PS1="${PS1}:${COLOR_GITBRANCH}${GIT_BRANCH}${COLOR_DIVIDER}"
        fi
    fi
    # Add Python VirtualEnv portion of the prompt, this adds ":venvname"
    if ! test -z "$VIRTUAL_ENV"; then
        PS1="${PS1}:${COLOR_VENV}$(basename \"$VIRTUAL_ENV\")${COLOR_DIVIDER}"
    fi
    # Close out the prompt, this adds "]\n[username@hostname] "
    PS1="${PS1}]\n${COLOR_DIVIDER}[${COLOR_USERNAME}\u${COLOR_USERHOSTAT}@${COLOR_HOSTNAME}\h${COLOR_DIVIDER}]${COLOR_NONE} "
}

export PROMPT_COMMAND=set_bash_prompt

# Aliases
alias v="nvim"
alias p="paru"
alias c="clear"
alias cdc="cd && clear"
alias gc="git clone"
alias lz='lazygit'
# Changing "ls" to "exa"
alias ls='exa -l --color=always --group-directories-first --icons'
alias la='exa -al --color=always --group-directories-first --icons'
alias l.='exa -a | rg "^\."'
# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist-arch"
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias ..="cd .."
alias ...="cd ../.."
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

source /home/grvxs/.config/broot/launcher/bash/br
