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

echo "shellrc tests: $tests_passed passed, $tests_failed failed"
exit "$tests_failed"
