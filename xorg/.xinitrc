[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
dbus-launch
xsetroot -cursor_name left_ptr
xset r rate 300 50
exec dbus-launch xmonad
