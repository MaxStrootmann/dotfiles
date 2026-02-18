#!/usr/bin/env bash
set -euo pipefail

# Usage: wt <worktree-path> [--bun|--pnpm|--npm]

if [[ $# -lt 1 ]]; then
  echo "Usage: wt <worktree-path> [--bun|--pnpm|--npm]" >&2
  exit 1
fi

worktree="$1"
shift || true

pkg_mgr="bun"

# parse optional flag (one of --bun|--pnpm|--npm, default bun)
while [[ $# -gt 0 ]]; do
  case "$1" in
    --bun)
      pkg_mgr="bun"
      shift
      ;;
    --pnpm)
      pkg_mgr="pnpm"
      shift
      ;;
    --npm)
      pkg_mgr="npm"
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      echo "Usage: wt <worktree-path> [--bun|--pnpm|--npm]" >&2
      exit 1
      ;;
  esac
done

# add worktree (run this from inside your .bare directory)
git worktree add "$worktree"

# copy .env from ./master worktree
if [[ -f "./master/.env" ]]; then
  cp "./master/.env" "$worktree/.env"
fi

# run chosen package manager in new worktree
case "$pkg_mgr" in
  bun)
    (cd "$worktree" && bun install)
    ;;
  pnpm)
    (cd "$worktree" && pnpm install)
    ;;
  npm)
    (cd "$worktree" && npm install)
    ;;
esac

cd ${worktree}
