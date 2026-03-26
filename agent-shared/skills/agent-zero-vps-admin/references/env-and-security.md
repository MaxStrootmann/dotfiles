# Agent Zero Env and Security Notes

This note captures behavior verified from the local `agent-zero` repository code paths.

## Core Runtime Facts

- Agent Zero container launcher starts UI on `0.0.0.0:80`.
  - Source: `docker/run/fs/exe/run_A0.sh`
- Persistent data should live under `/a0/usr`.
  - Source: installation docs and runtime dotenv path handling.

## Authentication Behavior

- Login requirement is determined by `AUTH_LOGIN` presence.
  - If set (non-empty), login is required.
  - Source: `python/helpers/login.py`
- Credentials are `AUTH_LOGIN` (username) and `AUTH_PASSWORD` (password).
  - `AUTH_LOGIN` is not a boolean switch.
  - Source: `docs/setup/vps-deployment.md`

## Origin / CSRF Behavior

- CSRF token endpoint enforces origin allowlist when login is disabled.
- Allowed origins come from `ALLOWED_ORIGINS` (comma-separated).
- If unset, defaults allow localhost/loopback patterns only:
  - `*://localhost`, `*://localhost:*`
  - `*://127.0.0.1`, `*://127.0.0.1:*`
  - `*://0.0.0.0`, `*://0.0.0.0:*`
- If `ALLOWED_ORIGINS` is unset and first request is non-local, app may append that origin automatically.
  - Source: `python/api/csrf_token.py`

Operational implication:
- Behind a reverse proxy, include your final browser origin(s) explicitly in `ALLOWED_ORIGINS`, especially when changing ports, domain, or protocol.

## Sensitive Values

- `ROOT_PASSWORD` is used by startup preparation logic.
  - Source: `prepare.py`
- Treat `.env` as sensitive; enforce owner-only read/write (`0600` preferred).

## Reverse Proxy Notes

- Caddy automatic HTTPS requires a domain name for public trusted certificates.
- For raw IP access, expect HTTP only (or custom/self-managed cert approach).
- Temporary `502` immediately after stack start can be normal while Agent Zero is still initializing.

## Recommended Deployment Shape

- Public exposure: reverse proxy only (`80/443`).
- Internal app port: Agent Zero at container port `80`.
- Persistence: mount only `/a0/usr`, not full `/a0`.
