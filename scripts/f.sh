#!/usr/bin/env bash
# Find files by name pattern
# Usage: f <pattern>

if [[ $# -eq 0 ]]; then
    echo "Usage: f <pattern>" >&2
    exit 1
fi

find ./ -name "*$*"
