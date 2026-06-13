#!/usr/bin/env bash
# Generate table of contents from markdown headings
# Usage: toc <file1> [file2] ...

if [[ $# -eq 0 ]]; then
    echo "Usage: toc <file1> [file2] ..." >&2
    exit 1
fi

for file in "$@"; do
    if [[ ! -f $file ]]; then
        echo "Error: $file is not a file" >&2
        continue
    fi

    if [[ ! -r $file ]]; then
        echo "Error: $file is not readable" >&2
        continue
    fi

    echo "- TOC for: $file"
    grep -e '#' -e '<h.>' "$file" | sed -e 's/^#//g; s/#/\t/g'
done
