FROM ubuntu:24.04 AS base
RUN apt update && apt upgrade -y \
	&& apt install -y linux-libc-dev build-essential \
	curl meson ninja-build cmake

FROM base AS builder
ARG ROFI_ARCHIVE_URL
WORKDIR /src
RUN : "${ROFI_ARCHIVE_URL:?Error: ROFI_ARCHIVE_URL must be provided}" \
	&& apt install -y \
	flex \
	bison \
	libpango1.0-dev libpangocairo-1.0-0 \
	libcairo2-dev \
	libglib2.0-dev \
	libgdk-pixbuf-2.0-dev \
	libstartup-notification0-dev \
	libxkbcommon-dev \
	libxkbcommon-x11-dev \
	libxcb1-dev \
	libxcb-xkb-dev \
	libxcb-randr0-dev \
	libxcb-xinerama0-dev \
	libxcb-util-dev \
	libxcb-ewmh-dev \
	libxcb-icccm4-dev \
	libxcb-cursor-dev \
	libxcb-imdkit-dev \
	libwayland-dev \
	libwayland-bin \
	wayland-protocols \
	&& echo "URL: ${ROFI_ARCHIVE_URL}" \
	&& echo "Download binary" \
	&& curl --silent --location ${ROFI_ARCHIVE_URL} --output rofi.tar.gz \
	&& tar -xzf rofi.tar.gz --strip-component=1 -C /src \
	&& meson setup build --prefix /out \
	&& ninja -C build && ninja -C build install

FROM scratch
COPY --from=builder /out /
