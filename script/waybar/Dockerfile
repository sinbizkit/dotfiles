FROM ubuntu:24.04 AS base

RUN apt update && apt upgrade -y \
	&& apt install -y linux-libc-dev build-essential \
	curl meson ninja-build cmake pkg-config

FROM base AS builder
ARG WAYBAR_ARCHIVE_URL
WORKDIR /src
RUN : "${WAYBAR_ARCHIVE_URL:?Error: WAY_ARCHIVE_URL must be provided}" \
	&& apt update && apt install -y \
	gobject-introspection libdbusmenu-gtk3-dev libevdev-dev \
	libfmt-dev libgirepository1.0-dev libgtk-3-dev libgtkmm-3.0-dev \
	libinput-dev libjsoncpp-dev libmpdclient-dev libnl-3-dev libnl-genl-3-dev \
	libpulse-dev libsigc++-2.0-dev libspdlog-dev libwayland-dev scdoc upower \
	libxkbregistry-dev \
	wayland-protocols \
	&& echo "URL: ${WAYBAR_ARCHIVE_URL}" \
	&& echo "Download binary" \
	&& curl --silent --location ${WAYBAR_ARCHIVE_URL} --output waybar.tar.gz \
	&& tar -xzf waybar.tar.gz --strip-component=1 -C /src \
	&& meson setup build --prefix /out \
	&& ninja -C build && ninja -C build install

FROM scratch
COPY --from=builder /out/bin /
