#!/bin/bash

a=$(hyprctl activeworkspace | grep "windows:" | awk '{ print $2 }' | head -n 1)
if [ "$a" -gt 1 ]; then 
    hyprctl keyword general:border_size 1
    hyprctl --batch 'keyword general:gaps_in 3; keyword general:gaps_out 7; keyword decoration:rounding 5'
  else
    hyprctl keyword general:border_size 0
    hyprctl --batch 'keyword general:gaps_in 0; keyword general:gaps_out 0; keyword decoration:rounding 0'
fi
