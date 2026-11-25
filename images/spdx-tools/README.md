# spdx-tools

Minimal image containing the [SPDX Java tools](https://github.com/spdx/tools-java)
for verifying, converting and comparing [SPDX](https://spdx.dev/) documents.

## Get It!

The image is available on `ghcr.io`:

```
docker pull ghcr.io/wolfi-dev/spdx-tools:latest
```

## Usage

The image entrypoint is the `tools-java` CLI, so pass the function and its
parameters as arguments:

```
docker run --rm ghcr.io/wolfi-dev/spdx-tools:latest Version
```

The image runs as the `nonroot` user (UID `65532`). Mount the directory
containing your SPDX documents and make sure that user can read it (and write
to it, for functions that produce output files):

```
docker run --rm -v "${PWD}:/work" -w /work ghcr.io/wolfi-dev/spdx-tools:latest \
  Verify sbom.spdx.json
```

Convert an SPDX JSON document to tag-value format:

```
docker run --rm -v "${PWD}:/work" -w /work ghcr.io/wolfi-dev/spdx-tools:latest \
  Convert sbom.spdx.json sbom.spdx JSON TAG
```

Run the image without arguments to list all available functions.
