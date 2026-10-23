#!/bin/bash

# if [[ -f "/etc/arch-release" ]]; then
# 	sudo pacman -S --needed neovim
# 	exit $?
# fi

api_url="https://api.github.com/repos/neovim/neovim/releases/latest"
# Fetch the download link for the latest release
echo "Requesting GitHub for the latest Neovim release"
http_resp=$(curl -L -s -H 'Accept: application/json' ${api_url})
if [[ $? -ne 0 ]]; then
	>&2 echo "Error occured ($?). Exit"
	exit 1
fi

if ! [[ -x "$(command -v jq)" ]]; then
	>&2 echo "\`jq\` isn't found. Visit \"https://stedolan.github.io/jq\" for additional info."
	>&2 echo "Error occured. Exit"
	exit 1
fi

archname="nvim-linux-x86_64.tar.gz"
url=$(echo ${http_resp} | jq -r ".assets[]
    | select(.name == \"$archname\")
    | .browser_download_url")
echo "Download URL: ${url}"

if [[ -z "${url}" ]]; then
	>&2 echo "Error: Empty download URL!. Exit"
	exit 1
fi

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
