#!/bin/sh
# Generate table of contents from markdown headings
# Usage: toc <file1> [file2] ...

if [ "$#" -eq 0 ]; then
    echo "Usage: toc <file1> [file2] ..." >&2
    exit 1
fi

status=0
for file do
    if [ ! -f "$file" ]; then
        echo "Error: $file is not a file" >&2
        status=1
        continue
    fi
    if [ ! -r "$file" ]; then
        echo "Error: $file is not readable" >&2
        status=1
        continue
    fi
    case $file in -*) input=./$file ;; *) input=$file ;; esac
    printf '%s\n' "- TOC for: $file"
    awk '
        /^#+[[:space:]]/ {
            match($0, /^#+/)
            if (RLENGTH <= 6) {
                depth = RLENGTH
                for (i = 1; i < depth; i++) printf "\t"
                print substr($0, depth + 1)
            }
            next
        }
        /^<h[1-6]>/ { print }
    ' "$input" || status=1
done
exit "$status"
