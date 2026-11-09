#!/bin/env bash

set -euo pipefail

if [[ ${OS} == "arch" ]]; then
	sudo pacman -Rns lf
	exit $?
fi

sdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "unstow -> ${HOME}/.local"
rootpath="${sdir}/.root"
echo "cleanup -> ${rootpath}"
rm -rf "${rootpath}"
