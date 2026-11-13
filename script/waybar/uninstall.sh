#!/bin/bash

if [[ ${OS} == "arch" ]]; then
    sudo pacman -Rsn waybar
    exit 0
fi
