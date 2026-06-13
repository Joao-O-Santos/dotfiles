#!/usr/bin/env bash
# Convert files using pandoc
# Usage: convert <format> <file>
# Formats: md, html, docx

if [[ $# -lt 2 ]]; then
    echo "Usage: convert <format> <file>" >&2
    echo "Formats: md, html, docx" >&2
    exit 1
fi

format="$1"
file="$2"

if [[ ! -f $file ]]; then
    echo "Error: $file is not a file" >&2
    exit 1
fi

if [[ ! -r $file ]]; then
    echo "Error: $file is not readable" >&2
    exit 1
fi

case "$format" in
    md)
        output="${file%.*}.md"
        pandoc "$file" -o "$output"
        echo "Converted: $file -> $output"
        ;;
    html)
        output="${file%.*}.html"
        pandoc -it revealjs --variable transition=convex -so "$output" "$file"
        echo "Converted: $file -> $output"
        ;;
    docx)
        echo "Warning: html comments are lost in .docx conversion!"
        chkdrft "$file"
        output="${file%.*}.docx"
        pandoc "$file" -f markdown+autolink_bare_uris-fancy_lists -o "$output"
        echo "Converted: $file -> $output"
        ;;
    *)
        echo "Error: Unknown format '$format'" >&2
        echo "Valid formats: md, html, docx" >&2
        exit 1
        ;;
esac
