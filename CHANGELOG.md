# Changelog — Dotfiles

All notable changes to this dotfiles configuration will be documented in this file.
This project follows [Semantic Versioning](https://semver.org/).

For detailed OpenCode Manuscript Workflow changes, see `opencode/CHANGELOG.md`.


## [v6.9.0] — 2026-06-13

**Script consolidation and smarter chkdrft output.**

### Shell
- Consolidated `tmd.sh`, `tpres.sh`, `twrd.sh` into single `convert.sh` with format options (md, html, docx)
- Shellrc aliases updated: `tmd='convert md'`, `tpres='convert html'`, `twrd='convert docx'`
- `chkdrft.sh` improved: reports each category individually
  - "No citations needed" / "3 citations needed"
  - "No TODOs left" / "2 TODOs left"
  - "No unaddressed comments" / "1 unaddressed comment"
- 16 tests passing across all scripts


## [v6.8.0] — 2026-06-13

**Shell script improvements and test refactoring.**

### Shell
- `chkdrft.sh`: cleaner output when no issues found
- `f.sh`: refactored to use ripgrep (`rg --files --glob`) for faster file searching
- Removed `xst.sh` (obsolete with ghostty terminal)
- Split monolithic `test_scripts.sh` into individual test files (`test_toc.sh`, `test_chkdrft.sh`, `test_tso.sh`)
- `test_scripts.sh` now acts as a test runner


## [v6.7.2] — 2026-06-13

**Fix snippet expansion in CHANGELOGs.**

Removed `#` prefix from snippet references in both CHANGELOG files to prevent automatic expansion when files are read.


## [v6.7.1] — 2026-06-13

**Fix CHANGELOG cross-reference direction.**

The opencode CHANGELOG now stands alone without referencing the top-level dotfiles CHANGELOG. Only the general log references the specific one.


## [v6.7.0] — 2026-06-13

**CHANGELOG refactor by scope.**

Documentation improvements: top-level CHANGELOG organized by semver with full dotfiles history, OpenCode CHANGELOG cleaned up with snippet references instead of inline expansions. Both files now self-contained for their respective scopes.


## [v6.6.0] — 2026-06-13

**Config audit, shell script refactoring, and DRY improvements.**

Comprehensive audit of the OpenCode configuration identified broken references, orphaned files, permission contradictions, and hardcoded paths. All issues fixed. Shell functions extracted into standalone scripts with proper error handling and a 27-test suite.

### OpenCode
- Planner now delegates git commits to automation (cleaner separation of concerns)
- Broken snippet references fixed; missing YAML frontmatter added to skills
- R coding conventions consolidated to single source of truth (`coding_style.md`)
- New shared `reviewer-output-format` snippet eliminates duplication across reviewer agents
- Hardcoded paths parameterized with `$HOME`; magic-context models moved to env vars
- 4 orphaned snippets and redundant `.gitignore` deleted
- See `opencode/CHANGELOG.md` for full details

### Shell
- 10 shell functions extracted from `shellrc` into standalone scripts in `scripts/`:
  `f.sh`, `xst.sh`, `o.sh`, `pull_all.sh`, `toc.sh`, `tso.sh`, `tmd.sh`, `tpres.sh`, `chkdrft.sh`, `twrd.sh`
- All scripts include input validation, usage messages, and error handling
- `shellrc` refactored: scripts directory added to PATH, alias wrappers for shorter commands
- Comprehensive test suite (`scripts/test_scripts.sh`) with 27 tests — all passing


## [v6.5.1] — 2026-06-13

**Documentation sync and environment refinements.**

README comprehensively synced with current config state. Plannotator plugin documented. Magic-context example updated. Model assignments now reference `set_models.sh`.

### OpenCode
- Plannotator plugin documented in README Key Features and plugin example
- `account.json` added to denied files list
- Magic-context config updated (memory block, sidekick block)
- Plannotator data directory environment variable added to shellrc
- r-analysis agent updated in opencode+planner temp config


## [v6.5.0] — 2026-06-11

**Model upgrades, writer autonomy, account.json lockdown.**

Writer empowered with more creative autonomy: WIP specifies paragraph purposes instead of pre-written topic sentences; writer reframed as "prose architect" with creative judgment.

### OpenCode
- Magic Context historian and dreamer models upgraded to `deepseek-v4-pro`
- Model assignments upgraded across agents; temperatures adjusted
- `account.json` added to read/external_directory deny list


## [v6.4.0] — 2026-05-29

**Shell consolidation and Zen browser integration.**

Shell configuration consolidated: `bash_profile` merged into `shellrc`, environment variables moved to `xinit`. R browser and mimeapps updated to use Zen browser. Ghostty tweaked for better workflow.

### Shell
- `bash_profile` merged into `shellrc` — single source for shell configuration
- Environment variables moved to `xinit` for cleaner session startup
- `link_configs` updated for bash

### Desktop
- R browser and mimeapps updated to Zen
- Wallpaper updated
- Ghostty: new splits now open in current working directory

### OpenCode
- PDF tool guidance (`pdftotext`, `pdfgrep`) added to research and automation skills
- Historian/dreamer models bumped to `qwen3.6-plus`


## [v6.3.0] — 2026-04-28

**Revert to bash for shell.**

Reverted from alternative shell back to bash for consistency and compatibility. Shellrc reorganized accordingly.


## [v6.2.0] — 2026-04-26

**Ghostty terminal emulator added.**

Ghostty added as a terminal emulator alongside st. i3 and shellrc updated to support it. npm moved off home directory.

### Desktop
- Ghostty config added
- i3/config updated for ghostty
- shellrc updated for ghostty and npm path cleanup


## [v6.1.0] — 2026-04-24

**Plannotator, snippets DRY, and config consolidation.**

Transformative period for OpenCode: Plannotator plugin added for plan-based decisions, AGENTS.md slimmed from ~183 to ~45 lines via snippet extraction, temperatures and steps limits moved to opencode.json, and `set_models.sh` introduced as canonical model source.

### OpenCode
- Plannotator plugin with `plan-agent` workflow
- AGENTS.md slimmed via snippet extraction; 10+ new shared snippets
- Per-agent `steps` limits for loop prevention
- Temperatures migrated to `opencode.json`
- `set_models.sh` as canonical model source
- See `opencode/CHANGELOG.md` for full details


## [v6.0.0] — 2026-04-23

**BREAKING: MCP integration, Magic Context, Git workflow hardening.**

Four MCP servers configured for academic research. Magic Context plugin installed replacing built-in compaction. Git workflow hardened with explicit commit approval. Critical fix: MCP servers moved from per-agent blocks to top-level `mcp` object.

### OpenCode
- MCP servers: Context7, Citecheck, OpenAlex, Semantic Scholar
- Magic Context plugin (`@cortexkit/opencode-magic-context`)
- Git commit rules: explicit approval required
- `build` agent added
- `gpgwarm` shell alias for GPG agent warm-up
- Editor changed from primary to subagent
- See `opencode/CHANGELOG.md` for full details


## [v5.0.0] — 2026-04-21

**BREAKING: Editor agent and workflow refactor.**

Formalized the Review → Edit → Write pipeline. Editor agent added as dedicated collation agent. Reviewers changed to subagent mode. Writer reframed as instruction-following prose engine. Planner given strict prohibition against prose, file editing, and mutating shell.

### OpenCode
- New `editor` agent for collation
- Reviewers → subagent mode
- Writer reframed as instruction-following prose engine
- Planner: strict non-negotiable prohibition
- `apa7-refs` skill added
- See `opencode/CHANGELOG.md` for full details


## [v4.1.0] — 2026-04-18

**Major manuscript workflow refactor.**

Major architectural shift: paper-type skills replaced with section-based skills. Specialized reviewer agents created for triangulated feedback. opencode-snippets plugin integrated.

### OpenCode
- Section-based skills: intro, lit-review, methods, results, discussion, manuscript-workflow
- Specialized reviewer agents: reviewer-structure, reviewer-detail, copyeditor
- opencode-snippets plugin integration
- Streamlined AGENTS.md and STYLE.md
- Title and abstract skills added
- See `opencode/CHANGELOG.md` for full details


## [v4.0.0] — 2026-04-06

**BREAKING: OpenCode workflow added.**

Multi-agent system for academic manuscript writing first established. This was the most significant addition to the dotfiles project — an entire AI-assisted manuscript workflows system with planner, writer, reviewers, guard, and research agents.

### OpenCode (new)
- Core agents: planner, automation, writer, guard, literature-reviewer, deep-research, r-analysis
- Empirical-paper and theoretical-paper skills
- STYLE.md and AGENTS.md documentation
- Basic opencode.json configuration
- See `opencode/CHANGELOG.md` for full details


## [v3.1.0] — 2026-03-31

**Firefox → Zen browser migration.**

Migrated from Firefox to Zen browser for both i3 config and mimeapps. Zen is a Firefox fork with a more modern UI and better privacy defaults.

### Desktop
- i3/config updated for Zen
- mimeapps.list updated for Zen


## [v3.0.0] — 2026-01-08

**BREAKING: Multi-monitor workspace pinning.**

i3 workspaces pinned to specific monitors: odd workspaces on main monitor, even on secondary. This is a breaking change for anyone used to the previous workspace behavior.

### Desktop
- i3/config: workspace pinning by monitor


## [v2.2.0] — 2025-05-06

**Desktop i3 config and pulseaudio.**

Added a simplified i3 config for the desktop machine, pulseaudio configuration for DAC output, and expanded the radio playlist.

### Desktop
- Simplified i3 config for desktop (i3/config, i3status/config)
- Pulseaudio config added (pulse/daemon.conf)
- Radio playlist updated

### Shell
- DAC output aliases added to shellrc


## [v2.1.0] — 2025-04-17

**Screen capture and editor improvements.**

Screen capture generalized to work with native resolution. Neovim smart tabs plugin replaced. i3bar font size increased.

### Desktop
- Screen capture generalized to work with native res (i3/config)
- i3bar font size increased
- Smart tabs plugin replaced in nvim


## [v2.0.0] — 2024-01-27

**BREAKING: nvim as git difftool and mergetool.**

Neovim configured as the default git difftool and mergetool, replacing the previous defaults. XZ compression memory limit increased. Screen capture without audio alias added.

### Git
- nvim configured as difftool and mergetool (git/config)

### Shell
- XZ memory limit increased (shellrc, scripts/backup.sh)
- Screen capture without audio alias added

### Desktop
- Screenshot hotkey added (i3/config)
- MAKEFLAGS added to profile


## [v1.3.0] — 2023-05-31

**vim-pandoc integration.**

Neovim refactored to use vim-pandoc for markdown/pandoc editing. This provides syntax highlighting, folding, and formatting specifically designed for academic writing.

### Editor
- init.vim refactored to use vim-pandoc
- vim-pandoc config tweaked

### Shell
- `pull_all` function added to update all git repos


## [v1.2.0] — 2023-03-01

**Task management with taskwarrior.**

Taskwarrior (taskrc) added for task management, with bugwarrior integration for importing external todos. TASKDATA environment variable added to shellrc.

### New
- taskrc configuration
- TASKDATA and TASKRC environment variables in shellrc
- Bugwarrior labels configuration

### Desktop
- New task context and i3 keybindings


## [v1.1.0] — 2022-07-25

**GPG/SSH setup and directory aliases.**

GPG and SSH agent configuration added to shellrc. Directory aliases extracted to their own script for portability.

### Shell
- GPG, SSH, and directory aliases added to shellrc
- dir_aliases extracted to separate script

### Firefox
- Firefox-view disabled in configs


## [v1.0.0] — 2022-04-05

**First stable release.**

Neovim configuration added. Firefox user.js hardened. Backup scripts created. i3status refactored. This marks the point where the dotfiles are considered stable for daily use.

### New
- Neovim configuration (init.vim)
- Firefox user.js hardening
- Tar backup script
- i3status refactored

### Desktop
- i3 resize increments reduced (100px → 50px)
- Profile and xinitrc links added


## [v0.1.0] — 2022-03-30

**Initial development release.**

First tracked version of the dotfiles. Core configuration for shell, git, i3, R, and pandoc established.

### New
- Shell configuration (shellrc)
- Git configuration (git/config)
- i3 window manager configuration (i3/config, i3status/config)
- R profile (Rprofile)
- Pandoc APA styles draft
- MIME apps and radio playlist
- LICENSES directory
