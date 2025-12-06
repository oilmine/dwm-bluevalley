#!/bin/bash

# Advanced DWM Status Script for BAT1 with icons

while true; do
    # Volume with icon using pamixer
    volume_level=$(pamixer --get-volume)
    volume_mute=$(pamixer --get-mute)
    
    if [ "$volume_mute" = "true" ]; then
        volume=" MUTE"
    else
        # Different volume icons based on level
        if [ $volume_level -eq 0 ]; then
            volume_icon=" "
        elif [ $volume_level -lt 33 ]; then
            volume_icon=""
        elif [ $volume_level -lt 66 ]; then
            volume_icon=" "
        else
            volume_icon=" "
        fi
        volume="$volume_icon $volume_level%"
    fi

    # Brightness with icon using brightnessctl
    brightness=$(brightnessctl -m | cut -d, -f4 | tr -d '%')
    
    # Brightness icon based on level
    bright_icon=" "
    brightness="$bright_icon $brightness%"

    # Battery with icon - using BAT1
    if [ -f /sys/class/power_supply/BAT1/capacity ]; then
        battery_capacity=$(cat /sys/class/power_supply/BAT1/capacity)
        battery_status=$(cat /sys/class/power_supply/BAT1/status)
        
        # Battery icon based on capacity
        if [ "$battery_status" = "Charging" ]; then
            bat_icon="⚡"
        elif [ $battery_capacity -gt 99 ]; then
            bat_icon=" "
        elif [ $battery_capacity -gt 85 ]; then
            bat_icon=" "
        elif [ $battery_capacity -gt 50 ]; then
            bat_icon=" "
        elif [ $battery_capacity -gt 20 ]; then
            bat_icon=" "
        else
            bat_icon=" "
        fi
        
        battery="$bat_icon $battery_capacity%"
    else
        battery=" NO_BAT"
    fi

    # Date and Time with icon
    datetime=" $(date +"%H:%M")"

    # Combine all components
    if [ "$battery" != " NO_BAT" ]; then
        status="$volume | $battery | $datetime"
    else
        status="$volume | $datetime"
    fi

    # Set DWM status
    xsetroot -name " $status "
done
