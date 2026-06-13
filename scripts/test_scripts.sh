#!/usr/bin/env bash
# Test suite for refactored shell scripts
# Usage: ./test_scripts.sh

set -e

SCRIPTS_DIR="$HOME/.config/scripts"
TESTS_PASSED=0
TESTS_FAILED=0

# Test helper functions
pass() {
    echo "✓ $1"
    ((++TESTS_PASSED))
}

fail() {
    echo "✗ $1"
    ((++TESTS_FAILED))
}

# Test 1: All scripts exist and are executable
test_scripts_exist() {
    local scripts=("f.sh" "xst.sh" "o.sh" "pull_all.sh" "toc.sh" "tso.sh" "tmd.sh" "tpres.sh" "chkdrft.sh" "twrd.sh")
    
    for script in "${scripts[@]}"; do
        if [[ -x "$SCRIPTS_DIR/$script" ]]; then
            pass "$script exists and is executable"
        else
            fail "$script missing or not executable"
        fi
    done
}

# Test 2: Scripts handle missing arguments
test_missing_args() {
    local scripts_with_args=("f.sh" "xst.sh" "o.sh" "toc.sh" "tso.sh" "tmd.sh" "tpres.sh" "chkdrft.sh" "twrd.sh")
    
    for script in "${scripts_with_args[@]}"; do
        if "$SCRIPTS_DIR/$script" 2>&1 | grep -q "Usage:"; then
            pass "$script shows usage when called without args"
        else
            fail "$script doesn't show usage when called without args"
        fi
    done
}

# Test 3: Scripts validate input
test_input_validation() {
    # xst.sh should reject non-numeric input
    if "$SCRIPTS_DIR/xst.sh" "abc" 2>&1 | grep -q "Error:"; then
        pass "xst.sh rejects non-numeric input"
    else
        fail "xst.sh doesn't validate numeric input"
    fi
    
    # toc.sh should handle non-existent files
    if "$SCRIPTS_DIR/toc.sh" "/nonexistent/file.md" 2>&1 | grep -q "Error:"; then
        pass "toc.sh handles non-existent files"
    else
        fail "toc.sh doesn't validate file existence"
    fi
    
    # tso.sh should handle non-existent files
    if "$SCRIPTS_DIR/tso.sh" "/nonexistent/file.md" 2>&1 | grep -q "Error:"; then
        pass "tso.sh handles non-existent files"
    else
        fail "tso.sh doesn't validate file existence"
    fi
}

# Test 4: Basic functionality with test files
test_basic_functionality() {
    local test_file="/tmp/test_script_$$"
    
    # Create test markdown file
    cat > "$test_file.md" << 'EOF'
# Heading 1

This is paragraph 1.

## Heading 2

This is paragraph 2.

<!-- TODO: fix this -->
<!-- CN: citation needed -->
EOF
    
    # Test toc.sh
    if "$SCRIPTS_DIR/toc.sh" "$test_file.md" | grep -q "Heading 1"; then
        pass "toc.sh extracts headings"
    else
        fail "toc.sh doesn't extract headings"
    fi
    
    # Test tso.sh
    if "$SCRIPTS_DIR/tso.sh" "$test_file.md" | grep -q "Topic Sentence Outline"; then
        pass "tso.sh shows outline header"
    else
        fail "tso.sh doesn't show outline"
    fi
    
    # Test chkdrft.sh
    if "$SCRIPTS_DIR/chkdrft.sh" "$test_file.md" | grep -q "citations needed"; then
        pass "chkdrft.sh counts citations needed"
    else
        fail "chkdrft.sh doesn't count citations"
    fi
    
    # Cleanup
    rm -f "$test_file.md"
}

# Test 5: Shellrc integration
test_shellrc_integration() {
    if grep -q 'scripts:\$PATH' "$HOME/.config/opencode/skills/automation-cli/shellrc"; then
        pass "shellrc adds scripts to PATH"
    else
        fail "shellrc doesn't add scripts to PATH"
    fi
    
    if grep -q "alias f='f.sh'" "$HOME/.config/opencode/skills/automation-cli/shellrc"; then
        pass "shellrc defines alias wrappers"
    else
        fail "shellrc doesn't define alias wrappers"
    fi
}

# Run all tests
echo "Running shell script tests..."
echo "=============================="
test_scripts_exist
test_missing_args
test_input_validation
test_basic_functionality
test_shellrc_integration

echo ""
echo "=============================="
echo "Tests passed: $TESTS_PASSED"
echo "Tests failed: $TESTS_FAILED"

if [[ $TESTS_FAILED -gt 0 ]]; then
    exit 1
fi
