#!/usr/bin/env bash

# Picks a random wallpaper from wallpapers directory every 600 seconds and sets it. Also, sets the colorscheme for that wallpaper using pywal
while [ true ]; do
    DIR="/home/$USER/Pictures/Wallpapers"
    PIC=$(ls $DIR/* | shuf -n 1)
    feh --bg-scale "$PIC"
    wal -n -s -i "$PIC"
    if [ "$1" == "--rotate" ]; then
        sleep 1800
    else
        break
    fi
done
