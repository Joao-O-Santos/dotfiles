# Test Metrics

Track these over time to measure config quality:

## Automated Tests

Run `bash tests/test_permissions.sh` and `bash tests/test_config.sh`.
Record pass/fail counts.

## Writing Exercises

For each exercise:
- **Time**: minutes from prompt to approved draft
- **Iterations**: number of fix cycles before approval
- **Style violations**: count from copyeditor review
- **Skill compliance**: did the agent load the right skills?

## R-Coder Exercises

For each exercise:
- **Time**: minutes from prompt to working script
- **Iterations**: number of fix cycles before correct output
- **Style violations**: tabs/pipes/line-length issues
- **Errors**: does the script run without errors?
- **Render**: does report.qmd render?

## Tracking

Keep a simple log:
```
Date       | Test              | Time | Iterations | Violations | Notes
2026-07-16 | 01-intro-empirical | 5m   | 2          | 3          | First run
```
