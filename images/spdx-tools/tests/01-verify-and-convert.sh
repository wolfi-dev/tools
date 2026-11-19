#!/usr/bin/env bash

set -o errexit -o nounset -o errtrace -o pipefail -x

IMAGE_NAME=${IMAGE_NAME:-"unset"}
if [[ "${IMAGE_NAME}" == "unset" ]]; then
    echo "Must set IMAGE_NAME in the environment. Exiting."
    exit 1
fi

# The image runs as nonroot by default.
docker run --rm --entrypoint id "${IMAGE_NAME}" -un | grep "^nonroot$"

WORKDIR="$(mktemp -d)"
trap 'rm -rf "${WORKDIR}"' EXIT
# The container runs as nonroot, so it must be able to write the converted
# document back into the mounted directory.
chmod a+rwx "${WORKDIR}"

cat > "${WORKDIR}/example.spdx.json" <<'DOC'
{
  "spdxVersion": "SPDX-2.3",
  "dataLicense": "CC0-1.0",
  "SPDXID": "SPDXRef-DOCUMENT",
  "name": "spdx-tools-smoke-test",
  "documentNamespace": "https://github.com/wolfi-dev/tools/images/spdx-tools/tests",
  "creationInfo": {
    "created": "2024-01-01T00:00:00Z",
    "creators": ["Organization: Wolfi"]
  },
  "packages": [
    {
      "name": "hello",
      "SPDXID": "SPDXRef-Package-hello",
      "versionInfo": "1.0.0",
      "downloadLocation": "NOASSERTION",
      "filesAnalyzed": false,
      "licenseConcluded": "Apache-2.0",
      "licenseDeclared": "Apache-2.0",
      "copyrightText": "NOASSERTION"
    }
  ],
  "relationships": [
    {
      "spdxElementId": "SPDXRef-DOCUMENT",
      "relationshipType": "DESCRIBES",
      "relatedSpdxElement": "SPDXRef-Package-hello"
    }
  ]
}
DOC

run() {
    docker run --rm -v "${WORKDIR}:/work" -w /work "${IMAGE_NAME}" "$@"
}

# A well-formed SPDX JSON document verifies successfully.
run Verify example.spdx.json | grep "This SPDX Document is valid."

# The document can be converted to tag-value, and the result also verifies.
run Convert example.spdx.json example.spdx JSON TAG
grep "^SPDXVersion: SPDX-2.3$" "${WORKDIR}/example.spdx"
grep "^PackageName: hello$" "${WORKDIR}/example.spdx"
run Verify example.spdx TAG | grep "This SPDX Document is valid."

# An invalid document must be rejected with a non-zero exit code.
echo '{"spdxVersion": "SPDX-2.3"}' > "${WORKDIR}/invalid.spdx.json"
if run Verify invalid.spdx.json; then
    echo "Verify unexpectedly accepted an invalid SPDX document."
    exit 1
fi
