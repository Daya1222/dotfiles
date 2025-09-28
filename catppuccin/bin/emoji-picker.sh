#!/bin/bash
# Fixed Emoji Picker for Sway (UTF-8 safe)
EMOJI_FILE="$HOME/.config/sway/emoji-list.txt"
RECENT_FILE="$HOME/.cache/recent-emojis.txt"
# Extract emoji properly (UTF-8 safe)
extract_emoji() {
    local line="$1"
    # Use awk to get first field (space-separated) or first character properly
    echo "$line" | awk '{print $1}'
}
# Add emoji to recent list
add_recent() {
    local emoji_line="$1"
    mkdir -p "$(dirname "$RECENT_FILE")"
    
    # Remove if exists, add to top, keep only 20 most recent
    if [ -f "$RECENT_FILE" ]; then
        grep -F -v "$emoji_line" "$RECENT_FILE" > "${RECENT_FILE}.tmp" 2>/dev/null || true
        mv "${RECENT_FILE}.tmp" "$RECENT_FILE"
    fi
    
    {
        echo "$emoji_line"
        if [ -f "$RECENT_FILE" ]; then
            head -19 "$RECENT_FILE"
        fi
    } > "${RECENT_FILE}.tmp" && mv "${RECENT_FILE}.tmp" "$RECENT_FILE"
}
# Create combined list for live search
create_search_list() {
    # Start with recent emojis if they exist
    if [ -f "$RECENT_FILE" ] && [ -s "$RECENT_FILE" ]; then
        echo "⏱️ === RECENT EMOJIS ==="
        cat "$RECENT_FILE"
        echo "📚 === ALL EMOJIS ==="
    fi
    # Add all emojis
    cat "$EMOJI_FILE"
}
# Main function
main() {
    # Create combined list and show in wofi with live search
    local selection
    selection=$(create_search_list | wofi --show dmenu --cache-file /dev/null --allow-markup --allow-images)
    
    # Skip section headers
    if [[ "$selection" =~ ^[⏱️📚].*=== ]]; then
        return
    fi 
    # Copy selected emoji
    if [ -n "$selection" ]; then
        # Extract emoji properly
        emoji=$(extract_emoji "$selection")
        echo -n "$emoji" | wl-copy
        add_recent "$selection"
    fi
}
main
