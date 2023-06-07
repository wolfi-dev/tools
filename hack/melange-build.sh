#!/usr/bin/env bash

# This script is used for local development
# to generate the packages/ for a specific image
# using melange

set -e

IMAGE="${1}"

if [[ "${IMAGE}" == "" ]]; then
    echo "usage: ./melange-build.sh <image>"
    exit 1
fi

if [[ ! -f melange.rsa ]]; then
    melange keygen
fi

cd "images/${IMAGE}"

melange build \
    --arch amd64,arm64 \
    --signing-key ../../melange.rsa \
    --out-dir ../../packages/ \
    configs/*.melange.yaml
