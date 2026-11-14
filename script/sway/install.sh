#!/bin/bash

set -eo pipefail

if [[ ${OS} == "arch" ]]; then
    sudo pacman -Sy --needed sway swaylock swayidle swaybg grimshot
    exit 0
fi

sudo apt install -y --install-recommends sway swaylock swayidle swaybg grimshot
