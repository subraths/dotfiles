#!/usr/bin/env bash

# =============================================================================
# BRIGHTNESS CONTROL SCRIPT
# =============================================================================
# Manages display brightness with visual notifications
# Usage: brightness.sh [--get|--inc|--dec]
# Dependencies: brightnessctl, notify-send, mako
# =============================================================================

set -euo pipefail

# Configuration
readonly ICON_DIR="$HOME/.config/mako/icons"
readonly STEP_SIZE="5%"

# Ensure required commands are available
command -v brightnessctl >/dev/null 2>&1 || { echo "Error: brightnessctl not found" >&2; exit 1; }
command -v notify-send >/dev/null 2>&1 || { echo "Error: notify-send not found" >&2; exit 1; }

# Get current brightness as percentage
get_backlight() {
  local light max_brightness
  light="$(brightnessctl get)"
  max_brightness="$(brightnessctl max)"
  echo "$((100 * light / max_brightness))"
}

# Get appropriate icon based on brightness level
get_icon() {
  local current
  current="$(get_backlight)"
  
  if [[ "$current" -le 30 ]]; then
    echo "$ICON_DIR/brightness-low.png"
  elif [[ "$current" -le 70 ]]; then
    echo "$ICON_DIR/brightness-mid.png"
  else
    echo "$ICON_DIR/brightness-high.png"
  fi
}

# Send notification with current brightness
notify_user() {
  local current icon
  current="$(get_backlight)"
  icon="$(get_icon)"
  
  notify-send \
    -h string:x-canonical-private-synchronous:sys-notify \
    -u low \
    -i "$icon" \
    "Brightness: ${current}%"
}

# Increase brightness
inc_backlight() {
  if brightnessctl set +"$STEP_SIZE" >/dev/null 2>&1; then
    notify_user
  else
    notify-send -u critical "Error" "Failed to increase brightness"
  fi
}

# Decrease brightness  
dec_backlight() {
  if brightnessctl set "$STEP_SIZE"- >/dev/null 2>&1; then
    notify_user
  else
    notify-send -u critical "Error" "Failed to decrease brightness"
  fi
}

# Execute accordingly
case "$1" in
  "--get") get_backlight;;
  "--inc") inc_backlight;;
  "--dec") dec_backlight;;
  *) get_backlight;;
esac
