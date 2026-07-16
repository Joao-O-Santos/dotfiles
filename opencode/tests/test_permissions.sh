#!/usr/bin/env bash
# Test agent permissions by checking opencode.json
set -uo pipefail

CONFIG="/home/random_user/.config/opencode/opencode.json"
PASS=0
FAIL=0

check() {
    local desc="$1" expected="$2" actual="$3"
    if [[ "$actual" == *"$expected"* ]]; then
        echo "  ✓ $desc"
        ((PASS++))
    else
        echo "  ✗ $desc (expected: $expected, got: $actual)"
        ((FAIL++))
    fi
}

echo "=== Permission Tests ==="

# Extract agent permissions using python
eval_agent() {
    python3 -c "
import json
with open('$CONFIG') as f:
    c = json.load(f)
a = c['agent'].get('$1', {}).get('permission', {})
edit = a.get('edit', 'inherit')
bash_val = a.get('bash', 'inherit')
task = a.get('task', 'inherit')
# bash may be a dict (rule-based) or a string; normalise to 'allow'/'deny'/'inherit'
if isinstance(bash_val, dict):
    bash_str = bash_val.get('*', 'inherit')
else:
    bash_str = bash_val
print(edit)
print(bash_str)
print(task)
"
}

# Test planner
echo "--- planner ---"
read -r edit bash task <<< "$(eval_agent planner | tr '\n' ' ')"
check "planner: no edit" "inherit" "$edit"
check "planner: no bash" "inherit" "$bash"
check "planner: has task" "allow" "$task"

# Test automation
echo "--- automation ---"
read -r edit bash task <<< "$(eval_agent automation | tr '\n' ' ')"
check "automation: has edit" "allow" "$edit"
check "automation: has bash" "allow" "$bash"

# Test writer
echo "--- writer ---"
read -r edit bash task <<< "$(eval_agent writer | tr '\n' ' ')"
check "writer: has edit" "allow" "$edit"
check "writer: no bash" "inherit" "$bash"

# Test reviewers
for reviewer in reviewer-structure reviewer-structure-2 reviewer-detail copyeditor editor; do
    echo "--- $reviewer ---"
    read -r edit bash task <<< "$(eval_agent $reviewer | tr '\n' ' ')"
    check "$reviewer: edit denied" "deny" "$edit"
    check "$reviewer: no bash" "inherit" "$bash"
done

# Test r-coder
echo "--- r-coder ---"
read -r edit bash task <<< "$(eval_agent r-coder | tr '\n' ' ')"
check "r-coder: has edit" "allow" "$edit"
check "r-coder: has bash" "allow" "$bash"

# Test strategist
echo "--- strategist ---"
read -r edit bash task <<< "$(eval_agent strategist | tr '\n' ' ')"
check "strategist: edit denied" "deny" "$edit"
check "strategist: no bash (inherits)" "inherit" "$bash"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
exit $FAIL
