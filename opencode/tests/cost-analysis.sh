#!/usr/bin/env bash
# Export ALL sessions and aggregate costs
# Parses plain-text output from `opencode session list` (no --json flag)
set -uo pipefail

echo "=== Full Cost Analysis ==="
echo ""

# --- Step 1: Get session IDs from plain-text table ---
# The table has a header row, a separator line, then data rows.
# Session IDs are in column 1 of each data row.
SESSION_IDS=()
while IFS= read -r line; do
    sid=$(echo "$line" | awk '{print $1}')
    [[ -n "$sid" ]] && SESSION_IDS+=("$sid")
done < <(opencode session list 2>/dev/null | awk 'NR > 2 && NF > 0')

if [[ ${#SESSION_IDS[@]} -eq 0 ]]; then
    echo "No sessions found"
    exit 1
fi

echo "Found ${#SESSION_IDS[@]} session(s). Exporting each..."
echo ""

# --- Step 2: Export each session to a temp dir ---
EXPORT_DIR=$(mktemp -d)
trap 'rm -rf "$EXPORT_DIR"' EXIT

for sid in "${SESSION_IDS[@]}"; do
    echo "  Exporting $sid ..."
    opencode export "$sid" --sanitize 2>/dev/null > "$EXPORT_DIR/$sid.json"
done

# --- Step 3: Parse and aggregate with Python ---
python3 - "$EXPORT_DIR" << 'PYEOF'
import json, sys, os, glob

export_dir = sys.argv[1]
files = sorted(glob.glob(os.path.join(export_dir, "*.json")))

if not files:
    print("No exported sessions found")
    sys.exit(1)

from collections import defaultdict

sessions = []
for fpath in files:
    try:
        with open(fpath) as f:
            raw = f.read()
        # The export prints "Exporting session: ..." line before JSON.
        # Find the JSON start.
        idx = raw.find("{")
        if idx < 0:
            continue
        data = json.loads(raw[idx:])
        info = data.get("info", {})
        agent = info.get("agent", "unknown")
        model_obj = info.get("model", {})
        model = model_obj.get("id", "unknown") if isinstance(model_obj, dict) else str(model_obj)
        cost = info.get("cost", 0) or 0
        tokens = info.get("tokens", {})
        sessions.append({
            "id": info.get("id", os.path.basename(fpath).replace(".json", "")),
            "title": info.get("title", "untitled"),
            "agent": agent,
            "model": model,
            "cost": cost,
            "input": tokens.get("input", 0) or 0,
            "output": tokens.get("output", 0) or 0,
            "reasoning": tokens.get("reasoning", 0) or 0,
            "cache_read": (tokens.get("cache") or {}).get("read", 0) or 0,
            "cache_write": (tokens.get("cache") or {}).get("write", 0) or 0,
        })
    except Exception as e:
        print(f"  Warning: failed to parse {fpath}: {e}", file=sys.stderr)

if not sessions:
    print("No valid session data found")
    sys.exit(1)

# Filter out sessions with zero cost and no agent (empty sessions)
active = [s for s in sessions if s["cost"] > 0 or s["agent"] != "unknown"]
skipped = len(sessions) - len(active)

# Sort by cost descending
active.sort(key=lambda s: s["cost"], reverse=True)

# Group by agent+model
groups = defaultdict(lambda: {"cost": 0, "input": 0, "output": 0, "reasoning": 0, "cache_read": 0, "cache_write": 0, "count": 0})

total_cost = 0
total_input = 0
total_output = 0
total_reasoning = 0
total_cache_read = 0
total_cache_write = 0

print(f"{'Agent':<25} {'Model':<30} {'Cost':>10} {'Input':>12} {'Output':>12}")
print("-" * 95)

for s in active:
    agent = s["agent"]
    model = s["model"]
    cost = s["cost"]
    inp = s["input"]
    out = s["output"]

    total_cost += cost
    total_input += inp
    total_output += out
    total_reasoning += s["reasoning"]
    total_cache_read += s["cache_read"]
    total_cache_write += s["cache_write"]

    key = f"{agent} {model}"
    groups[key]["cost"] += cost
    groups[key]["input"] += inp
    groups[key]["output"] += out
    groups[key]["reasoning"] += s["reasoning"]
    groups[key]["cache_read"] += s["cache_read"]
    groups[key]["cache_write"] += s["cache_write"]
    groups[key]["count"] += 1

    print(f"{agent:<25} {model:<30} ${cost:>9.4f} {inp:>12,} {out:>12,}")

print("-" * 95)
print(f"{'TOTAL':<25} {'':<30} ${total_cost:>9.4f} {total_input:>12,} {total_output:>12,}")
print()

# Summary by agent+model
print("=== Summary by Agent+Model ===")
print(f"{'Agent':<25} {'Model':<30} {'Cost':>10} {'Sessions':>8}")
print("-" * 78)
for key in sorted(groups, key=lambda k: groups[k]["cost"], reverse=True):
    g = groups[key]
    parts = key.split(" ", 1)
    agent = parts[0] if len(parts) > 0 else "?"
    model = parts[1] if len(parts) > 1 else "?"
    print(f"{agent:<25} {model:<30} ${g['cost']:>9.4f} {g['count']:>8}")
print("-" * 78)
print(f"{'TOTAL':<25} {'':<30} ${total_cost:>9.4f} {len(active):>8}")
print()

print(f"Total sessions: {len(sessions)} ({len(active)} with activity{f', {skipped} empty' if skipped else ''})")
print(f"Total cost:     ${total_cost:.4f}")
print(f"Total input:    {total_input:,} tokens")
print(f"Total output:   {total_output:,} tokens")
print(f"Total reasoning:{total_reasoning:,} tokens")
print(f"Cache read:     {total_cache_read:,} tokens")
print(f"Cache write:    {total_cache_write:,} tokens")
PYEOF
