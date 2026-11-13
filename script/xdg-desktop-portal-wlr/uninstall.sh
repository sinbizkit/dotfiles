#!/bin/env bash

set -eo pipefail

if [[ "$OS" == "arch" ]]; then
	sudo pacman -Rs xdg-desktop-portal-wlr
	exit $?
fi

sdir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# uninstall the binary.
echo "stow --delete -> /usr/local/libexec"
sudo stow --delete --target="/usr/local/libexec" --dir="${sdir}/.root/usr/local" libexec

# uninstall systemd unit file.
sudo rm -f "/usr/local/lib/systemd/user/xdg-desktop-portal-wlr.service"
# install dbus service.
sudo rm -f "/usr/local/share/dbus-1/services/org.freedesktop.impl.portal.desktop.wlr.service"
# uninstall portal config.
sudo rm -f "/usr/share/xdg-desktop-portal/portals/wlr.portal"
sudo rm -f "/usr/local/share/xdg-desktop-portal/portals/wlr.portal"

systemctl --user daemon-reload
