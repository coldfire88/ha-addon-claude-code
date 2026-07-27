
## Portfolio audit follow-ups (2026-05-16)

_Generated from the **still-active** (non-archived) answered questions in the `PORTFOLIO-AUDIT` Feedbackify project. Each item cites the question code so you can trace it back._

- [ ] <!-- id:c5202930-19bb-4921-a5da-60a57d29aba2 --> _[audit Q-151]_ Keep per-tab ephemeral tmux sessions (current behaviour). Don't build persistence across WebSocket reconnections.

- [ ] <!-- id:1285af97-c8bc-4d58-baec-04ad67f9a83b --> _[audit Q-151]_ Keep per-tab ephemeral tmux sessions (current behaviour). Don't build persistence across WebSocket reconnections.
- [ ] <!-- id:57836911-7974-4752-89e2-af030ab34054 --> _[audit Q-151]_ Keep per-tab ephemeral tmux sessions (current behaviour). Don't build persistence across WebSocket reconnections.

## Docs compliance — branding guide + compendium missing (added 2026-07-27)

Portfolio rule (`CLAUDE_BASE.md` §13, `DOCS_INSTRUCTIONS` §1.10–11): every **doc-generating** project
keeps a `BRANDING_GUIDE.md` and a root `HAADDON_COMPENDIUM.md`. This project has neither. It is also
invisible to doctools, which discovers projects only by the presence of a `md_to_docx.py` renderer
(`scripts/doctools/branding_guide.py:discover_projects`).

- [ ] <!-- id:4e8d33a4-e34c-4382-9348-5b80c7cbe36d --> **Decide scope first** — does this project produce client/stakeholder documents at all? If it is code-only, record that here and mark the rest of this section N/A rather than scaffolding unused files
- [ ] <!-- id:5fe9259f-1ae8-4a10-8355-10fc2615e044 --> If it is doc-generating: wire the shared house-style renderer — add `md_to_docx.py` (or `scripts/md_to_docx.py`) importing `scripts/doctools/house_style.py`; do **not** fork it
- [ ] <!-- id:610a0092-9b52-4c3f-962a-1ff56a640ff9 --> Generate the branding guide: `cd /mnt/d/ClaudeProjects/scripts/doctools && python3 branding_guide.py "ha-addon-claude-code"`
- [ ] <!-- id:c391810c-0c95-463a-8761-3674e482d858 --> Generate the root compendium: `cd /mnt/d/ClaudeProjects/scripts/doctools && python3 compendium.py --scaffold-missing`, then fill `HAADDON_COMPENDIUM.md` with the project's real doc inventory
- [ ] <!-- id:628d4fb2-fb73-4b46-92c7-3c1b56166f88 --> Verify: `python3 compendium.py --report` lists `ha-addon-claude-code` as `ok (root)`
