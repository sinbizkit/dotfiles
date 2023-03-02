#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -S --needed bat
	exit $?
fi

shell=/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
$shell "$script_dir/install_from_github_deb.sh" sharkdp bat _amd64.deb
exit $?
