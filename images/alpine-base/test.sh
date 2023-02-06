#!/usr/bin/env bash

set -o errexit -o nounset -o errtrace -o pipefail

IMAGE_NAME=${IMAGE_NAME:-"ghcr.io/wolfi-dev/alpine-base"}

docker run ${IMAGE_NAME} echo "hello"
