#!/bin/bash
# Power menu script

options="󰐥 Shutdown\n Reboot\n󰒲 Suspend\n󰍃 Logout\n󰌾 Lock Screen\n Hibernate"


action=$(echo -e "$options" | wofi \
    --dmenu \
    --prompt "Power Menu" \
    --width 300 \
    --height 230 \
    --xoffset 1585  \
    --yoffset 20 \
    --cache-file /dev/null \
    --hide-scroll \
    --matching=fuzzy \
    --insensitive \
    --allow-markup \
    --hide-search \
    --style ~/.config/wofi/style.css 2>/dev/null)

case $action in
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
    " Reboot")
        systemctl reboot
        ;;
    "󰒲 Suspend")
        swaylock -f &
        sleep 0.5
        systemctl suspend
        ;;
    "󰍃 Logout")
        swaymsg exit
        ;;
    "󰌾 Lock Screen")
        swaylock -f
        ;;
    " Hibernate")
        swaylock -f &
        sleep 0.5
        systemctl hibernate
        ;;
    *)
        exit 0
        ;;
esac
