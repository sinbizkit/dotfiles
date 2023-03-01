#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -S --needed fd
	exit $?
fi

shell=/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
$shell "$script_dir/install_from_github_deb.sh" sharkdp fd _amd64.deb
exit $?
