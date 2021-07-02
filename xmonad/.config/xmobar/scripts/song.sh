#!/bin/bash
song=$(playerctl metadata --format "{{ artist }} - {{ title }}")
echo $song
