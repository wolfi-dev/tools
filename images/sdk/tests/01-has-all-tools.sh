#!/usr/bin/env bash

set -o errexit -o nounset -o errtrace -o pipefail

IMAGE_NAME=${IMAGE_NAME:-"unset"}
if [[ "${IMAGE_NAME}" == "unset" ]]; then
    echo "Must set IMAGE_NAME in the environment. Exiting."
    exit 1
fi

docker run --rm --entrypoint bash "${IMAGE_NAME}" -xc \
    'tree --version &&
     go version &&
     make --version &&
     curl --version &&
     git version &&
     apk --version &&
     bwrap --version &&
     melange version &&
     apko version &&
     wolfictl version'

# Check that everything is up to date
# Freshly minted image, should be fully up to date, this however will
# catch any package renames/provides that apko resolved using out of
# date packages, due to packaging mistakes or ongoing transitions
docker run --rm --entrypoint bash "${IMAGE_NAME}" -xc \
     'apk update; apk upgrade --all --latest || true'
