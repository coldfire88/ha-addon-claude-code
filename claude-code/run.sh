#!/bin/bash

# Optional: use API key if provided
if [ -f /data/options.json ]; then
    ANTHROPIC_API_KEY=$(python3 -c "import json; d=json.load(open('/data/options.json')); print(d.get('anthropic_api_key',''))" 2>/dev/null || true)
    if [ -n "$ANTHROPIC_API_KEY" ]; then
        export ANTHROPIC_API_KEY
        echo "Using configured API key."
    else
        echo "No API key configured. Run 'claude login' in the terminal to authenticate."
    fi
fi

# Set workspace to HA config directory
WORKSPACE="/config"

# Persist Claude Code auth across add-on restarts
export HOME="/data"

echo "Claude Code - Home Assistant"
echo "Starting web terminal on port 8099..."

# Launch ttyd serving a bash shell
exec ttyd \
    --port 8099 \
    --writable \
    bash -c "cd ${WORKSPACE} && echo 'Claude Code - Home Assistant' && echo '---' && echo 'Run: claude login  (if first time)' && echo '' && exec bash"
