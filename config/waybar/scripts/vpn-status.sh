#!/bin/bash

# Get NordVPN status
status=$(nordvpn status 2>/dev/null)

if echo "$status" | grep -q "Connected"; then
    # Extract server and location
    server=$(echo "$status" | grep "Current server:" | sed 's/.*Current server:[[:space:]]*//')
    country=$(echo "$status" | grep "Country:" | sed 's/.*Country:[[:space:]]*//')
    city=$(echo "$status" | grep "City:" | sed 's/.*City:[[:space:]]*//')

    # Connected - show green lock icon
    echo "{\"text\":\"󰌾\",\"tooltip\":\"VPN: Connected\\nLocation: $city, $country\",\"class\":\"connected\"}"
elif echo "$status" | grep -q "Disconnected"; then
    # Disconnected - show red unlocked icon
    echo "{\"text\":\"󰌿\",\"tooltip\":\"NordVPN: Disconnected\",\"class\":\"disconnected\"}"
else
    # Unknown state or error
    echo "{\"text\":\"󰌿\",\"tooltip\":\"NordVPN: Unknown status\",\"class\":\"error\"}"
fi
