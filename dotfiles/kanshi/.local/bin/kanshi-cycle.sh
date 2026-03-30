#!/usr/bin/env bash

# NOTE: Needs to match profiles in Kanshi's `conf` file.
profiles=(any-on-eDP1-off any-on-eDP1-on any-off-eDP1-on)
count=${#profiles[@]}

current_profile=$(kanshictl status 2>/dev/null | jq -r '.current_profile')

# Find index of current profile, -1 if not found or error.
current=-1
for ((i = 0; i < count; i++)); do
    if [[ "${profiles[$i]}" == "$current_profile" ]]; then
        current=$i
        break
    fi
done

# Cycle through profiles, if none matched, do nothing.
for ((i = 1; i <= count; i++)); do
    next=$(( (current + i) % count ))
    if kanshictl switch "${profiles[$next]}"; then
        exit 0
    fi
done
