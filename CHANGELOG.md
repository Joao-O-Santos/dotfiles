# Changelog

All notable changes to this dotfiles configuration will be documented in this file.

## [Unreleased]

## 2026-04-21

- agents: update roster - reviewers to subagent, add editor primary
- agents: add editor agent - collates and sorts reviewer output
- planner: add non-negotiable prohibition, WIP spec, review pipeline
- writer: reframe as instruction-following prose engine
- reviewers: update collaboration rules for subagent mode
- opencode.json: reviewers to subagent, add editor, planner read-only bash
- snippets: add agent-anti-fabrication-notice and reviewer-collaboration-rules
- agents: refactor to use snippets for anti-fab notice and collaboration rules
- revert: undo snippet usage, restore verbatim text in agents
- fix: editor remove task perm, add read-for-context snippet, fix collaboration
- fix: add input handling to pipeline, fix editor description, clarify skill loading
- fix: writer skill loading, remove orchestration from editor, clean up WIP fields
- docs: update CHANGELOG and README for editor agent refactor
- Fix mimo slug
- update agent models to use opencode/* versions
- Update playlist (6 stations removed)

## 2026-04-19

- refactor: shared snippets, skill edits, agent/skill renames

## 2026-04-18

- Refactor OpenCode Manuscript Workflow: replace paper-type skills with section skills, create specialized reviewer agents, integrate opencode-snippets, optimize model assignments, and streamline configuration files
- Add tui.json for snippets plugin
- Add README.md and CHANGELOG.md documentation; clean up cache/temp files while preserving directory structure
- Add title and abstract skills for manuscript workflow enhancement
- Update title skill with real examples from examples.md
- Update examples in title skill
- Remove useless fallback parameters
- Update models

## 2026-04-17

- Update refs to files with explicit paths (opencode config files)
- Update playlist (21 stations added, 69 removed)
- Refactor opencode config (AGENTS.md, STYLE.md, reviewer.md, opencode.json - 213 insertions, 233 deletions)
- Yet another refactor (16 files changed across opencode agents, skills, and shellrc)

## 2026-04-16

- Fix opencode (STYLE.md, planner.md, opencode.json - 42 insertions, 26 deletions)

## 2026-04-14

- Continue updating opencode.json
- Refactor model providers: HuggingFace → OpenCode Go + Zen + OpenRouter

## 2026-04-10

- Remove useless lock file
- Git ignore package-lock file

## 2026-04-08

- Update opencode config
- Update opencode workflow

## 2026-04-07

- Update opencode config

## 2026-04-06

- Add opencode workflow files
- Consolidate OpenCode config: primary automation agent, deep-research subagent, fix model conflicts and fallbacks, OpenCode-first quota strategy
- Fix critical bugs and structural issues from workflow critique

## 2026-03-31

- Update playlist
- Move from firefox to zen (i3/config, mimeapps.list)

## 2026-01-08

- Pin odd workspaces to main monitor and even to secondary (i3/config)

## 2025-10-25

- Remove pulseaudio conf (94 lines deleted) + change dac in shellrc

## 2025-09-26

- Add ecampus and pad to work tabs (i3/config)

## 2025-09-19

- Update neovim config (init.vim)
- Add mimeapps.list association (3 lines added)
- Move mash radio to top of playlist

## 2025-07-28

- Use us altgr-intl layout (i3/config, shellrc)
- Update radio playlist
- Attempt to get nvim to work well with quarto (init.vim tweaks)

## 2025-05-26

- Change recording resolution and fps (shellrc ffmpeg settings)

## 2025-05-12

- Add and remove radios
- Merge branch 'main' into desktop

## 2025-05-10

- Merge branch 'main' into desktop

## 2025-05-09

- Fix radio links

## 2025-05-06

- Add pulseaudio config (pulse/daemon.conf - 92 lines added)
- Update radio list
- Add simplified i3 config for desktop (i3/config, i3status/config)

## 2025-04-17

- Replace plugin that controls smart tabs (nvim/init.vim)
- Increase font size in i3bar (i3/config)
- Generalize screen capture to work with native res

## 2025-01-16

- Make ffmpeg screen capture size agnostic (i3/config)

## 2025-01-13

- Replace mod+t shortcut (i3/config)

## 2024-10-28

- Disable vim-pandoc-syntax for rmd and pandoc

## 2024-10-09

- Update pandoc word styles
- Update unsafest user.js

## 2024-07-06

- Add git alias for graphical logs (git/config, scripts/exclude)

## 2024-07-01

- Increase ram limit for compressing backup

## 2024-06-21

- Add muttrc (mail config)

## 2024-05-23

- Teach pull_all to run from HOME
- Remove LimeLight + custom colorscheme

## 2024-05-14

- Update radio playlist
- Stop automatically enabling limelight with goyo

## 2024-04-11

- Improve radio and dacmpv (shellrc tweaks)
- Use base firefox profile for comms
- Reconfigure nvim for writing

## 2024-03-07

- Switch to firefox for comms as well

## 2024-02-22

- Add MAKEFLAGS to profile (shellrc)
- Add screenshot hotkey (i3/config)
- Rename Bibliography References but keep alias
- Add Rock station to playlist (3 lines added)

## 2024-01-27

- Add nvim as git difftool and mergetool (git/config)
- Allow xz to use more memory (shellrc, scripts/backup.sh)
- Add alias to screen capture without audio

## 2023-10-05

- Disable fancy lists + Get bold table headers in docx

## 2023-09-29

- Update git config

## 2023-09-08

- Report correct user agent even in hardened
- Report Linux user-agent in unsafe as well

## 2023-09-01

- Add spotify to unsafe keybind

## 2023-07-17

- Refactor chkdrft function/awk script

## 2023-06-07

- Add alias for keyboard config

## 2023-05-31

- Refactor init.vim to use vim-pandoc
- Tweak vim-pandoc config

## 2023-05-23

- Add function to update all git repos

## 2023-05-03

- Update submodule handling in git config

## 2023-03-03

- Define new context for task + new bindings in i3 (taskrc, i3/config)

## 2023-03-02

- Import gitlab todos with bugwarrior
- Refactor shellrc
- Revert "Import gitlab todos with bugwarrior"

## 2023-03-01

- Add TASKDATA to shellrc + labels to bugwarrior
- Add taskrc
- Add license for taskrc
- Add copyright info to taskrc

## 2023-02-23

- Add TASKDATA to shellrc + labels to bugwarrior

## 2023-02-20

- Restore desktop record profile

## 2023-02-07

- Ignore rsconnect config

## 2022-12-19

- Start setting up task+bugwarrior
- Fix bugwarriorrc config

## 2022-12-10

- Add Heading 5 style to pandoc

## 2022-10-22

- Fix sourcing with ksh in shellrc (5 insertions, 1 deletion)

## 2022-10-21

- Move dir_aliases to their own script (shellrc)

## 2022-10-19

- Update firefox configs to disable firefox-view

## 2022-09-27

- Update shortcuts
- Update git config

## 2022-07-27

- ffmpeg recording settings for desktop

## 2022-07-25

- Add gpg, ssh, and dir aliases to shellrc (11 insertions, 4 deletions)

## 2022-06-23

- Take no chances with Rprofile licensing

## 2022-06-09

- Add nvim options for yaml

## 2022-05-25

- Remove needless clear alias

## 2022-04-13

- Add thesis to shell aliases

## 2022-04-11

- Set unsafest as R's browser + slow ffpmeg preset

## 2022-04-08

- Add verbatim char style to pandoc/docx

## 2022-04-07

- Fix "Body Text" style in pandoc docx
- Add title,block quotes, and bib to pandoc/docx

## 2022-04-05

- Add nvim config

## 2022-04-04

- Add actual user.js in firefox + refactor i3status (2547 lines added to firefox configs)
- Add links to profile and xinitrc
- Make i3 to resize in smaller increments (from 100px to 50px)
- Fix firefox/unsafe cookie policy
- Revert cookie policy for unsafe
- Add tar backup script
- Refactor backup script

## 2022-04-02

- Add table with file-licenses

## 2022-04-01

- Add LICENSES, README, firefox + make some tweaks
- Fix README type, add more exceptions to .gitignore
- Try to prevent misinterpretation of README

## 2022-03-30

- Add more dotfiles (git/config, i3/config, i3status/config, shellrc, Rprofile - 395 lines added)
- Add mime (i.e., default) apps + radio playlist
- Make minor tweaks to shellrc (cleanup, 2 insertions, 5 deletions)

## 2022-03-29

- Initial commit: pandoc apa styles draft