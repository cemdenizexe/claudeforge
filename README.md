# ClaudeForge ⚒️

**Professional developer environment setup framework for Claude Code**

🇬🇧 English | 🇹🇷 [Türkçe](README.tr.md)

> One command. 200+ skills. Automatic security. Session memory. GSD workflow. 60-90% token savings.

---

## What does it do?

ClaudeForge installs and configures Claude Code as a professional development environment — not just an empty terminal.

**Before:** Blank terminal. Every session starts from zero. Claude doesn't know your project.

**After:** 200+ skills active. Security runs automatically. Session memory works. GSD workflow ready. RTK compresses every Bash output by 60-90%.

ClaudeForge is not a standalone product. It installs and configures these tools on your machine:
- [Claude Code](https://github.com/anthropics/claude-code) — Anthropic's terminal AI tool
- [GSD](https://github.com/softworks427/get-shit-done) — Workflow engine (70+ commands)
- [claude-mem](https://github.com/thedotmack/claude-mem) — Session memory
- [Caveman](https://github.com/JuliusBrussee/caveman) — 65-75% token savings
- [RTK](https://github.com/rtk-ai/rtk) — 60-90% Bash output compression
- [Graphify](https://github.com/safishamsi/graphify) — Codebase knowledge graph
- And 200+ skills/plugins

ClaudeForge does not own these tools. Each has its own license.

---

## Disclaimer

ClaudeForge provides no guarantees about the security or privacy of third-party tools it installs. MCP servers run on your local machine and may access your file system. Review tool source code before installation.

---

## Installation

**Requirements:** Node.js, Git, Claude Code, Python 3

### Windows

```powershell
git clone https://github.com/cemdenizexe/claudeforge.git
cd claudeforge
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

### macOS / Linux / WSL

```bash
git clone https://github.com/cemdenizexe/claudeforge.git
cd claudeforge
chmod +x scripts/setup.sh
./scripts/setup.sh
```

The wizard will ask:
1. Your projects directory (`D:\Dev`, `~/Dev`, etc.)
2. Your name (for CLAUDE.md identity)
3. Install Caveman? (token savings)
4. Install GSD? (workflow engine)
5. Install video pipeline? (Seedance, SEO, YouTube)

---

## After Installation

### Using with Claude Code

**Windows** — for each project:
```powershell
cd [project-folder]
.\start.ps1
```

**macOS / Linux / WSL** — for each project:
```bash
cd [project-folder]
./start.sh
```

Paste the bootstrap prompt (copied to clipboard). Claude knows your project instantly.

### Claude Desktop / claude.ai awareness

During setup, `ecosystem-awareness.md` content is copied to clipboard.

**claude.ai:** Projects → Instructions → Ctrl+V

**Claude Desktop:** Filesystem MCP is added automatically. Restart Desktop.

---

## Features

| Feature | What it does | How to use |
|---------|-------------|------------|
| **GSD Workflow** | Plan→Execute→Review→Ship | `gsd plan`, `gsd execute`, `gsd ship` |
| **Caveman** | 65-75% token savings | Type `$caveman` |
| **RTK** | 60-90% Bash output compression | Auto via hook, `rtk gain` for stats |
| **Graphify** | Codebase knowledge graph | `/graphify .` in Claude Code |
| **Security** | Auto security scan on every edit | Runs automatically |
| **Notification** | Windows/Mac popup when Claude needs input | Runs automatically |
| **Self-learning** | Auto-logs errors, fixes, rules to learnings.md | Runs automatically |
| **claude-mem** | Session memory, past decisions | Automatic, `localhost:37777` |
| **Status Bar** | Rate limit, context, model info | Appears at bottom automatically |
| **Skills** | 200+ expert capabilities | Say the trigger phrase |

---

## Token Savings Stack

| Tool | Method | Savings |
|------|--------|---------|
| Caveman | Shorter Claude responses | 65-75% |
| RTK | Bash output compression | 60-90% |
| Graphify | Graph navigation vs raw file reads | up to 71x |
| /compact | Context window compression | situational |
| codeburn | Usage analytics | — |

```
$caveman              → Write every session. 65-75% token reduction.
/compact              → Compress when context window fills up.
rtk gain              → See how many tokens RTK saved this session.
rtk discover --since 1 → See missed savings opportunities.
/graphify .           → Build knowledge graph for new projects.
npx codeburn          → Weekly token spend report.
```

---

## Hooks

ClaudeForge wires these hooks automatically:

| Hook | Trigger | What it does |
|------|---------|-------------|
| SessionStart | Claude Code opens | Banner, RTK init, bootstrap prompt |
| PreToolUse (Edit/Write) | Before file edits | Sensitive file guard |
| PreToolUse (Bash) | Before every Bash call | RTK output compression |
| PreToolUse (Glob/Grep) | Before file search | Graphify hint if graph exists |
| PostToolUse (Bash) | After Bash | Self-learning: logs errors + fixes |
| Notification | Claude needs input | Windows MessageBox / Mac notification |

---

## Skill Triggers

Whatever you tell Claude activates the relevant skill:

```
"spec this feature"        → Feature Forge (requirements analysis)
"design this system"       → Architecture Designer
"red team this"            → The Fool (find what breaks)
"reverse engineer this"    → Spec Miner (code analysis)
"design this API"          → API Designer
"scrape https://..."       → Firecrawl (web scraping)
```

---

## Documentation

| Guide | Content |
|-------|---------|
| [Getting Started](docs/01-getting-started.md) | First project, basic commands |
| [CLAUDE.md](docs/06-claude-md-engineering.md) | How it works, what it contains |
| [Skills System](docs/02-skills-system.md) | What skills are, how to install |
| [GSD Workflow](docs/04-gsd-workflow.md) | Daily workflow |
| [Security](docs/07-security.md) | Automatic hooks |
| [Multi-Project](docs/08-multi-project.md) | Managing 10+ projects |
| [Context Tracking](docs/11-health-check.md) | claude-mem, codeburn, status bar |
| [Skills Library](docs/skills-library.md) | Skills list by category |
| [MCP Servers](docs/12-mcp-servers.md) | Recommended MCPs, install commands |
| [Project Instructions](templates/project-instructions.md) | Ready-to-use instructions template |

---

## License

MIT — for ClaudeForge code. Installed tools have their own licenses.
