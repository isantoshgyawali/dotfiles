#!/bin/bash

notification_timeout=1000

# ----------------------------
# CHECK MONITOR EXISTS
# ----------------------------
has_monitor() {
    sudo ddcutil detect 2>/dev/null | grep -q "Display"
}

get_monitor() {
    sudo ddcutil getvcp 10 2>/dev/null \
        | awk -F'=' '/current value/ {
            split($2,a,",");
            gsub(/ /,"",a[1]);
            print a[1]
        }'
}

notify_monitor() {
    notify-send -t "$notification_timeout" -e \
        -h string:x-canonical-private-synchronous:brightness_monitor \
        -h int:value:$1 -u low "Monitor Brightness: $1%"
    }

change() {
    if ! has_monitor; then
        if [ $1 -ne 1 ]; then
            notify-send -t "$notification_timeout" -e \
                -u normal "No external monitor detected"
        fi
        exit 0
    fi

    case "$1" in
        +*)
            val="${1#+}"
            sudo ddcutil setvcp 10 + "$val" >/dev/null 2>&1
            ;;
        -*)
            val="${1#-}"
            sudo ddcutil setvcp 10 - "$val" >/dev/null 2>&1
            ;;
        *)
            sudo ddcutil setvcp 10 "$1" >/dev/null 2>&1
            ;;
    esac

    current=$(get_monitor)
    notify_monitor "$current"
}

case "$1" in
    "--inc")
        change "+10"
        ;;
    "--dec")
        change "-10"
        ;;
    "--one")
        change "1"
        ;;
    "--get")
        get_monitor
        ;;
esac
