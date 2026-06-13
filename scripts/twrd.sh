#!/usr/bin/env bash
# Convert markdown to Word document
# Usage: twrd <file>

if [[ $# -eq 0 ]]; then
    echo "Usage: twrd <file>" >&2
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

echo "Warning: html comments are lost in .docx conversion!"
chkdrft "$1"
fnm=$(echo "$1" | sed 's/\.md/.docx/g')
pandoc "$1" -f markdown+autolink_bare_uris-fancy_lists -o "$fnm"
echo "Converted: $1 -> $fnm"
