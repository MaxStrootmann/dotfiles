#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: perplexity-query.sh \"your question\"" >&2
  exit 1
fi

prompt="$*"
key="${PERPLEXITY_API_KEY:-}"

if [[ -z "$key" && -r "${HOME}/.config/codex/secrets/perplexity_api_key" ]]; then
  key="$(<"${HOME}/.config/codex/secrets/perplexity_api_key")"
fi

if [[ -z "$key" ]]; then
  echo "Missing PERPLEXITY_API_KEY and no key file at ~/.config/codex/secrets/perplexity_api_key" >&2
  exit 1
fi

curl -sS https://api.perplexity.ai/chat/completions \
  -H "Authorization: Bearer $key" \
  -H 'Content-Type: application/json' \
  -d "$(jq -n --arg p "$prompt" '{model:"sonar",messages:[{role:"user",content:$p}]}')" \
  | jq -r '.choices[0].message.content // .error.message // .'
