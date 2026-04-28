# Documentation contract

Agents do not have infinite context windows and can only work from what is in the current chat history plus what they can find in the repo. Keep this documentation system in place, so agents can recover context quickly, stay on track, and work effectively without wasting time rediscovering the project.

Keep the documentation set small and consistent, so both humans and agents always know where to look and what to update.

- Keep `~/AGENTS.md` for global rules only, so cross-project guidance stays in one stable place.
- Keep `~/AGENTS.md` as the top-level table of contents for cross-project guidance, so agents can discover the right local context quickly.
- Keep `~/AGENTS.md` stored via GNU Stow in `~/dotfiles` and version-controlled there, so changes to your global workflow are preserved, reviewable, and reusable across sessions and machines.

- Keep `./AGENTS.md` as the local project table of contents, so agents can find the important project docs fast.
- Keep `./AGENTS.md` for project-specific agent behavior notes only, so repo-local rules do not leak into global guidance.

- Keep `./README.md` as the human quickstart, so you can get up to speed on what the project is and how it currently works.
- Keep `./README.md` focused on the current state, setup, and key workflows, so it stays useful instead of turning into a historical dump.
- Prefer Mermaid diagrams in `./README.md`, so the current architecture and flow are easy to grasp at a glance.

- Keep `./TODO.md` as the shared progress tracker for humans and agents, so everyone can see what is done, what is next, and how far along the project really is.
- Keep `./TODO.md` aligned with the real implementation state, so planning does not drift away from reality.

- Keep `./docs/*.md` as the agent memory layer, so each new session can recover context despite agent amnesia.
- Put notes, runbooks, findings, decisions, and other durable context in `./docs/*.md`, so important knowledge is not trapped in chat history.

Rules:
- Keep repo-specific detail out of `~/AGENTS.md`, so the global file stays short, stable, and broadly reusable.
- Keep `README.md` and `TODO.md` current whenever behavior or status changes, so humans and agents see the same reality.
- Index important project docs from the nearest `./AGENTS.md`, so agents can navigate the repo quickly.
- Prefer adding durable context to `./docs/*.md` instead of leaving it only in chat history, so future sessions can find and reuse it.

## Git and GitHub contract

- Always use `git` and the `gh` CLI for version control tasks, so repo state and GitHub state are managed consistently from the terminal.
- Avoid branches and worktrees, so the working flow stays simple and there is only one active line of work unless the user explicitly asks otherwise.
- Make small, frequent commits, so changes stay easy to review, understand, and roll back if needed.
- Commit and push directly to `master`, so local work and remote state stay closely aligned.
- If a project does not yet have a GitHub repo, create a private one with the `gh` CLI, so the work is backed up and ready to sync immediately.


## Project AGENTS Index

- `/home/max/Work/odoo/AGENTS.md`
- `/home/max/Work/bouwbureanederland-website/AGENTS.md`
- `/home/max/Work/estimation/AGENTS.md`
- `/home/max/Work/zoho/AGENTS.md`

## Obsidian vault contract

- When I mention my Obsidian vault, personal wiki, `_wiki/` overlay, or vault notes, first read the `max-obsidian-wiki` skill at `/home/max/.pi/agent/skills/max-obsidian-wiki/SKILL.md`, so vault work follows the current safety rules, canonical paths, and wiki maintenance workflow.

## Paperclip contract

- When working with Paperclip runtime, first read the `paperclip` skill at `/home/max/.pi/agent/skills/paperclip/SKILL.md`, so API/UI operations follow the current control-plane workflow.
- Use the hosted Paperclip instance at `https://paperclip.manndigital.nl` by default; it runs on the `mann-dev` VPS, reachable with `ssh mann-dev` from this machine.
- For Paperclip UI work, use the `agent-browser` skill in non-headless/interactive mode when login or visual inspection is needed, so Max can log in if required.

## Pi coding agent contract

- When working on Pi itself, read the local Pi source and docs first, so implementation and advice match the actual installed instance.
- Use the local Pi source at `~/.bun/install/global/node_modules/@mariozechner/pi-coding-agent`, so you can inspect the real code behind this installed Pi instance.
- Use the main Pi docs at `~/.bun/install/global/node_modules/@mariozechner/pi-coding-agent/README.md`, so you start from the primary local documentation entrypoint.
- Use the additional Pi docs at `~/.bun/install/global/node_modules/@mariozechner/pi-coding-agent/docs`, so feature-specific context such as extensions, themes, skills, prompt templates, TUI, SDK integrations, providers, models, and packages is easy to find.
- Use the local Pi examples at `~/.bun/install/global/node_modules/@mariozechner/pi-coding-agent/examples`, so extension and SDK work can follow real working patterns from the installed codebase.

- Prefer global Pi configuration and resources over project-local customization, so personal Pi workflow changes stay centralized unless the user explicitly wants repo-local behavior.
- When changing Pi extensions or similar custom scripts, update the existing implementation in place, so there is one clear active code path instead of parallel legacy variants.
- Use the global Pi extension registry commands first:
  - `/extensions [all|global|project]`
  - `/extension <name>`
  - Registry source: `~/.pi/agent/extensions/extension-registry/index.ts`
  so extension discovery starts from the same canonical index every time.


## Navigation preference

- In custom Pi TUI pickers and navigable extension UIs, prefer `Ctrl+N` and `Ctrl+P` for next/previous navigation, so movement matches my terminal workflow better than arrow keys.

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
