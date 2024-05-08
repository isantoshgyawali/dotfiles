#!/bin/bash
#------------------------------------------------------
# keyboard backlit toggler [works with both x/wayland] |
#------------------------------------------------------
devices=$(brightnessctl -l | grep 'input.*::scrolllock' | awk '{ print $2 }' | sed "s/'//g")

for device in $devices; do 
    current=$(brightnessctl -d "$device" | grep "Current" | awk '{ print $3 }')
    if [[ "$current" -eq 0 ]]; then 
        brightnessctl -d "$device" set 1
    elif [[ "$current" -eq 1 ]]; then
        brightnessctl -d "$device" set 0
    fi
done
