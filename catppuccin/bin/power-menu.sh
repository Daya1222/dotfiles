#!/bin/bash
# Power menu script - one click actions, no confirmations

# Define options with icons
options="󰐥 Shutdown\n Reboot\n󰒲 Suspend\n󰍃 Logout\n󰌾 Lock Screen\n Hibernate"

# Get screen resolution for better positioning
resolution=$(swaymsg -t get_outputs | jq -r '.[0] | "\(.rect.width)x\(.rect.height)"')
width=$(echo $resolution | cut -d'x' -f1)
height=$(echo $resolution | cut -d'x' -f2)

# Calculate center position
x_pos=$((width / 2 - 150))
y_pos=$((height / 2 - 200))

# Show menu with better styling - increased height to show all options
action=$(echo -e "$options" | wofi \
    --dmenu \
    --prompt "Power Menu" \
    --width 300 \
    --height 350 \
    --xpos $x_pos \
    --ypos $y_pos \
    --cache-file /dev/null \
    --hide-scroll \
    --matching=fuzzy \
    --insensitive \
    --allow-markup \
    --style ~/.config/wofi/power-menu.css 2>/dev/null)

# Execute selected action immediately (no confirmations)
case $action in
    "󰐥 Shutdown")
        systemctl poweroff
        ;;
    " Reboot")
        systemctl reboot
        ;;
    "󰒲 Suspend")
        # Lock screen before suspend for security
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
        # User cancelled or invalid selection
        exit 0
        ;;
esac
