#!/bin/bash
song=$(playerctl metadata --format "{{ artist }} - {{ album }} - {{ title }}")
echo $song
