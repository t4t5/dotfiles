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

# Get device name/description
device_name=$(pactl list sinks | grep -A 30 "Name: $bt_sink_name" | grep "Description:" | sed 's/.*Description: //')

# Get AirPods battery information if available
battery_info=""
if command -v podpower &> /dev/null; then
    if airpods_data=$(timeout 5 podpower 2>/dev/null); then
        battery=$(echo "$airpods_data" | jq -r '.battery // ""')
        type=$(echo "$airpods_data" | jq -r '.type // ""')

        if [ -n "$battery" ]; then
            if [ "$type" = "over_ear" ]; then
                # AirPods Max - single battery value
                battery_info="\\n$battery%"
            else
                # In-ear AirPods - build battery string with only available components
                battery_parts=()

                left=$(echo "$airpods_data" | jq -r '.components[] | select(.name=="left") | .battery // ""')
                right=$(echo "$airpods_data" | jq -r '.components[] | select(.name=="right") | .battery // ""')
                case=$(echo "$airpods_data" | jq -r '.components[] | select(.name=="case") | .battery // ""')

                [ -n "$left" ] && battery_parts+=("L: ${left}%")
                [ -n "$right" ] && battery_parts+=("R: ${right}%")
                [ -n "$case" ] && battery_parts+=("Case: ${case}%")

                if [ ${#battery_parts[@]} -gt 0 ]; then
                    # Join array elements with ", " (note: IFS uses the first char as separator)
                    battery_info="\\n$(printf "%s, " "${battery_parts[@]}" | sed 's/, $//')"
                fi
            fi
        fi
    fi
fi

# Get default sink and source
default_sink=$(pactl get-default-sink)
default_source=$(pactl get-default-source)

# Check if the bluetooth device is being used for both output and input
# For input, we need to check if there's a corresponding bluez_source
bt_source_name=$(echo "$bt_sink_name" | sed 's/bluez_output/bluez_input/')

# Determine status
if [ "$default_sink" = "$bt_sink_name" ] && echo "$default_source" | grep -q "bluez"; then
    # Green: used for both output and input
    echo "{\"text\":\"󰋋\",\"tooltip\":\"$device_name\\nActive (Output + Input)$battery_info\",\"class\":\"active\"}"
elif [ "$default_sink" = "$bt_sink_name" ]; then
    # Yellow/Orange: used for output only
    echo "{\"text\":\"󰋋\",\"tooltip\":\"$device_name\\nOutput Only$battery_info\",\"class\":\"output-only\"}"
else
    # Red: connected but not being used
    echo "{\"text\":\"󰋋\",\"tooltip\":\"$device_name\\nConnected (Not in use)$battery_info\",\"class\":\"inactive\"}"
fi
