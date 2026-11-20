#!/bin/sh
# Pull all git repositories under $HOME
# Usage: pull_all

find "$HOME" -name .git \( -type d -o -type f \) -prune -exec sh -c '
    status=0
    for dir do
        repo_dir=${dir%/.git}
        echo "Pulling: $repo_dir"
        git -C "$repo_dir" pull || status=1
        printf "\n"
    done
    exit "$status"
' _ {} +
