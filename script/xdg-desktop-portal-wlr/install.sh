#!/bin/env bash

set -eo pipefail

if [[ $OS == "arch" ]]; then
	sudo pacman -S --needed xdg-desktop-portal-wlr
	exit $?
fi

# Fetch the download link for the latest release
echo "Requesting GitHub for the latest xdg-desktop-portal-wlr release"
AUTH_HEADER=()
if [[ -n "$GH_TOKEN" ]]; then
    AUTH_HEADER=(-H "Authorization: Bearer $GH_TOKEN")
fi

http_resp=$(curl -L -s \
    "${AUTH_HEADER[@]}" \
    -H 'Accept: application/json' \
    -H 'X-GitHub-Api-Version: 2022-11-28' \
    'https://api.github.com/repos/emersion/xdg-desktop-portal-wlr/releases/latest')

if [[ $? -ne 0 ]]; then
	>&2 echo "Error occured ($?). Exit"
	exit 1
fi

name=$(echo ${http_resp} | jq -r ".tag_name")

url=$(echo ${http_resp} | jq -r ".assets[]
    | select(.name | test(\"^xdg-desktop-portal-wlr-.*.tar.gz\$\"))
    | .browser_download_url")
printf "ver: %s, URL: %s\n" "${name}" "${url}"

if [[ -z "${url}" ]]; then
	>&2 echo "Error: Empty download URL!. Exit"
	exit 1
fi

sdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
docker buildx build --no-cache-filter builder \
    --build-arg WLR_ARCHIVE_URL=${url} \
    --output type=local,dest="${sdir}/.root" "${sdir}"

sudo mkdir -p "/usr/local/libexec"

# install the binary.
echo "stow -> /usr/local/libexec"
sudo stow --target="/usr/local/libexec" --dir="${sdir}/.root/usr/local" libexec

# install systemd unit file.
sudo mkdir -p "/usr/local/lib/systemd/user" \
    && sudo cp "${sdir}/.root/usr/local/lib/systemd/user/xdg-desktop-portal-wlr.service" \
        "/usr/local/lib/systemd/user"

# install dbus service.
sudo mkdir -p "/usr/local/share/dbus-1/services" \
    && sudo cp "${sdir}/.root/usr/local/share/dbus-1/services/org.freedesktop.impl.portal.desktop.wlr.service" \
        "/usr/local/share/dbus-1/services"

# install portal config.
sudo mkdir -p "/usr/local/share/xdg-desktop-portal/portals" \
    && sudo cp "${sdir}/.root/usr/local/share/xdg-desktop-portal/portals/wlr.portal" \
        "/usr/local/share/xdg-desktop-portal/portals"
sudo ln -sf "/usr/local/share/xdg-desktop-portal/portals/wlr.portal" "/usr/share/xdg-desktop-portal/portals/wlr.portal"

systemctl --user daemon-reload
systemctl --user enable --now xdg-desktop-portal-wlr.service
