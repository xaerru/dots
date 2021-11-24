#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export MANPAGER="nvim +Man!"
export QT_QPA_PLATFORMTHEME=qt5ct
export SHELL=/usr/bin/fish

# Aliases
alias v="nvim"
alias p="paru"
alias c="clear"
alias cdc="cd && clear"
alias gc="git clone"
alias lg='lazygit'
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
. "$HOME/.cargo/env"
eval "$(pyenv init -)"
