FROM ubuntu:24.04 AS base
RUN apt update && apt upgrade -y \
	&& apt install -y linux-libc-dev build-essential \
	curl meson ninja-build cmake

RUN apt update && apt upgrade -y

FROM base AS builder
ARG TMUX_ARCHIVE_URL
WORKDIR /src
RUN : "${TMUX_ARCHIVE_URL:?Error: TMUX_ARCHIVE_URL must be provided}" \
	&& apt install -y libevent-dev byacc libncurses-dev \
	&& echo "URL: ${TMUX_ARCHIVE_URL}" \
	&& echo "Download binary" \
	&& curl --silent --location ${TMUX_ARCHIVE_URL} --output tmux.tar.gz \
	&& tar -xzf tmux.tar.gz --strip-component=1 -C /src \
	&& ./configure --prefix=/out \
	&& make install 

FROM scratch
COPY --from=builder /out /
