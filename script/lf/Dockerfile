FROM golang:1.27-trixie AS base

FROM base AS builder
WORKDIR /src
RUN apt update && apt install -y git
RUN GOBIN=/out CGOENABLED=0 GOOS=linux GOARCH=amd64 go install -trimpath -ldflags="-s -w" github.com/gokcehan/lf@r42

FROM scratch
COPY --from=builder /out /bin
