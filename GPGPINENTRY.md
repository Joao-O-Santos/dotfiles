# GPG Pinentry Configuration for Non-Blocking Password Input

## Problem

By default, GPG pinentry prompts for a passphrase in whichever terminal
initiated the request (via `GPG_TTY`). During Pi agent work this blocks that
terminal until a password is typed, stalling any agent or script waiting on
the same `git commit`, `git push`, or SSH operation.

## Solution

Configure `gpg-agent` to use a **GUI pinentry** program that pops up in its
own window instead of prompting in the terminal, and make the shell only
fall back to terminal-based pinentry when no graphical display is available.

```
Recommended priority order:
  1. pinentry-gnome3   (GUI window, works well under X11 and Wayland)
  2. pinentry-qt       (GUI window, Qt/KDE environments)
  3. pinentry-curses   (terminal-based fallback, needs a real TTY and
                        GPG_TTY set; blocks that terminal, use only when
                        no GUI is available)
```

On Arch Linux, the `pinentry-gnome3`, `pinentry-qt`, and `pinentry-curses`
binaries all ship inside the single `core/pinentry` package (already
installed on most systems: `pacman -Qi pinentry`). There is no separate
`pinentry-gtk2` package on current Arch; the setup script still tries that
name for compatibility with other distributions that do package it
separately.

## Critical detail: config file location

`gpg-agent` reads `~/.gnupg/gpg-agent.conf` by default. It does **not**
respect `XDG_CONFIG_HOME` unless `GNUPGHOME` is explicitly set to point
elsewhere. Writing configuration under `~/.config/.gnupg/` (or any other XDG
path) has no effect unless you also export `GNUPGHOME` to match. This
dotfiles setup does not set `GNUPGHOME`, so:

- `scripts/setup-gpg-pinentry.sh` writes only to `~/.gnupg/gpg-agent.conf`.
- Do not create or rely on `~/.config/.gnupg/`; it is not read by `gpg-agent`.

## Dependency gotcha: GUI pinentry binaries that fail silently

`pinentry-gnome3` and `pinentry-qt` can be present and executable but still
fail at runtime with a missing shared-library error if their GUI toolkit
dependency isn't installed, for example:

```
pinentry-gnome3: error while loading shared libraries: libgcr-base-3.so.1
pinentry-qt:     error while loading shared libraries: libKF6WindowSystem.so.6
```

On Arch, install the missing library packages:

```bash
sudo pacman -S gcr            # provides libgcr-base-3.so.1, for pinentry-gnome3
sudo pacman -S kwindowsystem  # provides libKF6WindowSystem.so.6, for pinentry-qt
```

`scripts/setup-gpg-pinentry.sh` checks that the chosen pinentry binary can
actually run (`pinentry --version`) before writing it into the
configuration, and its `--auto` mode skips any candidate that exists but
fails to execute.

## Core configuration: `~/.gnupg/gpg-agent.conf`

```bash
pinentry-program /usr/bin/pinentry-gnome3
max-cache-ttl 34560
default-cache-ttl 34560
enable-ssh-support
allow-loopback-pinentry
```

- `max-cache-ttl` / `default-cache-ttl`: 34560 seconds (~9.6 hours) so a
  passphrase entered once covers a long Pi working session.
- `enable-ssh-support`: shares the same agent (and pinentry) for SSH
  authentication, see the SSH section below.
- `allow-loopback-pinentry`: permits `--pinentry-mode loopback` for
  scripted/non-interactive testing; it does not disable the normal GUI
  prompt for ordinary use.

## Shell environment: `shellrc`

`shellrc` detects whether a graphical display is available and only sets
`GPG_TTY` (which forces terminal-based prompting) when it isn't:

```bash
if [[ $- == *i* ]] && [[ -t 0 || -t 1 || -t 2 ]]; then
    if [[ -n "$DISPLAY" || -n "$WAYLAND_DISPLAY" ]]; then
        # GUI mode: let gpg-agent's configured GUI pinentry handle prompts
        unset GPG_TTY
        gpg-connect-agent --quiet /bye >/dev/null 2>&1 || :
    else
        # Headless mode: fall back to terminal pinentry
        export GPG_TTY="$(tty)"
        gpg-connect-agent --quiet updatestartuptty /bye >/dev/null 2>&1 || :
    fi
fi
```

If you deliberately want `pinentry-curses` instead of a GUI pinentry, this
logic works against you: with `DISPLAY` set it unsets `GPG_TTY`, and
`pinentry-curses` needs `GPG_TTY` pointed at a real, ioctl-capable TTY to
avoid an `Inappropriate ioctl for device` failure. Prefer the GUI path for
Pi workflows; only switch to curses if no working GUI pinentry is available.

## Setup script: `scripts/setup-gpg-pinentry.sh`

Automates the steps above:

