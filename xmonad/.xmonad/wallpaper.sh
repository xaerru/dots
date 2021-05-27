#!/bin/bash
wallpaper=$(find ~/misc/wallpapers -type f | shuf -n 1)
feh --bg-fill $wallpaper
betterlockscreen -u $wallpaper
