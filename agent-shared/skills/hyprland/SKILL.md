---
name: hyprland
description: Configure and troubleshoot Hyprland behavior (layouts, workspace rules, binds, dispatchers, and hyprctl options) using official Hyprland docs references. Use when user asks about Hyprland tiling/layout behavior or specific config semantics.
---

# Hyprland Skill

Use this skill when the user asks about Hyprland configuration, especially layout behavior and option semantics.

## Scope

- Hyprland config semantics and behavior
- Workspace rules vs global options
- Layout behavior (`dwindle`, `master`, `scrolling`)
- Binds, dispatchers, and `hyprctl` runtime checks

## Safety Rules

- Do not guess Hyprland option semantics from memory.
- Validate semantics against the local references in `references/` before changing config.
- Prefer minimal, reversible edits in `~/.config/hypr/`.
- Back up files before edits.
- Never modify Omarchy core files under `~/.local/share/omarchy/`.

## Decision Policy (Mandatory)

1. Try the simplest native solution first.
2. If uncertain on semantics, do research first (official docs + Perplexity if available).
3. If a simple documented solution still fails, then ask the user explicitly before any complex/custom/hacky solution.
4. Do not introduce scripts/daemons/workarounds unless the user approved that escalation.

## Workflow

1. Identify exact user intent in behavior terms.
2. Inspect current effective state:
   - `hyprctl activeworkspace -j`
   - `hyprctl workspaces -j`
   - `hyprctl monitors -j`
   - `hyprctl getoption <category:option>`
3. Read only the relevant reference file(s):
   - `references/wiki-hypr-land-configuring-scrolling-layout.md`
   - `references/wiki-hypr-land-configuring-workspace-rules.md`
   - `references/wiki-hypr-land-configuring-variables.md`
   - `references/wiki-hypr-land-configuring-dwindle-layout.md`
   - `references/wiki-hypr-land-configuring-master-layout.md`
   - `references/wiki-hypr-land-configuring-dispatchers.md`
   - `references/wiki-hypr-land-configuring-binds.md`
4. Propose and apply the smallest change that fits the docs.
5. Apply change with `hyprctl reload` (or targeted `hyprctl keyword ...` when safer).
6. Verify behavior by querying runtime state again.
7. If unresolved after simple path + research, ask for permission before escalating complexity.
8. Summarize exact changes and how to revert.

## High-value Checks (Always)

- Distinguish global options (e.g. `scrolling:*`) from workspace rule options (`layoutopt:*`).
- Confirm that `exec-once` only runs at session start, not every reload.
- If behavior appears unchanged, verify active workspace `tiledLayout` and overridden workspace rules.
- If using dynamic scripts/hooks, verify process is running and logs are clean.

## References

Read these on demand; avoid loading all files at once.

- `references/wiki-hypr-land-configuring-variables.md`
- `references/wiki-hypr-land-configuring-workspace-rules.md`
- `references/wiki-hypr-land-configuring-scrolling-layout.md`
- `references/wiki-hypr-land-configuring-dwindle-layout.md`
- `references/wiki-hypr-land-configuring-master-layout.md`
- `references/wiki-hypr-land-configuring-dispatchers.md`
- `references/wiki-hypr-land-configuring-binds.md`
