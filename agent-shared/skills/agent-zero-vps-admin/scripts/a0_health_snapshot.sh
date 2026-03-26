#!/usr/bin/env bash
set -u

COMPOSE_FILE="${1:-/home/max/compose.yml}"
DOMAIN="${2:-}"

section() {
  printf "\n== %s ==\n" "$1"
}

run_cmd() {
  echo "+ $*"
  "$@" 2>&1 || echo "(command failed)"
}

section "Host"
run_cmd date -Is
run_cmd whoami
run_cmd hostname
run_cmd uname -a

section "Compose file"
if [ -f "$COMPOSE_FILE" ]; then
  run_cmd ls -l "$COMPOSE_FILE"
  run_cmd docker compose -f "$COMPOSE_FILE" config
  run_cmd docker compose -f "$COMPOSE_FILE" ps
else
  echo "Compose file not found: $COMPOSE_FILE"
fi

section "Container logs"
if [ -f "$COMPOSE_FILE" ]; then
  run_cmd docker compose -f "$COMPOSE_FILE" logs --tail=120 agent-zero
  run_cmd docker compose -f "$COMPOSE_FILE" logs --tail=120 caddy
fi

section "Listeners"
if command -v ss >/dev/null 2>&1; then
  run_cmd ss -ltnup
else
  echo "ss not found"
fi

section "HTTP probe"
if [ -n "$DOMAIN" ]; then
  run_cmd curl -sS -I --max-time 10 "http://$DOMAIN/"
  run_cmd curl -sS -I --max-time 10 "https://$DOMAIN/"
else
  echo "No domain provided; skipping external HTTP/HTTPS probe."
fi
