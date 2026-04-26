# ClaudeForge Ecosystem Awareness

Paste into [claude.ai](http://claude.ai) Projects &gt; Instructions.

---

## Active tools

- GSD: 70+ skills. Plan-&gt;Execute-&gt;Review-&gt;Debug-&gt;Ship
- Caveman: $caveman = 65-75% token reduction
- Security: auto-scan every edit
- claude-mem: session memory, localhost:37777
- RTK: Bash output compression 60-90%. Auto via PreToolUse hook.
- 200+ skills: security, code-review, playwright, frontend-design, docs, video

## RTK — Bash commands

Use these instead of raw equivalents:

- git -&gt; `rtk git [status|diff|log|add|commit|push|pull]`
- cat/head/tail -&gt; `rtk read <file>`
- rg/grep -&gt; `rtk grep <pattern>`
- ls -&gt; `rtk ls`
- pytest -&gt; `rtk pytest`
- cargo test/build/clippy -&gt; `rtk cargo [...]`
- npm test/build -&gt; `rtk err npm run build`
- ruff check -&gt; `rtk ruff check`
- docker ps/images/logs -&gt; `rtk docker [...]`
- tsc -&gt; `rtk tsc`
- eslint/biome -&gt; `rtk lint`

Built-in Read/Grep/Glob bypass hook — use shell (cat, rg, find) instead. Stats: `rtk gain` | Missed: `rtk discover --since 1`

## Hooks

- SessionStart: session-start.js — banner, RTK auto-init, bootstrap prompt
- PreToolUse (Edit|Write|MultiEdit): sensitive-file-guard.js
- PostToolUse (Bash): self-learning.js
- Notification: Windows MessageBox popup when input needed

## Skill triggers

- New feature -&gt; "spec this feature" (Feature Forge)
- Architecture -&gt; "design this system"
- Code analysis -&gt; "reverse engineer this" (Spec Miner)
- Challenge idea -&gt; "red team this" (The Fool)
- API design -&gt; "design this API"
- UI -&gt; frontend-design + Shadcn
- Test -&gt; playwright + semgrep
- Token save -&gt; $caveman + /compact + RTK

## MCP servers

filesystem, github, firecrawl, playwright, Desktop Commander

## Memory

No session memory. [CLAUDE.md](http://CLAUDE.md) + git log = memory. Not written = forgotten.

## Task routing

Simple -&gt; haiku. Single file -&gt; sonnet. Multi-file/arch -&gt; opus. 3+ parallel -&gt; opus + swarm.

## Rules

- Read before edit (4:1 ratio)
- [CLAUDE.md](http://CLAUDE.md) read every session
- Never commit .env
- Never push to main directly
- Use rtk prefix on all Bash commands
