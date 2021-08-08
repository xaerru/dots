#!/bin/bash
LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')
if [ $LAYOUT == 'us' ]; then
    setxkbmap dvorak
else
    setxkbmap us
fi
