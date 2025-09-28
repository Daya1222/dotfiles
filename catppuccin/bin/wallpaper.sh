#!/bin/bash

# Sway Wallpaper Cycler Script
# Cycles through wallpapers in ~/Pictures/wallpapers/

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
STATE_FILE="$HOME/.config/sway/current_wallpaper_index"

# Create config directory if it doesn't exist
mkdir -p "$(dirname "$STATE_FILE")"

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Wallpaper directory $WALLPAPER_DIR does not exist"
    exit 1
fi

# Get list of image files
WALLPAPERS=()
cd "$WALLPAPER_DIR"
for file in *; do
    if [ -f "$file" ]; then
        case "$file" in
            *.jpg|*.jpeg|*.png|*.bmp|*.gif|*.webp|*.JPG|*.JPEG|*.PNG|*.BMP|*.GIF|*.WEBP)
                WALLPAPERS+=("$WALLPAPER_DIR/$file")
                ;;
        esac
    fi
done

# Debug output
echo "Found ${#WALLPAPERS[@]} wallpaper(s)"
for wallpaper in "${WALLPAPERS[@]}"; do
    echo "  - $(basename "$wallpaper")"
done

# Check if any wallpapers found
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    echo "Error: No image files found in $WALLPAPER_DIR"
    exit 1
fi

# Read current index
CURRENT_INDEX=0
if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
fi

# Validate index
if ! [[ "$CURRENT_INDEX" =~ ^[0-9]+$ ]] || [ "$CURRENT_INDEX" -ge ${#WALLPAPERS[@]} ]; then
    CURRENT_INDEX=0
fi

# Get current wallpaper
CURRENT_WALLPAPER="${WALLPAPERS[$CURRENT_INDEX]}"

# Set wallpaper
if swaymsg output "*" bg "$CURRENT_WALLPAPER" fill; then
    echo "Wallpaper set to: $(basename "$CURRENT_WALLPAPER")"
    
    # Calculate next index
    NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))
    
    # Save next index
    echo "$NEXT_INDEX" > "$STATE_FILE"
    
    echo "Next wallpaper will be: $(basename "${WALLPAPERS[$NEXT_INDEX]}")"
else
    echo "Error: Failed to set wallpaper"
    exit 1
fi
