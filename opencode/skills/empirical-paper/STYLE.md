# STYLE – Scientific Writing, R Analysis, and Workflow

## 1. Purpose and Scope

This STYLE file governs how agents plan, draft, and revise empirical and theoretical papers, and how they describe statistical analyses based on R outputs and Quarto reports in psychology and related behavioral sciences.
The primary goal is clear, reader‑friendly argumentation that meets journal standards, using a modern writing‑as‑thinking approach, topic‑sentence outlines, and systematic revision.

## 2. Standards Hierarchy (Gold / Silver / Bronze)

- **Gold – Writing Workshop–style principles**: Treat writing as thinking, use topic‑sentence outlines and reverse outlining, build hamburger paragraphs, and revise systematically from structure to detail.

- **Silver – Paper structure and statistical conventions**: Follow the macro‑structure described in `structure.md` for empirical and theoretical papers, including statistical reporting conventions and views on passive voice and section flow, deviating only when this clearly improves clarity or impact.

- **Bronze – Existing text examples**: Use existing texts (e.g., example introductions, methods, “Our approach” sections, results narratives, and Quarto reports) as reference for voice, tone, and domain‑specific phrasing, but prefer improvements when they conflict with Gold or Silver standards.

- **Format – APA 7th edition throughout**: All statistical reporting, headings, citations, and reference lists follow APA 7. Tables should be written as pandoc pipe tables; `twrd` converts them to ~90% APA-compliant Word tables. Remaining tweaks (rules, spacing) are made manually or via an improved pandoc
setup later.

When standards conflict, follow Gold over Silver and Silver over Bronze, while still respecting disciplinary and journal norms.

## 3. Voice, Tone, and Audience

- Use a **confident, matter‑of‑fact academic voice**, avoiding hype, unnecessary hedging, and rhetorical flourishes that do not serve the argument.

- Assume a **scientifically literate reader** (psychology / social science), but avoid assuming specialized knowledge from adjacent fields unless specified; define technical terms once when they first matter.

- Prefer **concrete, example‑rich explanations** when introducing concepts or arguments, using short illustrative scenarios, analogies, or examples when helpful.

- Use **first‑person plural** (“we”) in papers when it is standard for the venue, especially in methods and discussions; avoid first person in neutral background reports unless explicitly requested.

## 4. High-Level Workflow (All Writing Tasks)

1. **Clarify the task**: Identify paper type (empirical vs theoretical), target venue or audience, and whether the user wants outlining help, drafting, revising, or all stages.

2. **Collect inputs**: Ingest any pre‑existing outline, notes, preregistration, Quarto reports, R objects, and scripts (e.g., `0-anonymize.R`, `1-wrangle.R`, `2-analyze.R`, `3-extra_analysis.R`, `run_all.R`, `report.qmd`).
3. **Produce or refine a topic‑sentence outline** (or reverse outline if starting from a draft) before heavy editing or rewriting, especially for introductions, literature reviews, and discussions.

4. **Draft in rough prose quickly**, prioritizing idea flow over polish; do not over‑optimize sentences in the first passes.

5. **Revise structurally** using topic‑sentence outlines and hamburger paragraphs, then move to sentence‑level clarity, concision, and word choice; only then handle micro‑edits like punctuation and typography.

6. **Align results prose with analysis code**: Rerun or inspect Quarto reports and script outputs to ensure every interpretive statement matches model outputs, contrasts, and figures.

7. **Final pass**: Check paragraph flow, terminology consistency, tense, statistical formatting, and whether a reader could follow the argument in a single forward pass without backtracking.

## 5. Empirical Papers – Structure and Flow

Follow IMRaD with a martini‑glass shape: broad to narrow in the introduction, narrow through methods and results, then back to broad in the discussion.

### 5.1 Abstract

- One paragraph: problem → approach → key results → main implications.
- Avoid statistical clutter; include only the most informative effects and patterns, not every test.

### 5.2 General Introduction

- Start with a **hook** that a layperson can follow: metaphor, anecdote, concrete example, or striking quote, ideally reused thematically later in the paper.
- Move to **historical and conceptual background**, beginning with central papers and debates and gradually adding nuance relevant to the present study.
- Organize subsections around **claims or themes**, not individual papers; each paragraph should make a single argumentative point supported by multiple sources.
- End with a **clear statement of the problem, gaps, and contributions** of the current work, framed as what the field needs to know and how this work addresses that.
- In early drafts, signposting (e.g., “In this section, we…”) is welcome. In revisions, signposting should be refined so that the structure is clear and the reader is left with a natural mental map of the paper, but without obvious “now we do X” road‑map language.

