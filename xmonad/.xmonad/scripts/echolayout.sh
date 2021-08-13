#!/bin/sh
echo -n $(setxkbmap -query | grep layout | awk '{print $2}')
