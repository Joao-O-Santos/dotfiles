# Exercise 02: Manuscript Workflow Test

## Prompt

Draft a 2-paragraph introduction for a study on children's
perceptions of fairness. The study uses a resource-allocation
task with 80 children aged 5-8.

After the initial draft, apply the following reviewer feedback:
- "The hook is weak — start with a concrete example, not a
  general statement about fairness"
- "Missing citation for the claim that children understand
  fairness by age 5"
- "The transition between paragraphs is abrupt"

---

## Measurable Metrics

| Metric | How to measure | Target |
|--------|---------------|--------|
| Planner routes correctly | Does planner delegate to writer (not itself)? | Yes |
| Writer loads correct skill | Does writer load `intro` skill? | Yes |
| Reviewers run | Do reviewer-structure, reviewer-detail, copyeditor all run? | Yes |
| Editor collates | Does editor produce a Chronological Edit List? | Yes |
| Writer applies fixes | Does writer fix all 3 reviewer comments? | 3/3 |
| Total agent invocations | Count of task calls | ≤ 8 |

## Manual Metrics

| Criterion | Check |
|-----------|-------|
| Hook is concrete | Does the intro open with a specific example? |
| Citation present | Is the fairness-by-age-5 claim cited? |
| Transition smooth | Does paragraph 2 flow naturally from paragraph 1? |
| Style compliant | Follows STYLE.md conventions? |
| Placeholders preserved | Are any <!-- TODO --> markers left? |

## Expected Workflow

1. Planner receives prompt, compiles WIP
2. Planner delegates to writer with `intro` skill
3. Writer returns draft
4. Planner launches Fast Loop (3 reviewers)
5. Reviewers return feedback
6. Planner applies straightforward fixes
7. Writer returns revised version
8. User judges final output

## Red Flags

- Planner drafting text itself (should delegate)
- Reviewer suggesting fixes (should only diagnose)
- Writer ignoring reviewer feedback
- Missing citations not marked with <!-- TODO -->
