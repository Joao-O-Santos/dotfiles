#!/bin/sh
# Check draft for TODOs, comments, and citations needed
# Usage: chkdrft <file1> [file2] ...

if [ "$#" -eq 0 ]; then
    echo "Usage: chkdrft <file1> [file2] ..." >&2
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
    awk -v name="$file" '
        /<!-- TODO: cite -->/ { cns++ }
        /TODO:/ { todos++ }
        {
            text = $0
            while (length(text)) {
                if (!in_comment) {
                    start = index(text, "<!--")
                    if (!start) break
                    text = substr(text, start + 4)
                    in_comment = 1
                    comment = ""
                }
                end = index(text, "-->")
                if (!end) {
                    comment = comment text "\n"
                    break
                }
                comment = comment substr(text, 1, end - 1)
                if (comment !~ /TODO:/) comments++
                in_comment = 0
                text = substr(text, end + 3)
            }
        }
        END {
            if (in_comment && comment !~ /TODO:/) comments++
            if (cns) printf "%d citations needed/missing in %s\n", cns, name
            else printf "No citations needed in %s\n", name
            if (todos) printf "%d TODOs left in %s\n", todos, name
            else printf "No TODOs left in %s\n", name
            if (comments) printf "%d unaddressed comments (excluding TODOs) in %s\n", comments, name
            else printf "No unaddressed comments in %s\n", name
        }
    ' "$input" || status=1
done
exit "$status"
