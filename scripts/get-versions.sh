#!/usr/bin/env bash
set -euo pipefail

fetch_latest_tag() {
  local repo="$1"
  curl -sf "https://api.github.com/repos/${repo}/releases/latest" | jq -r '.tag_name'
}

JAMSERVE_VERSION=$(fetch_latest_tag "ffalt/jamserve")
JAMBERRY_VERSION=$(fetch_latest_tag "ffalt/jamberry")

echo "JAMSERVE_VERSION=${JAMSERVE_VERSION}"
echo "JAMBERRY_VERSION=${JAMBERRY_VERSION}"

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "jamserve_version=${JAMSERVE_VERSION}" >> "$GITHUB_OUTPUT"
  echo "jamberry_version=${JAMBERRY_VERSION}" >> "$GITHUB_OUTPUT"
fi
