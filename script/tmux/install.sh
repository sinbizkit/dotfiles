#!/bin/bash

set -eo pipefail

if [[ ${OS} == "arch" ]]; then
	sudo pacman -S --needed tmux
	exit $?
fi

# Fetch the download link for the latest release
echo "Requesting GitHub for the latest Tmux release"
AUTH_HEADER=()
if [[ -n "$GH_TOKEN" ]]; then
    AUTH_HEADER=(-H "Authorization: Bearer $GH_TOKEN")
fi

http_resp=$(curl -L -s \
    "${AUTH_HEADER[@]}" \
    -H 'Accept: application/json' \
    -H 'X-GitHub-Api-Version: 2022-11-28' \
    'https://api.github.com/repos/tmux/tmux/releases/latest')

name=$(echo ${http_resp} | jq -r ".name")

url=$(echo ${http_resp} | jq -r '.assets[]
    | select(.name | test("^tmux-[0-9.]+.tar.gz$"))
    | .browser_download_url')
printf "ver: %s, URL: %s\n" "${name}" "${url}"

if [[ -z "${url}" ]]; then
	>&2 echo "Error: Empty download URL!. Exit"
	exit 1
fi

sdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
docker buildx build --no-cache-filter builder \
    --build-arg TMUX_ARCHIVE_URL=${url} \
    --output type=local,dest="${sdir}/.root" "${sdir}"

echo "stow -> ${HOME}/.local"
stow --target="${HOME}/.local" --dir="${sdir}" .root
