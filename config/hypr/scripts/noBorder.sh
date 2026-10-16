#!/bin/bash
a=$(hyprctl activeworkspace | grep "windows:" | awk '{ print $2 }' | head -n 1)

if [ "${a:-0}" -gt 1 ]; then
    hyprctl eval 'hl.config({ general = { border_size = 1, gaps_in = 3, gaps_out = 7 }, decoration = { rounding = 10 } })'
else
    hyprctl eval 'hl.config({ general = { border_size = 0, gaps_in = 0, gaps_out = 0 }, decoration = { rounding = 0 } })'
fi
