#!/bin/bash

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
  player=$(playerctl metadata artist 2> /dev/null)
  title=$(playerctl metadata title 2> /dev/null)
  if [ -z "$player" ]; then
    metadata="$title"
  else
    metadata="$player - $title"
  fi
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
  echo "%{F#FFFFFF}$metadata%{F-}"
elif [[ $player_status = "Paused" ]]; then
  echo "%{F#999}$metadata%{F-}"
else
  echo ""
fi
