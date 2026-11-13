FROM ubuntu:24.04 AS base

RUN apt update && apt upgrade -y \
	&& apt install -y linux-libc-dev build-essential \
	curl meson ninja-build cmake pkg-config

FROM base AS builder
ARG WLR_ARCHIVE_URL
WORKDIR /src
RUN : "${WLR_ARCHIVE_URL:?Error: WLR_ARCHIVE_URL must be provided}" \
	&& NEEDRESTART_SUSPEND=1 apt install -y \
	   libpipewire-0.3-dev libwayland-dev wayland-protocols \
	   libinih-dev libgbm-dev libdrm-dev systemd libsystemd-dev \
	&& echo "URL: ${WLR_ARCHIVE_URL}" \
	&& echo "Download binary" \
	&& curl --silent --location ${WLR_ARCHIVE_URL} --output xdg-desktop-portal-wlr.tar.gz \
	&& tar -xzf xdg-desktop-portal-wlr.tar.gz --strip-component=1 -C /src \
	&& meson setup build --prefix=/usr/local --buildtype=release -Dwerror=false -Dstrip=true \
	&& DESTDIR=/out ninja -C build install 

FROM scratch
COPY --from=builder /out /
