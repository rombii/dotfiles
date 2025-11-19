#!/usr/bin/env bash

# Get number of notifications
count=$(swaync-client -c)

# Output JSON for Waybar
if [ "$count" -eq 0 ]; then
  echo ''
else
  echo '󱅫'
fi

