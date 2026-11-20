#!/usr/bin/env bash
# Non-destructive tests: su, tar, xz, and git are replaced with doubles.
set -eu
scripts_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
mkdir -p "$tmp/bin"
export TEST_TMP="$tmp"
export PATH="$tmp/bin:$PATH"

cat > "$tmp/bin/su" <<'EOF'
#!/bin/sh
[ "$1" = -s ] && [ "$2" = /bin/sh ] && [ "$3" = -c ] && [ "$5" = root ] || exit 99
command=$4
shift 5
exec /bin/sh -c "$command" "$@"
EOF
cat > "$tmp/bin/tar" <<'EOF'
#!/bin/sh
printf '%s\0' "$PWD" "$@" > "$TEST_TMP/tar.args"
exit "${TAR_STATUS:-0}"
EOF
cat > "$tmp/bin/xz" <<'EOF'
#!/bin/sh
printf '%s\0' "$@" > "$TEST_TMP/xz.args"
exit "${XZ_STATUS:-0}"
EOF
cat > "$tmp/bin/git" <<'EOF'
#!/bin/sh
printf '%s\0' "$@" >> "$TEST_TMP/git.args"
case "$2" in *fail*) exit 1;; esac
EOF
chmod +x "$tmp/bin/"*

export HOME="$tmp/home space;\$(touch INJECTED)"
export XDG_CONFIG_HOME="$tmp/config ' space"
mkdir -p "$HOME" "$XDG_CONFIG_HOME"
sh "$scripts_dir/backup.sh"
mapfile -d '' -t tar_args < "$tmp/tar.args"
mapfile -d '' -t xz_args < "$tmp/xz.args"
[[ ${tar_args[0]} == "$HOME" && ${tar_args[1]} == "--exclude-from=$XDG_CONFIG_HOME/scripts/exclude" ]]
[[ ${tar_args[2]} == "--exclude=$HOME/bp.tar" && ${xz_args[3]} == "$HOME/bp.tar" ]]
[[ ! -e "$HOME/INJECTED" && ! -e INJECTED ]]
rm "$tmp/xz.args"
if TAR_STATUS=2 sh "$scripts_dir/backup.sh"; then echo 'tar failure masked' >&2; exit 1; fi
[[ ! -e "$tmp/xz.args" ]]
if XZ_STATUS=3 sh "$scripts_dir/backup.sh"; then echo 'xz failure masked' >&2; exit 1; fi
rm "$tmp/tar.args" "$tmp/xz.args"
if HOME="$tmp/missing" sh "$scripts_dir/backup.sh" 2>/dev/null; then echo 'cd failure masked' >&2; exit 1; fi
[[ ! -e "$tmp/tar.args" && ! -e "$tmp/xz.args" ]]
touch "$HOME/bp.tar.xz"
if sh "$scripts_dir/backup.sh" 2>/dev/null; then echo 'existing backup not protected' >&2; exit 1; fi
[[ ! -e "$tmp/tar.args" && -e "$HOME/bp.tar.xz" ]]
rm "$HOME/bp.tar.xz"

mkdir -p "$HOME/repo space/.git" "$HOME/fail repo/.git" "$HOME/another/.git" "$HOME/worktree"
touch "$HOME/worktree/.git"
if "$scripts_dir/pull_all.sh"; then echo 'git failure masked' >&2; exit 1; fi
mapfile -d '' -t git_args < "$tmp/git.args"
[[ ${#git_args[@]} == 12 ]]
for repo in 'repo space' 'fail repo' another worktree; do
    found=0
    for arg in "${git_args[@]}"; do [[ $arg != "$HOME/$repo" ]] || found=1; done
    [[ $found == 1 ]]
done
rm -rf "$HOME/fail repo"
"$scripts_dir/pull_all.sh"
if HOME="$tmp/missing" "$scripts_dir/pull_all.sh" 2>/dev/null; then echo 'find failure masked' >&2; exit 1; fi
echo 'backup and pull_all tests passed'
