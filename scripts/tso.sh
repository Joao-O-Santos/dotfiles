#!/bin/sh
# Generate topic sentence outline
# Usage: tso <file1> [file2] ...

if [ "$#" -eq 0 ]; then
    echo "Usage: tso <file1> [file2] ..." >&2
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
    printf '%s\n' "- Topic Sentence Outline for: $file"
    awk '
        function emit() {
            if (paragraph == "") return
            if (match(paragraph, /[.!?]([[:space:]]|$)/))
                print substr(paragraph, 1, RSTART)
            else print paragraph
            paragraph = ""
        }
        /^[[:space:]]*$/ { emit(); next }
        /^#+[[:space:]]/ { emit(); next }
        { if (paragraph != "") paragraph = paragraph " "; paragraph = paragraph $0 }
        END { emit() }
    ' "$input" || status=1
done
exit "$status"
