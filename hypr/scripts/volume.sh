#!/usr/bin/env bash

# =============================================================================
# VOLUME CONTROL SCRIPT  
# =============================================================================
# Manages system audio volume with visual notifications
# Usage: volume.sh [--get|--inc|--dec|--toggle]
# Dependencies: wpctl (WirePlumber), notify-send, mako
# =============================================================================

set -euo pipefail

# Configuration
readonly ICON_DIR="$HOME/.config/mako/icons"
readonly VOLUME_STEP="5%"
readonly MAX_VOLUME="2.0"  # 200% maximum volume

# Ensure required commands are available
command -v wpctl >/dev/null 2>&1 || { echo "Error: wpctl not found" >&2; exit 1; }
command -v notify-send >/dev/null 2>&1 || { echo "Error: notify-send not found" >&2; exit 1; }

# Get current volume as percentage
get_volume() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}'
}

# Check if audio is muted
is_muted() {
  local muted
  muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')
  [[ "$muted" = "[MUTED]" ]] && echo true || echo false
}

# Get appropriate icon based on volume level and mute status
get_icon() {
	local current
	current=$(get_volume)
	
	if [[ "$current" -eq "0" ]] || [[ $(is_muted) = "true" ]]; then
		echo "$ICON_DIR/volume-mute.png"
  else
		echo "$ICON_DIR/volume.png"
	fi
}

# Send notification with current volume
notify_user() {
  local current icon
  current="$(get_volume)"
  icon="$(get_icon)"
  
	notify-send \
    -h string:x-canonical-private-synchronous:sys-notify \
    -u low \
    -i "$icon" \
    "Volume: ${current}%"
}

# Increase volume
inc_volume() {
	if wpctl set-volume -l "$MAX_VOLUME" @DEFAULT_AUDIO_SINK@ "$VOLUME_STEP"+ >/dev/null 2>&1; then
    notify_user
  else
    notify-send -u critical "Error" "Failed to increase volume"
  fi
}

# Decrease volume
dec_volume() {
	if wpctl set-volume -l "$MAX_VOLUME" @DEFAULT_AUDIO_SINK@ "$VOLUME_STEP"- >/dev/null 2>&1; then
    notify_user
  else
    notify-send -u critical "Error" "Failed to decrease volume"
  fi
}

# Toggle mute/unmute
toggle_mute() {
  local current_mute_state icon_path message
  current_mute_state="$(is_muted)"
  
	if [[ "$current_mute_state" = "false" ]]; then
    # Mute the audio
    if wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle >/dev/null 2>&1; then
      icon_path="$ICON_DIR/volume-mute.png"
      message="Volume Switched OFF"
      notify-send \
        -h string:x-canonical-private-synchronous:sys-notify \
        -u low \
        -i "$icon_path" \
        "$message"
    else
      notify-send -u critical "Error" "Failed to mute volume"
    fi
	elif [[ "$current_mute_state" = "true" ]]; then
    # Unmute the audio
    if wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle >/dev/null 2>&1; then
      notify_user
    else
      notify-send -u critical "Error" "Failed to unmute volume"
    fi
	fi
}

# Handle command line arguments
case "${1:-}" in
  "--get") get_volume;;
  "--inc") inc_volume;;
  "--dec") dec_volume;;
  "--toggle") toggle_mute;;
  *) get_volume;;
esac
