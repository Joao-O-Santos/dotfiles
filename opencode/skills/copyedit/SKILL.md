---
name: copyedit
description: Paragraph, sentence, and word-level review for flow, clarity, and impact.
---

# Skill: copyedit

#style-core

## Focus Areas

### Prose Quality

Check paragraph flow, sentence clarity, and word choice against the
style conventions inlined via the `#style-core` snippet. Focus on
compliance with THIS project's standards:

- Hamburger paragraphs: topic sentence → evidence → linking sentence
- Topic-sentence clarity and old-to-new information flow
- Active/passive voice: passive is allowed when the patient, not
  the agent, should be the subject
- Concrete, specific words; no nominalizations or needless words
- End-weight principle (longer phrases toward sentence end)
- No multiple negations

### Markdown Style Compliance

- 72-character line wrapping (MANDATORY)
- Heading spacing: 4/3/2/1 blank lines before H1/H2/H3/H4
- List formatting (consistent indentation, blank lines between items
  when multi-paragraph)
- Custom styles for Word conversion preserved unchanged: `{custom-style=
  "Title"}`, `{custom-style="Abstract"}`, `{custom-style="Figure"}`,
  `{custom-style="Compact"}`, `{custom-style="References"}`
- OpenXML page break blocks preserved unchanged
- Pandoc pipe tables (APA-compliant via `twrd`)

### Terminology Consistency

- Same construct and variable names across prose, tables, figures,
  and R code
- No multiple terms for the same concept
- No same term for different concepts
- Terminology aligned with the consistent-terminology rule

### Titles

- Provocative and memorable: open with an idiom,
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

#reviewer-output-format

#examples-disclaimer