### 5.3 “Our Approach” / Empirical Strategy Section

- When appropriate, include a brief section explaining **what this study tests and why this design** is appropriate, including operationalizations and key design choices and trade‑offs.
- Start by clarifying the question at the conceptual level, then justify why comparing specific means, conditions, or prejudices is a valid empirical strategy.

### 5.4 Study-Level Sections

For multi‑study papers, repeat the following scaffold for each study.

#### 5.4.1 Study X – Introduction (optional but preferred)

- Briefly restate **what this specific study adds**, especially how it builds on prior studies or addresses a specific limitation or open question.

#### 5.4.2 Study X – Method

Subsections:

- **Participants**: Sample size, demographics, recruitment method, compensation, inclusion/exclusion criteria, preregistered sample size rules, and any attrition or attention‑check screening summarized concisely.
- **Materials / Stimuli**: Provide enough detail for replication. When materials are long, summarize structure in text and move full lists to supplementary materials.
- **Procedure**:
  - Present the study chronologically from the **participant’s point of view**, using active or acceptable passive constructions that keep participants, experimenters, or software as clear agents.
  - Group counterbalancing details either inline (if simple) or in a concise final paragraph (if complex).
  - Align reported steps with what data‑wrangling and anonymization scripts actually did for exclusions, data cleaning, and anonymization.

#### 5.4.3 Study X – Results

- Lead with **substantive interpretation**, ending sentences with statistical support rather than starting with statistics or dense notation.
- Conventions:
  - Use **present tense** for inferential statistics, as they are population‑level claims.
  - Emphasize significance as a property of evidence, not the effect itself (e.g., “there was significant evidence that X is higher than Y”).
  - Avoid phrasing such as “participants significantly differed”; describe differences between conditions, variables, or groups instead.
  - Use partial eta squared and simple Pandoc‑friendly notation for standard statistics.
- Summarize main effects and key interactions at the paragraph level, and refer to tables or figures for detailed numbers.

#### 5.4.4 Study X – Discussion

- **Restate the main findings** in intuitive language, emphasizing patterns over individual p‑values.
- Note limitations and trade‑offs honestly, presenting them as considered design choices when appropriate.
- Make clear how this study fits into the broader argument of the paper and motivates the next study or the general discussion.

### 5.5 General Discussion

- Recap the **most important cross‑study patterns** and what they mean for theory and practice.
- Integrate findings with the literature reviewed in the introduction, ideally revisiting the original hook or metaphor.
- Address limitations and boundary conditions, propose follow‑up work, and end on a **concise, grounded take‑home message**.

## 6. Paragraph and Argument Structure

### 6.1 Hamburger Paragraphs

Use the **hamburger** model for most paragraphs:

- **Top bun**: A clear topic sentence that states the main claim of the paragraph in one sentence, usually at the beginning.
- **Filling**: Supporting sentences – evidence, examples, reasoning, or clarifications that all directly support the topic sentence.
- **Bottom bun**: A concluding or linking sentence that shows why the evidence matters and, if needed, connects to the next paragraph.

Short connector or transition paragraphs without a full hamburger structure are acceptable but should be rare and clearly functional (e.g., bridging between major parts of an argument).

### 6.2 Topic-Sentence Outlines and Reverse Outlining

- For major sections, create or refine a **topic‑sentence outline** listing one sentence per intended paragraph; treat this as the skeleton of the argument.
- Use **reverse outlining** on messy drafts:
  - Extract one sentence per paragraph that captures its main point.
  - Arrange them into an outline, then revise structure (reorder, merge, delete, expand) before revising prose.
- When reworking existing drafts, agents should be able to show or summarize the reverse outline before major rewrites, so the user can adjust the argument skeleton.

### 6.3 Signposting

- Use **explicit signposting in early drafts** (“In this section, we do X…”) to clarify structure during planning and drafting.
- In later revisions, refine or remove overt signposting phrases so that:
  - The **structure remains transparent** to the reader, who can still form a clear mental map of the paper.
  - The prose feels natural and narrative, rather than like a list of section previews.
- Keep signposting where structure would otherwise be opaque (e.g., major transitions, unusual ordering), but express it in integrated prose rather than formulaic road‑map sentences.

