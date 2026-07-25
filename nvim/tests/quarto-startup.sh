#!/bin/sh
set -eu

config=${1:-nvim/init.vim}
output=$(mktemp)
trap 'rm -f "$output"' EXIT

nvim --headless -u "$config" \
  +'lua assert(vim.g.loaded_netrw ~= nil or true)' \
  +qa 2>"$output"

if grep -Eiq 'E[0-9]+:|Error detected|stack traceback' "$output"; then
  cat "$output" >&2
  exit 1
fi
printf '%s\n' 'Neovim startup succeeded with the configured plugins.'
