#!/usr/bin/env python3
# Read-only search of the curated ~/lit database (CC0-1.0).
import argparse
import sqlite3
import sys
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description="Search ~/lit/_index.db (read-only)")
    parser.add_argument('--dir', metavar='DIR', help='list up to 50 papers in a directory')
    parser.add_argument('--count', action='store_true', help='count papers by directory')
    parser.add_argument('--recent', type=int, metavar='N', help='list N most recently indexed papers')
    parser.add_argument('--year', nargs='+', metavar='VALUE', help='DIR YEAR or START END (optionally with --dir)')
    parser.add_argument('--doi', metavar='TEXT', help='find DOI or canonical URL substring')
    parser.add_argument('--file', metavar='TEXT', help='find filename or filepath substring')
    parser.add_argument('query', nargs='*', help='FTS5 expression, e.g. prejudice AND stereotype')
    args = parser.parse_args()
    selected = sum(x is not None for x in (args.dir, args.recent, args.year, args.doi, args.file)) + args.count
    if (selected > 1 and not (selected == 2 and args.dir is not None and args.year is not None)) or (selected and args.query):
        parser.error('choose one search mode (except --dir with --year)')
    if not selected and not args.query:
        parser.print_help()
        return 0
    if args.recent is not None and args.recent < 1:
        parser.error('--recent requires a positive integer')
    columns = 'filepath, year, item_type, creators_json, title'
    params = ()
    if args.year is not None:
        values = args.year
        if len(values) != 2:
            parser.error('--year requires DIR YEAR or START END')
        if args.dir is not None:
            directory, years = args.dir, values
        elif values[0].isdigit() and values[1].isdigit():
            directory, years = None, values
        else:
            directory, years = values[0], [values[1], values[1]]
        if not all(y.isdigit() and len(y) == 4 for y in years) or int(years[0]) > int(years[1]):
            parser.error('years must be four-digit integers in ascending order')
        sql = f'SELECT {columns} FROM papers WHERE year BETWEEN ? AND ?'
        params = (int(years[0]), int(years[1]))
        if directory is not None:
            sql += ' AND directory = ?'
            params += (directory,)
        sql += ' ORDER BY year DESC, filepath'
    elif args.dir is not None:
        sql = f'SELECT {columns} FROM papers WHERE directory = ? ORDER BY year DESC, filepath LIMIT 50'
        params = (args.dir,)
    elif args.count:
        sql = 'SELECT directory, COUNT(*) AS n FROM papers GROUP BY directory ORDER BY n DESC, directory'
    elif args.recent is not None:
        sql = f'SELECT {columns} FROM papers ORDER BY indexed_at DESC, filepath LIMIT ?'
        params = (args.recent,)
    elif args.doi is not None:
        sql = f'SELECT {columns}, doi FROM papers WHERE instr(lower(doi), lower(?)) > 0 ORDER BY filepath'
        params = (args.doi,)
    elif args.file is not None:
        sql = 'SELECT * FROM papers WHERE instr(lower(filename), lower(?)) > 0 OR instr(lower(filepath), lower(?)) > 0 ORDER BY filepath'
        params = (args.file, args.file)
    else:
        sql = f'SELECT {", ".join("p." + c for c in columns.split(", "))} FROM papers_fts JOIN papers AS p ON p.rowid = papers_fts.rowid WHERE papers_fts MATCH ? ORDER BY papers_fts.rank LIMIT 20'
        params = (' '.join(args.query),)
    try:
        db = Path.home() / 'lit' / '_index.db'
        with sqlite3.connect(db.as_uri() + '?mode=ro', uri=True) as conn:
            conn.execute('PRAGMA query_only = ON')
            cursor = conn.execute(sql, params)
            print('\t'.join(col[0] for col in cursor.description))
            for row in cursor:
                print('\t'.join('' if value is None else str(value).replace('\t', ' ').replace('\n', ' ') for value in row))
    except (sqlite3.Error, OSError) as exc:
        print(f'litsearch: {exc}', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
