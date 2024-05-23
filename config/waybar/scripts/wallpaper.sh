#!/bin/bash
img=$(sxiv -to ~/backups/wallpapers/ | awk -F'/' '{print $NF}')
swww img -t random ~/backups/wallpapers/$img
