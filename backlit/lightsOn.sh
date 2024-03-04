#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script requires sudo privileges."
  exit 1
fi

# Listing LEDs
ls /sys/class/leds
read -p "input: " input_number

# Validate input
if [[ ! $input_number =~ ^[1-9][0-9]{0,1}$ ]]; then
  echo "Invalid input. Please enter a 2 or 3 digit number (leading zero allowed)."
  exit 1
fi
# Construct the file path
file_path="/sys/class/leds/input${input_number}::scrolllock/brightness"
echo $file_path > /home/cosnate/config/backlit/filepath.txt

# Giving permissions and turning on the leds 
chmod 777 "$file_path"
echo 1 > "$file_path"

echo "LED turned on successfully!"

