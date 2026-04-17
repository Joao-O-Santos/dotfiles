# Intro

- opening paragraph so easy a layperson can understand; starts with a
  provocative questions/idiom/quote/anecdote, or something that draws
  the reader in (may introduce a metaphor that we'll come back to
  throughout the manuscript). Explains what we did, why we did it, and
  why it's important (not necessarily in that order)

- second paragraph expands reasoning, introduces a nuance (if
  important), is a bit more technical and formalizes the thesis/claims.

- third paragraph outlines the manuscript structure, ideally without
  using explicit signposting, but presents the sections in a more
  narrative/natural way. It's fine to start with obvious signposting
  when drafting, and later refine it to more subtle/natural flow.

**Common mistakes:**
- Don't open with a vague disciplinary overview; start concrete.
- Don't bury the main finding or contribution in the third paragraph.


# Lit Review

- Starts with historical perspectives and critical definitions

- Goes through the main topics/ideas presented in the paper, starting
  with the most seminal papers; moving through the history of that
  topic, and piling on nuance and details relevant for the manuscript

- is structured in the way that is most persuasive, impactful and
  logical. Should be outlined before it's filled in. It's fine (and
  good) to refine and revise the structure once it moves from outline to
  fledged out prose.

**Common mistakes:**
- Don't organize author-by-author; organize by theme or claim.
- Don't introduce new literature in the discussion that wasn't
  covered here.


# Our Approach

- Include a section outlining the empirical approach: why this design
  was chosen, key operationalizations, and important trade-offs.


# Study X

- One or two paragraphs on what the study tested and why we conducted it

## Method

### Participants

- Demographics, number, sampling approach, etc...


### Materials

- If using piloted materials or some specific setup where stimuli
  descriptions are crucial and need to be detailed, a materials section
  is worth adding

### Procedure

- Write from the **participant's point of view**, using active voice or
  well-formed passive constructions where the actor is obvious or
  irrelevant (e.g., passive is fine when the software is the agent and
  focus belongs on the participant's experience).
  Participants should be the protagonists. Experimenters and software
  can also be active agents. Present the procedure
  chronologically. Interleave short notes on
  what was counterbalanced OR present those details after the narration
  of the full procedure, if there are many details to report.

**Common mistakes:**
- Don’t write from the researcher’s perspective ("we then asked...");
  write from the participant’s POV.
- Don’t omit counterbalancing or randomization details.


## Results

See `/home/random_user/.config/opencode/skills/empirical-paper/STYLE.md` §2 for the full statistical reporting
and results-prose conventions (present tense, "significant evidence
that", lead with meaning, effect sizes, Greek letter formatting, etc.).

Additional structural guidance:

- Consider reporting interactions first, as the interpretation of main
  effects is qualified by any significant interaction. If main effects
  are reported first, note when they are qualified by an interaction.

- Use estimated marginal means (computed from `emmeans`) to break down
  main effects. Use simple contrasts to break down interactions (A1
  - A2 at B1; A1 - A2 at B2; B1 - B2 at A1; B1 - B2 at A2).

- When reporting linear mixed models, report their fixed-effect
  structure first, then the random effects. State that we used Singmann
  and Kelen’s (2019) approach of starting with the maximal model
  warranted by the design, simplifying it only if there are warnings or
  errors in the fitting process.

**Common mistakes:**
- Don’t start paragraphs with statistics; lead with the substantive
  claim and end with the statistical support.
- Don’t report main effects when a significant interaction qualifies
  them without noting the qualification.
- Don’t use Unicode Greek letters or LaTeX math; use HTML entities
  (&eta;, &beta;) and pandoc notation.


## Discussion

- Recall the most relevant findings from the results, in less technical
  language and less statistical detail.

- Structure the paragraphs in the most persuasive, natural and clear way
  possible to build the arguments.

- Outline the discussion first, then expand with user input.

- Keep the discussion of each study short if it's a multi-study paper

**Common mistakes:**
- Don't introduce new literature here that wasn't in the lit review.
- Don't overstate conclusions beyond what the data support.

[Rinse and repeat for Study Y, etc...]


# General Discussion

- Recall the most relevant findings in a way that makes the patterns
  we're highlighting the most clear to readers.

- Discuss limitations, honestly, but don't be afraid to conterargue or
  describe them as tradeoffs that we deemed worth taking, when that's
  the case.

- Discuss strengths, and contributions (theoretical and practical)

- Try to end on a punchy (but backed by data and humble) way

**Common mistakes:**
- Don't repeat the results verbatim; synthesize across studies.
- Don't end with vague future directions; end with a concrete take-home
  message.

