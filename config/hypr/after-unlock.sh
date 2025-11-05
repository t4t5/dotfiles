#!/bin/bash

# Reconnect NordVPN after unlock
nordvpn disconnect >> /tmp/hyprlock-unlock.log 2>&1
nordvpn connect >> /tmp/hyprlock-unlock.log 2>&1
