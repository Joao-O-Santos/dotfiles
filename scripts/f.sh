#!/bin/sh
# Find files by name pattern using ripgrep
# Usage: f <pattern>

if [ "$#" -ne 1 ] || [ -z "$1" ]; then
    echo "Usage: f <pattern>" >&2
    exit 1
fi

rg --files --glob "*$1*"
