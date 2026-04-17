# Documentation contract

Keep the documentation set small and consistent.

- `~/AGENTS.md`
  - Global rules only.
  - Top-level table of contents for cross-project guidance.
  - Stored via GNU Stow in `~/dotfiles` and version-controlled there, so changes here must be committed and pushed.
- `./AGENTS.md`
  - Local project table of contents.
  - Project-specific agent behavior notes only.
- `./README.md`
  - Human quickstart.
  - Explain what the project is, current state, and key workflows.
  - Prefer Mermaid diagrams for fast visual orientation.
- `./TODO.md`
  - Shared progress/status tracker for humans and agents.
  - Keep it aligned with the real implementation state.
- `./docs/*.md`
  - Agent memory layer.
  - Notes, runbooks, findings, decisions, and session-to-session context so new agents can recover context quickly.

Rules:
- Keep repo-specific detail out of `~/AGENTS.md`.
- Keep `README.md` and `TODO.md` current whenever behavior or status changes.
- Index important project docs from the nearest `./AGENTS.md`.
- Prefer adding durable context to `./docs/*.md` instead of leaving it only in chat history.

Use ~/AGENTS.md as the global behavior note file and top-level table of contents for cross-project guidance. Keep directory-scoped instructions and notes in a dedicated `AGENTS.md` inside that project or workflow directory. Also notes on mistakes and specific behavior changes for future sessions should be noted here when they are global rather than repo-specific.

## Project AGENTS Index

- `/home/max/Work/odoo/AGENTS.md`
- `/home/max/Work/bouwbureanederland-website/AGENTS.md`
- `/home/max/Work/estimation/AGENTS.md`
- `/home/max/Work/zoho/AGENTS.md`

## Global Behavior Notes

- Prefer keeping repo-specific rules, runbooks, and notes out of `~/AGENTS.md`; store them in the nearest project-level `AGENTS.md` instead.
- For pi customizations and personal workflow tweaks, prefer global configuration/resources over project-local ones unless the user explicitly asks for a repo-local customization.
- When changing extensions or similar custom scripts, update the existing implementation in place. Do not keep old versions, parallel variants, or superseded code paths unless the user explicitly asks for them.
- For pi extension discovery, use the global extension registry commands first:
  - `/extensions [all|global|project]`
  - `/extension <name>`
  - Registry extension path: `~/.pi/agent/extensions/extension-registry/index.ts`
- When the user says to use "subagents", interpret that as using the pi swarm extension (`~/.pi/agent/extensions/swarm/index.ts`) unless they clearly mean another orchestration method. Do not substitute parallel local tool calls for swarm-based subagents.
- When using the swarm extension, prefer the active session's slash-command workflow (`/swarm-start`, `/swarm-assign`, `/swarm-collect`, `/swarm-stop`) so the agent remains the orchestrator in the current session with neighboring panes. Do not fall back to ad hoc raw tmux scripting unless the harness cannot invoke the slash-command flow directly, and in that case say so explicitly first.
- Keep git working trees clean by making small, frequent commits instead of letting unrelated changes accumulate.
- Do not use branches or worktrees unless the user explicitly asks for them.
- Always keep the nearest relevant `README.md` up to date when the project’s current behavior, setup, or workflows change.
- When a repo uses a planning or status tracker such as `TODO.md`, keep it aligned with the actual implementation state at the same time as the `README.md` so status docs do not drift.

# Concise response preference

  For final user-facing answers, prefer concise output by default.

  - Answer first.
  - Keep wording tight and direct.
  - Do not add greetings, cheerleading, or decorative phrasing unless the user clearly wants that tone.
  - Use short paragraphs.
  - Use flat bullets only when they improve clarity.
  - Do not use tables unless they clearly help.
  - Avoid repeating the user's question back to them.
  - Give extra detail only when necessary for correctness, safety, or when the user asks for depth.
  - If other style instructions conflict, prefer concise final user-facing output.
