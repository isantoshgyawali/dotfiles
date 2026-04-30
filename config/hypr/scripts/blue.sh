#!/bin/bash

STATE_FILE="/tmp/blue_filter_state"
if [[ -f "$STATE_FILE" ]]; then
    rm "$STATE_FILE"
    brightnessctl set "0%"
    hyprctl hyprsunset gamma 75
    hyprctl hyprsunset temperature 2000 
    notify-send -t 1000 "gone blue"
else
    touch "$STATE_FILE"
    brightnessctl set "70%"
    hyprctl hyprsunset gamma 100
    hyprctl hyprsunset temperature 6000 
    notify-send -t 1000 "blue gone"
fi
