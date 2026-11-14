#!/bin/bash

if [[ ${OS} == "arch" ]]; then
    sudo pacman -Sy waybar
    exit 0
fi

# Fetch the download link for the latest release
echo "Requesting GitHub for the latest waybar release"
AUTH_HEADER=()
if [[ -n "$GH_TOKEN" ]]; then
    AUTH_HEADER=(-H "Authorization: Bearer $GH_TOKEN")
fi

http_resp=$(curl -L -s \
    "${AUTH_HEADER[@]}" \
    -H 'Accept: application/json' \
    -H 'X-GitHub-Api-Version: 2022-11-28' \
    'https://api.github.com/repos/Alexays/Waybar/releases/latest')

if [[ $? -ne 0 ]]; then
	>&2 echo "Error occured ($?). Exit"
	exit 1
fi

name=$(echo ${http_resp} | jq -r ".tag_name")

url=$(echo ${http_resp} | jq -r ".tarball_url")
printf "ver: %s, URL: %s\n" "${name}" "${url}"

if [[ -z "${url}" ]]; then
	>&2 echo "Error: Empty download URL!. Exit"
	exit 1
fi

sdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
docker buildx build --no-cache-filter builder \
    --build-arg WAYBAR_ARCHIVE_URL=${url} \
    --output type=local,dest="${sdir}/.root" "${sdir}"

echo "stow -> /usr/local/bin"
sudo stow --target="/usr/local/bin" --dir="${sdir}" .root
