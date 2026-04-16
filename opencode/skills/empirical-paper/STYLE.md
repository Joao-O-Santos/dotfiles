# STYLE – Empirical Paper Conventions

This file extends the shared conventions in `/home/random_user/.config/opencode/STYLE.md` with
empirical-specific rules. Read the root STYLE.md first; everything there
applies (72-char wrap, heading line breaks, OpenXML page breaks, custom
styles, hamburger paragraphs, etc.).

## 1. Empirical Papers – Structure and Flow

Follow IMRaD with a martini‑glass shape: broad to narrow in the
introduction, narrow through methods and results, then back to broad in
the discussion.

### 1.1 Abstract

- One paragraph: problem → approach → key results → main implications.
- Avoid statistical clutter; include only the most informative effects
  and patterns, not every test.

### 1.2 General Introduction

- Start with a **hook** that a layperson can follow: metaphor, anecdote,
  concrete example, or striking quote, ideally reused thematically later
  in the paper.
- Move to **historical and conceptual background**, beginning with central
  papers and debates and gradually adding nuance relevant to the present
  study.
- Organize subsections around **claims or themes**, not individual papers;
  each paragraph should make a single argumentative point supported by
  multiple sources.
- End with a **clear statement of the problem, gaps, and contributions**
  of the current work, framed as what the field needs to know and how
  this work addresses that.
- In early drafts, signposting (e.g., "In this section, we…") is welcome.
  In revisions, signposting should be refined so that the structure is
  clear and the reader is left with a natural mental map of the paper,
  but without obvious "now we do X" road‑map language.

### 1.3 "Our Approach" / Empirical Strategy Section

- When appropriate, include a brief section explaining **what this study
  tests and why this design** is appropriate, including
  operationalizations and key design choices and trade‑offs.
- Start by clarifying the question at the conceptual level, then justify
  why comparing specific means, conditions, or prejudices is a valid
  empirical strategy.

### 1.4 Study-Level Sections

For multi‑study papers, repeat the following scaffold for each study.

#### 1.4.1 Study X – Introduction (optional but preferred)

- Briefly restate **what this specific study adds**, especially how it
  builds on prior studies or addresses a specific limitation or open
  question.

#### 1.4.2 Study X – Method

Subsections:

- **Participants**: Sample size, demographics, recruitment method,
  compensation, inclusion/exclusion criteria, preregistered sample size
  rules, and any attrition or attention‑check screening summarized
  concisely.
- **Materials / Stimuli**: Provide enough detail for replication. When
  materials are long, summarize structure in text and move full lists to
  supplementary materials.
- **Procedure**:
  - Present the study chronologically from the **participant's point of
    view**, using active or acceptable passive constructions that keep
    participants, experimenters, or software as clear agents.
  - Group counterbalancing details either inline (if simple) or in a
    concise final paragraph (if complex).
  - Align reported steps with what data‑wrangling and anonymization
    scripts actually did for exclusions, data cleaning, and
    anonymization.

#### 1.4.3 Study X – Results

- Lead with **substantive interpretation**, ending sentences with
  statistical support rather than starting with statistics or dense
  notation.
- Conventions:
  - Use **present tense** for inferential statistics, as they are
    population‑level claims.
  - Emphasize significance as a property of evidence, not the effect
    itself (e.g., "there was significant evidence that X is higher than
    Y").
  - Avoid phrasing such as "participants significantly differed";
    describe differences between conditions, variables, or groups
    instead.
  - Use partial eta squared and simple Pandoc‑friendly notation for
    standard statistics.

#### 1.4.4 Study X – Discussion

- **Restate the main findings** in intuitive language, emphasizing
  patterns over individual p‑values.
- Note limitations and trade‑offs honestly, presenting them as
  considered design choices when appropriate.
- Make clear how this study fits into the broader argument of the paper
  and motivates the next study or the general discussion.

### 1.5 General Discussion

- Recap the **most important cross‑study patterns** and what they mean
  for theory and practice.
- Integrate findings with the literature reviewed in the introduction,
  ideally revisiting the original hook or metaphor.
- Address limitations and boundary conditions, propose follow‑up work,
  and end on a **concise, grounded take‑home message**.

## 2. Statistical Reporting and Results Prose

- Base all statistical descriptions on **actual model objects and
  outputs** from scripts like `2-analyze.R`, preregistration scripts,
  and Quarto reports; do not invent numbers or patterns.
- **Lead with meaning**, then show evidence:
  - e.g., "There was strong evidence that egocentric discounting was
    greater when the advisor was an AI than a human, *F*(1, …) = …"
    rather than a bare list of statistics.
- Conventions:
  - Present tense for inferential statements.
  - "Significant evidence that X is higher than Y" instead of "X is
    significantly higher than Y."
  - Avoid "participants differed significantly"; talk about effects or
    variables, not people.
  - Use estimated marginal means to break down main effects and
    interactions.
- For linear mixed models or GLMs, mention:
  - Fixed‑effect structure first, then random‑effects structure,
    following a maximal‑model‑then‑simplify approach.
  - How key contrasts or multiple comparisons were obtained (e.g., via
    `emmeans` and `pairs()` on specific grids).

- **Effect size mandate**: Report η²~p~ for ANOVAs/mixed models,
  Cohen's *d* for *t*-tests, and *r* for correlations. No confidence
  intervals for effect sizes in the main text by default; CIs go in
  supplementary materials or can be derived from reported values.

- **Greek letters and formatting**: Always use HTML character codes —
  `&eta;`, `&beta;`, `&alpha;`, `&chi;`, `&omega;` etc. — never Unicode
  characters or LaTeX math. Subscripts use pandoc tilde notation
  (`M~psych~`); superscripts use caret notation (`&eta;~p~^2^`). This
  ensures correct rendering via `twrd`/Pandoc.

## 3. Collaboration with the User

- At the start of a project, confirm scope and constraints (target
  journal, word limit, deadline, how much freedom there is to
  reorganize sections).
- Before large rewrites, provide or summarize:
  - A **topic‑sentence outline** for new work, or
  - A **reverse outline** for existing drafts, including notes about
    gaps, redundancy, and possible reordering.
- Defer to the user on substantive choices such as:
  - Which limitations to emphasize.
  - Desired strength of claims (e.g., "suggests" vs "demonstrates").
  - Which secondary analyses (from `3-extra_analysis.R`) belong in
    the main text versus supplements or footnotes.
