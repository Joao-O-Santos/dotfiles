# Dotfiles

My dotfiles for the programs I use. Updated continuously since 2022.

## Programs Configured

| Program | Config Files | Purpose |
|--------|-------------|---------|
| **ghostty** | `ghostty/config.ghostty` | Terminal emulator |
| **zen** | `zen/profiles.ini`, `zen/installs.ini` | Browser (replaced firefox) |
| **i3** | `i3/config` | Window manager |
| **shell** | `shellrc`, `profile` | Shell config (bash) |
| **git** | `git/config`, `scripts/exclude` | Version control |
| **nvim** | `nvim/init.vim` | Text editor (vim-pandoc, quarto) |
| **pandoc** | `pandoc/docx/word/styles.xml` | Document conversion |
| **R** | `R/Rprofile` | Statistics (browser, packages) |
| **mutt** | `mutt/muttrc` | Mail client |
| **mimeapps** | `mimeapps.list` | Default app associations |
| **xorg** | `xorg/xinitrc` | X11 init |
| **wallpapers** | `wallpapers/` | Desktop backgrounds |
| **opencode** | `opencode/*` | Multi-agent AI system for academic manuscript writing, revision, and review |
| **cortexkit** | `cortexkit/aft.jsonc`, `cortexkit/magic-context.jsonc` | AFT code-analysis plugin and Magic Context session management |
| **scripts** | `scripts/*.sh` | Shell scripts (added to PATH via `shellrc`) |

OpenCode reviewer routing is defined by the tracked agent files and workflow
rules in `opencode/AGENTS.md`. There is no agent-variants or token-monitor
plugin; `reviewer-structure-2` is a supported checkpoint-only agent.

## Versioning

This project uses annotated [semver](https://semver.org/) tags across the
entire repository. The current version is **v8.4.0**. See
[CHANGELOG.md](CHANGELOG.md) for the full release history back to v0.1.0
(2022-03-30).

## Scripts

Standalone shell scripts live in the `scripts/` directory and are added to
`PATH` via `shellrc`. The symlink helper `link_configs.sh` lives at the
repository root.

**Converters:**
- `convert.sh` — Pandoc wrapper for Markdown, HTML, and DOCX output; it uses
  the user's Pandoc configuration and installed custom styles by default

**Literature tools (~/lit):**
- `litindex.sh` — Re-index the literature library (SQLite + FTS5)
- `litsearch.sh` — Full-text search across the literature database
- `litfix.sh` — Manually fix metadata fields (title, year, DOI, author)

**Drafting tools:**
- `chkdrft.sh` — Check drafts for TODOs, missing citations, and unaddressed
  comments
- `toc.sh` — Generate a table of contents from markdown headings
- `tso.sh` — Generate a topic sentence outline from paragraphs

**Utilities:**
- `backup.sh` — Tar backup script
- `f.sh` — Find files by name pattern (ripgrep wrapper)
- `o.sh` — Open files with xdg-open
- `pull_all.sh` — Pull all git repositories under `$HOME`

**Tests:**
- `test_scripts.sh` — Test runner (orchestrates individual test files)
- `test_chkdrft.sh`, `test_toc.sh`, `test_tso.sh` — Per-script unit tests
  (16 tests total, all passing)

## Literature Library

The `~/lit` directory is a separate git repository (independently
version-controlled, not part of this dotfiles repo) containing ~1,500
academic papers organized by topic. It has its own indexing system:

- **SQLite + FTS5 database** — Full-text search across titles, authors, and
  abstracts
- **`litindex.sh`** — Mechanical indexer with 3-strategy DOI extraction
  (PyMuPDF, pdfgrep, pdftotext) and a locked-record flag that preserves
  manually-corrected metadata
- **`litsearch.sh`** — Agent-friendly search tool with FTS5 queries and
  per-directory listing
- **OpenCode integration** — The `literature-reviewer` and `deep-research`
  agents have direct access to the index via lit-index, lit-search, and
  lit-heal skills

## Quick Start

```bash
# Link all config files into place
./link_configs.sh

# For OpenCode Manuscript Workflow:
source opencode/set_models.sh   # set API keys and model environment variables
```

## Changelog

See `CHANGELOG.md` for all changes since 2022.

## Legalities

The files or sets of modifications that I've authored in this project,
if ever considered copyrightable, are hereby licensed under CC0-1.0 (see
`./LICENSES/CC0-1.0`). **You still need to comply with the
original licenses for files others have authored (see table below).**

**WARNING: Some configuration files are the works of other authors and
are under different licenses.** In those cases the original licenses
must be obeyed. This mostly means that if you share those files you must
include the original author's copyright notice and the full text of the
license. The copyright notice is at the top of said files. The full text
for the license is in `./LICENSES/` and is named after the corresponding
spdx license identifier. Below is a table with the files and their
corresponding licenses, please refer to it if the file does not include
an spdx license identifier.

Note that `opencode/skills/review-detail/SKILL.md` adapts the logical
fallacy catalog, bias detection framework, and statistical red flags from
the `scientific-critical-thinking` skill by K-Dense Inc. (MIT License).
The full MIT license text is at `./LICENSES/MIT-K-Dense`.

The opencode config directory contains content adapted from third-party
projects. See `opencode/COPYING.md` for attribution details.

| File                          | SPDX-License-Identifier      |
|-------------------------------|------------------------------|
| `.gitignore`                  | CC0-1.0                      |
| `README.md`                   | CC0-1.0                      |
| `R/Rprofile`                  | GPL-2.0-only or GPL-3.0-only |
| `ghostty/config.ghostty`      | CC0-1.0                      |
| `git/config`                  | CC0-1.0                      |
| `i3/config`                   | BSD-3-Clause                 |
| `link_configs.sh`             | CC0-1.0                      |
| `mimeapps.list`               | CC0-1.0                      |
| `mutt/muttrc`                 | CC0-1.0                      |
| `nvim/init.vim`               | CC0-1.0                      |
| `opencode/skills/review-detail/SKILL.md` | MIT (K-Dense Inc.) |
| `pandoc/docx/word/styles.xml` | CC0-1.0                      |
| `playlist.m3u`                | CC0-1.0                      |
| `profile`                     | CC0-1.0                      |
| `scripts/backup.sh`           | CC0-1.0                      |
| `scripts/chkdrft.sh`          | CC0-1.0                      |
| `scripts/convert.sh`          | CC0-1.0                      |
| `scripts/exclude`             | CC0-1.0                      |
| `scripts/f.sh`                | CC0-1.0                      |
| `scripts/litfix.sh`           | CC0-1.0                      |
| `scripts/litindex.sh`         | CC0-1.0                      |
| `scripts/litsearch.sh`        | CC0-1.0                      |
| `scripts/o.sh`                | CC0-1.0                      |
| `scripts/pull_all.sh`         | CC0-1.0                      |
| `scripts/toc.sh`              | CC0-1.0                      |
| `scripts/tso.sh`              | CC0-1.0                      |
| `scripts/test_chkdrft.sh`     | CC0-1.0                      |
| `scripts/test_scripts.sh`     | CC0-1.0                      |
| `scripts/test_toc.sh`         | CC0-1.0                      |
| `scripts/test_tso.sh`         | CC0-1.0                      |
| `shellrc`                     | CC0-1.0                      |
| `xorg/xinitrc`                | CC0-1.0                      |
| `zen/installs.ini`            | CC0-1.0                      |
| `zen/profiles.ini`            | CC0-1.0                      |

## Author

Joao-O-Santos (joao.filip.oliv.santos94@gmail.com)
