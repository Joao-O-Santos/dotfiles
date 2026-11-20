#!/usr/bin/env bash
# Convert files using pandoc
# Usage: convert <format> [-f] <file>
# Formats: md, html, docx

if [[ $# -lt 2 || $# -gt 3 ]]; then
    echo "Usage: convert <format> [-f] <file>" >&2
    echo "Formats: md, html, docx" >&2
    exit 1
fi

format="$1"
force=false
if [[ $# -eq 3 ]]; then
    if [[ $2 != -f ]]; then
        echo "Error: unknown option '$2' (use -f to overwrite output)" >&2
        exit 1
    fi
    force=true
    file="$3"
else
    file="$2"
fi
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

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
        if [[ $file == *.md ]]; then
            echo "Error: refusing to overwrite Markdown input '$file'" >&2
            exit 1
        fi
        output="${file%.*}.md"
        ;;
    html)
        output="${file%.*}.html"
        ;;
    docx)
        output="${file%.*}.docx"
        filter="${XDG_CONFIG_HOME:-$HOME/.config}/pandoc/filters/apa-tables.lua"
        if [[ ! -f $filter ]]; then
            echo "Error: APA Lua filter not found: $filter" >&2
            exit 1
        fi
        if [[ ! -x $script_dir/chkdrft.sh ]]; then
            echo "Error: chkdrft.sh is missing or not executable: $script_dir/chkdrft.sh" >&2
            exit 1
        fi
        ;;
    *)
        echo "Error: Unknown format '$format'" >&2
        echo "Valid formats: md, html, docx" >&2
        exit 1
        ;;
esac

if ! command -v pandoc >/dev/null 2>&1; then
    echo "Error: pandoc executable not found" >&2
    exit 1
fi

if [[ -e $output && $force != true ]]; then
    echo "Error: output already exists: $output" >&2
    echo "Choose another output name or use -f to overwrite it" >&2
    exit 1
fi

if [[ $format == docx ]]; then
    echo "Warning: html comments are lost in .docx conversion!"
    "$script_dir/chkdrft.sh" "$file" || exit 1
    pandoc "$file" -f markdown+autolink_bare_uris-fancy_lists \
        --lua-filter="$filter" -o "$output"
elif [[ $format == html ]]; then
    pandoc -it revealjs --variable transition=convex -so "$output" "$file"
else
    pandoc "$file" -o "$output"
fi

conversion_status=$?
if [[ $conversion_status -eq 0 ]]; then
        echo "Converted: $file -> $output"
fi
exit "$conversion_status"
