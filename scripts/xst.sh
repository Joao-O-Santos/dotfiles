#!/usr/bin/env bash
# Open multiple st terminals
# Usage: xst <count>

if [[ $# -eq 0 ]]; then
    echo "Usage: xst <count>" >&2
    exit 1
fi

if ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "Error: count must be a positive integer" >&2
    exit 1
fi

for i in $(seq 1 "$1"); do
    (setsid st -f hermit:size=13.9 > /dev/null &) > /dev/null 2>&1
done
