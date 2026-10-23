#!/bin/env bash

if [[ "$OS" == "arch" ]]; then
	sudo pacman -Syu
elif [[ "$OS" == "ubuntu" ]]; then
	sudo apt update && sudo apt upgrade -y
else
    exit 1
fi

exit $?
