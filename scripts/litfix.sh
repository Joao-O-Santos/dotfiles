#!/usr/bin/env bash
# Manually fix metadata fields in the lit database
# Usage:
#   litfix --file <filename> --title "Correct Title"
#   litfix --file <filename> --year 2020
#   litfix --file <filename> --doi 10.1234/test
#   litfix --file <filename> --lock   # mark as manually corrected
#   litfix --file <filename> --unlock # allow re-indexing
set -euo pipefail

DB="$HOME/lit/_index.db"
FILE=""

usage() {
    sed -n '3,9p' "$0"
    exit "${1:-0}"
}

[[ $# -eq 0 || "$1" == "--help" || "$1" == "-h" ]] && usage 0

while [[ $# -gt 0 ]]; do
    case "$1" in
        --file) FILE="$2"; shift 2 ;;
        --title) sqlite3 "$DB" "UPDATE papers SET title='$2', locked=1 WHERE filename='$FILE' OR filepath LIKE '%/$FILE'" && echo "Set title=$2 on $FILE"; shift 2 ;;
        --year) sqlite3 "$DB" "UPDATE papers SET year=$2, locked=1 WHERE filename='$FILE' OR filepath LIKE '%/$FILE'" && echo "Set year=$2 on $FILE"; shift 2 ;;
        --doi) sqlite3 "$DB" "UPDATE papers SET doi='$2', locked=1 WHERE filename='$FILE' OR filepath LIKE '%/$FILE'" && echo "Set doi=$2 on $FILE"; shift 2 ;;
        --first-author) sqlite3 "$DB" "UPDATE papers SET first_author='$2', locked=1 WHERE filename='$FILE' OR filepath LIKE '%/$FILE'" && echo "Set first_author=$2 on $FILE"; shift 2 ;;
        --lock) sqlite3 "$DB" "UPDATE papers SET locked=1 WHERE filename='$FILE' OR filepath LIKE '%/$FILE'" && echo "Locked $FILE"; shift ;;
        --unlock) sqlite3 "$DB" "UPDATE papers SET locked=0 WHERE filename='$FILE' OR filepath LIKE '%/$FILE'" && echo "Unlocked $FILE"; shift ;;
        *) echo "Unknown option: $1" >&2; usage 1 ;;
    esac
done
