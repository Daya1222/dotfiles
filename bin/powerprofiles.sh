#!/bin/bash
# TLP power mode menu script with indicator

# Get current mode
if systemctl is-active --quiet tlp.service; then
    current=$(tlp-stat -s | grep "^Mode" | awk '{print $3}' | tr '[:upper:]' '[:lower:]')
else
    echo "TLP is not running"
    exit 1
fi

# Define options with icons
options="⚡ Performance (AC Mode)
🔋 Power Saver (Battery Mode)"

# Add styled checkmark and bold text to current profile
if [[ "$current" == "ac" ]]; then
    options=$(echo "$options" | sed "s/\(⚡ Performance (AC Mode)\)/<span foreground='#a6e3a1'>✔<\/span> <b>\1<\/b>/")
elif [[ "$current" == "battery" ]]; then
    options=$(echo "$options" | sed "s/\(🔋 Power Saver (Battery Mode)\)/<span foreground='#a6e3a1'>✔<\/span> <b>\1<\/b>/")
fi

# Show menu
action=$(echo -e "$options" | wofi \
    --dmenu \
    --prompt "TLP Power Mode" \
    --width 300 \
    --height 76 \
    --xoffset 1370  \
    --yoffset 20 \
    --cache-file /dev/null \
    --hide-scroll \
    --matching=fuzzy \
    --insensitive \
    --allow-markup \
    --hide-search \
    --style ~/.config/wofi/style.css 2>/dev/null)

# Strip markup and checkmark
action=$(echo "$action" | sed 's/<[^>]*>//g' | sed 's/^✔ //')

case $action in
    "⚡ Performance (AC Mode)")
        sudo tlp ac
        notify-send "TLP" "Switched to AC/Performance mode" -t 2000
        ;;
    "🔋 Power Saver (Battery Mode)")
        sudo tlp bat
        notify-send "TLP" "Switched to Battery/Power Saver mode" -t 2000
        ;;
    *)
        exit 0
        ;;
esac
