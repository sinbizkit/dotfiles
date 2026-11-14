FROM ubuntu:24.04 AS base
RUN apt update && apt upgrade -y \
	&& apt install -y linux-libc-dev build-essential \
	curl meson ninja-build cmake

FROM base AS builder
ARG DUNST_ARCHIVE_URL
WORKDIR /src
RUN : "${DUNST_ARCHIVE_URL:?Error: ROFI_ARCHIVE_URL must be provided}" \
	&& apt install -y \
	libglib2.0-dev libgdk-pixbuf2.0-dev libcairo2-dev libpango1.0-dev \
	libxinerama-dev libxrandr-dev libxss-dev \
	libwayland-dev wayland-protocols \
	libnotify-dev \
	&& echo "URL: ${DUNST_ARCHIVE_URL}" \
	&& echo "Download binary" \
	&& curl --silent --location ${DUNST_ARCHIVE_URL} --output dunst.tar.gz \
	&& tar -xzf dunst.tar.gz --strip-component=1 -C /src \
	&& meson setup build --prefix /out \
	&& ninja -C build && ninja -C build install

FROM scratch
COPY --from=builder /out /
