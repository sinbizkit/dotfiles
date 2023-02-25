#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -Syu neovim
	if [[ $? -eq 0 ]]; then
		echo "NeoVim is installed succesfully."
		exit 0
	else
		echo "Error. NeoVim installation failed."
		exit 1
	fi
fi

user=neovim
repo=neovim
fname=nvim-linux64.deb
api_url="https://api.github.com/repos/${user}/${repo}/releases/latest"


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
url=$(echo ${http_resp} | jq '.assets[]
	| {name: .name, url: .browser_download_url}
	| select(.name == "'${fname}'")
	| .url' \
	| tr -d '"')

if [[ -z ${url} ]]; then
	>&2 echo "Download URL not found"
	>&2 echo "Error occured. Exit"
	exit 1
fi

echo "URL: ${url}"
echo "Download binary"
tmp_fpath="/tmp/${fname}"
curl --silent --location ${url} --output ${tmp_fpath}

echo "Install .deb package"
sudo dpkg -i ${tmp_fpath}

echo "Cleanup"
rm ${tmp_fpath}
