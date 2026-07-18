#!/usr/bin/env bash
# Validate opencode.json structure and references
set -uo pipefail

CONFIG="/home/random_user/.config/opencode/opencode.json"
PASS=0
FAIL=0

check() {
    local desc="$1"
    local cmd="$2"
    if bash -c "$cmd" >/dev/null 2>&1; then
        echo "  ✓ $desc"
        ((PASS++)) || true
    else
        echo "  ✗ $desc"
        ((FAIL++)) || true
    fi
}

echo "=== Config Validation Tests ==="

# JSON validity
check "opencode.json is valid JSON" "python3 -c 'import json,sys; json.load(open(sys.argv[1]))' \"$CONFIG\""

# Required fields
check "has \$schema"          "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert \"\$schema\" in c, \"missing \$schema\"' '$CONFIG'"
check "has default_agent"     "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert \"default_agent\" in c, \"missing default_agent\"' '$CONFIG'"
check "has agent block"       "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert \"agent\" in c, \"missing agent\"' '$CONFIG'"
check "has permission block"  "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert \"permission\" in c, \"missing permission\"' '$CONFIG'"
check "has mcp block"         "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert \"mcp\" in c, \"missing mcp\"' '$CONFIG'"
check "has plugin array"      "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert \"plugin\" in c, \"missing plugin\"' '$CONFIG'"

# Agent count
check "has 12 agents"         "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert len(c[\"agent\"]) == 12, \"expected 12 agents\"' '$CONFIG'"

# MCP servers enabled
check "context7 enabled"          "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert c[\"mcp\"][\"context7\"][\"enabled\"] == True, \"not enabled\"' '$CONFIG'"
check "citecheck enabled"         "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert c[\"mcp\"][\"citecheck\"][\"enabled\"] == True, \"not enabled\"' '$CONFIG'"
check "openalex enabled"          "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert c[\"mcp\"][\"openalex\"][\"enabled\"] == True, \"not enabled\"' '$CONFIG'"
check "semantic-scholar enabled"  "python3 -c 'import json,sys; c=json.load(open(sys.argv[1])); assert c[\"mcp\"][\"semantic-scholar\"][\"enabled\"] == True, \"not enabled\"' '$CONFIG'"

# References exist
check "style reference exists"            "test -f /home/random_user/.config/opencode/STYLE.md"
check "r-style reference exists"          "test -d /home/random_user/.config/opencode/skills/r-analysis-quarto"
check "writing-examples reference exists" "test -d /home/random_user/.config/opencode/writing-examples"

# Agent files exist
for agent in planner automation writer r-coder reviewer-structure reviewer-structure-2 reviewer-detail copyeditor editor strategist literature-reviewer deep-research; do
    check "agent file: $agent" "test -f /home/random_user/.config/opencode/agents/$agent.md"
done

# Every active reviewer routing reference must name an existing agent.
check "reviewer references resolve" "python3 - <<'PY'
import pathlib, re
root = pathlib.Path('/home/random_user/.config/opencode')
text = '\n'.join(
    p.read_text() for p in root.rglob('*.md')
    if p.name != 'CHANGELOG.md' and p.parent.name not in {'snippet', 'skills'}
)
names = set(re.findall(r'\x60(reviewer-[a-z0-9-]+)\x60', text))
missing = [name for name in names if not (root / 'agents' / f'{name}.md').is_file()]
assert not missing, f'missing reviewer agents: {missing}'
PY"

echo ""
echo "=== Results: $PASS passed, $FAIL failed ==="
exit $FAIL
