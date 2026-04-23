# ClaudeForge ⚒️

**Professional developer environment setup framework for Claude Code**

🇬🇧 English | 🇹🇷 [Türkçe](README.tr.md)

> One command. 200+ skills. Automatic security. Session memory. GSD workflow.

---

## What does it do?

ClaudeForge installs and configures Claude Code as a professional development environment — not just an empty terminal.

**Before:** Blank terminal. Every session starts from zero. Claude doesn't know your project.

**After:** 200+ skills active. Security runs automatically. Session memory works. GSD workflow ready.

ClaudeForge is not a standalone product. It installs and configures these tools on your machine:
- [Claude Code](https://github.com/anthropics/claude-code) — Anthropic's terminal AI tool
- [GSD](https://github.com/softworks427/get-shit-done) — Workflow engine (70+ commands)
- [claude-mem](https://github.com/thedotmack/claude-mem) — Session memory
- [Caveman](https://github.com/JuliusBrussee/caveman) — 65-75% token savings
- And 200+ skills/plugins

ClaudeForge does not own these tools. Each has its own license.

---

## Disclaimer

ClaudeForge provides no guarantees about the security or privacy of third-party tools it installs. MCP servers run on your local machine and may access your file system. Review tool source code before installation.

---

## Installation (5 minutes)

**Requirements:** Node.js, Git, Claude Code

```powershell
git clone https://github.com/cemdenizexe/claudeforge.git
cd claudeforge
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

The wizard will ask:
1. Your projects directory (`D:\Dev`, `C:\code`, etc.)
2. Your name (for CLAUDE.md identity)
3. Install Caveman? (token savings)
4. Install video pipeline? (Seedance, SEO, YouTube)
5. Install GSD? (workflow engine)

---

## After Installation

### Using with Claude Code

For each project:
```powershell
cd [project-folder]
.\start.ps1
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
| **Security** | Auto security scan on every edit | Runs automatically |
| **claude-mem** | Session memory, past decisions | Automatic, `localhost:37777` |
| **Status Bar** | Rate limit, context, model info | Appears at bottom automatically |
| **Skills** | 200+ expert capabilities | Say the trigger phrase |

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

## Cost Reduction

```
$caveman              → Write every session. 65-75% token reduction.
/compact              → Compress when context window fills up.
/model                → Switch to haiku for simple tasks.
npx codeburn          → Weekly token spend report.
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
| [MCP Servers](docs/12-mcp-servers.md) | Recommended MCPs, install commands |
| [Project Instructions](templates/project-instructions.md) | Ready-to-use instructions template for any project |

---

## License

MIT — for ClaudeForge code. Installed tools have their own licenses.
