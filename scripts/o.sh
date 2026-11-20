#!/bin/sh
# Open files with xdg-open
# Usage: o <file1> [file2] ...

if [ "$#" -eq 0 ]; then
    echo "Usage: o <file1> [file2] ..." >&2
    exit 1
fi

status=0
for file do
    if [ ! -e "$file" ]; then
        echo "Warning: $file does not exist" >&2
        status=1
        continue
    fi
    case $file in -*) file=./$file ;; esac
    (setsid xdg-open "$file" >/dev/null 2>&1 &)
done
exit "$status"
