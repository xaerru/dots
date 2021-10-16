#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ] && [[ "$(tty)" = "/dev/tty1" ]]; then
  exec startx
fi
