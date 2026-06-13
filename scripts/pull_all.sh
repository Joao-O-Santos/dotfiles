#!/usr/bin/env bash
# Pull all git repositories under $HOME
# Usage: pull_all

for dir in $(find "$HOME" -name ".git" -type d); do
    repo_dir="$dir/.."
    echo "Pulling: $repo_dir"
    git -C "$repo_dir" pull
    printf "\n"
done
