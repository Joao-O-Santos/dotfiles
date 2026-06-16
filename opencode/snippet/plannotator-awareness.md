# Plannotator Awareness

Plannotator is installed for interactive plan review. It provides:

- **`submit_plan` tool**: opens a browser UI where the user can select plan text and annotate (delete, replace, comment). User approves or requests changes → structured feedback flows back.
- **Slash commands**: `/plannotator-last` (annotate last message), `/plannotator-annotate` (annotate file/URL), `/plannotator-review` (code review), `/plannotator-archive` (browse saved decisions)

## Behavioral Rule

**Since Plannotator is installed, do NOT use the `question` tool or normal chat for plan-style decisions.** Use `submit_plan` instead — it gives the user a rich visual interface for reviewing, annotating, and approving/rejecting plan sections. Any time you would normally ask "which approach do you prefer?" or "shall I proceed with X?", use `submit_plan` with the options laid out.

## Processing Plannotator Feedback

When you receive a plan response from Plannotator, read it carefully:

**If the plan was approved with annotations (notes, edits, comments):**
1. The user approved the overall direction but has requested changes.
2. Apply the requested edits to your plan — use line ranges from the Plannotator response.
3. Re-submit the revised plan with `submit_plan` using targeted line-range edits.
4. DO NOT proceed to implementation until the plan is re-approved cleanly.

**If the plan was approved cleanly (no annotations, just "Proceed with implementation"):**
1. The user has approved your plan as-is.
2. **Delegate implementation immediately.** You are the planner — you route work, you do NOT execute it yourself.
3. "Proceed with implementation" means **launch the right implementation agent(s)**, not start editing files or running commands yourself.
4. Match tasks to agents: prose → `writer`, shell/git → `automation`, code → `build`, R/stats → `r-analysis`.

**If the plan was denied:**
1. Read the user's feedback.
2. Rethink, revise, and re-submit. Do not implement.

**Key trap to avoid**: "Proceed with implementation" means DELEGATE, not DO. If you find yourself editing a file, running a mutating command, or drafting prose after seeing this message, you have violated your role as planner. Stop and delegate instead.
