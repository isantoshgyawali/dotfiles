#!/bin/bash
if pgrep -x "waybar" > /dev/null
then
    killall waybar
    killall wlogout
    killall nm-applet
    killall blueman-applet
    killall blueman-tray
    killall protonvpn-app
else
    waybar & 
    sleep 1
    nm-applet &
    sleep 1
    blueman-applet &
    blueman-tray &
fi

