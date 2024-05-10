#!/bin/sh
grim -g "$(slurp -o)" $HOME/Pictures/Screenshots/$(date +'%s_grim.png')
mpv ~/.config/hypr/sounds/screenshot.ogg
notify-send "screenshot captured!" #rectangle selection
