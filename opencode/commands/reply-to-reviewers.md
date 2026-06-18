---
agent: writer
---

Draft or revise a response letter to reviewers.

## Usage

`reply-to-reviewers [manuscript_path] [reviews_path]`

## Process

1. Load the `reply-to-reviewers` skill and `writing-craft` skill
2. Read the manuscript and the editor/reviewer comments
3. Create a decision table (comment → agree/disagree/misunderstanding)
4. Identify which changes are mandatory (editor-specified) vs negotiable
5. Draft the response letter following the 4-step process in the skill
6. For each comment: quote it, then respond with change confirmation
   or reasoned explanation

## Output

A response letter in markdown format, structured as:
- Opening (thanks)
- Summary of major changes
- Point-by-point response to each reviewer
- Point-by-point response to editor (if separate from reviewers)
