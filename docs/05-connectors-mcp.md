# 05 — Connectors & MCP

## Two Access Layers

### MCP Tools (Claude Code + Browser Claude)
Direct filesystem and system access via installed MCP servers:
- **filesystem**: read/write/list/search files
- **Desktop Commander**: read_file with pagination, list_directory with depth, write_file, start_process
- **Windows-MCP**: PowerShell execution, app control, screenshots, clipboard
- **git**: status, log, diff, add, commit, branch, checkout

### Browser Connectors (Browser Claude only)
Data access via claude.ai connected services:

| Category | Connectors | Use case |
|----------|-----------|----------|
| Crypto | Crypto.com, LunarCrush, Blockscout | Price data, sentiment, on-chain |
| Finance | MT Newswires, Massive Market Data | News, SQL queries |
| Design | Figma, Canva, Shadcn UI | Design-to-code, components |
| Backend | Supabase, Netlify | DB management, deployment |
| Communication | Gmail, Google Calendar, Google Drive | Email, scheduling, docs |
| AI/ML | Hugging Face | Models, datasets, spaces |
| Automation | Playwright, Claude in Chrome, Coupler.io | Browser control, data flows |

## Bridge Pattern

Browser Claude can't run code. Claude Code can't access connectors. Solution:

```
Browser Claude
  → reads connector data (LunarCrush sentiment, Crypto.com price)
  → reads project files via MCP (CLAUDE.md, source code)
  → generates a Claude Code prompt with all context
  → you paste it into Claude Code
  → Claude Code executes
```

## Connecting a New Service

1. claude.ai → Settings → Connected Apps
2. Click the service → Authorize
3. It appears in your connector list immediately
4. Update ecosystem-awareness.md if needed