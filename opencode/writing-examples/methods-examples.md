<!-- Example: Methods Task Description -->

The examples above demonstrate form, style, and structure. Their content and topics are for illustration only—do not copy substance into your writing.

# Methods — Describing a Behavioral Task

**Source**: Published paper (2015). Learning to Represent Exact Numbers.
**Skill**: `methods`
**Pattern**: Task introduction → operational description → concrete vignette → conceptual insight

One task that demonstrates this gap is the Give-N task, which I will describe here because
it appears in many of the studies discussed below. (The task is also sometimes called 'Give-A-Number,'
'Give-X,' or the 'verbal production task.') In this task, the child is asked to generate
sets of a particular number. For example, the child might be given a bowl of 15 small plastic
apples, and asked to 'Give one apple to the frog,' 'Give two apples to the frog,' 'Give five apples
to the frog,' and so on. Children's performance on this task reveals an interesting gap between
knowledge of counting (in the sense of being able to recite the list of words while pointing to
objects) and knowledge of the cardinality principle (i.e., the principle that says the last word of a
count tells the numerosity of the whole set.)

Although many 2–4-year-olds can recite the beginning of this and point to objects just
fine (e.g., when asked to count a row of apples, they say "one, two, three, four, five, six" while
pointing to each apple in turn), they may be unable to 'Give six apples to the frog' when asked.
Instead of counting (i.e., instead of reciting the number list up to six while adding one apple to
the set with each word), they just grab a handful of apples and hand them to the frog.

Typically, the scene looks something like this. The child is asked to give six apples to the
frog, and scoops up two handfuls of apples (which happens to be eight), dumping them on the
frog's plate. The experimenter asks, "Is that six?" to which the child nods happily.
The experimenter says, "Can you count and make sure it's six?"
The child points to each apple in turn, reciting, "One, two, three, four, five, six, seven, eight."
The experimenter says, "So, is that six?"
The child nods again.
The experimenter says, "Hmm. I don't think that's six. And the frog really wanted six
apples. Can you fix it so there's six?"
The child grabs more apples and adds them to the plate.

In other words, there is a noticeable gap between children's (early) learning of how to
recite the counting list and point to objects, and their (later) conceptual understanding of how
counting relates to cardinal numerosity.

---

<!-- Example: Data Analysis Approach -->

The examples above demonstrate form, style, and structure. Their content and topics are for illustration only—do not copy substance into your writing.

# Data Analysis Approach — Statistical Philosophy (User's Voice)

**Source**: PhD thesis (2024).
**Skill**: `methods`
**Key patterns**: afex + emmeans pipeline, robust alternatives, DevOps for reproducibility

I relied on the afex package (Singmann et al., 2023) to compute all the ANOVAs and
mixed models. The objects returned by afex are compatible with the functions from the emmeans
package (Lenth, 2023), which streamlines the computation of estimated marginal means and
contrasts. To compute partial eta squares for mixed effects models, I leveraged the eta_squared()
function from the effectsize package (Ben-Shachar et al., 2020; Ben-Shachar et al., 2023). The
computation of mixed models was sometimes parallelized across processors, using the parallel
package (R Core Team, 2023) in tandem with afex. It is worth noting that afex itself relies on car
(Fox & Weisberg, 2019; Fox et al., 2023), lme4 (Bates et al., 2015; 2023), and lmerTest
(Kuznetsova et al., 2017; 2020). I also used WRS2 (Mair & Wilcox, 2020; 2022) and robustlmm
(Koller, 2016; 2023) to compute robust alternatives to ANOVA and linear mixed effects models,
respectively. The tidyr package (Wickham & Girlich, 2022; Wickham et al., 2024) allowed me to
(re)format data from/into the long/wide format as needed.

[...]

To ensure replicability and transparency, I leveraged computer tooling used by
programmers, and companies, who adopt DevOps (developer operations) practices. These
practices help ensure that, for each project, all dependencies and system requirements are
formally specified in a replicable way. [...] GitLab specifically allowed me
to specify all the system requirements and project dependencies needed to run my scripts,
compile the statistical reports, and render drafts of the thesis in different formats (e.g., DOCX,
PDF). This ensures my analyses are replicable, given they have been shown to work in GitLab's
servers/cloud. [...] I was also deliberate in
ensuring the Docker container was based on a Linux distribution (in this case Debian testing),
other than the one I use on my machines (I use Arch Linux myself). This proves the analysis can
be replicated in a different software environment, as long as they follow the specification.
