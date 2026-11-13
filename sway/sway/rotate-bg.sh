#!/bin/env bash

PICROOT="$HOME/Pictures/wallpaper"


if [[ -z ${SWAYSOCK} ]]; then
    export SWAYSOCK=$(find /run/user/$(id -u) -maxdepth 1 -name 'sway-ipc.*' -print0)
fi

bgimg=$(find "${HOME}/Pictures/wallpaper/" -maxdepth 1 -type f -print0 | shuf -z -n1)
swaymsg "output * bg ${bgimg} fill"
notify-send --urgency low --icon ${bgimg} "sway" "Wallpaper => $(basename \"${bgimg}\")"
