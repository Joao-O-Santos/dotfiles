# STYLE – Shared Writing Conventions

## 1. Purpose and Scope

This STYLE file governs shared writing conventions across all agents and skills. It defines voice, tone, paragraph structure, sentence-level style, and collaboration rules that apply universally. Skill-specific STYLE.md files extend or override these conventions for their domain.

## 2. Standards Hierarchy (Gold / Silver / Bronze)

- **Gold – Writing Workshop–style principles**: Treat writing as thinking, use topic-sentence outlines and reverse outlining, build hamburger paragraphs, and revise systematically from structure to detail.

- **Silver – Paper structure and statistical conventions**: Follow the macro-structure described in skill-specific `/home/random_user/.config/opencode/skills/*/SKILL.md` files, including statistical reporting conventions and views on passive voice and section flow, deviating only when this clearly improves clarity or impact.

- **Bronze – Existing text examples**: Use existing texts (e.g., example introductions, methods, results narratives, and Quarto reports) as reference for voice, tone, and domain-specific phrasing, but prefer improvements when they conflict with Gold or Silver standards.

- **Format – APA 7th edition throughout**: All statistical reporting, headings, citations, and reference lists follow APA 7. Tables should be written as pandoc pipe tables; `twrd` converts them to ~90% APA-compliant Word tables. Remaining tweaks (rules, spacing) are made manually or via an improved pandoc setup later.

When standards conflict, follow Gold over Silver and Silver over Bronze, while still respecting disciplinary and journal norms.

## 3. Voice, Tone, and Audience

- Use a **confident, matter-of-fact academic voice**, avoiding hype, unnecessary hedging, and rhetorical flourishes that do not serve the argument.

- Assume a **scientifically literate reader** (psychology / social science), but avoid assuming specialized knowledge from adjacent fields unless specified; define technical terms once when they first matter.

- Prefer **concrete, example-rich explanations** when introducing concepts or arguments, using short illustrative scenarios, analogies, or examples when helpful.

- Use **first-person plural** ("we") in papers when it is standard for the venue, especially in methods and discussions; avoid first person in neutral background reports unless explicitly requested.

## 4. Paragraph and Argument Structure

### 4.1 Hamburger Paragraphs

Use the **hamburger** model for most paragraphs:

- **Top bun**: A clear topic sentence that states the main claim of the paragraph in one sentence, usually at the beginning.
- **Filling**: Supporting sentences – evidence, examples, reasoning, or clarifications that all directly support the topic sentence.
- **Bottom bun**: A concluding or linking sentence that shows why the evidence matters and, if needed, connects to the next paragraph.

Short connector or transition paragraphs without a full hamburger structure are acceptable but should be rare and clearly functional (e.g., bridging between major parts of an argument).

### 4.2 Topic-Sentence Outlines and Reverse Outlining

- For major sections, create or refine a **topic-sentence outline** listing one sentence per intended paragraph; treat this as the skeleton of the argument.
- Use **reverse outlining** on messy drafts:
  - Extract one sentence per paragraph that captures its main point.
  - Arrange them into an outline, then revise structure (reorder, merge, delete, expand) before revising prose.
- When reworking existing drafts, agents should be able to show or summarize the reverse outline before major rewrites, so the user can adjust the argument skeleton.

### 4.3 Signposting

- Use **explicit signposting in early drafts** ("In this section, we do X…") to clarify structure during planning and drafting.
- In later revisions, refine or remove overt signposting phrases so that:
  - The **structure remains transparent** to the reader, who can still form a clear mental map of the paper.
  - The prose feels natural and narrative, rather than like a list of section previews.
- Keep signposting where structure would otherwise be opaque (e.g., major transitions, unusual ordering), but express it in integrated prose rather than formulaic road-map sentences.

## 5. Sentence-Level Style

### 5.1 Active vs Passive Voice

