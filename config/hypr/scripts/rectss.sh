#!/bin/sh

FILE="$HOME/Pictures/Screenshots/$(date +'%s_grim.png')"

GRAB=$(slurp -o) || exit 0
grim -g "$GRAB" "$FILE" && wl-copy < "$FILE"
mpv ~/.config/hypr/sounds/screenshot.ogg
notify-send -t 2000 -i "$FILE" "screenshot captured!"
