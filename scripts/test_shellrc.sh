#!/usr/bin/env bash
# Regression checks for the shellrc command surface and script-backed tools.
set -euo pipefail

scripts_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_dir="$(cd -- "$scripts_dir/.." && pwd)"
tmp_home="$(mktemp -d)"
trap 'rm -rf "$tmp_home"' EXIT
mkdir -p "$tmp_home/.config/pi"
ln -s "$scripts_dir" "$tmp_home/.config/scripts"
ln -s "$config_dir/pandoc" "$tmp_home/.config/pandoc"
: > "$tmp_home/.config/pi/secrets.env"
printf '# Example\n\nSome text.\n' > "$tmp_home/draft with spaces.md"

HOME="$tmp_home" bash --noprofile --norc -e -c '
    source "$1"

    # Keep the established commands and reject the retired duplicate.
    for name in f o pull_all toc tso tdx tmd tpres chkdrft; do
        command -v "$name" >/dev/null || { echo "Missing command: $name" >&2; exit 1; }
    done
    if command -v twrd >/dev/null; then
        echo "Retired command twrd is still available" >&2
        exit 1
    fi

    chkdrft "$2" >/dev/null
    toc "$2" >/dev/null
    if toc "$2.missing" >/dev/null 2>&1; then
        echo "toc accepted a missing file" >&2
        exit 1
    fi
    if command -v pandoc >/dev/null; then
        tdx "$2" >/dev/null
        [[ -s "${2%.md}.docx" ]] || { echo "DOCX conversion failed" >&2; exit 1; }
        if tdx "$2" >/dev/null 2>&1; then
            echo "DOCX conversion overwrote an existing file" >&2
            exit 1
        fi
    else
        echo "Skipping DOCX conversion check: pandoc not installed"
    fi
' _ "$config_dir/shellrc" "$tmp_home/draft with spaces.md"

echo "shellrc regression checks passed"
