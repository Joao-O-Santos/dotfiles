#!/usr/bin/env bash
# Evaluate a test result using LLM-as-judge
set -uo pipefail

TEST_DIR="$(cd "$(dirname "$0")" && pwd)"
CASE="${1:?Usage: evaluate.sh <test-case-name> [timestamp]}"
TIMESTAMP="${2:-$(ls -t "$TEST_DIR/results/$CASE/" | head -1)}"
RESULT_DIR="$TEST_DIR/results/$CASE/$TIMESTAMP"

if [[ ! -d "$RESULT_DIR" ]]; then
    echo "Error: result directory not found: $RESULT_DIR"
    exit 1
fi

SESSION_FILE="$RESULT_DIR/session.json"
CRITERIA_FILE="$RESULT_DIR/criteria.md"

if [[ ! -f "$SESSION_FILE" ]]; then
    echo "Error: session.json not found"
    exit 1
fi

echo "=== Evaluating test: $CASE ==="
echo "Session: $SESSION_FILE"

# Extract key information from session JSON
python3 << PYEOF
import json, sys

with open("$SESSION_FILE") as f:
    data = json.load(f)

info = data.get("info", {})
messages = data.get("messages", [])

print(f"Session: {info.get('id', 'unknown')}")
print(f"Model: {info.get('model', 'unknown')}")
print(f"Tokens: {info.get('tokens', {})}")
print(f"Cost: {info.get('cost', 0)}")
print(f"Messages: {len(messages)}")

# Extract agent messages
agent_messages = [m for m in messages if m.get("role") == "assistant"]
print(f"Assistant messages: {len(agent_messages)}")

# Extract tool calls
tool_calls = []
for m in messages:
    if "tool_calls" in m:
        tool_calls.extend(m["tool_calls"])
print(f"Tool calls: {len(tool_calls)}")

# List tool names used
tool_names = set()
for tc in tool_calls:
    if "function" in tc:
        tool_names.add(tc["function"].get("name", "unknown"))
print(f"Tools used: {', '.join(sorted(tool_names))}")
PYEOF

echo ""
echo "To evaluate with LLM-as-judge, run:"
echo "  opencode run 'Evaluate this session against the criteria in $CRITERIA_FILE. Session data: [paste from $SESSION_FILE]'"
