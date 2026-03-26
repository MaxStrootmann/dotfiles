---
name: perplexity-research
description: Run fast external research using the Perplexity API, then summarize findings with citations and feed only relevant conclusions into implementation tasks.
---

# Perplexity Research Skill

Use this skill when you need up-to-date web research before implementing changes.

## When to Use

- You are unsure about current docs, APIs, releases, behavior, or best practices.
- The user asked to research first.
- You need quick comparison across multiple web sources.

## Decision Rule

1. Try simplest native/documented solution first.
2. If uncertain, run Perplexity research.
3. If simple path still fails, ask user before complex/custom/hacky solutions.

## Prerequisites

- `PERPLEXITY_API_KEY` in environment, or key file at:
  - `~/.config/codex/secrets/perplexity_api_key`

## Commands

- Query helper:
  - `~/.config/scripts/perplexity-query.sh "your question"`
- Set key helper:
  - `~/.config/scripts/perplexity-key-set.sh`

## Research Workflow

1. Ask one precise question per behavior.
2. Capture actionable output only (avoid broad copy/paste).
3. Verify critical config semantics against primary docs.
4. Apply minimal change first.
