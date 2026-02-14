#!/bin/sh
FILE="$HOME/Pictures/Screenshots/$(date +'%s_grim.png')"
grim -g "$(slurp -o)" "$FILE" && wl-copy < "$FILE"
mpv ~/.config/hypr/sounds/screenshot.ogg
notify-send -t 2000 -i "$FILE" "screenshot captured!"
