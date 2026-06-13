#!/usr/bin/env bash
# Open files with xdg-open
# Usage: o <file1> [file2] ...

if [[ $# -eq 0 ]]; then
    echo "Usage: o <file1> [file2] ..." >&2
    exit 1
fi

for file in "$@"; do
    if [[ ! -e $file ]]; then
        echo "Warning: $file does not exist" >&2
        continue
    fi
    (setsid xdg-open "$file" > /dev/null &) > /dev/null 2>&1
done
