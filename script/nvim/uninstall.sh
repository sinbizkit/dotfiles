#!/bin/bash

set -euo pipefail

if [[ "$OS" == "arch" ]]; then
	sudo pacman -Rns neovim
	exit $?
fi

sdir=$( cd -- "$( dirname -- ${BASH_SOURCE[0]} )" &> /dev/null && pwd )
rootpath="${sdir}/.root"
if [[ ! -d "${rootpath}" ]]; then
    echo "neovim is not installed. Exit."
    exit 0
fi
echo "unstow -> ${HOME}/.local"
stow --delete --target="${HOME}/.local" --dir="${sdir}" .root

echo "Cleanup: ${rootpath}"
rm -rf "${rootpath}"
