#!/usr/bin/env bash
set -euo pipefail

REMOTE_HOST="${REMOTE_HOST:-mann-dev}"
TARGET_DIR="${TARGET_DIR:-$HOME/Downloads/mann-dev}"

mkdir -p "${TARGET_DIR}"

normalize_remote_path() {
  local remote_path="$1"

  case "${remote_path}" in
    /home/max/shared/*)
      printf '~/shared/%s\n' "${remote_path#/home/max/shared/}"
      ;;
    /home/mann/shared/*)
      printf '~/shared/%s\n' "${remote_path#/home/mann/shared/}"
      ;;
    shared/*)
      printf '~/%s\n' "${remote_path}"
      ;;
    inbox/*|outbox/*|shots/*|downloads/*)
      printf '~/shared/%s\n' "${remote_path}"
      ;;
    *)
      printf '%s\n' "${remote_path}"
      ;;
  esac
}

if [ "$#" -eq 0 ]; then
  rsync -av --progress "${REMOTE_HOST}:~/shared/" "${TARGET_DIR}/"
else
  for remote_path in "$@"; do
    rsync -av --progress "${REMOTE_HOST}:$(normalize_remote_path "${remote_path}")" "${TARGET_DIR}/"
  done
fi
