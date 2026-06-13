#!/usr/bin/env bash
# Test suite for toc.sh
# Usage: ./test_toc.sh

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
if [[ -x "$SCRIPTS_DIR/toc.sh" ]]; then
    pass "toc.sh exists and is executable"
else
    fail "toc.sh missing or not executable"
fi

# Test: Shows usage when called without args
if "$SCRIPTS_DIR/toc.sh" 2>&1 | grep -q "Usage:"; then
    pass "toc.sh shows usage when called without args"
else
    fail "toc.sh doesn't show usage when called without args"
fi

# Test: Handles non-existent files
if "$SCRIPTS_DIR/toc.sh" "/nonexistent/file.md" 2>&1 | grep -q "Error:"; then
    pass "toc.sh handles non-existent files"
else
    fail "toc.sh doesn't validate file existence"
fi

# Test: Extracts headings correctly
test_file="/tmp/test_toc_$$"
cat > "$test_file.md" << 'EOF'
# Heading 1

This is paragraph 1.

## Heading 2

This is paragraph 2.
EOF

if "$SCRIPTS_DIR/toc.sh" "$test_file.md" | grep -q "Heading 1"; then
    pass "toc.sh extracts headings"
else
    fail "toc.sh doesn't extract headings"
fi

rm -f "$test_file.md"

echo ""
echo "toc.sh tests: $TESTS_PASSED passed, $TESTS_FAILED failed"
exit $TESTS_FAILED
