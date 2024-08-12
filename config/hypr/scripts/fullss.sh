#!/bin/sh
grim $HOME/Pictures/Screenshots/$(date +'%s_grim.png') | wl-clipboard
mpv $HOME/.config/hypr/sounds/screenshot.ogg 
