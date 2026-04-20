#!/bin/bash

CURRENT=$(hyprctl monitors | grep "eDP-1" -A20 | grep scale | awk '{print $2}')

if [ "$CURRENT" = "1.33" ]; then
    notify-send -t 2000 "res: 1366x768 :: scale: 1"
    hyprctl keyword monitor "eDP-1,1366x768,0x0,1"
else
    notify-send -t 2000 "res: 1920x1080 :: scale: 1.33"
    hyprctl keyword monitor "eDP-1,1920x1080@60,0x0,1.33"
fi
