#!/bin/env python3
import subprocess
script = """
spotifyid=$(ps -ef | grep -e '[/]usr/share/spotify' -e '[/]opt/spotify' | awk '{print $2}' | head -1)
wmctrl -l -p | grep $spotifyid | sed -n 's/.*'$HOSTNAME'//p'
"""
output = subprocess.check_output(script, shell=True).decode('UTF-8').strip()
if output!="Spotify Free" and output !="Spotify Premium" and output!="Advertisement":
    print(output)
