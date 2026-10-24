#!/bin/bash

if [[ "$OS" == "arch" ]]; then
	sudo pacman -S --needed neovim
	exit $?
fi

# Fetch the download link for the latest release
echo "Requesting GitHub for the latest Neovim release"
AUTH_HEADER=()
if [[ -n "$GH_TOKEN" ]]; then
    AUTH_HEADER=(-H "Authorization: Bearer $GH_TOKEN")
fi

http_resp=$(curl -L -s \
    "${AUTH_HEADER[@]}" \
    -H 'Accept: application/json' \
    -H 'X-GitHub-Api-Version: 2022-11-28' \
    'https://api.github.com/repos/neovim/neovim/releases/latest')

if [[ $? -ne 0 ]]; then
	>&2 echo "Error occured ($?). Exit"
	exit 1
fi

if [[ ! -x "$(command -v jq)" ]]; then
	>&2 echo "\`jq\` isn't found. Visit \"https://stedolan.github.io/jq\" for additional info."
	>&2 echo "Error occured. Exit"
	exit 1
fi

name=$(echo ${http_resp} | jq -r ".tag_name")
archname="nvim-linux-x86_64.tar.gz"

url=$(echo ${http_resp} | jq -r ".assets[]
    | select(.name == \"$archname\")
    | .browser_download_url")
printf "ver: %s, URL: %s\n" "${name}" "${url}"

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
