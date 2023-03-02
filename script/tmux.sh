#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -S --needed tmux
	exit $?
fi

shell=/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
$shell "$script_dir/install_by_package_manager.sh" tmux
exit $?
