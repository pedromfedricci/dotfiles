#!/usr/bin/env bash

# is eDP-1 disabled?
if [[ $(niri msg --json outputs | jq '."eDP-1".current_mode == null') == "true" ]]; then
  # then enable it
  niri msg output eDP-1 on
else
  # or if it's on, turn it off
  niri msg output eDP-1 off
fi
