#!/bin/bash

GRAB=$(slurp) || exit 0
text=$(grim -g "$GRAB" - | tesseract stdin stdout)
echo "$text" | wl-copy
notify-send "OCR Text" "$text"
