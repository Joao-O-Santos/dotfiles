# Delegation Stop-Loss Limits

Every delegation must include explicit limits. These complement the hard `steps` limits configured per-agent in `opencode.json` — the config caps enforce termination, while these prompt limits teach agents *how* to fail gracefully (returning blocker reports instead of just being truncated).

## Limits

- Maximum 6 tool calls unless user approves continuation
- Stop after 2 failed attempts to locate a file or directory
- Stop after 3 similar search attempts (grep/glob) without a useful hit
- Stop after 4 tool calls with no new material evidence or state change
- If a strategy fails once, do not repeat without changing scope and explaining why

## Blocker Report Format

If any limit is hit, return immediately:

```
- Objective: [restate objective]
- Attempts made: [list what you tried]
- Evidence found: [summarize what you learned]
- Blocker: [what stopped you]
- Recommended next step: [reroute / broaden search / ask user]
```
