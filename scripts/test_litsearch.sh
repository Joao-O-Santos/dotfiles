#!/usr/bin/env bash
# Regression tests use only a temporary synthetic library.
set -euo pipefail
script_dir=$(cd -- "$(dirname -- "$0")" && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
export HOME="$tmp"
mkdir "$HOME/lit"
python3 - <<'PY'
import sqlite3, os
c = sqlite3.connect(os.path.join(os.environ['HOME'], 'lit', '_index.db'))
c.executescript('''
CREATE TABLE papers (filepath TEXT, filename TEXT, directory TEXT, year INTEGER,
 item_type TEXT, creators_json TEXT, title TEXT, abstract TEXT, topic_tags TEXT, doi TEXT, indexed_at TEXT);
CREATE VIRTUAL TABLE papers_fts USING fts5(title, abstract, topic_tags, doi, content='papers', content_rowid='rowid');
INSERT INTO papers VALUES ('discrim/a.pdf','a.pdf','discrim',2019,'article-journal','{"author":[]}', 'Prejudice study','test','social','10.1234/abc','2024');
INSERT INTO papers VALUES ('other/b.pdf','b.pdf','other',2021,'book',NULL,'Other title',NULL,NULL,'https://example.test','2023');
INSERT INTO papers_fts(papers_fts) VALUES('rebuild');
''')
c.commit()
PY
search="$script_dir/litsearch.sh"
[[ $($search prejudice AND study) == *discrim/a.pdf* ]]
[[ $($search --dir discrim) == *discrim/a.pdf* ]]
[[ $($search --dir discrim --year 2018 2020) == *discrim/a.pdf* ]]
[[ $($search --year discrim 2019) == *discrim/a.pdf* ]]
[[ $($search --year 2020 2022) == *other/b.pdf* ]]
[[ $($search --doi 10.1234) == *discrim/a.pdf* ]]
[[ $($search --file b.pdf) == *other/b.pdf* ]]
[[ $($search --recent 1) == *discrim/a.pdf* ]]
[[ $($search --count) == *discrim* ]]
[[ $($search --dir "' OR 1=1 --") != *discrim/a.pdf* ]]
[[ $($search --doi '%') != *discrim/a.pdf* ]]
if $search --recent '1; DROP TABLE papers' >/dev/null 2>&1; then exit 1; fi
if $search '"bad' >/dev/null 2>&1; then exit 1; fi
[[ $($search --count) == *discrim* ]]
rm "$HOME/lit/_index.db"
if $search --count >/dev/null 2>&1; then exit 1; fi
[[ ! -e "$HOME/lit/_index.db" ]]
echo 'literature search tests passed'
