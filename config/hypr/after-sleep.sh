#!/bin/bash

# Turn on display
hyprctl dispatch dpms on

# Reconnect NordVPN
nordvpn disconnect
nordvpn connect
