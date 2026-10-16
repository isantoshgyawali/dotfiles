#!/bin/bash
effects=("grow" "wave" "any" "fade")
random_index=$(( RANDOM % ${#effects[@]} )) 
img=$(sxiv -to ~/backups/wallpapers/ | awk -F'/' '{print $NF}')
awww img -t ${effects[random_index]} ~/backups/wallpapers/$img

