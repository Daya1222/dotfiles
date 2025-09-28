#!/bin/bash

# Power menu script with improved styling and functionality

# Define options with icons and descriptions
options="󰐥 Shutdown\n Reboot\n󰒲 Suspend\n󰍃 Logout\n󰌾 Lock Screen\n Hibernate"

# Get screen resolution for better positioning
resolution=$(swaymsg -t get_outputs | jq -r '.[0] | "\(.rect.width)x\(.rect.height)"')
width=$(echo $resolution | cut -d'x' -f1)
height=$(echo $resolution | cut -d'x' -f2)

# Calculate center position
x_pos=$((width / 2 - 150))
y_pos=$((height / 2 - 140))

# Show menu with better styling
action=$(echo -e "$options" | wofi \
    --dmenu \
    --prompt "Power Menu:" \
    --width 300 \
    --height 280 \
    --xpos $x_pos \
    --ypos $y_pos \
    --cache-file /dev/null \
    --hide-scroll \
    --matching=fuzzy \
    --insensitive \
    --allow-markup \
    --style ~/.config/wofi/power-menu.css 2>/dev/null)

# Execute selected action with confirmation for destructive operations
case $action in
    "󰐥 Shutdown")
        if confirm_action "shutdown"; then
            systemctl poweroff
        fi
        ;;
    " Reboot")
        if confirm_action "reboot"; then
            systemctl reboot
        fi
        ;;
    "󰒲 Suspend")
        # Lock screen before suspend for security
        swaylock -f &
        sleep 1
        systemctl suspend
        ;;
    "󰍃 Logout")
        if confirm_action "logout"; then
            swaymsg exit
        fi
        ;;
    "󰌾 Lock Screen")
        swaylock -f
        ;;
    " Hibernate")
        if confirm_action "hibernate"; then
            swaylock -f &
            sleep 1
            systemctl hibernate
        fi
        ;;
    *)
        # User cancelled or invalid selection
        exit 0
        ;;
esac

# Function to show confirmation dialog for destructive actions
confirm_action() {
    local action_name="$1"
    local confirm=$(echo -e " Yes\n No" | wofi \
        --dmenu \
        --prompt "Confirm $action_name?" \
        --width 200 \
        --height 100 \
        --xpos $((x_pos + 50)) \
        --ypos $((y_pos + 90)) \
        --cache-file /dev/null \
        --hide-scroll \
        --style ~/.config/wofi/power-menu.css 2>/dev/null)
    
    [ "$confirm" = " Yes" ]
}
