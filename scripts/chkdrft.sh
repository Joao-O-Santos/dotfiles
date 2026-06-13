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
        /CN/ { cns++ }
        /<!--/ { cmnts++ }
        /TODO:/ { todos++ }
        END {
            cns = cns + 0
            todos = todos + 0
            cmnts = cmnts + 0
            comments = cmnts - todos
            
            if (cns == 0 && todos == 0 && comments == 0) {
                printf "No comments, TODOs, or citations needed in %s\n", FILENAME
            } else {
                printf "%d citations needed/missing, %d TODOs, and %d unaddressed comments (excluding TODOs) still left in %s\n",
                    cns, todos, comments, FILENAME
            }
        }
    ' "$file"
done
