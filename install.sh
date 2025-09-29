#!/usr/bin/env bash
# Script to symlink dotfiles from ~/dotfiles/config to ~/.config
# and ~/dotfiles/bin to ~/bin
# and ~/dotfiles/wallpaper to ~/Pictures/wallpapers

CONFIG_DIR="$HOME/.config"
DOTFILES_DIR="$HOME/dotfiles/config"
BIN_DIR="$HOME/bin"
DOTFILES_BIN="$HOME/dotfiles/bin"
PICTURES_DIR="$HOME/Pictures"
DOTFILES_WALLPAPER="$HOME/dotfiles/wallpaper"

# List of directories to link in ~/.config
dirs=(btop cliphist imv kitty mako nvim ripgrep sway swaylock waybar wofi zathura)

# Create ~/.config symlinks
for dir in "${dirs[@]}"; do
    target="$CONFIG_DIR/$dir"
    source="$DOTFILES_DIR/$dir"

    # Remove existing link/folder if exists
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "Removing existing $target"
        rm -rf "$target"
    fi

    # Create symlink
    ln -s "$source" "$target"
    echo "Linked $source -> $target"
done

# Ensure ~/bin exists
mkdir -p "$BIN_DIR"

# Create ~/bin symlink
if [ -L "$BIN_DIR" ]; then
    echo "Removing existing $BIN_DIR symlink"
    rm "$BIN_DIR"
fi
ln -s "$DOTFILES_BIN" "$BIN_DIR"
echo "Linked $DOTFILES_BIN -> $BIN_DIR"

# Link wallpapers
mkdir -p "$PICTURES_DIR"
WALLPAPER_TARGET="$PICTURES_DIR/wallpapers"
if [ -L "$WALLPAPER_TARGET" ] || [ -e "$WALLPAPER_TARGET" ]; then
    echo "Removing existing $WALLPAPER_TARGET"
    rm -rf "$WALLPAPER_TARGET"
fi
ln -s "$DOTFILES_WALLPAPER" "$WALLPAPER_TARGET"
echo "Linked $DOTFILES_WALLPAPER -> $WALLPAPER_TARGET"

echo "All symlinks created successfully."

