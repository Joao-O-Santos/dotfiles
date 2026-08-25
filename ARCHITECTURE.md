# Architecture

## Pattern Overview

**Overall:** An XDG-oriented dotfiles repository with shell utilities,
application-native configuration, and a Pi Sych supervisor overlay.

**Key characteristics:**
- Keep application configuration in its program-specific directory and link
  only shell and X11 entry files with `link_configs.sh`.
- Keep reusable command-line behavior in `scripts/`; invoke scripts from
  `shellrc` aliases and functions rather than duplicating implementations.
- Load Pi Sych and Pi Auch from npm through `pi/settings.json`; keep
  credentials and runtime state outside tracked files.
- Keep shared MCP configuration secret-free and load credentials only in the
  Pi child process.

## Layers

**Session and shell bootstrap:**
- Purpose: Establish XDG locations, interactive-shell behavior, editor and
  GPG settings, aliases, and user-facing command helpers.
- Location: `profile`, `shellrc`, and `link_configs.sh`.
- Used by: Login and interactive Bash sessions.

**Application configuration:**
- Purpose: Configure desktop, terminal, browser, mail, Git, R, Neovim,
  Pandoc, and related applications.
- Location: Program-specific directories at the repository root.
- Used by: Each application's normal startup path.

**Scripted utilities and conversion:**
- Purpose: Provide reusable shell commands for draft checking, conversion,
  literature maintenance, navigation, backups, and related automation.
- Location: `scripts/`.
- Used by: `shellrc` and direct user invocation.

**Pi Sych supervisor:**
- Purpose: Keep project state, evidence, decisions, verification, and bounded
  worker dispatch visible and reviewable.
- Location: `pi/`.
- Contains: Pi settings, supervisor instructions, Pi Sych runtime
  configuration, a worker model catalog, private skills, and secret-free
  documentation.
- Depends on: Pi, the npm `pi-sych` package, the `pi-auch` quota extension,
  and optional configured MCP servers.
- Used by: Pi sessions launched with `pi`.

**MCP configuration:**
- Purpose: Declare intended shared MCP services without tracking secrets.
- Location: `mcp/mcp.json` and `mcp/README.md`.
- Credentials: Loaded from ignored local files only for the Pi child process.

## Data Flow

**Interactive shell startup:**

1. The login environment points `ENV` at `shellrc` through `profile`.
2. `shellrc` establishes XDG paths and interactive-shell state.
3. The `pi` wrapper loads ignored local credentials only in its child process,
   then invokes Pi.

**Pi Sych workflow:**

1. Pi loads `pi/settings.json`, including `npm:pi-sych` and `npm:pi-auch`.
2. Pi Sych reads `pi/pi-sych/config.json` for its worker, compaction, MCP,
   and review settings.
3. The supervisor reads repository project state and applies
   `pi/AGENTS.md` policy.
4. For bounded work, the supervisor selects a model from
   `pi/pi-sych/models.json`. Luna is the routine workhorse; Claude is
   reserved primarily for scientific writing and review, and Kimi provides
   a selective independent perspective.
5. Consequential changes require explicit human review of a submitted plan;
   executable checks are recorded only when actually run.

**Draft-to-DOCX conversion:**

1. Validate the requested format, input, output collision, dependencies, and
   required local scripts in `scripts/convert.sh`.
2. For DOCX output, report unresolved citations, TODOs, and HTML comments in
   `scripts/chkdrft.sh` before rendering.
3. Render with Pandoc and the APA table filter, which formats header and body
   cells according to the configured rules.

## Entry Points

**Shell session:** `profile` and `shellrc` establish the environment and
command helpers.

**Pi workbench:** `pi/settings.json` loads Pi Sych; `pi/AGENTS.md` supplies
the supervisor instruction overlay.

**Configuration linker:** `link_configs.sh` links X11 and Bash entry files
into the user's home directory.

**Script tests:** `scripts/test_scripts.sh` runs shell-utility regression
suites.

## Cross-Cutting Concerns

**Secrets:** Tracked configuration names required environment variables but
does not store their values. `.gitignore` excludes Pi credentials, package
installs, sessions, and runtime state.

**Verification:** Shell utilities validate inputs and dependencies before
expensive or destructive work. Pi Sych records actual declared verification
rather than inferring it from model output.

**Storage:** Dotfiles live under XDG configuration paths. The external
`~/lit` library stores literature data independently of this repository.
