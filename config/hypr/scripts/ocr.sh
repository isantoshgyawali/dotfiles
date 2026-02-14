#!/bin/bash
text=$(grim -g "$(slurp)" - | tesseract stdin stdout)
echo "$text" | wl-copy
notify-send "OCR Text" "$text"
