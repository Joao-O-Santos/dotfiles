#!/usr/bin/env bash
# Search the ~/lit literature library database
# Usage:
#   litsearch <query>                    # FTS5 full-text search
#   litsearch --dir <name>               # list papers in directory
#   litsearch --count                    # paper counts per directory
#   litsearch --recent <N>               # N most recent papers
#   litsearch --year <dir> <year>        # papers in dir from year
#   litsearch --doi <doi>                # find paper by DOI
#   litsearch --file <filename>           # get full metadata for a file
#   litsearch --help                     # show this help

DB="$HOME/lit/_index.db"

usage() {
    sed -n '2,11p' "$0"
    exit "${1:-0}"
}

if [[ $# -eq 0 || "$1" == "--help" || "$1" == "-h" ]]; then
    usage 0
fi

case "$1" in
    --dir)
        [[ $# -ge 2 ]] || { echo "Usage: litsearch --dir <name>" >&2; exit 1; }
        sqlite3 "$DB" "SELECT filepath, year, first_author, substr(title,1,60) FROM papers WHERE directory='$2' ORDER BY year DESC LIMIT 50" -header -column
        ;;
    --count)
        sqlite3 "$DB" "SELECT directory, COUNT(*) AS n FROM papers GROUP BY directory ORDER BY 2 DESC" -header -column
        ;;
    --recent)
        [[ $# -ge 2 ]] || { echo "Usage: litsearch --recent <N>" >&2; exit 1; }
        N="${2:-10}"
        sqlite3 "$DB" "SELECT directory, filename, year, first_author FROM papers ORDER BY indexed_at DESC LIMIT $N" -header -column
        ;;
    --year)
        [[ $# -ge 3 ]] || { echo "Usage: litsearch --year <dir> <year>" >&2; exit 1; }
        sqlite3 "$DB" "SELECT filename, year, first_author, title FROM papers WHERE directory='$2' AND year=$3 ORDER BY year DESC" -header -column
        ;;
    --doi)
        [[ $# -ge 2 ]] || { echo "Usage: litsearch --doi <doi-or-part>" >&2; exit 1; }
        sqlite3 "$DB" "SELECT filepath, doi, year, first_author, title FROM papers WHERE doi LIKE '%$2%'"
        ;;
    --file)
        [[ $# -ge 2 ]] || { echo "Usage: litsearch --file <filename>" >&2; exit 1; }
        sqlite3 "$DB" "SELECT filepath, doi, year, first_author, title FROM papers WHERE filename LIKE '%$2%' OR filepath LIKE '%$2%'"
        ;;
    *)
        # Default: FTS5 full-text search
        query="$*"
        sqlite3 "$DB" "SELECT filepath, year, first_author, substr(title,1,60) FROM papers_fts WHERE papers_fts MATCH '$query' ORDER BY rank LIMIT 20" -header -column
        ;;
esac