```bash
setup-gpg-pinentry.sh --auto      # detect a working pinentry and configure it
setup-gpg-pinentry.sh --gnome3    # force pinentry-gnome3
setup-gpg-pinentry.sh --qt        # force pinentry-qt
setup-gpg-pinentry.sh --gtk2      # force pinentry-gtk2 (non-Arch distros)
setup-gpg-pinentry.sh --kde       # force pinentry-kde
gpgsetup                          # shellrc alias for --auto
```

It writes `~/.gnupg/gpg-agent.conf` (mode `600`), restarts `gpg-agent`, and
runs a signing test.

## Installation walkthrough

```bash
# 1. Install the pinentry package (Arch ships all frontends in one package)
sudo pacman -S pinentry
# Debian/Ubuntu:
sudo apt install pinentry-gnome3
# Fedora:
sudo dnf install pinentry-gtk

# 2. If gnome3/qt fail with a missing shared-library error, install the
#    matching dependency (see "Dependency gotcha" above), e.g. on Arch:
sudo pacman -S gcr kwindowsystem

# 3. Run the setup script
cd ~/.config
./scripts/setup-gpg-pinentry.sh --auto
# or: gpgsetup

# 4. Test signing (should open a GUI dialog, not block the terminal)
echo "test" | gpg --clearsign -o /dev/null

# 5. Test with git
git commit --allow-empty -m "Test signed commit"
```

## SSH integration

`enable-ssh-support` makes the same `gpg-agent` (and the same pinentry
configuration) serve SSH authentication requests through
`SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh` (already exported in
`shellrc`). This was verified working end to end:

```bash
gpg-connect-agent 'KEYINFO --ssh-list' /bye   # lists keys known to the agent
ssh-add -l                                    # lists SSH-usable keys from the agent
```

When an SSH operation needs a passphrase (first use, or after cache
expiry), it triggers the **same** GUI pinentry dialog as GPG signing — no
separate SSH-specific pinentry configuration is required.

## Pi agent workflows

Pre-warm the passphrase cache before dispatching agents, so a mid-session
commit or push does not need an interactive prompt at all:

```bash
gpgwarm   # echo test | gpg --clearsign -o /dev/null; caches the passphrase
pi        # agents can now sign commits without blocking the terminal
```

If GPG signing is genuinely unavailable for a session and blocking commits
is unacceptable, disable signing for that invocation only rather than
leaving it silently unsigned long-term:

```bash
GIT_COMMIT_GPG_SIGN=false pi
```

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `Operation cancelled` with `PINENTRY_LAUNCHED ... tty ...` | `gpg-agent.conf` still points at `pinentry-tty`/curses while you expect GUI | Re-run `setup-gpg-pinentry.sh --auto`; confirm `~/.gnupg/gpg-agent.conf` (not `~/.config/.gnupg/...`) has the GUI `pinentry-program` |
| `error while loading shared libraries: libgcr-base-3.so.1` | `pinentry-gnome3` present but `gcr` not installed | `sudo pacman -S gcr` |
| `error while loading shared libraries: libKF6WindowSystem.so.6` | `pinentry-qt` present but `kwindowsystem` not installed | `sudo pacman -S kwindowsystem` |
| `Inappropriate ioctl for device` | Using `pinentry-curses` without a valid `GPG_TTY` pointed at a real TTY | Either switch to a GUI pinentry (recommended), or `export GPG_TTY=$(tty)` and restart the agent before signing |
| Config edits seem to have no effect | Edited `~/.config/.gnupg/gpg-agent.conf` instead of `~/.gnupg/gpg-agent.conf` | `gpg-agent` ignores the XDG path unless `GNUPGHOME` is set; edit `~/.gnupg/gpg-agent.conf` |
| GUI dialog never appears | No `DISPLAY`/`WAYLAND_DISPLAY` in the shell that started the agent | Check `echo $DISPLAY`; restart the agent from a session that has it: `gpgconf --kill gpg-agent && gpg-connect-agent --quiet /bye` |
| Re-prompted too often | Cache TTL too short | Increase `max-cache-ttl` / `default-cache-ttl` in `~/.gnupg/gpg-agent.conf` |

## Verification checklist

- [ ] `~/.gnupg/gpg-agent.conf` exists, mode `600`, `pinentry-program` points
      at a binary that runs (`<path> --version` succeeds)
- [ ] `gpgconf --kill gpg-agent && gpg-connect-agent --quiet /bye` succeeds
- [ ] `echo test | gpg --clearsign -o /dev/null` opens a GUI dialog and does
      not block the terminal
- [ ] `git commit --allow-empty -m test` succeeds without a terminal prompt
- [ ] `ssh-add -l` lists the expected key(s) via the GPG agent's SSH socket
- [ ] `gpgwarm` caches the passphrase so a following `pi` session's commits
      do not prompt again within the cache TTL

## References

- GnuPG Manual: https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
- Arch Wiki GnuPG: https://wiki.archlinux.org/title/GnuPG
