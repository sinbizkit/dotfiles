#!/bin/bash

if [[ -f "/etc/arch-release" ]]; then
	sudo pacman -S --needed fzf
	exit $?
fi

# Install/update all the required packages
shell=/bin/bash
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
$shell "$script_dir/install_by_package_manager.sh" curl jq tar
if [[ $? -ne 0 ]]; then
	exit 1
fi
exit 0

user=junegunn
repo=fzf
api_url="https://api.github.com/repos/${user}/${repo}/releases/latest"

# Fetch the download link for the latest release
echo "Requesting GitHub for the latest FZF release"
http_resp=$(curl -L -s -H 'Accept: application/json' ${api_url})
if [[ $? -ne 0 ]]; then
	>&2 echo "Error occured ($?). Exit"
	exit 1
fi

url=$(echo ${http_resp} | jq '.assets[]
	| {name: .name, url: .browser_download_url}
	| select(.name | test(".*-linux_amd64.tar.gz"))
	| .url' \
	| tr -d '"')

if [[ -z ${url} ]]; then
	>&2 echo "Download URL not found"
	>&2 echo "Error occured. Exit"
	exit 1
fi

local_bin="$HOME/.local/bin"
mkdir -p "$local_bin"
if [[ $? -ne 0 ]]; then
	>&2 echo "Cannot create the directory \`$local_bin\`"
	>&2 echo "Error occured. Exit"
	exit 1
fi

tmp_fpath="/tmp/fzf_latest_$(date +%s).tar.gz"
echo "URL: ${url}"
echo "Download binary"
curl --silent --location ${url} --output ${tmp_fpath}

echo "Unpack .tar archive"
tar -xzf ${tmp_fpath} -C "$local_bin"

echo "Cleanup"
rm ${tmp_fpath}
