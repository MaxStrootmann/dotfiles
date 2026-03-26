#!/usr/bin/env bash
set -euo pipefail

REMOTE_HOST="${REMOTE_HOST:-max@agent-zero}"

if [ "$#" -lt 1 ]; then
  echo "usage: agent-zero-put.sh <file-or-dir> [...]" >&2
  exit 1
fi

rsync -av --progress "$@" "${REMOTE_HOST}:~/shared/inbox/"
