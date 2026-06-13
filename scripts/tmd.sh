#!/usr/bin/env bash
# Convert file to markdown using pandoc
# Usage: tmd <file>

if [[ $# -eq 0 ]]; then
    echo "Usage: tmd <file>" >&2
    exit 1
fi

if [[ ! -f $1 ]]; then
    echo "Error: $1 is not a file" >&2
    exit 1
fi

if [[ ! -r $1 ]]; then
    echo "Error: $1 is not readable" >&2
    exit 1
fi

fnm=$(echo "$1" | sed 's/\..*$/.md/g')
pandoc "$1" -o "$fnm"
echo "Converted: $1 -> $fnm"
