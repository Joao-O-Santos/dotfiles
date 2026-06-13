#!/usr/bin/env bash
# Test suite for tso.sh
# Usage: ./test_tso.sh

SCRIPTS_DIR="$HOME/.config/scripts"
TESTS_PASSED=0
TESTS_FAILED=0

pass() {
    echo "✓ $1"
    ((++TESTS_PASSED))
}

fail() {
    echo "✗ $1"
    ((++TESTS_FAILED))
}

# Test: Script exists and is executable
if [[ -x "$SCRIPTS_DIR/tso.sh" ]]; then
    pass "tso.sh exists and is executable"
else
    fail "tso.sh missing or not executable"
fi

# Test: Shows usage when called without args
if "$SCRIPTS_DIR/tso.sh" 2>&1 | grep -q "Usage:"; then
    pass "tso.sh shows usage when called without args"
else
    fail "tso.sh doesn't show usage when called without args"
fi

# Test: Handles non-existent files
if "$SCRIPTS_DIR/tso.sh" "/nonexistent/file.md" 2>&1 | grep -q "Error:"; then
    pass "tso.sh handles non-existent files"
else
    fail "tso.sh doesn't validate file existence"
fi

# Test: Shows outline header
test_file="/tmp/test_tso_$$"
cat > "$test_file.md" << 'EOF'
# Heading 1

This is paragraph 1.

## Heading 2

This is paragraph 2.
EOF

if "$SCRIPTS_DIR/tso.sh" "$test_file.md" | grep -q "Topic Sentence Outline"; then
    pass "tso.sh shows outline header"
else
    fail "tso.sh doesn't show outline"
fi

rm -f "$test_file.md"

echo ""
echo "tso.sh tests: $TESTS_PASSED passed, $TESTS_FAILED failed"
exit $TESTS_FAILED
