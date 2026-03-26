---
name: agent-zero-vps-admin
description: Administer Agent Zero on Linux VPS hosts with Docker/Compose and reverse proxies (Caddy/Apache/Nginx). Use for deployment, upgrades, auth/origin/env fixes, HTTPS/domain setup, 502/WebSocket debugging, logs triage, and basic host hardening checks.
---

# Agent Zero Vps Admin

Use this skill to run Agent Zero as a stable and secure VPS service with fast, evidence-based troubleshooting.

## Load References Only As Needed

- Read [references/runbook.md](references/runbook.md) for end-to-end deployment, diagnostics, and change validation.
- Read [references/env-and-security.md](references/env-and-security.md) when debugging auth/origin behavior or hardening `.env` and access controls.

## Primary Workflow

### 1) Discover Current Deployment

Run read-only discovery first:

```bash
whoami && hostname && uname -a
ls -la
rg --files . | rg -n "(compose\\.(yml|yaml)|docker-compose\\.(yml|yaml)|Caddyfile|\\.env)$"
```

Locate these quickly:
- Compose stack file
- Agent Zero persistent dir mapped to `/a0/usr`
- Reverse proxy config (`Caddyfile` or vhost config)

### 2) Capture Fast Health Snapshot

Use the bundled script:

```bash
scripts/a0_health_snapshot.sh /path/to/compose.yml your-domain.example.com
```

The script prints:
- Container status and restarts
- Recent `agent-zero` and proxy logs
- Listener ports
- Optional HTTP/HTTPS probe results

### 3) Debug by Symptom

- `502` from reverse proxy:
  - Confirm Agent Zero is actually listening (container boot may still be in progress).
  - Verify upstream target is `agent-zero:80` (or mapped localhost port for host-based proxy).
- "Origin ... not allowed when login is disabled":
  - Add exact browser origin to `ALLOWED_ORIGINS` (scheme + host [+ port]) or enable auth.
- HTTPS not coming up:
  - Use a real domain (not bare IP) and ensure DNS A record points to VPS.
  - Ensure inbound `80/tcp` and `443/tcp` are reachable for ACME validation.
- Login/auth confusion:
  - `AUTH_LOGIN` is username text, not a boolean flag.
- WebSocket issues:
  - Verify reverse proxy supports upgrades and preserves host headers.

### 4) Apply Minimal Safe Fixes

- Prefer editing only:
  - compose file
  - proxy config
  - `/a0/usr/.env` (host-mounted)
- Restart only affected services where possible.
- Avoid broad host changes unless symptoms require them.

### 5) Validate and Report

Always provide:
1. What changed.
2. Why it changed.
3. Verification commands and results.
4. Remaining risks or follow-up hardening tasks.

## Guardrails

- Prefer exposing only the proxy (`80/443`) publicly, not Agent Zero directly.
- Do not mount whole `/a0`; mount `/a0/usr` for persistence.
- Keep secret-bearing `.env` files owner-only (`0600` preferred).
- Be explicit about firewall behavior when Docker-published ports are in use.
