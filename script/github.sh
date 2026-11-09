#!/bin/bash

set -eo pipefail

if [[ $OS == "arch" ]]; then
    # Arch have everything in Pacman already BTW.
    # No need in Github token.
    exit 0
fi

if [[ -z ${GH_TOKEN} ]]; then
    echo "Warning: GitHub token not set."
fi
