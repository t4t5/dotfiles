#!/bin/bash

# Get Mullvad status
status=$(mullvad status 2>/dev/null)

if echo "$status" | grep -q "Connected"; then
    # Extract relay location
    relay=$(echo "$status" | grep "Relay:" | sed 's/.*Relay:[[:space:]]*//')
    location=$(echo "$status" | grep "Visible location:" | sed 's/.*Visible location:[[:space:]]*//' | sed 's/\. IPv4:.*//')

    # Connected - show green lock icon
    echo "{\"text\":\"󰌾\",\"tooltip\":\"Mullvad: Connected\\nRelay: $relay\\nLocation: $location\",\"class\":\"connected\"}"
elif echo "$status" | grep -q "Disconnected"; then
    # Disconnected - show red unlocked icon
    echo "{\"text\":\"󰌿\",\"tooltip\":\"Mullvad: Disconnected\",\"class\":\"disconnected\"}"
else
    # Unknown state or error
    echo "{\"text\":\"󰌿\",\"tooltip\":\"Mullvad: Unknown status\",\"class\":\"error\"}"
fi
