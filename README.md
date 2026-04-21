# Dotfiles

My dotfiles for the programs I use. Updated continuously since 2022.

## Programs Configured

| Program | Config Files | Purpose |
|--------|-------------|---------|
| **i3** | `i3/config` | Window manager |
| **shell** | `shellrc`, `profile` | Shell config (bash/ksh) |
| **git** | `git/config`, `scripts/backup.sh`, `scripts/exclude` | Version control + backups |
| **nvim** | `nvim/init.vim` | Text editor (vim-pandoc, quarto) |
| **pandoc** | `pandoc/docx/word/styles.xml` | Document conversion |
| **firefox** | `firefox/comms/user.js`, `firefox/hardened/user.js`, `firefox/unsafest/user.js`, `firefox/unsafe/user.js`, `firefox/pdfviewer/user.js`, `firefox/profiles.ini` | Browser (comms, hardened, unsafe, unsafest profiles) |
| **R** | `R/Rprofile` | Statistics (browser, packages) |
| **task** | `task/taskrc` | Taskwarrior |
| **bugwarrior** | `bugwarrior/bugwarriorrc` | Task sync (gitlab) |
| **mutt** | `mutt/muttrc` | Mail client |
| **mimeapps** | `mimeapps.list` | Default app associations |
| **xorg** | `xorg/xinitrc` | X11 init |
| **wallpapers** | `wallpapers/WALLPAPERS_GO_HERE` | Desktop backgrounds |
| **opencode** | `opencode/*` | AI scientific-writing and R coding workflow |

## Scripts

- `link_configs.sh` - Symlink helper

## Quick Start

```bash
# Link configs (use link_configs.sh or manual linking)
./link_configs.sh

# Or manually:
ln -s ~/.config/i3 ~/.dotfiles/i3
ln -s ~/.config/shellrc ~/.dotfiles/shellrc
# etc.
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

| File                          | SPDX-License-Identifier      |
|-------------------------------|------------------------------|
| `.gitignore`                  | CC0-1.0                      |
| `R/Rprofile`                  | GPL-2.0-only or GPL-3.0-only |
| `README.md`                   | CC0-1.0                      |
| `firefox/comms/user.js`       | CC0-1.0                      |
| `firefox/hardened/user.js`    | MIT                          |
| `firefox/unsafe/user.js`      | MIT                          |
| `firefox/unsafest/user.js`    | CC0-1.0                      |
| `firefox/pdfviewer/user.js`   | CC0-1.0                      |
| `firefox/profiles.ini`        | CC0-1.0                      |
| `git/config`                  | CC0-1.0                      |
| `i3/config`                   | BSD-3-Clause                 |
| `link_configs.sh`             | CC0-1.0                      |
| `mimeapps.list`               | CC0-1.0                      |
| `mutt/muttrc`                | CC0-1.0                      |
| `nvim/init.vim`               | CC0-1.0                      |
| `pandoc/docx/word/styles.xml` | CC0-1.0                      |
| `playlist.m3u`                | CC0-1.0                      |
| `profile`                     | CC0-1.0                      |
| `scripts/backup.sh`           | CC0-1.0                      |
| `scripts/exclude`             | CC0-1.0                      |
| `shellrc`                     | CC0-1.0                      |
| `task/taskrc`                 | GPL-3.0-only                 |
| `xorg/xinitrc`                | CC0-1.0                      |

## Author

Joao-O-Santos (joao.filip.oliv.santos94@gmail.com)
