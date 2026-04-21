# 08 — Multi-Project Setup

## The Problem

You have 10+ projects. Each needs skills, configs, templates. Manually copying = nightmare.

## Solution: Ecosystem Sync

### File hierarchy
```
C:\Users\[you]\.claude\
├── CLAUDE.md          ← Global rules (every project reads this)
├── skills\            ← Global skills (Caveman, SEO, etc.)
├── hooks\             ← GSD hooks (auto-fire)
└── settings.json      ← Plugins, permissions, hooks config

D:\Dev\
├── sync-skills.ps1    ← Syncs everything
├── init-project.ps1   ← New project setup
├── _templates\        ← Template files
└── [Project]\
    ├── CLAUDE.md      ← Project-specific
    ├── start.ps1      ← Session launcher
    └── .claude\
        ├── skills\    ← Synced project skills
        └── ecosystem-awareness.md  ← Browser Claude knowledge
```

### Sync command
```powershell
powershell -ExecutionPolicy Bypass -File D:\Dev\sync-skills.ps1
```

Syncs to all projects: skills, commands, start.ps1, ecosystem-awareness.md, .mcp.json.

### New project
```powershell
powershell -ExecutionPolicy Bypass -File D:\Dev\init-project.ps1 -Name "my-app"
# Optional flags:
#   -Design "vercel"        → brand DESIGN.md
#   -TypeUI "glassmorphism"  → style SKILL.md
```

## Browser Claude: One Project for All

Don't create 18 browser projects. Create ONE: "Dev Hub".
- Instructions: paste `browser-instructions.md`
- Files: upload `ecosystem-awareness.md`
- Switch projects mid-conversation: "Switch to Trade-Bot" → Claude reads via MCP

## Context Switching in Claude Code

Each project has its own CLAUDE.md. When you `cd` to a project and run `.\start.ps1`:
1. Global CLAUDE.md loads (skills, security, workflow)
2. Project CLAUDE.md loads (stack, phase, known issues)
3. Git status + recent commits shown
4. Bootstrap prompt pasted → Claude knows exactly where you left off