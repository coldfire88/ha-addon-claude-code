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

export HOME="/data"

# tmux config
cat > /data/.tmux.conf << 'TMUXCONF'
set -g default-terminal "xterm-256color"
set -g mouse on
set -s escape-time 0
set -g history-limit 50000
TMUXCONF

echo "Claude Code - Home Assistant"
echo "Starting xterm.js terminal on port 8099..."

# Launch the Node.js terminal server
exec node /opt/terminal/server.js
