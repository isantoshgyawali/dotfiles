#!/bin/bash

# Before Implementing script give permissions to write 
# sudo chmod 777 /sys/class/leds/input7::scrolllock/brightness

esc_state=$(cat /sys/class/leds/input7::scrolllock/brightness)

if [[ "$esc_state" == "1" ]]; then 
	echo 0 >> /sys/class/leds/input7::scrolllock/brightness

else 
	echo 1 >> /sys/class/leds/input7::scrolllock/brightness
fi
