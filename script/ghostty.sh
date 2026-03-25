#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -S --needed ghostty ghostty-shell-integration ghostty-terminfo
	exit $?
fi
