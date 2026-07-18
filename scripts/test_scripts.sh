#!/usr/bin/env bash
# Test runner for all shell scripts
# Usage: ./test_scripts.sh

SCRIPTS_DIR="$HOME/.config/scripts"
TOTAL_PASSED=0
TOTAL_FAILED=0

echo "Running shell script tests..."

# Run each test file
shopt -s nullglob
for test_file in "$SCRIPTS_DIR"/test_*.sh; do
    # Skip this file itself
    if [[ "$test_file" == "$SCRIPTS_DIR/test_scripts.sh" ]]; then
        continue
    fi
    
    echo "Running $(basename "$test_file")"
    if "$test_file"; then
        ((++TOTAL_PASSED))
    else
        ((++TOTAL_FAILED))
    fi
done

echo "Shell script tests: $TOTAL_PASSED passed, $TOTAL_FAILED failed"
(( TOTAL_FAILED == 0 ))
