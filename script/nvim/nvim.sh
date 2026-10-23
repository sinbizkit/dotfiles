#!/bin/bash

if [[ "$OS" == "arch" ]]; then
	sudo pacman -S --needed neovim
	exit $?
fi

version="v0.12.6"
archname="nvim-linux-x86_64.tar.gz"
url="https://github.com/neovim/neovim/releases/download/${version}/${archname}"
echo "URL: ${url}"
echo "Download binary"
sdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
archpath="${sdir}/${archname}"
curl --silent --location ${url} --output "${archpath}"

echo "tar extract: ${archpath}"
rootpath="${sdir}/.root"
mkdir -p "${rootpath}" && tar -xzf "${archpath}" --strip-component=1 -C "${rootpath}"

echo "stow -> ${HOME}/.local"
stow --target="${HOME}/.local" --dir="${sdir}" .root

echo "Cleanup"
rm "${archpath}"
