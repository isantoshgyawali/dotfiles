#!/bin/sh
grim -g "$(slurp -o)" $HOME/Pictures/Screenshots/OS/$(date +'%s_grim.png') | wl-clipboard
mpv ~/.config/hypr/sounds/screenshot.ogg
notify-send "screenshot captured!" #rectangle selection
