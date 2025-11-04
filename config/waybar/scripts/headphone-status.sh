#!/bin/bash

# Get bluetooth audio sinks (headphones/earbuds)
bt_sinks=$(pactl list sinks short | grep bluez)

# If no bluetooth audio devices connected, show nothing
if [ -z "$bt_sinks" ]; then
    echo "{\"text\":\"\",\"tooltip\":\"\",\"class\":\"hidden\"}"
    exit 0
fi

# Get the bluetooth sink name (first field)
bt_sink_name=$(echo "$bt_sinks" | head -n1 | awk '{print $2}')

# Get default sink and source
default_sink=$(pactl get-default-sink)
default_source=$(pactl get-default-source)

# Check if the bluetooth device is being used for both output and input
# For input, we need to check if there's a corresponding bluez_source
bt_source_name=$(echo "$bt_sink_name" | sed 's/bluez_output/bluez_input/')

# Determine status
if [ "$default_sink" = "$bt_sink_name" ] && echo "$default_source" | grep -q "bluez"; then
    # Green: used for both output and input
    echo "{\"text\":\"󰋋\",\"tooltip\":\"Headphones: Active (Output + Input)\",\"class\":\"active\"}"
elif [ "$default_sink" = "$bt_sink_name" ]; then
    # Yellow/Orange: used for output only
    echo "{\"text\":\"󰋋\",\"tooltip\":\"Headphones: Output Only\",\"class\":\"output-only\"}"
else
    # Red: connected but not being used
    echo "{\"text\":\"󰋋\",\"tooltip\":\"Headphones: Connected (Not in use)\",\"class\":\"inactive\"}"
fi
