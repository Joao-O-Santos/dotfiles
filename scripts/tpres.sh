#!/usr/bin/env bash
# Convert file to reveal.js presentation using pandoc
# Usage: tpres <file>

if [[ $# -eq 0 ]]; then
    echo "Usage: tpres <file>" >&2
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

fnm=$(echo "$1" | sed 's/\..*$/.html/g')
pandoc -it revealjs --variable transition=convex -so "$fnm" "$1"
echo "Converted: $1 -> $fnm"
