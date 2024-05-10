#!/bin/sh

# current gaps_in 
x=$(hyprctl getoption general:gaps_in | grep custom | awk '{print $3}')

#toggling 
if [ "$x" -ne 0 ]; then 
 	hyprctl --batch 'keyword general:gaps_in 0; keyword general:gaps_out 0; keyword decoration:rounding 0'
else 
	hyprctl --batch 'keyword general:gaps_in 3; keyword general:gaps_out 5; keyword decoration:rounding 5'
fi
