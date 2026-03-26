# Agent Zero VPS Runbook

Use this runbook when Agent Zero is deployed on a Linux VPS with Docker/Compose and a reverse proxy.

## 1) Quick Discovery

```bash
whoami && hostname && uname -a
pwd
ls -la
rg --files . | rg -n "(compose\\.(yml|yaml)|docker-compose\\.(yml|yaml)|Caddyfile|\\.env)$"
```

Identify:
- Active compose file
- Agent Zero data dir mapped to `/a0/usr`
- Reverse proxy config

## 2) Baseline Checks

```bash
docker compose -f /path/to/compose.yml config
docker compose -f /path/to/compose.yml ps
docker compose -f /path/to/compose.yml logs --tail=120 agent-zero
docker compose -f /path/to/compose.yml logs --tail=120 caddy
ss -ltnup | rg -n "(:22|:80|:443|:50080)"
```

Expected:
- `agent-zero` and proxy are `Up`
- Agent Zero eventually logs `Uvicorn running on http://0.0.0.0:80`
- Proxy sees successful upstream connections after startup

## 3) Symptom Playbooks

### A) 502 Bad Gateway from proxy

1. Check if Agent Zero is still booting:
```bash
docker compose -f /path/to/compose.yml logs --tail=200 agent-zero
```
2. Confirm upstream port target is correct:
- In-container default is port `80`.
3. Recheck proxy logs:
```bash
docker compose -f /path/to/compose.yml logs --tail=200 caddy
```

### B) "Origin ... not allowed when login is disabled"

1. Check current `ALLOWED_ORIGINS` in `.env`.
2. Add exact browser origin(s), including scheme and non-default port when used.
3. Restart Agent Zero container.

### C) HTTPS missing

1. Use a real domain, not a raw IP, for public TLS.
2. Verify DNS resolves to VPS.
3. Ensure public inbound `80/tcp` and `443/tcp`.
4. Inspect proxy logs for ACME/certificate events.

### D) Login confusion

- `AUTH_LOGIN` is the username value; it is not a boolean.
- If `AUTH_LOGIN` is set, login is required.

### E) WebSocket failures

- Ensure reverse proxy supports protocol upgrade.
- Confirm requests are reaching same hostname/origin expected by Agent Zero.

## 4) Safe Change Pattern

1. Save current files (`compose`, proxy config, `.env`).
2. Apply the smallest edit that matches observed failure.
3. Restart only affected services.
4. Re-run baseline checks.

## 5) Security Sanity Checks

```bash
stat -c "%a %U:%G %n" /path/to/.env
sudo ufw status verbose
sudo sshd -T | rg -n "^(permitrootlogin|passwordauthentication|pubkeyauthentication)"
sudo iptables -S | sed -n "1,220p"
```

Targets:
- `.env` not world-readable (`0600` preferred)
- SSH key auth enabled, root login disabled
- Firewall policy matches actual exposed ports

Note: Docker-published ports can bypass naive UFW expectations unless Docker firewall behavior is explicitly managed.