- **Passive voice is allowed and sometimes preferred.** Use passive when the actor is unknown, irrelevant, obvious, or when the focus should be on the patient rather than the agent.
- Prefer **active constructions** when participants, experimenters, or software are clear actors, especially in methods and when describing what was done.
- Avoid long strings of agentless passives that obscure who did what; if multiple actions share the same agent, name it early and then omit only when unambiguous.

### 5.2 Information Flow and Main Verb Placement

- Bring the **main verb early** in the sentence where possible so readers do not have to hold long noun phrases in memory before understanding the action.
- Follow the **end-weight principle**: place longer or more complex phrases toward the end of sentences, keeping early positions simpler.
- Use **topic → comment** ordering: start sentences with familiar information ("topic") before introducing new or surprising information ("comment").

### 5.3 Negation and Logical Structure

- Avoid **multiple negations** and convoluted conditional negation; rewrite in positive terms where possible.
- Ensure logical relations (if, unless, although, however) are clear on first read without backtracking.

### 5.4 Word Choice and Concision

- Prefer **concrete, specific words** and short, familiar terms over abstract nominalizations and jargon, especially in topic sentences and hooks.
- Remove redundancy and filler ("it is important to note that", "in order to", etc.) unless rhythm or emphasis requires it.
- Maintain consistent terminology for variables, conditions, and constructs across text, tables, figures, and code (e.g., use the same name for a construct in the prose, table headers, figure labels, and R objects).

### 5.5 Text Width (MANDATORY)

- **MANDATORY**: All prose output must be hard-wrapped to **72 characters** per line. This applies to all drafted and revised sections, not code blocks or tables. Use a text editor with a wrap column set to 72, or manually hard-wrap each paragraph before submission.

### 5.6 Titles

- Paper and section titles should be **provocative and memorable**: open with an idiom, rhetorical question, cultural reference, or surprising juxtaposition rather than a neutral description of the content.
- The subtitle (if present) can then anchor the title to the actual topic.
- Example pattern: "Would You Like to Update Now? Depends on Who's Asking — Human or AI?" instead of "Advice-taking with human vs ai advisors: how advisor type affects updating"

## 6. Heading Line Breaks

Use the following blank lines before headings:

- **4 blank lines** before H1 (title)
- **3 blank lines** before H2 (major section)
- **2 blank lines** before H3 (subsection)
- **1 blank line** before H4 (minor subsection)

Example:
```
# H1 Section



## H2 Subsection


### H3 Sub-subsection

#### H4 sub-sub-subsection





# Another H1 Section
```

## 7. OpenXML Page Breaks

To insert a page break in documents that will be converted to Word (via `twrd`), use:

```{=openxml}
<w:p><w:r><w:br w:type="page"/></w:r></w:p>
```

Place this code block where a page break is needed (e.g., before Abstract, before References).

Add four linebreaks before the page break (and keep the four linebreaks after the page break and before the next section.

Example:

````md

:::: {custom-style="Title"}
Title
::::




[pagebreak xml]




# Title (intro header)
````

## 8. Custom Styles for Word Conversion

When converting markdown to Word, use custom Pandoc attributes to apply Word styles. The following custom styles are supported:

- **`{custom-style="Title"}`** – Applied to the paper title (use before H1)
- **`{custom-style="Abstract"}`** – Applied to the Abstract section
- **`{custom-style="Figure"}`** – Applied to figure captions
- **`{custom-style="Compact"}`** – Applied to compact lists or narrow columns
- **`{custom-style="References"}`** – Applied to the References section

### Usage Examples

Title:
```markdown
:::: {custom-style="Title"}
Paper Title
::::
```

Abstract:
```markdown

# Abstract

:::: {custom-style="Abstract"}

Abstract text here...

::::
```

Figure caption:
```markdown
:::: {custom-style="Figure"}
**Figure 1.** Description of figure.
::::
```

References:
```markdown
## References

:::: {custom-style="References"}


[reference entries...]

::::
```

Do NOT remove these custom styles when editing existing documents. Preserve them exactly as they appear in the source file.