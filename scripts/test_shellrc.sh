#!/usr/bin/env bash
# Focused tests for optional shellrc configuration.

set -u
scripts_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_dir="$(cd -- "$scripts_dir/.." && pwd)"
shellrc="$config_dir/shellrc"
tmp_home="$(mktemp -d)"
trap 'rm -rf "$tmp_home"' EXIT

tests_passed=0
tests_failed=0
pass() { echo "✓ $1"; ((++tests_passed)); }
fail() { echo "✗ $1"; ((++tests_failed)); }

mkdir -p "$tmp_home/.config/opencode"
cp "$config_dir/opencode/set_models.sh" "$tmp_home/.config/opencode/set_models.sh"

if output=$(HOME="$tmp_home" bash --noprofile --norc -c 'source "$1"' _ "$shellrc" 2>&1); then
    if [[ -z "$output" ]]; then
        pass "shellrc starts silently without optional files"
    else
        fail "shellrc emits output without optional files"
    fi
else
    fail "shellrc starts successfully without optional files"
fi

mkdir -p "$tmp_home/bin"
cat > "$tmp_home/bin/tty" <<'EOF'
#!/usr/bin/env bash
printf 'tty was called\n' >> "${TEST_GPG_LOG:?}"
EOF
cat > "$tmp_home/bin/gpg-connect-agent" <<'EOF'
#!/usr/bin/env bash
printf 'gpg-connect-agent was called\n' >> "${TEST_GPG_LOG:?}"
EOF
chmod +x "$tmp_home/bin/tty" "$tmp_home/bin/gpg-connect-agent"
gpg_log="$tmp_home/gpg-setup.log"
if output=$(HOME="$tmp_home" PATH="$tmp_home/bin:$PATH" TEST_GPG_LOG="$gpg_log" \
    bash --noprofile --norc -c 'source "$1"; [[ $LESSHISTFILE == /dev/null ]]' _ "$shellrc" 2>&1); then
    if [[ -z "$output" && ! -e "$gpg_log" && ! -e "$tmp_home/.lesshst" ]]; then
        pass "noninteractive shell skips TTY/GPG setup and LESS history"
    else
        fail "noninteractive shell skips TTY/GPG setup and LESS history"
    fi
else
    fail "noninteractive shell skips TTY/GPG setup and LESS history"
fi

cat > "$tmp_home/.config/opencode/mcp_keys.env" <<'EOF'
export TEST_MCP_KEYS_SOURCED=1
EOF
cat > "$tmp_home/.config/dir_aliases.sh" <<'EOF'
export TEST_DIR_ALIASES_SOURCED=1
EOF

if sourced=$(HOME="$tmp_home" bash --noprofile --norc -c '
    source "$1"
    [[ ${TEST_MCP_KEYS_SOURCED:-} == 1 && ${TEST_DIR_ALIASES_SOURCED:-} == 1 ]]
    printf sourced
' _ "$shellrc" 2>/dev/null); then
    [[ "$sourced" == sourced ]] && pass "shellrc sources present optional files" || fail "shellrc sources present optional files"
else
    fail "shellrc sources present optional files"
fi

mkdir -p "$tmp_home/.config/scripts"
cat > "$tmp_home/.config/scripts/convert.sh" <<'EOF'
#!/usr/bin/env bash
printf '%s\n' "$@" > "${TEST_TWRD_LOG:?}"
exit 17
EOF
chmod +x "$tmp_home/.config/scripts/convert.sh"
twrd_log="$tmp_home/twrd-args"
if output=$(HOME="$tmp_home" TEST_TWRD_LOG="$twrd_log" bash --noprofile --norc -c '
    source "$1"
    twrd "file with spaces.md" "extra argument"
' _ "$shellrc" 2>&1); then
    fail "twrd returns converter status"
else
    status=$?
    if [[ $status -eq 17 && -z "$output" && $(<"$twrd_log") == $'docx\nfile with spaces.md\nextra argument' ]]; then
        pass "twrd delegates arguments to canonical converter"
    else
        fail "twrd delegates arguments to canonical converter"
    fi
fi

echo "shellrc tests: $tests_passed passed, $tests_failed failed"
exit "$tests_failed"
