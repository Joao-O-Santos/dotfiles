#!/bin/sh
# SPDX-License-Identifier: CC0-1.0

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# gpg-agent reads this path even though the source belongs in the tracked
# dotfiles repository. Back up an existing regular file before linking; never
# touch keys, trust databases, or any other state under ~/.gnupg.
gpg_source="$CONFIG_HOME/gnupg/gpg-agent.conf"
gpg_target="$HOME/.gnupg/gpg-agent.conf"
if [ ! -f "$gpg_source" ]; then
    printf 'GPG agent configuration not found: %s\n' "$gpg_source" >&2
    exit 1
fi
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
if [ -e "$gpg_target" ] && [ ! -L "$gpg_target" ]; then
    gpg_backup="$gpg_target.pre-dotfiles"
    if [ -e "$gpg_backup" ]; then
        printf 'Refusing to replace %s: backup already exists at %s\n' \
            "$gpg_target" "$gpg_backup" >&2
        exit 1
    fi
    mv "$gpg_target" "$gpg_backup"
    printf 'Backed up %s to %s\n' "$gpg_target" "$gpg_backup"
fi
chmod 600 "$gpg_source"
ln -sfn "$gpg_source" "$gpg_target"

ln -s "$CONFIG_HOME/xorg/xinitrc" "$HOME/.xinitrc"
#ln -s "$CONFIG_HOME/shellrc" "$HOME/.profile"
# If using bash
ln -s "$CONFIG_HOME/shellrc" "$HOME/.bashrc"
ln -s "$CONFIG_HOME/shellrc" "$HOME/.bash_profile"
#ln -s $XDG_CONFIG_HOME/firefox/profiles.ini $HOME/.mozilla/firefox/profiles.ini
#ln -s $XDG_CONFIG_HOME/firefox/hardened/user.js $HOME/.mozilla/firefox/hardened/user.js
#ln -s $XDG_CONFIG_HOME/firefox/unsafe/user.js $HOME/.mozilla/firefox/unsafe/user.js
#ln -s $XDG_CONFIG_HOME/firefox/unsafest/user.js $HOME/.mozilla/firefox/unsafest/user.js
#ln -s $XDG_CONFIG_HOME/firefox/pdfviewer/user.js $HOME/.mozilla/firefox/pdfviewer/user.js
#ln -s $XDG_CONFIG_HOME/firefox/comms/user.js $HOME/.mozilla/firefox/comms/user.js
