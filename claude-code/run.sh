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

# Pin the model to Claude Opus 4.7. Auth is via `claude login` (Max
# subscription) — no API key needed for this to take effect.
export ANTHROPIC_MODEL="claude-opus-4-7"

# tmux config
cat > /data/.tmux.conf << 'TMUXCONF'
set -g default-terminal "xterm-256color"
set -g mouse on
set -s escape-time 0
set -g history-limit 50000
TMUXCONF

# Permission policy ("auto-safe" mode): auto-allow reads, edits, git and common
# safe home-ops commands so Claude stops prompting on every step; still PROMPT
# before clearly destructive shell ops (rm, mv, dd, chown, reboot, git reset, …).
# Managed by the add-on — rewritten on every start so the policy is declarative.
mkdir -p /data/.claude
cat > /data/.claude/settings.json << 'SETTINGS'
{
  "permissions": {
    "defaultMode": "default",
    "allow": [
      "Read", "Glob", "Grep", "LS", "TodoWrite", "WebFetch", "WebSearch", "Task",
      "Edit", "Write", "MultiEdit", "NotebookEdit",
      "Bash(ls:*)", "Bash(cat:*)", "Bash(head:*)", "Bash(tail:*)", "Bash(grep:*)",
      "Bash(rg:*)", "Bash(find:*)", "Bash(echo:*)", "Bash(pwd)", "Bash(cd:*)",
      "Bash(which:*)", "Bash(env)", "Bash(test:*)", "Bash(true)", "Bash(date:*)",
      "Bash(sort:*)", "Bash(uniq:*)", "Bash(wc:*)", "Bash(sed:*)", "Bash(awk:*)",
      "Bash(mkdir:*)", "Bash(touch:*)", "Bash(cp:*)", "Bash(diff:*)", "Bash(ln:*)",
      "Bash(git status:*)", "Bash(git diff:*)", "Bash(git log:*)", "Bash(git show:*)",
      "Bash(git add:*)", "Bash(git commit:*)", "Bash(git pull:*)", "Bash(git push:*)",
      "Bash(git fetch:*)", "Bash(git branch:*)", "Bash(git checkout:*)",
      "Bash(git stash:*)", "Bash(git restore:*)", "Bash(git remote:*)",
      "Bash(python3:*)", "Bash(pip3:*)", "Bash(node:*)", "Bash(npm:*)", "Bash(npx:*)",
      "Bash(curl:*)", "Bash(wget:*)", "Bash(jq:*)", "Bash(tmux:*)",
      "Bash(ha:*)", "Bash(bashio:*)", "Bash(ping:*)"
    ],
    "ask": [
      "Bash(rm:*)", "Bash(rmdir:*)", "Bash(mv:*)", "Bash(dd:*)", "Bash(mkfs:*)",
      "Bash(chmod:*)", "Bash(chown:*)", "Bash(kill:*)", "Bash(pkill:*)",
      "Bash(reboot:*)", "Bash(shutdown:*)", "Bash(git reset:*)", "Bash(git clean:*)"
    ],
    "deny": []
  }
}
SETTINGS

echo "Claude Code - Home Assistant"
echo "Starting xterm.js terminal on port 8099..."

# Launch the Node.js terminal server
exec node /opt/terminal/server.js
