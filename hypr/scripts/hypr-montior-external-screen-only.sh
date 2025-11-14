#!/usr/bin/env bash

# Delay slightly to let Hyprland detect the new monitor
sleep 1

INTERNAL="eDP-1"
EXTERNAL="GIGA-BYTE TECHNOLOGY CO. LTD. M28U 23120B007904"

# Check if the external monitor is connected
if hyprctl monitors | grep -q "$EXTERNAL"; then
    # External monitor connected → use only external monitor
    hyprctl keyword monitor "$INTERNAL,disable"
    sleep 1
    hyprctl keyword monitor "desc:$EXTERNAL, highres, auto, 1.5, bitdepth, 8"
else
    # External monitor disconnected → use only laptop display
    hyprctl keyword monitor "$INTERNAL,enable"
    sleep 1
    hyprctl keyword monitor "desc:$EXTERNAL,disable"
fi

