FROM golang:1.27-trixie AS base

FROM base AS builder
WORKDIR /src
RUN apt update && apt upgrade -y && apt install -y --no-install-recommends git ca-certificates
RUN GOBIN=/out CGOENABLED=0 GOOS=linux GOARCH=amd64 go install -trimpath -ldflags="-s -w" github.com/gokcehan/lf@latest

FROM scratch
COPY --from=builder /out /bin
