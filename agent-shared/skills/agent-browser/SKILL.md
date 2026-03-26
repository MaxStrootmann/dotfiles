---
name: agent-browser
description: Use the shared browser on agent-zero. Prefer the existing Chromium session managed by shared-browser over launching a separate browser. Connect with --cdp 9222 so Codex and the user operate the same browser instance.
---

# Agent Browser On Agent Zero

On this VPS, browser automation should use the shared Chromium session created by `shared-browser`.

## Default Workflow

1. Check the shared browser stack:

```bash
shared-browser status
```

2. If it is not running, start it:

```bash
shared-browser start
```

3. Reuse the existing Chromium session through CDP instead of opening a separate browser:

```bash
agent-browser --cdp 9222 snapshot -i
agent-browser --cdp 9222 click @e1
agent-browser --cdp 9222 fill @e2 "text"
agent-browser --cdp 9222 screenshot
```

4. If a page needs to be opened in the shared browser, use one of:

```bash
shared-browser open http://127.0.0.1:3000
agent-browser --cdp 9222 open http://127.0.0.1:3000
```

## Important Rules

- Prefer `agent-browser --cdp 9222 ...` for all browser actions.
- Prefer `shared-browser open URL` when you want the user to immediately see the navigation in the shared window.
- Do not start a separate Chromium or Playwright-managed browser unless the task explicitly requires isolation.
- Screenshots intended for handoff should usually go into `~/shared/shots` via `shared-browser shot` or by moving captured files there.
- The user can view the same browser through the forwarded noVNC session on `http://127.0.0.1:6080/vnc.html?autoconnect=1&resize=scale`.
