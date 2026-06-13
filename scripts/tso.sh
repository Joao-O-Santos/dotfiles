#!/usr/bin/env bash
# Generate topic sentence outline
# Usage: tso <file1> [file2] ...

if [[ $# -eq 0 ]]; then
    echo "Usage: tso <file1> [file2] ..." >&2
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

    echo "- Topic Sentence Outline for: $file"
    grep -A3 '^$' "$file"
done
