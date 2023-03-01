#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -S --needed neovim
	exit $?
fi

shell=/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
$shell "$script_dir/install_from_github_deb.sh" neovim neovim nvim-linux64.deb
exit $?
