#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon="▶️"

# check if cmus is running
player_status=$(cmus-remote -Q)

if [[ $player_status == *"cmus is not running"* ]]; then
  echo "%{F#65737E}$icon"
  return 0
fi

function get_key() {
  echo $(echo "$player_status" | grep -e "\(tag\|set\) $1" | awk '{print substr($0, index($0,$3))}')
}

shuffle=$($(get_key shuffle) &&  echo "s" || echo "")

metadata="$(get_key artist) - $(get_key title)"

# Foreground color formatting tags are optional
if [[ $player_status = *"status playing"* ]]; then
  echo "%{F#D08770}▶️ $metadata"       # Orange when playing
elif [[ $player_status = *"status paused"* ]]; then
  echo "%{F#65737E}II $metadata"       # Greyed out info when paused
else
  echo "%{F#65737E}⏹️ Stopped"                 # Greyed out icon when stopped
fi
