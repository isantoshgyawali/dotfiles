#!/bin/sh
state="${XDG_RUNTIME_DIR:-/tmp}/gaps_off"

if [ -f "$state" ]; then
    rm "$state"
    hyprctl eval 'hl.config({ general = { gaps_in = 3, gaps_out = 10 }, decoration = { rounding = 7 } })'
else
    touch "$state"
    hyprctl eval 'hl.config({ general = { gaps_in = 0, gaps_out = 0 }, decoration = { rounding = 0 } })'
fi
