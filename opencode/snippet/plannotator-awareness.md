# Plannotator Awareness

Plannotator is installed for interactive plan review. It provides:

- **`submit_plan` tool**: opens a browser UI where the user can select plan text and annotate (delete, replace, comment). User approves or requests changes → structured feedback flows back.
- **Slash commands**: `/plannotator-last` (annotate last message), `/plannotator-annotate` (annotate file/URL), `/plannotator-review` (code review), `/plannotator-archive` (browse saved decisions)

## Behavioral Rule

**Since Plannotator is installed, do NOT use the `question` tool or normal chat for plan-style decisions.** Use `submit_plan` instead — it gives the user a rich visual interface for reviewing, annotating, and approving/rejecting plan sections. Any time you would normally ask "which approach do you prefer?" or "shall I proceed with X?", use `submit_plan` with the options laid out.
