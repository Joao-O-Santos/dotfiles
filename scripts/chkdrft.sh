#!/usr/bin/env bash
# Check draft for TODOs, comments, and citations needed
# Usage: chkdrft <file1> [file2] ...

if [[ $# -eq 0 ]]; then
    echo "Usage: chkdrft <file1> [file2] ..." >&2
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

    awk -F " " '
        /<!-- TODO: cite -->/ { cns++ }
        /<!--/ { cmnts++ }
        /TODO:/ { todos++ }
        END {
            cns = cns + 0
            todos = todos + 0
            cmnts = cmnts + 0
            comments = cmnts - todos
            
            if (cns == 0) {
                printf "No citations needed in %s\n", FILENAME
            } else {
                printf "%d citations needed/missing in %s\n", cns, FILENAME
            }
            
            if (todos == 0) {
                printf "No TODOs left in %s\n", FILENAME
            } else {
                printf "%d TODOs left in %s\n", todos, FILENAME
            }
            
            if (comments == 0) {
                printf "No unaddressed comments in %s\n", FILENAME
            } else {
                printf "%d unaddressed comments (excluding TODOs) in %s\n", comments, FILENAME
            }
        }
    ' "$file"
done
