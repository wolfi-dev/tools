#!/usr/bin/env bash

# This script is used in .github/workflows/release.yaml
# to dynamically generate a build matrix based on repo contents

set -e
matrix='{"include":[]}'
for name in `find images -mindepth 1 -maxdepth 1 -type d | sed 's|images/||' | sort | xargs`; do
    [[ "${ONLY}" == "" || "${ONLY}" == "${name}" ]] || continue
    entry='{imageName: "'${name}'"}'
    melange_config="$(cd images/${name} && find . -name '*.melange.yaml' | sed 's|./||')"
    if [[ "${melange_config}" != "" ]]; then
        entry="{imageName: \"${name}\", melangeConfig: \"${melange_config}\"}"
    fi
    matrix="$(echo "${matrix}" | jq -c ".include += [${entry}]")"
done
echo "${matrix}"
