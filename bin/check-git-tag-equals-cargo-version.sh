#!/bin/bash

# Test with:
# echo "refs/tags/v1.0.0 _ _ _" | .../bin/check-git-tag-equals-cargo-version.sh

set -e -f -u -o pipefail

main() {
  if [[ "$#" -ne 0 ]]; then
    echo "Unexpected arguments: $*" >&2
    echo "Usage: $0 < GIT_TAG_INFO" >&2
    return 1
  fi

  local cargo_version
  cargo_version="$(sed -n 's/^version = "\(.*\)"/\1/p' Cargo.toml | head -n 1)"

  while read -r local_ref _ _ _; do
    if [[ "${local_ref}" == refs/tags/* ]]; then
      local tag_name="${local_ref#refs/tags/}"
      if [ "${tag_name}" != "${cargo_version}" ] \
          && [ "${tag_name}" != "v${cargo_version}" ]; then
        echo "❌ ERROR: Version Mismatch" >&2
        echo "Git Tag: ${tag_name}" >&2
        echo "Cargo.toml: ${cargo_version}" >&2
        return 1
      fi
      echo "✅ Version match confirmed: ${tag_name}"
      return 0
    fi
  done
}

main "$@"
