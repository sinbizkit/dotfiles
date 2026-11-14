#!/bin/bash

set -eo pipefail

if [[ ${OS} == "arch" ]]; then
    sudo pacman -Rns sway swaylock swaybg grim
    exit 0
fi

sudo apt purge -y sway swaylock swaybg grimshot
