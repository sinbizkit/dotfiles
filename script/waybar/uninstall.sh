#!/bin/bash

if [[ ${OS} == "arch" ]]; then
    sudo pacman -Rsn waybar
    exit 0
fi

sdir=$( cd -- "$( dirname -- ${BASH_SOURCE[0]} )" &> /dev/null && pwd )
rootpath="${sdir}/.root"
if [[ ! -d "${rootpath}" ]]; then
    echo "waybar is not installed. Exit."
    exit 0
fi

echo "unstow -> /usr/local/bin"
sudo stow --delete --target="/usr/local/bin" --dir="${sdir}" .root

echo "Cleanup: ${rootpath}"
rm -rf "${rootpath}"
