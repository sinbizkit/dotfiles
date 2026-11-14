#!/bin/bash

set -eo pipefail

if [[ "${OS}" == "arch" ]]; then
	sudo pacman -S --needed fzf
	exit $?
fi

# Fetch the download link for the latest release
echo "Requesting GitHub for the latest FZF release"
AUTH_HEADER=()
if [[ -n "$GH_TOKEN" ]]; then
    AUTH_HEADER=(-H "Authorization: Bearer $GH_TOKEN")
fi

http_resp=$(curl -L -s \
    "${AUTH_HEADER[@]}" \
    -H 'Accept: application/json' ${api_url} \
    -H 'X-GitHub-Api-Version: 2022-11-28' \
    'https://api.github.com/repos/junegunn/fzf/releases/latest'
)

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
	| select(.name | test(".*-linux_amd64.tar.gz$"))
	| .url' \
	| tr -d '"')

if [[ -z ${url} ]]; then
	>&2 echo "Download URL not found"
	>&2 echo "Error occured. Exit"
	exit 1
fi

echo "URL: ${url}"
echo "Download binary"
sdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
archname="fzf-latest-linux-amd64.tar.gz"
archpath="${sdir}/${archname}"
curl --silent --location ${url} --output ${archpath}

echo "tar extract: ${archpath}"
rootpath="${sdir}/.root/bin"
mkdir -p "${rootpath}" && tar -xzf "${archpath}" -C "${rootpath}"

echo "stow -> ${HOME}/.local"
stow --target="${HOME}/.local" --dir="${sdir}" .root

echo "Cleanup"
rm ${archpath}
