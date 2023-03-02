#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -S --needed lf
	exit $?
fi

shell=/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
$shell "$script_dir/install_from_github_archive.sh" gokcehan lf lf-linux-amd64.tar.gz
exit $?
