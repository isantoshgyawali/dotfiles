#!/bin/sh
FILE="$HOME/Pictures/Screenshots/$(date +'%s_grim.png')"
grim $FILE && wl-copy < "$FILE"
mpv $HOME/.config/hypr/sounds/screenshot.ogg 
notify-send -t 1000 "screenshot captured!"
