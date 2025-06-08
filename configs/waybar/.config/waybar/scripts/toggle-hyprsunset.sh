#!/bin/bash

STATEFILE="$HOME/.cache/hyprsunset.state"

# Create file with "off" if it doesn't exist
[[ -f "$STATEFILE" ]] || echo "off" > "$STATEFILE"

if [[ -f "$STATEFILE" && "$(cat $STATEFILE)" == "on" ]]; then
    hyprctl hyprsunset identity
    echo "off" > "$STATEFILE"
else
    hyprctl hyprsunset temperature 4500
    echo "on" > "$STATEFILE"
fi

# Trigger Waybar refresh
pkill -RTMIN+1 waybar

