#!/bin/bash

if [[ ${OS} == "arch" ]]; then
    sudo pacman -Sy --needed sway swaylock swaybg grimshot
    exit 0
fi

sudo apt install -y --install-recommends sway swaylock swaybg grimshot
