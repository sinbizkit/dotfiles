#!/bin/bash

if [[ ${OS} == "arch" ]]; then
    sudo pacman -Rns sway swaylock swaybg grimshot
    exit 0
fi

sudo apt purge -y sway swaylock swaybg grimshot
