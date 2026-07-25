#!/bin/sh
set -eu

config=${1:-nvim/init.vim}
output=$(mktemp)
trap 'rm -f "$output"' EXIT

nvim --headless -u "$config" \
  +'enew' \
  +'setfiletype quarto' \
  +'lua assert(pcall(require, "quarto")); assert(pcall(require, "otter"))' \
  +qa 2>"$output"

if grep -Eiq 'E[0-9]+:|Error detected|stack traceback' "$output"; then
  cat "$output" >&2
  exit 1
fi
printf '%s\n' 'Neovim starts and loads the configured Quarto stack.'
