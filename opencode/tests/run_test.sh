#!/usr/bin/env bash
# Run a single test case and export the session
set -uo pipefail

TEST_DIR="$(cd "$(dirname "$0")" && pwd)"
CASE="${1:?Usage: run_test.sh <test-case-name>}"
CASE_DIR="$TEST_DIR/test_cases/$CASE"

if [[ ! -d "$CASE_DIR" ]]; then
    echo "Error: test case '$CASE' not found in $TEST_DIR/test_cases/"
    exit 1
fi

PROMPT_FILE="$CASE_DIR/prompt.md"
CRITERIA_FILE="$CASE_DIR/criteria.md"

if [[ ! -f "$PROMPT_FILE" ]]; then
    echo "Error: $PROMPT_FILE not found"
    exit 1
fi

PROMPT=$(cat "$PROMPT_FILE")
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="$TEST_DIR/results/$CASE/$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

echo "=== Running test: $CASE ==="
echo "Prompt: $(head -1 "$PROMPT_FILE")"
echo ""

# Run the test in headless auto mode
cd /home/random_user/.config
opencode run --auto "$PROMPT" 2>&1 | tee "$OUTPUT_DIR/run.log"
EXIT_CODE=${PIPESTATUS[0]}

# Get the session ID from the log (last session)
SESSION_ID=$(opencode session list --json 2>/dev/null | python3 -c "
import sys, json
sessions = json.load(sys.stdin)
if sessions:
    print(sessions[-1]['id'])
" 2>/dev/null)

if [[ -z "$SESSION_ID" ]]; then
    echo "Warning: could not extract session ID"
else
    echo "Session ID: $SESSION_ID"
    # Export the session
    opencode export "$SESSION_ID" > "$OUTPUT_DIR/session.json"
    echo "Session exported to $OUTPUT_DIR/session.json"
fi

# Copy criteria for evaluation
if [[ -f "$CRITERIA_FILE" ]]; then
    cp "$CRITERIA_FILE" "$OUTPUT_DIR/criteria.md"
fi

echo ""
echo "=== Test complete ==="
echo "Results in: $OUTPUT_DIR"
echo "Exit code: $EXIT_CODE"
