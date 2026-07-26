# HA Claude Addon

> **Shared rules**: See `/mnt/d/ClaudeProjects/CLAUDE_BASE.md` for permissions, working style, git rules, and all standard Claude Code practices.

<!-- INFRA:START (generated from INFRA.md — edit there, then re-sync from the hub) -->
## Infrastructure

**Purpose:** A custom Home Assistant add-on that runs the Claude Code CLI inside a browser terminal, served through Home Assistant's authenticated UI on the always-on Intel NUC. It gives Zoli a persistent Claude Code session on the home server — reachable over LAN or Tailscale — so home-automation work can be done from any device without keeping a PC running. It is the companion to the SMD HOME project.

**Key features:**
- Browser-based terminal (xterm.js) exposing the Claude Code CLI through HA ingress, reachable from anywhere HA is.
- Docker-based add-on image (Debian Bookworm + Node.js 20) deployed via the NUC's Samba `addons` share and installed/updated from HA → Add-ons.
- Persistent `tmux` sessions so long-running work survives disconnects and tab closes.
- Authenticated via HA ingress; the CLI inside the container logs in with the user's Anthropic/Claude subscription (no API key stored in the repo).

| Aspect | Details |
|--------|---------|
| Accounts | GitHub `coldfire88` (2FA on; portfolio-wide Classic PAT) · **Anthropic / Claude** account `zoli@somodi.ch` (the CLI inside the container logs in with the Claude subscription) · NUC Samba login (deployment) |
| Repository | github.com/coldfire88/ha-addon-claude-code.git · account `coldfire88` |
| Hosting / platform | **Intel NUC** — runs as a Docker-based HA add-on (Debian Bookworm + Node.js 20 + xterm.js + tmux), deployed via the NUC's Samba `addons` share |
| Domain(s) | exposed inside HA's UI (LAN/Tailscale only) |
| Database | none |
| Storage | HA add-on persistent volume |
| Auth | HA ingress auth (the add-on is reached through HA's authenticated UI) |
| Google (account + Drive) | none |
| Email | none |
| External APIs | Claude Code CLI uses the user's Anthropic/Claude subscription auth inside the container |

## Secrets
Values live in `.env.local` / `.env` (gitignored) and the central store `.secrets/projects/ha-addon.env` (+ `.server.env` for server-only). See `/mnt/d/ClaudeProjects/.secrets/manifest.toml`. **Never write secret values in this file — only names + where the value lives.**
- Anthropic / Claude Code auth — provided to the container at runtime (not stored in the repo)
- NUC Samba password for deployment — `.secrets/local/nuc-ssh.env`

## Deploy
- Build/run: build the Docker image per the add-on `Dockerfile`
- Deploy: copy the add-on dir to `\\192.168.8.60\addons\` then install/update from HA → Add-ons
- Env file: HA add-on `options` (config.yaml), no `.env`

## Notes
Companion to the `ha` project — gives a Claude Code terminal on the always-on NUC.
<!-- INFRA:END -->

<!-- TOOLBASE:START (generated — do not edit; run hub/toolbase.py sync) -->
## Toolbase — check before building a tool

Before writing an OCR helper, a Drive uploader, a doc renderer, an API client or any other utility, **search what the portfolio already has**:

```bash
python3 /mnt/d/ClaudeProjects/hub/toolbase.py search "<what you need>"
```

A ⭐ canonical hit means **use or extend it — never fork it**. Nothing back means it's safe to build, then add it to `TOOLS.md`.

**This project's own tools** (1):
- `Personal/ha-addon-claude-code/claude-code/run.sh` — Optional: use API key if provided

Full index: `/mnt/d/ClaudeProjects/TOOLS_INDEX.md` · canonical picks: `/mnt/d/ClaudeProjects/TOOLS.md` · rule: `CLAUDE_BASE.md §16`
<!-- TOOLBASE:END -->
