#!/bin/env bash

if [[ ! -f "/etc/os-release" ]]; then
    exit 1
fi

source /etc/os-release

if [[ "$ID" == "arch" ]]; then
    echo arch
elif [[ "$ID" == "ubuntu" ]]; then
    echo ubuntu
fi
