#!/bin/bash

# Check if mako is in do-not-disturb mode
if makoctl mode | grep -q "do-not-disturb"; then
    # Show quarter moon icon when silenced
    echo "{\"text\":\"🌜\",\"tooltip\":\"Notifications silenced\\nClick to enable\",\"class\":\"silenced\"}"
else
    # Show nothing when notifications are enabled
    echo "{\"text\":\"\",\"tooltip\":\"\",\"class\":\"hidden\"}"
fi
