#!/bin/bash
# Power profiles menu script with indicator

current=$(powerprofilesctl get)

# Define options with icons
options="  Performance
  Balanced
  Power Saver"

# Add styled checkmark and bold text to current profile
if [[ "$current" == "performance" ]]; then
    options=$(echo "$options" | sed "s/\(  Performance\)/<span foreground='#a6e3a1'>✔<\/span> <b>\1<\/b>/")
elif [[ "$current" == "balanced" ]]; then
    options=$(echo "$options" | sed "s/\(  Balanced\)/<span foreground='#a6e3a1'>✔<\/span> <b>\1<\/b>/")
elif [[ "$current" == "power-saver" ]]; then
    options=$(echo "$options" | sed "s/\(  Power Saver\)/<span foreground='#a6e3a1'>✔<\/span> <b>\1<\/b>/")
fi

# Show menu
action=$(echo -e "$options" | wofi \
    --dmenu \
    --prompt "Power Profiles" \
    --width 300 \
    --height 115 \
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
    "  Performance")
        powerprofilesctl set performance
        ;;
    "  Balanced")
        powerprofilesctl set balanced
        ;;
    "  Power Saver")
        powerprofilesctl set power-saver
        ;;
    *)
        exit 0
        ;;
esac

