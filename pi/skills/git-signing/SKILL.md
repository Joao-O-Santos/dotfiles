---
name: git-signing
description: Private user workflow for GPG-signed Git commits. Warm the agent outside Pi before the first signed commit of a session; never run interactive pinentry inside the agent.
---

# Private GPG signing workflow

This skill is user-owned and is not part of the pi-sych package. It describes
how this machine signs Git history. Do not put passphrases, key material, or
pinentry interaction into agent commands.

## Current configuration

- `commit.gpgsign` is enabled.
- Signing key: `1AEA77B0D5CE5C44!`
- Prefer the user's ordinary Git config; do not invent alternate keys or disable
  signing unless the user explicitly requests it.

## Warm-up

Before the first signed commit of a session, the GPG agent may need unlocking
in a separate interactive terminal:

```bash
gpgwarm
```

Agents must never run `gpgwarm` or any other interactive pinentry command.
Those prompts hang inside agent shells.

## First-commit-of-session protocol

1. If this may be the first signed commit of the session, ask the user to run
   `gpgwarm` in another terminal and confirm when done.
2. Wait for confirmation.
3. Proceed with the ordinary signed `git commit`.
4. After one successful commit in the session, further commits may proceed
   without repeating the warm-up unless a later signing failure shows the agent
   locked again.

## Commands that may need a warm agent

Any command that creates a signed commit object can need the warm-up, including
`git commit`, merge commits, `git cherry-pick`, `git revert`, and `git am` when
signing is enabled.

## Boundaries

- Still follow `git-workflow`: no push, publish, rewrite of shared history, or
  remote changes without explicit instruction.
- Never disable `commit.gpgsign` to bypass a locked agent.
- Never print, copy, or request private key material.

## Optional user examples

If `~/.config/pi/skills/git-signing/examples.md` exists, read it before applying this skill. Use it as illustrative preference, not as evidence or project requirements.
