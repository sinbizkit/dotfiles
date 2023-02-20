#!/bin/bash

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

if ! [[ -x "$(command -v jq)" ]]; then
	>&2 echo "\`jq\` isn't found. Visit \"https://stedolan.github.io/jq\" for additional info."
	>&2 echo "Error occured. Exit"
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

tmp_fpath="/tmp/fzf_latest.tar.gz"
echo "URL: ${url}"
echo "Download binary"
curl --silent --location ${url} --output ${tmp_fpath}

echo "Unpack .tar archive"
tar -xzf ${tmp_fpath} -C $HOME/.local/bin

echo "Cleanup"
rm ${tmp_fpath}
