#!/bin/sh
# SPDX-License-Identifier: CC0-1.0
su -s /bin/sh -c '
    cd "$1" || exit 1
    if [ -e bp.tar ] || [ -e bp.tar.xz ]; then
        echo "Backup already exists; move it before starting a new backup." >&2
        exit 1
    fi
    tar --exclude-from="$2/scripts/exclude" --exclude="$1/bp.tar" \
        --exclude="$1/bp.tar.xz" --acls --xattrs -pvcf bp.tar / &&
    xz -T0 -9 --memlimit=16GB "$1/bp.tar"
' root backup "$HOME" "${XDG_CONFIG_HOME:-$HOME/.config}"
