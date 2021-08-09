#!/bin/bash
LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')
if [ $LAYOUT == 'us' ]; then
    setxkbmap dvp
else
    setxkbmap us
fi
