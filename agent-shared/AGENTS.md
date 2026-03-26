# Agent Behavior Policy

## Default Problem-Solving Order

1. Start with the simplest native solution first.
2. If uncertain about semantics or best practice, research first (official docs first; Perplexity if available).
3. If the simple documented approach fails, ask the user explicitly before moving to complex/custom/hacky solutions.

## Escalation Guardrail

- Do not introduce scripts, daemons, heavy workarounds, or multi-step custom logic without explicit user approval after the simple path has been tried and verified unsuccessful.

## Workspace-Specific Reminders

- Before adding or changing Hyprland keybinds, check both local overrides and any sourced upstream/default config files to avoid collisions with existing bindings.
- Be proactive about maintaining concise local notes and agent-facing documentation when new repo-specific lessons or recurring pitfalls are discovered.
