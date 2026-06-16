#!/usr/bin/env bash
# Re-index the ~/lit literature library
# Usage: litindex [--update|--dir <name>|--stats]
set -euo pipefail
cd "$HOME/lit"
python3 _index.py "$@"
