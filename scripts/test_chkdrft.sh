#!/usr/bin/env bash
# Test suite for chkdrft.sh
# Usage: ./test_chkdrft.sh

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
if [[ -x "$SCRIPTS_DIR/chkdrft.sh" ]]; then
    pass "chkdrft.sh exists and is executable"
else
    fail "chkdrft.sh missing or not executable"
fi

# Test: Shows usage when called without args
if "$SCRIPTS_DIR/chkdrft.sh" 2>&1 | grep -q "Usage:"; then
    pass "chkdrft.sh shows usage when called without args"
else
    fail "chkdrft.sh doesn't show usage when called without args"
fi

# Test: Counts citations, TODOs, and comments
test_file="/tmp/test_chkdrft_$$"
cat > "$test_file.md" << 'EOF'
# Test Document

This has a citation needed: CN

And a TODO: fix this

<!-- This is a comment -->
EOF

if "$SCRIPTS_DIR/chkdrft.sh" "$test_file.md" | grep -q "citations needed"; then
    pass "chkdrft.sh counts citations needed"
else
    fail "chkdrft.sh doesn't count citations"
fi

if "$SCRIPTS_DIR/chkdrft.sh" "$test_file.md" | grep -q "TODOs left"; then
    pass "chkdrft.sh counts TODOs"
else
    fail "chkdrft.sh doesn't count TODOs"
fi

if "$SCRIPTS_DIR/chkdrft.sh" "$test_file.md" | grep -q "unaddressed comments"; then
    pass "chkdrft.sh counts comments"
else
    fail "chkdrft.sh doesn't count comments"
fi

# Test: Shows "No <x>" when clean
cat > "$test_file.md" << 'EOF'
# Clean Document

This document has no issues.
EOF

if "$SCRIPTS_DIR/chkdrft.sh" "$test_file.md" | grep -q "No citations needed"; then
    pass "chkdrft.sh shows 'No citations needed' when clean"
else
    fail "chkdrft.sh doesn't show clean citations message"
fi

if "$SCRIPTS_DIR/chkdrft.sh" "$test_file.md" | grep -q "No TODOs left"; then
    pass "chkdrft.sh shows 'No TODOs left' when clean"
else
    fail "chkdrft.sh doesn't show clean TODOs message"
fi

if "$SCRIPTS_DIR/chkdrft.sh" "$test_file.md" | grep -q "No unaddressed comments"; then
    pass "chkdrft.sh shows 'No unaddressed comments' when clean"
else
    fail "chkdrft.sh doesn't show clean comments message"
fi

rm -f "$test_file.md"

echo ""
echo "chkdrft.sh tests: $TESTS_PASSED passed, $TESTS_FAILED failed"
exit $TESTS_FAILED
