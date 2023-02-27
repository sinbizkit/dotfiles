#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -S --needed i3 rofi polybar
	exit $?
fi
