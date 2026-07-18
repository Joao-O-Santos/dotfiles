#!/usr/bin/env bash
# Focused tests for convert.sh

set -u
scripts_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
tests_passed=0
tests_failed=0

pass() { echo "✓ $1"; ((++tests_passed)); }
fail() { echo "✗ $1"; ((++tests_failed)); }

run_test() {
    local name=$1 expected=$2
    shift 2
    if "$@" >/dev/null 2>&1; then status=0; else status=$?; fi
    if [[ $status -eq $expected ]]; then pass "$name"; else fail "$name"; fi
}

input="$tmp_dir/input.txt"
printf '# Test\n' > "$input"

run_test "rejects extra arguments" 1 "$scripts_dir/convert.sh" md "$input" extra
printf '# Test\n' > "$tmp_dir/input.md"
run_test "rejects Markdown self-overwrite" 1 "$scripts_dir/convert.sh" md "$tmp_dir/input.md"
run_test "rejects existing output" 1 bash -c 'printf x > "$1"; touch "${1%.*}.md"; "$2" md "$1"' _ "$tmp_dir/existing.txt" "$scripts_dir/convert.sh"

fake_bin="$tmp_dir/bin"
mkdir "$fake_bin"
ln -s /bin/bash "$fake_bin/bash"
ln -s /usr/bin/dirname "$fake_bin/dirname"
cat > "$fake_bin/pandoc" <<'EOF'
#!/usr/bin/env bash
out=""
for ((i=1; i<=$#; i++)); do
    if [[ ${!i} == -o || ${!i} == -so ]]; then ((i++)); out=${!i}; fi
done
touch "$out"
EOF
chmod +x "$fake_bin/pandoc"
no_pandoc_bin="$tmp_dir/no-pandoc-bin"
mkdir "$no_pandoc_bin"
ln -s /bin/bash "$no_pandoc_bin/bash"
ln -s /usr/bin/dirname "$no_pandoc_bin/dirname"
printf '# Fresh test\n' > "$tmp_dir/fresh.txt"
run_test "converts Markdown" 0 env PATH="$fake_bin:$PATH" "$scripts_dir/convert.sh" md "$tmp_dir/fresh.txt"
printf '# DOCX test\n' > "$tmp_dir/doc.txt"
run_test "rejects missing APA filter" 1 env PATH="$fake_bin:$PATH" XDG_CONFIG_HOME="$tmp_dir/config" "$scripts_dir/convert.sh" docx "$tmp_dir/doc.txt"
filter_dir="$tmp_dir/config/pandoc/filters"
mkdir -p "$filter_dir"
touch "$filter_dir/apa-tables.lua"
run_test "invokes sibling chkdrft for DOCX" 0 env PATH="$fake_bin:$PATH" XDG_CONFIG_HOME="$tmp_dir/config" "$scripts_dir/convert.sh" docx "$tmp_dir/doc.txt"
printf '# Missing Pandoc test\n' > "$tmp_dir/no-pandoc.txt"
run_test "rejects missing Pandoc" 1 env PATH="$no_pandoc_bin" "$scripts_dir/convert.sh" md "$tmp_dir/no-pandoc.txt"

echo "convert.sh tests: $tests_passed passed, $tests_failed failed"
exit "$tests_failed"
