# Codebase Structure

## Directory Layout

```
[project-root]/
├── R/                    # R startup configuration
├── LICENSES/             # License texts for tracked material
├── environment.d/        # Session environment configuration
├── ghostty/              # Terminal emulator configuration
├── git/                  # Git configuration
├── i3/                   # Window-manager configuration
├── mcp/                  # Shared MCP configuration
├── nvim/                 # Neovim, Quarto, and LSP setup
├── pandoc/               # DOCX style assets and Lua filters
├── pi/                   # Pi Sych supervisor overlay
├── scripts/              # Executable utilities and shell regression tests
├── xorg/                 # X11 session startup configuration
├── link_configs.sh       # Home-directory symlink helper
├── profile               # POSIX profile entry configuration
└── shellrc               # Interactive Bash configuration and command entrypoints
```

Other root-level directories hold configuration or assets for their named
application. Keep their native format and let the owning application load
them directly.

## Directory Purposes

**`pi/`:**
- Purpose: Configure the Pi Sych supervisor and private local preferences.
- Contains: Pi settings, supervisor instructions, Pi Sych runtime
  configuration, model catalog, private skills, and secret-free
  documentation.
- Key files: `pi/settings.json`, `pi/AGENTS.md`,
  `pi/pi-sych/config.json`, and `pi/pi-sych/models.json`.
- Pi Sych and Pi Auch are loaded from npm; credentials, installed packages,
  and runtime state remain ignored.

**`mcp/`:**
- Purpose: Keep shared MCP server configuration separate from credentials.
- Contains: The MCP configuration and usage documentation.
- Key files: `mcp/mcp.json`, `mcp/README.md`.

**`nvim/`:**
- Purpose: Configure editing, Markdown/Quarto support, completion, and R LSP.
- Contains: Vimscript, Lua modules, and headless startup tests.
- Key files: `nvim/init.vim`, `nvim/lua/quarto_setup.lua`,
  `nvim/tests/quarto-startup.sh`.

**`pandoc/`:**
- Purpose: Hold document-conversion assets.
- Contains: Word style assets and Lua filters.
- Key files: `pandoc/filters/apa-tables.lua`,
  `pandoc/docx/word/styles.xml`.

**`scripts/`:**
- Purpose: Provide reusable shell utilities and regression coverage.
- Contains: Executable Bash commands and `test_*.sh` scripts.
- Key files: `scripts/convert.sh`, `scripts/chkdrft.sh`,
  `scripts/test_scripts.sh`, `scripts/test_apa_tables.sh`.

## Key File Locations

**Shell entry points:** `profile` selects `shellrc`; `shellrc` establishes the
interactive environment, aliases, and helper functions.

**Pi supervisor:** `pi/settings.json` loads the npm Pi Sych and Pi Auch
packages; `pi/AGENTS.md` provides supervisor policy;
`pi/pi-sych/config.json` configures the workbench; and
`pi/pi-sych/models.json` provides the user-ranked worker catalog.

**Configuration linker:** `link_configs.sh` links shell and X11 entry files
into the home directory.

**Core document conversion:** `scripts/convert.sh` validates and dispatches
Pandoc conversion; `pandoc/filters/apa-tables.lua` supplies DOCX table
alignment and header styling.

**Tests:** Run `scripts/test_scripts.sh` for shell utilities and
`nvim/tests/quarto-startup.sh` for a headless Neovim startup check.

## Naming Conventions

**Shell utilities:** lowercase Bash filenames; preserve underscores where
established, for example `scripts/pull_all.sh`.

**Shell tests:** prefix test scripts with `test_`.

**Pi skills:** lowercase hyphenated directories with `SKILL.md` as the primary
instruction file.

## Where to Add New Code

**New application configuration:** Create or extend the named application
directory at the repository root; preserve the application's native format.

**New shell utility:** Add `scripts/<name>.sh`, make it executable, expose it
from `shellrc` only when a short interactive alias or wrapper is needed, and
add `scripts/test_<name>.sh` when behavior is testable.

**New Pandoc transformation:** Add `pandoc/filters/<name>.lua`; invoke it from
`scripts/convert.sh` only after validating its presence and add a focused
regression test in `scripts/`.

**New Pi skill:** Add `pi/skills/<skill-name>/SKILL.md`. Keep private
credentials and personal examples out of tracked files.
