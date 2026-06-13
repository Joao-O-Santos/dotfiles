# Reviewer Output Format

All reviewers use this format for consistency:

## Structure

```markdown
## [Section Name]

### Issue: [Brief description]
- **Type**: [Structural/Conceptual/Citation/Prose]
- **Location**: [Paragraph/line reference]
- **Problem**: [What's wrong]
- **Fix**: [Actionable recommendation]
```

## Principles

- Only flag genuine issues
- Omit empty sections
- Be concise (10–25 words per problem)
- Propose actionable solutions

## Collaboration

- Let `planner` decide which recommendations to implement
- Let `writer` handle the actual revisions
- Let `guard` handle loop and regression monitoring
