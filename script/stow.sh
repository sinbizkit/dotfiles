#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -S --needed stow
else
	sudo apt install stow
fi

exit $?
