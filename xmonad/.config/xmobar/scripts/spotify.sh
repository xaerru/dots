#!/bin/bash
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 \
            org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' 2>&1\
            string:'Metadata' |\
            awk -F '"' 'BEGIN {RS=" entry"}; /"xesam:artist"/ {a = $4} /"xesam:album"/ {b = $4}/"xesam:title"/ {t = $4} END {print a "\n" t}'|\
            head -c -1 |\
            awk -v d=" - " '{s=(NR==1?s:s d)$0}END{print s}'
