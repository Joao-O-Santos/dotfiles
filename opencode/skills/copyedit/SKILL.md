---
name: copyedit
description: Paragraph, sentence, and word-level review for flow, clarity, and impact.
---

# Skill: copyedit

## Focus Areas

### Prose Quality

Check paragraph flow, sentence clarity, and word choice against STYLE.md
conventions. The model already knows good prose — focus on compliance
with THIS project's standards:

- Hamburger paragraph structure (STYLE.md §4.1)
- Topic-sentence clarity and old-to-new information flow (STYLE.md
  §4.2, §5.2)
- Active/passive voice per STYLE.md §5.1 (passive is allowed when
  appropriate)
- Concrete, specific words; no nominalizations or needless words
  (STYLE.md §5.4)
- End-weight principle (STYLE.md §5.2)
- No multiple negations (STYLE.md §5.3)

### Markdown Style Compliance

- 72-character line wrapping (MANDATORY, STYLE.md §5.5)
- Heading spacing: 4/3/2/1 blank lines before H1/H2/H3/H4 (STYLE.md
  §6)
- List formatting (consistent indentation, blank lines between items
  when multi-paragraph)
- Custom styles for Word conversion preserved unchanged: `{custom-style=
  "Title"}`, `{custom-style="Abstract"}`, `{custom-style="Figure"}`,
  `{custom-style="Compact"}`, `{custom-style="References"}` (STYLE.md
  §8)
- OpenXML page break blocks preserved unchanged (STYLE.md §7)
- Pandoc pipe tables (APA-compliant via `twrd`; see STYLE.md §2 Format)

### Terminology Consistency

- Same construct and variable names across prose, tables, figures,
  and R code
- No multiple terms for the same concept
- No same term for different concepts
- Terminology aligned with STYLE.md §5.4 (consistent terminology
  rule)

### Titles

- Provocative and memorable per STYLE.md §5.6: open with an idiom,
  rhetorical question, cultural reference, or surprising juxtaposition
  rather than a neutral description
- Header level appropriateness (correct depth for section importance)

## Output Format

### Prose Quality

- **Problem** (10-25 words): [description]
- **Solution**: [proposed fix]

### Markdown Style Compliance

- **Problem** (10-25 words): [description]
- **Solution**: [proposed fix]

### Terminology Consistency

- **Problem** (10-25 words): [description]
- **Solution**: [proposed fix]

### Titles

- **Problem** (10-25 words): [description]
- **Solution**: [proposed fix]

## Rules

#reviewer-output-rules

## Note on Examples

#examples-disclaimer