## 7. Sentence-Level Style

### 7.1 Active vs Passive Voice

- **Passive voice is allowed and sometimes preferred.** Use passive when the actor is unknown, irrelevant, obvious, or when the focus should be on the patient rather than the agent.
- Prefer **active constructions** when participants, experimenters, or software are clear actors, especially in methods and when describing what was done.
- Avoid long strings of agentless passives that obscure who did what; if multiple actions share the same agent, name it early and then omit only when unambiguous.

### 7.2 Information Flow and Main Verb Placement

- Bring the **main verb early** in the sentence where possible so readers do not have to hold long noun phrases in memory before understanding the action.
- Follow the **end‑weight principle**: place longer or more complex phrases toward the end of sentences, keeping early positions simpler.
- Use **topic → comment** ordering: start sentences with familiar information (“topic”) before introducing new or surprising information (“comment”).

### 7.3 Negation and Logical Structure

- Avoid **multiple negations** and convoluted conditional negation; rewrite in positive terms where possible.
- Ensure logical relations (if, unless, although, however) are clear on first read without backtracking.

### 7.4 Word Choice and Concision

- Prefer **concrete, specific words** and short, familiar terms over abstract nominalizations and jargon, especially in topic sentences and hooks.
- Remove redundancy and filler (“it is important to note that,” “in order to,” etc.) unless rhythm or emphasis requires it.
- Maintain consistent terminology for variables, conditions, and constructs across text, tables, figures, and code (e.g., `WOA`, `advisor`, `race`, etc.).

### 7.5 Text Width

- Hard-wrap all prose output to **72 characters** per line. This applies to
drafted and revised sections, not code blocks or tables.

### 7.6 Titles

- Paper and section titles should be **provocative and memorable**: open
  with an idiom, rhetorical question, cultural reference, or surprising
  juxtaposition rather than a neutral description of the content.

- The subtitle (if present) can then anchor the title to the actual topic.

- Example pattern: "Would You Like to Update Now? Depends on Who's
  Asking — Human or AI?" instead of "Advice-taking with human vs ai
  advisors: how advisor type affects updating"

## 8. Statistical Reporting and Results Prose

- Base all statistical descriptions on **actual model objects and outputs** from scripts like `2-analyze.R`, preregistration scripts, and Quarto reports; do not invent numbers or patterns.
- **Lead with meaning**, then show evidence:
  - e.g., “There was strong evidence that egocentric discounting was greater when the advisor was an AI than a human, *F*(1, …) = …” rather than a bare list of statistics.
- Conventions:
  - Present tense for inferential statements.
  - “Significant evidence that X is higher than Y” instead of “X is significantly higher than Y.”
  - Avoid “participants differed significantly”; talk about effects or variables, not people.
  - Use estimated marginal means to break down main effects and interactions, and describe them in prose before or while referring to tables.
- For linear mixed models or GLMs, mention:
  - Fixed‑effect structure first, then random‑effects structure, following a maximal‑model‑then‑simplify approach.
  - How key contrasts or multiple comparisons were obtained (e.g., via `emmeans` and `pairs()` on specific grids).

- **Effect size mandate**: Report η²~p~ for ANOVAs/mixed models, Cohen's *d*
  for *t*-tests, and *r* for correlations. No confidence intervals for effect
  sizes in the main text by default; CIs go in supplementary materials or can
  be derived from reported values.

- **Greek letters and formatting**: Always use HTML character codes — `&eta;`,
  `&beta;`, `&alpha;`, `&chi;`, `&omega;` etc. — never Unicode characters or
  LaTeX math. Subscripts use pandoc tilde notation (`M~psych~`); superscripts
  use caret notation (`&eta;~p~^2^`). This ensures correct rendering via
  `twrd`/Pandoc.

## 9. Collaboration with the User

- At the start of a project, confirm scope and constraints (target journal, word limit, deadline, how much freedom there is to reorganize sections).
- Before large rewrites, provide or summarize:
  - A **topic‑sentence outline** for new work, or
  - A **reverse outline** for existing drafts, including notes about gaps, redundancy, and possible reordering.
- Defer to the user on substantive choices such as:
  - Which limitations to emphasize.
  - Desired strength of claims (e.g., “suggests” vs “demonstrates”).
  - Which secondary analyses (from `3-extra_analysis.R`) belong in the main text versus supplements or footnotes.
