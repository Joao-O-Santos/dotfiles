#!/bin/sh
# Functional regression tests for the standalone utilities.
set -eu
scripts=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT HUP INT TERM
fail() { echo "FAIL: $*" >&2; exit 1; }

for script in chkdrft toc tso; do
    if "$scripts/$script.sh" >"$tmp/out" 2>&1; then fail "$script accepted no arguments"; fi
    if "$scripts/$script.sh" "$tmp/missing" >"$tmp/out" 2>&1; then fail "$script accepted missing file"; fi
    printf 'ordinary text\n' > "$tmp/valid file"
    if "$scripts/$script.sh" "$tmp/missing" "$tmp/valid file" >"$tmp/out" 2>&1; then fail "$script lost earlier error"; fi
    grep -Fq "$tmp/valid file" "$tmp/out" || fail "$script did not continue"
done

cat > "$tmp/draft" <<'EOF'
TODO: outside; ordinary prose mentions CN.
<!-- ordinary comment --> TODO: outside too
<!-- TODO: cite -->
<!-- another comment --> <!-- TODO: fix -->
<!-- multiline
comment -->
EOF
"$scripts/chkdrft.sh" "$tmp/draft" > "$tmp/out"
grep -q '^1 citations needed/missing' "$tmp/out" || fail 'citation count'
grep -q '^4 TODOs left' "$tmp/out" || fail 'TODO count'
grep -q '^3 unaddressed comments' "$tmp/out" || fail 'comment count'
printf 'TODO: outside\n' > "$tmp/draft"
"$scripts/chkdrft.sh" "$tmp/draft" > "$tmp/out"
grep -q '^No unaddressed comments' "$tmp/out" || fail 'outside TODO reduces comments'

cat > "$tmp/doc" <<'EOF'
# First
Text with #not-a-heading. Second sentence.

## Second
Another paragraph
continued here. More text!
EOF
"$scripts/toc.sh" "$tmp/doc" > "$tmp/out"
grep -q ' First$' "$tmp/out" || fail 'first heading'
grep -q ' Second$' "$tmp/out" || fail 'second heading'
if grep -q 'not-a-heading' "$tmp/out"; then fail 'inline hash treated as heading'; fi
"$scripts/tso.sh" "$tmp/doc" > "$tmp/out"
grep -Fxq 'Text with #not-a-heading.' "$tmp/out" || fail 'first topic sentence'
grep -Fxq 'Another paragraph continued here.' "$tmp/out" || fail 'wrapped topic sentence'
if grep -q 'More text' "$tmp/out"; then fail 'extra sentence included'; fi

mkdir "$tmp/search"
touch "$tmp/search/alpha file.txt" "$tmp/search/beta.txt"
if "$scripts/f.sh" > "$tmp/out" 2>&1; then fail 'f accepted no arguments'; fi
if "$scripts/f.sh" a b > "$tmp/out" 2>&1; then fail 'f accepted extra arguments'; fi
(cd "$tmp/search" && "$scripts/f.sh" 'alpha file') > "$tmp/out"
grep -Fxq 'alpha file.txt' "$tmp/out" || fail 'f pattern with spaces'
if (cd "$tmp/search" && "$scripts/f.sh" absent) > "$tmp/out"; then fail 'f no-match status'; fi
echo 'Script functional regressions passed'
