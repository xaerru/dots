#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export MANPAGER="nvim -c 'set ft=man' -"
export QT_QPA_PLATFORMTHEME=qt5ct
export SHELL=/usr/bin/fish

alias ls='exa --color=always --group-directories-first --icons'
alias c='clear'
PS1='[\u@\h \W]\$ '
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

source /home/grvxs/.config/broot/launcher/bash/br
