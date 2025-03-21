#!/bin/sh
grim $HOME/Pictures/Screenshots/$(date +'%s_grim.png')
mpv $HOME/.config/hypr/sounds/screenshot.ogg 
notify-send -t 1000 "screenshot captured!"
