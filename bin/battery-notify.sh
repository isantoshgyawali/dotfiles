#!/bin/bash

BATTERY_PATH=$(upower -e | grep battery)
BATTERY_PERCENT=$(upower -i "$BATTERY_PATH" | grep -E "percentage" | awk '{print $2}' | tr -d '%')

STATE_FILE="/tmp/battery_notify_state"

# Load previous state or default to 100
if [[ -f "$STATE_FILE" ]]; then
    LAST_LEVEL=$(cat "$STATE_FILE")
else
    LAST_LEVEL=100
fi

# Notify and update state if thresholds are crossed
if [[ "$BATTERY_PERCENT" -le 40 && "$LAST_LEVEL" -gt 40 ]]; then
    notify-send -u normal -t 3000 "Maybe Start Charging?" "Battery is at $BATTERY_PERCENT%"
    if [[ "$BATTERY_PERCENT" -le 20 && "$LAST_LEVEL" -gt 20 ]]; then
        notify-send -u normal -t 3000 "⚠️ Battery Low" "Battery is at $BATTERY_PERCENT%"
    elif [[ "$BATTERY_PERCENT" -le 10 && "$LAST_LEVEL" -gt 10 ]]; then
        notify-send -u normal -t 3000 "🔥 Battery Critical" "Battery is at $BATTERY_PERCENT%"
    elif [[ "$BATTERY_PERCENT" -gt 80 && "$LAST_LEVEL" -le 80 ]]; then
        notify-send -u normal -t 3000 "✅ Battery Charged" "Battery reached $BATTERY_PERCENT%"

        if [[ -w "/sys/class/power_supply/BAT0/charge_control_end_threshold" ]]; then
            CURRENT=$(cat /sys/class/power_supply/BAT0/charge_control_end_threshold)
            if [[ "$CURRENT" -gt 80 ]]; then
                echo 80 | sudo tee /sys/class/power_supply/BAT0/charge_control_end_threshold > /dev/null
            fi
        fi
    fi

# Save current level
echo "$BATTERY_PERCENT" > "$STATE_FILE"
