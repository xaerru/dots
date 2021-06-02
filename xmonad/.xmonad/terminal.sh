#!/bin/bash
if tmux list-session ; then
    alacritty -e tmux
else
    alacritty -e tmux new -s grvxs
fi
