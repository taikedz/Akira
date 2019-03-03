#!/usr/bin/env bash

## Launch the build from the host environment
external_build_akira() {
    cd "$(dirname "$0")"
    (set -x
    docker run --rm -v "$(dirname "$PWD"):/var/akira-source" -it akira/builder
    )
}

## Host environment flags
if [[ "$*" =~ --build-docker ]]; then
    cd "$(dirname "$0")"
    docker build -t akira/builder . || exit 101
    external_build_akira
    exit
fi

if [[ "$*" =~ --build-akira ]]; then
    external_build_akira
    exit
fi

## In-docker 
if [[ ! -d /var/akira-source ]]; then
    echo "No Akira source. Mount the Akira git directory to /var/akira-source"
    echo "If you meant to also build the docker image, run with --build-docker"
    exit 1
fi

cd /var/akira-source

echo "Building akira..."
meson build --prefix=/usr || exit

echo
echo "--- Done."
