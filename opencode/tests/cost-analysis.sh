#!/usr/bin/env bash
# Export ALL sessions and aggregate costs
set -uo pipefail

echo "=== Full Cost Analysis ==="
echo ""

# Get all sessions
SESSIONS=$(opencode session list --json 2>/dev/null)

if [[ -z "$SESSIONS" ]]; then
    echo "No sessions found"
    exit 1
fi

python3 << 'PYEOF'
import json, sys

sessions = json.load(sys.stdin)

total_cost = 0
total_input = 0
total_output = 0

print(f"{'Agent':<25} {'Model':<30} {'Cost':>10} {'Input':>12} {'Output':>12}")
print("-" * 95)

for s in sessions:
    agent = s.get("agent", "unknown")
    model = s.get("model", "unknown")
    cost = s.get("cost", 0)
    tokens = s.get("tokens", {})
    inp = tokens.get("input", 0)
    out = tokens.get("output", 0)
    
    total_cost += cost
    total_input += inp
    total_output += out
    
    print(f"{agent:<25} {model:<30} ${cost:>9.4f} {inp:>12,} {out:>12,}")

print("-" * 95)
print(f"{'TOTAL':<25} {'':<30} ${total_cost:>9.4f} {total_input:>12,} {total_output:>12,}")
print()
print(f"Sessions: {len(sessions)}")
print(f"Total cost: ${total_cost:.4f}")
PYEOF
