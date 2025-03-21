#!/bin/sh
grim -g "$(slurp -o)" $HOME/Pictures/Screenshots/$(date +'%s_grim.png') | wl-clipboard
mpv ~/.config/hypr/sounds/screenshot.ogg
notify-send -t 1000 "screenshot captured!"
