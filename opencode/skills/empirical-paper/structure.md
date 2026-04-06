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


# Lit Review

- Starts with historical perspectives and critical definitions

- Goes through the main topics/ideas presented in the paper, starting
  with the most seminal papers; moving through the history of that
  topic, and piling on nuance and details relevant for the manuscript

- is structured in the way that is most persuasive, impactful and
  logical. Should be outlined before it's filled in. It's fine (and
  good) to refine and revise the structure once it moves from outline to
  fledged out prose.


# Our Approach

- I typically include a section outlining the (empirical) approach we
  took, why we studied things the way we did (e.g., important
  operationalizations, key decisions explaining the tradeoffs, etc).


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

- Ideally written in active voice, or one of the totally fine types of
  passive (see https://youtu.be/jstTBXV0cWE?si=QJYpOdV5K5aBWIz-).
  Participants should be the protagonists. Experimenters and software
  can also be active agents. Try to present the procedure
  chronologically, from the participants' POV. Interleave short notes on
  what was counterbalanced OR present those details after the narration
  of the full procedure, if there are many details to report.


## Results

- Present tense for inferential statistics â€“ I use present tense when
  reporting significant findings because they refer to population-level
  inferences, not just our sample's behavior

- Avoid "participants differ" phrasing â€“ For the same reason, I try to
  avoid saying "participants significantly differ," since the test
  concerns the hypothetical population, not our specific sample

- "Significant" qualifies the evidence, not the effect â€“ I write
  "significant evidence that X is higher" rather than "X is
  significantly higher" to emphasize we're describing evidence strength,
  not the effect itself

- Text before statistics â€“ I try to lead with the substantive
  interpretation and finish with the statistical support, rather than
  starting with F-values, or weaving the means throughout.

- Use &eta;~p~^2^  for partial eta squared (avoid special characters and
  rely on pandoc-flavoured markdown to add subscripts and upperscripts;
  avoid latex math, unless presenting an actual formula); &beta; for a
  beta; etc...

- Consider reporting interactions first as the interpretation of main
  effects is qualified by any significant interaction (it's fine to
  report them after the main effects, but if there are relevant
  interactions, it should be made clear, when reporting the effects that
  the main effects are qualified by the interaction).

- Use estimated marginal means (computed from emmeans) to break down
  main effects. Use simple contrasts to break down the interactions (A1
  - A2 at B1; A1 - A2 at B2; B1 - B2 at A1; B1 - B2 at A2).

- When reporting linear mixed models, report their fixed effect
  structure first, then the random effects. State that we used Singmann
  and Kelen's (2029) approach of starting with the maximal model
  warranted by the design, simplifying it only if there are warnings or
  errors in the fitting process.

## Discussion

- Recall the most relevant findings from the results, in less technical
  language and less statistical detail.

- Structure the paragraphs in the most persuasive, natural and clear way
  possible to build the arguments.

- Discussion should be outlined first, and then expanded with my input

- Keep the discussion of each study short if it's a multi-study paper

[Rinse and repeat for Study Y, etc...]


# General Discussion

- Recall the most relevant findings in a way that makes the patterns
  we're highlighting the most clear to readers.

- Discuss limitations, honestly, but don't be afraid to conterargue or
  describe them as tradeoffs that we deemed worth taking, when that's
  the case.

- Discuss strengths, and contributions (theoretical and practical)

- Try to end on a punchy (but backed by data and humble) way


-------------------------------------------------------------------


# THEORETICAL PAPERS

-------------------------------------------------------------------

