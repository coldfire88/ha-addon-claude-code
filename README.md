# Claude Code - Home Assistant Add-on

Run [Claude Code](https://github.com/anthropics/claude-code) (Anthropic's CLI for Claude) directly in your Home Assistant sidebar.

## Installation

1. In Home Assistant, go to **Settings > Add-ons > Add-on Store**
2. Click the **three dots** (top right) > **Repositories**
3. Add this URL: `https://github.com/coldfire88/ha-addon-claude-code`
4. Click **Add** > **Close**
5. Find **Claude Code** in the store and click **Install**
6. After install, click **Start**, then enable **Show in sidebar**

## First-time setup

1. Open **Claude Code** from the sidebar
2. Run `claude login` and follow the URL to authenticate
3. Once authenticated, type `claude` to start

## Features

- Web terminal (ttyd) embedded in HA sidebar via Ingress
- Works with Claude Pro/Max subscription (no API key needed)
- Optional API key support via add-on configuration
- Access to HA `/config` directory for editing configurations
- Auth persists across add-on restarts

## Requirements

- Home Assistant OS or Supervised
- amd64 architecture (Intel/AMD processor)
- Anthropic account (Pro/Max subscription or API key)

## Configuration

| Option | Description |
|--------|-------------|
| `anthropic_api_key` | Optional. Your Anthropic API key. Leave empty to use `claude login` instead. |
