const express = require('express');
const http = require('http');
const path = require('path');
const { WebSocketServer } = require('ws');
const pty = require('node-pty');

const app = express();
const server = http.createServer(app);
const wss = new WebSocketServer({ server });

const SESSION = 'claude';
const WORKSPACE = '/config';
const HOME = '/data';

const webDir = path.join(__dirname, 'web');

// Serve static files at root and under any ingress prefix path
app.use(express.static(webDir));
app.use('*', (req, res, next) => {
  // For HA ingress: serve index.html for any non-ws HTML request
  if (req.accepts('html')) {
    res.sendFile(path.join(webDir, 'index.html'));
  } else {
    next();
  }
});

wss.on('connection', (ws) => {
  const shell = pty.spawn('bash', ['-c', [
    `cd ${WORKSPACE}`,
    `export HOME=${HOME}`,
    `if ! tmux has-session -t ${SESSION} 2>/dev/null; then`,
    `  tmux new-session -d -s ${SESSION} -x 200 -y 50`,
    `  tmux send-keys -t ${SESSION} 'cd ${WORKSPACE}' Enter`,
    `fi`,
    `exec tmux new-session -t ${SESSION}`
  ].join('\n')], {
    name: 'xterm-256color',
    cols: 120,
    rows: 40,
    cwd: WORKSPACE,
    env: { ...process.env, HOME, TERM: 'xterm-256color' }
  });

  shell.onData((data) => {
    try { ws.send(data); } catch (e) { /* client gone */ }
  });

  ws.on('message', (raw) => {
    try {
      const msg = JSON.parse(raw);
      switch (msg.type) {
        case 'input': shell.write(msg.data); break;
        case 'resize': shell.resize(msg.cols, msg.rows); break;
      }
    } catch (e) {
      // binary or plain text fallback — treat as input
      shell.write(raw.toString());
    }
  });

  ws.on('close', () => shell.kill());
  shell.onExit(() => { try { ws.close(); } catch (e) {} });
});

const PORT = 8099;
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Claude Code terminal running on port ${PORT}`);
});
