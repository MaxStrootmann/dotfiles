#!/usr/bin/env bash
set -euo pipefail

key_file="${HOME}/.config/codex/secrets/perplexity_api_key"
mkdir -p "$(dirname "$key_file")"

if [[ "${1:-}" != "" ]]; then
  key="$1"
else
  read -r -s "key?Enter Perplexity API key: "
  echo
fi

if [[ -z "${key:-}" ]]; then
  echo "No key provided." >&2
  exit 1
fi

printf '%s\n' "$key" > "$key_file"
chmod 600 "$key_file"

echo "Saved key to: $key_file"
echo "Restart shell or run: source ~/.zshrc"
