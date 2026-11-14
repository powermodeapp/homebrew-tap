#!/usr/bin/env bash
set -euo pipefail

repo="powermodeapp/PowerModeManager-Releases"
cask="Casks/powermodemanager.rb"
release_json="$(curl --fail --silent --show-error "https://api.github.com/repos/${repo}/releases/latest")"
tag="$(printf '%s' "$release_json" | jq -r '.tag_name')"
draft="$(printf '%s' "$release_json" | jq -r '.draft')"
prerelease="$(printf '%s' "$release_json" | jq -r '.prerelease')"

if [[ "$draft" != "false" || "$prerelease" != "false" ]]; then
  echo "Latest release is not a published stable release: ${tag}" >&2
  exit 1
fi

if [[ ! "$tag" =~ ^v?([0-9]+\.[0-9]+\.[0-9]+)$ ]]; then
  echo "Unsupported release tag format: ${tag}" >&2
  exit 1
fi
version="${BASH_REMATCH[1]}"
checksum_text="$(curl --fail --location --silent --show-error "https://github.com/${repo}/releases/download/${tag}/PowerModeManager.dmg.sha256")"
sha256="$(printf '%s\n' "$checksum_text" | awk 'NF { print $1; exit }')"
if [[ ${#sha256} -ne 64 || "$sha256" == *[!0-9a-f]* ]]; then
  echo "Invalid DMG SHA-256 for release ${tag}" >&2
  exit 1
fi

python3 - "$cask" "$version" "$sha256" <<'PY'
from pathlib import Path
import re
import sys

path = Path(sys.argv[1])
version, checksum = sys.argv[2:]
text = path.read_text()
text, versions = re.subn(r'(?m)^  version "[^"]+"$', f'  version "{version}"', text, count=1)
text, checksums = re.subn(r'(?m)^  sha256 "[0-9a-f]{64}"$', f'  sha256 "{checksum}"', text, count=1)
if versions != 1 or checksums != 1:
    raise SystemExit("Cask version or SHA-256 stanza could not be updated safely")
path.write_text(text)
PY

echo "Updated Cask to ${version} (${sha256})"
if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  printf 'version=%s\n' "$version" >> "$GITHUB_OUTPUT"
fi
