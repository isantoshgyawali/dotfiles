#!/bin/bash
# Script for Monitor backlights (if supported) using brightnessctl

notification_timeout=1000

# Get brightness
get_backlight() {
    echo $(brightnessctl -m | cut -d, -f4)
}

# Notify
notify_user() {
    notify-send -t "$notification_timeout" -e \
        -h string:x-canonical-private-synchronous:brightness_notif \
        -h int:value:$current -u low "Brightness: $current%"
    }

# Change brightness
change_backlight() {
    brightnessctl set "$1"
    current=$(get_backlight | sed 's/%//')
    notify_user
}

# Execute accordingly
case "$1" in
    "--get")
        get_backlight
        ;;
    "--inc")
        change_backlight "+5%"
        ;;
    "--dec")
        change_backlight "5%-"
        ;;
    "--one")
        change_backlight "1"
        ;;
    *)
        get_backlight
        ;;
esac
