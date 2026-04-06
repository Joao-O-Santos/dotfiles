---
name: automation-cli
description: Use when automating repetitive shell tasks: document conversion, pipeline runs, draft checks, or new shell scripts on Arch Linux.
---

# Skill: automation-cli

Design small, safe shell workflows for the user's Arch Linux / oksh environment.

## Environment

Shell: oksh (POSIX-compatible); bash also available.
Key helpers already defined in the user's shellrc:

- `twrd <file.md>`  – convert markdown to DOCX via pandoc (warns about lost HTML comments; runs `chkdrft` first)
- `tmd <file>`      – convert any format to markdown via pandoc
- `tpres <file.md>` – build reveal.js HTML slides via pandoc
- `toc <file>`      – extract headings as a table of contents
- `tso <file>`      – extract topic-sentence outline (first line of each paragraph)
- `chkdrft <file>`  – count `CN`, `TODO:`, and `<!--` markers in a draft
- `R`               – aliased to `R --no-save --quiet`

## Design principles

- Compose from existing helpers; do not re-implement what `twrd`, `tmd`, etc. already do.
- Use relative paths; never hard-code `$HOME`.
- Keep commands idempotent.
- Name scripts descriptively; add a one-line comment at the top.
- Prefer simple shell functions or small scripts over complex frameworks.

## Guardrails

- Never suggest `rm -rf` or destructive glob patterns without explicit user consent.
- Check for non-standard tools before using them; suggest installation steps instead.
- Do not modify system configuration outside the project without explicit permission.
