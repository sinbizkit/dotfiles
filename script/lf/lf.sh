#!/bin/env bash

if [[ ${OS} == "arch" ]]; then
	sudo pacman -S --needed lf
	exit $?
fi

sdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
docker buildx build --no-cache-filter builder --output type=local,dest="${sdir}/.root" "${sdir}"

echo "stow -> ${HOME}/.local"
rootpath="${sdir}/.root"
mkdir -p "${rootpath}" && stow --target="${HOME}/.local" --dir="${sdir}" .root
