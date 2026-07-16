#!/usr/bin/env bash
# Estimate per-agent cost breakdown from session export
set -uo pipefail

SESSION_ID="${1:-latest}"

if [[ "$SESSION_ID" == "latest" ]]; then
    SESSION_ID=$(opencode session list 2>/dev/null | awk 'NR>2{print $1; exit}')
fi

if [[ -z "$SESSION_ID" ]]; then
    echo "Error: no session found"
    exit 1
fi

echo "=== Cost Breakdown ==="
echo "Session: $SESSION_ID"
echo ""

# Save export to temp file (pipe + heredoc both consume stdin)
TMPFILE=$(mktemp /tmp/opencode_export.XXXXXX.json)
trap 'rm -f "$TMPFILE"' EXIT

opencode export "$SESSION_ID" 2>/dev/null > "$TMPFILE"

if [[ ! -s "$TMPFILE" ]]; then
    echo "Error: export produced no output"
    exit 1
fi

python3 - "$TMPFILE" << 'PYEOF'
import json, sys
from collections import defaultdict

json_path = sys.argv[1]
with open(json_path) as f:
    data = json.load(f)

info = data.get("info", {})
messages = data.get("messages", [])

# Get session totals
total_cost = info.get("cost", 0)
total_tokens = info.get("tokens", {})
total_input = total_tokens.get("input", 0)
total_output = total_tokens.get("output", 0)

# Parse task invocations from parts[].type == "tool", tool == "task"
task_invocations = []
for msg in messages:
    for part in msg.get("parts", []):
        if part.get("type") == "tool" and part.get("tool") == "task":
            state = part.get("state", {})
            inp = state.get("input", {})
            meta = state.get("metadata", {})
            task_invocations.append({
                "call_id": part.get("callID", "unknown"),
                "description": inp.get("description", "unknown"),
                "subagent_type": inp.get("subagent_type", "unknown"),
                "prompt_length": len(inp.get("prompt", "")),
                "model": meta.get("model", {}).get("modelID", "unknown"),
                "status": state.get("status", "unknown"),
            })

# Count by subagent type
by_type = defaultdict(lambda: {"count": 0, "total_prompt_chars": 0})
for inv in task_invocations:
    t = inv["subagent_type"]
    by_type[t]["count"] += 1
    by_type[t]["total_prompt_chars"] += inv["prompt_length"]

# Approximate cost per 1K tokens (input + output combined)
cost_per_1k = {
    "planner": 0.005,          # deepseek-v4-pro: $1.74/$3.48 per 1M
    "writer": 0.00035,         # deepseek-v4-flash: $0.07/$0.28 per 1M
    "reviewer-structure": 0.00035,
    "reviewer-structure-2": 0.001,  # glm-5.2 (estimated)
    "reviewer-detail": 0.0005,      # mimo-v2.5: $0.10/$0.40 per 1M
    "copyeditor": 0.0005,
    "editor": 0.0005,
    "strategist": 0.0025,           # qwen3.7-max: $0.50/$2.00 per 1M
    "literature-reviewer": 0.0005,
    "deep-research": 0.00035,
    "automation": 0.0005,
    "r-coder": 0.00035,
}

# Print breakdown
print(f"Total session cost: ${total_cost:.4f}")
print(f"Total tokens: input={total_input:,} output={total_output:,}")
print(f"Total task invocations: {len(task_invocations)}")
print()

print(f"{'Agent Type':<25} {'Count':>8} {'Est. Cost':>12} {'% of Total':>12}")
print("-" * 60)

estimated_total = 0
for agent_type, stats in sorted(by_type.items(), key=lambda x: -x[1]["count"]):
    count = stats["count"]
    # Estimate ~2K tokens per invocation (conservative)
    est_tokens = count * 2000
    est_cost = est_tokens * cost_per_1k.get(agent_type, 0.001) / 1000
    estimated_total += est_cost
    pct = (est_cost / total_cost * 100) if total_cost > 0 else 0
    print(f"{agent_type:<25} {count:>8} ${est_cost:>10.4f} {pct:>10.1f}%")

print("-" * 60)
print(f"{'ESTIMATED SUBTOTAL':<25} {len(task_invocations):>8} ${estimated_total:>10.4f}")
print(f"{'SESSION TOTAL':<25} {'':>8} ${total_cost:>10.4f}")
print()

if estimated_total > 0:
    ratio = total_cost / estimated_total
    print(f"Note: Estimated cost is {ratio:.1f}x the actual total.")
    print("This suggests the per-invocation token estimate is off,")
    print("or there are costs not captured by task invocations.")
print()
print("Breakdown by agent type:")
for agent_type, stats in sorted(by_type.items(), key=lambda x: -x[1]["count"]):
    print(f"  {agent_type}: {stats['count']} invocations")

# Show per-invocation details
print()
print("Per-invocation details:")
for inv in task_invocations:
    desc = inv["description"][:50]
    print(f"  [{inv['subagent_type']}] {desc} (model: {inv['model']}, status: {inv['status']})")
PYEOF
