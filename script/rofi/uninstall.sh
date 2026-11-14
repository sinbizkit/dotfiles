#!/bin/env bash

set -eo pipefail

if [[ ${OS} == "arch" ]]; then
    sudo pacman -Rsn rofi
    exit 0
fi

sdir=$( cd -- "$( dirname -- ${BASH_SOURCE[0]} )" &> /dev/null && pwd )
rootpath="${sdir}/.root"
if [[ ! -d "${rootpath}" ]]; then
    echo "rofi is not installed. Exit."
    exit 0
fi

echo "unstow -> /usr/local"
sudo stow --delete --target="/usr/local" --dir="${sdir}" .root

echo "Cleanup: ${rootpath}"
rm -rf "${rootpath}"
