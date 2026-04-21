# 10 — Browser-Desktop Bridge

## Two Claudes, One Ecosystem

| | Browser Claude (claude.ai) | Claude Code (terminal) |
|---|---|---|
| Runs code | ❌ | ✅ |
| Accesses connectors | ✅ (Crypto.com, LunarCrush, etc.) | ❌ |
| Reads files via MCP | ✅ (Desktop Commander, filesystem) | ✅ (direct) |
| Writes files | ✅ (via MCP) | ✅ (direct) |
| Reads CLAUDE.md | ❌ (needs ecosystem-awareness.md) | ✅ (automatic) |
| Skill awareness | Via instructions + knowledge base | Via CLAUDE.md + SKILL.md |

## Setup

### Browser Claude
1. Create "Dev Hub" project in claude.ai
2. Instructions → paste `browser-instructions.md`
3. Files → upload `ecosystem-awareness.md`

### Claude Code
Already configured via:
- `C:\Users\[you]\.claude\CLAUDE.md` (global)
- `[project]\CLAUDE.md` (local)
- `[project]\start.ps1` (session launcher)

## Workflow

```
1. Browser Claude: "Analyze Trade-Bot's newsletter feature needs"
   → reads CLAUDE.md via MCP
   → pulls LunarCrush sentiment data
   → pulls MT Newswires headlines
   → generates Claude Code prompt with all context

2. You: copy prompt → paste into Claude Code

3. Claude Code: executes with full skill awareness
   → Feature Forge specs the feature
   → API Designer creates endpoints
   → GSD workflow: plan → execute → review → ship

4. Browser Claude: "Check what Claude Code built"
   → reads new files via MCP
   → validates against connector data
   → suggests next steps
```

## When to Use Which

| Task | Use |
|------|-----|
| Write code | Claude Code |
| Research with connectors | Browser Claude |
| Generate Claude Code prompts | Browser Claude |
| Review code changes | Either (MCP for browser) |
| Deploy | Claude Code |
| Market analysis | Browser Claude (connectors) |
| Multi-project overview | Browser Claude (MCP scans all) |

## Key Principle

Browser Claude = orchestrator + data access.
Claude Code = executor + file operations.
Neither replaces the other. Together = full stack.