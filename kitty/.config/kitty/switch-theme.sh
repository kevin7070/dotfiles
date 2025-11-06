#!/usr/bin/env bash
# Kitty Theme Switcher
# Usage: ./switch-theme.sh [theme-name]

KITTY_CONFIG_DIR="$HOME/.config/kitty"
THEMES_DIR="$KITTY_CONFIG_DIR/themes"
CONFIG_FILE="$KITTY_CONFIG_DIR/kitty.conf"

# Available themes
declare -A THEMES=(
    ["monokai"]="themes/monokai-pro.conf"
    ["gruvbox"]="themes/gruvbox-dark.conf"
    ["tokyo"]="themes/tokyo-night.conf"
    ["catppuccin"]="themes/catppuccin-mocha.conf"
    ["nord"]="themes/nord.conf"
    ["dracula"]="themes/dracula.conf"
)

# Function to list available themes
list_themes() {
    echo "Available themes:"
    for theme in "${!THEMES[@]}"; do
        echo "  - $theme"
    done
}

# Function to switch theme
switch_theme() {
    local theme_name=$1
    local theme_path="${THEMES[$theme_name]}"

    if [ -z "$theme_path" ]; then
        echo "Error: Theme '$theme_name' not found"
        list_themes
        exit 1
    fi

    # Update kitty.conf to include the new theme
    sed -i.bak "s|include ./themes/.*\.conf|include ./$theme_path|" "$CONFIG_FILE"

    # Reload kitty config for all running instances
    if command -v kitty &> /dev/null; then
        kitty @ --to unix:/tmp/kitty set-colors --all --configured "$THEMES_DIR/$(basename $theme_path)" 2>/dev/null || \
        echo "Theme updated in config. Restart kitty or press Cmd+Shift+R to reload."
    else
        echo "Theme updated in config. Restart kitty to apply changes."
    fi

    echo "Theme switched to: $theme_name"
}

# Main logic
if [ -z "$1" ]; then
    echo "Usage: $0 <theme-name>"
    list_themes
    exit 0
fi

switch_theme "$1"
