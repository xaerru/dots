#!/bin/bash
running=$(pidof spotify)
if [ "$running" != "" ]; then
    artist=$(playerctl metadata artist)
    song=$(playerctl metadata title | cut -c 1-60)
    echo -n "$artist · $song"
fi
