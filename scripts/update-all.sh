#!/usr/bin/env bash
# SPDX-License-Identifier: CC0-1.0
# Update the system and the user-managed development tools in one session.

set -Eeuo pipefail

usage() {
    cat <<'EOF'
Usage: update-all.sh [--dry-run]

Update Arch packages, R packages, Neovim plugins, and Pi.
Neovim runs headlessly and waits for PlugUpdate to finish.

Options:
  --dry-run   Print the commands without running them.
  -h, --help  Show this help.
EOF
}

dry_run=0

while (($#)); do
    case $1 in
        --dry-run)
            dry_run=1
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            printf 'Unknown option: %s\n\n' "$1" >&2
            usage >&2
            exit 2
            ;;
    esac
    shift
done

config_home=${XDG_CONFIG_HOME:-$HOME/.config}
nvim_config=$config_home/nvim/init.vim

for command_name in yay R nvim pi sudo; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$command_name" >&2
        exit 127
    fi
done

if [[ ! -r $nvim_config ]]; then
    printf 'Neovim config not found or unreadable: %s\n' "$nvim_config" >&2
    exit 1
fi

if (( ! dry_run )) && [[ ! -t 0 || ! -t 1 ]]; then
    printf 'update-all.sh must run from an interactive terminal.\n' >&2
    exit 1
fi

current_step='initialization'
trap 'status=$?; printf "\nERROR: %s failed (exit status %d): %s\n" "$current_step" "$status" "$BASH_COMMAND" >&2; exit "$status"' ERR

run_step() {
    local description=$1
    current_step=$description
    shift
    printf '\n==> %s\n' "$description"
    if (( dry_run )); then
        printf '+'
        printf ' %q' "$@"
        printf '\n'
    else
        "$@"
    fi
}

if (( ! dry_run )); then
    # Authenticate before beginning the privileged stages.
    current_step='sudo authentication'
    sudo -v
fi

run_step 'Arch packages' yay -Syu
run_step 'R packages' sudo R -e 'options(warn = 2); update.packages(ask = F, checkBuilt = TRUE, Ncpus = 8)'
run_step 'Neovim plugins' \
    sudo nvim --headless -u "$nvim_config" \
    -c 'redir => g:plug_upgrade_output | silent PlugUpgrade | redir END' \
    -c 'if g:plug_upgrade_output =~# "Error upgrading vim-plug" | echo g:plug_upgrade_output | cquit 1 | endif' \
    -c 'PlugUpdate --sync' \
    -c 'if search("^x ", "nw") > 0 | cquit 1 | endif' \
    -c 'qa!'

run_step 'Pi itself' sudo pi update
run_step 'Pi extensions' pi update --extensions --no-approve

printf '\nAll requested updates completed.\n'
