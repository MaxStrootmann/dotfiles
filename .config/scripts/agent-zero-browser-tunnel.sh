#!/usr/bin/env bash
set -euo pipefail

REMOTE_HOST="${REMOTE_HOST:-mann-dev}"

exec ssh \
  -L 6080:127.0.0.1:6080 \
  -L 9222:127.0.0.1:9222 \
  "${REMOTE_HOST}" -N
