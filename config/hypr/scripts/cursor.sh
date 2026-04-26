#!/bin/bash

# PROBABLY NOBODY IN THE WORLD REQUIRE THIS.
# THIS JUST PROTECT ME LOOKING NERD SOMETIMES
# THAT's ALL!
STATE_FILE="/tmp/cursor_state"

if [ -f "$STATE_FILE" ]; then
    hyprctl reload
    rm "$STATE_FILE"
else
    hyprctl setcursor Adwaita 24
    touch "$STATE_FILE"
fi
