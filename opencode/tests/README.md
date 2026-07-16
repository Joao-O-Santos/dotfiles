# OpenCode Config Test Suite

## Automated Tests (run with bash)

- `test_permissions.sh` — verifies each agent has the right tools
- `test_config.sh` — validates opencode.json structure and references

## Manual Writing Exercises

Exercises in `writing-exercises/`. Each gives a prompt and expected
structure. You judge the output quality. Track:
- Did the writer follow the WIP structure?
- Did it load the correct skill?
- Did it preserve placeholders?
- Is the prose STYLE.md-compliant?

## R-Coder Exercises

Tasks in `r-coder-exercises/`. Each gives a dataset and analysis goal.
Track:
- Number of fix iterations before correct output
- Coding style compliance (tabs, pipes, ≤80 chars)
- Does the script run without errors?
- Does report.qmd render?

## Metrics

See `metrics/README.md` for how to track test results over time.
