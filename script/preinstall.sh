#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -Syu
else
	sudo apt update && sudo apt upgrade 
fi

exit $?
