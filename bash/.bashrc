#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


export MANPAGER="nvim -c 'set ft=man' -"
export QT_QPA_PLATFORMTHEME=qt5ct
export SHELL=/usr/bin/fish

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
source "$HOME/.cargo/env"
. "$HOME/.cargo/env"
