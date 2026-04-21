# ClaudeForge ⚒️
### Turn Claude Code from a chatbot into a professional development environment

🇬🇧 [English](README.md) | 🇹🇷 [Türkçe](README.tr.md)

> One setup wizard. 200+ skills. Security autopilot. Self-learning. Multi-project sync.
> Built by [cemdenizexe](https://github.com/cemdenizexe) — managing 18+ projects with a unified workflow.

## What is this?

A battle-tested setup for developers who want to:
- Run Claude Code with **200+ skills** that trigger at the right time
- Use **GSD workflow** (70+ commands, 9 auto-hooks)
- Connect **27 browser connectors** (crypto, finance, design, deployment, AI)
- Manage **multiple projects** from a single ecosystem
- Save **65-75% tokens** with Caveman mode
- Auto-sync skills, configs, and templates across all projects

## Quick Start (5 minutes)

```powershell
git clone https://github.com/cemdenizexe/claudeforge.git
cd claudeforge
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

The wizard will ask:
1. **Where are your projects?** (e.g. `D:\Dev`, `~/projects`)
2. **Your name** (for CLAUDE.md identity)
3. **Install Caveman?** (65-75% token savings)
4. **Install video pipeline?** (Seedance 2.0, SEO, YouTube skills)

Then it auto-installs 18 plugins, skills, security hooks, GSD workflow, and generates your personalized Global CLAUDE.md.

## Documentation

| Guide | What you'll learn |
|-------|-------------------|
| [00 — Usage Guide](docs/00-usage-guide.md) | Daily workflow, 8 real scenarios, token optimization |
| [01 — Getting Started](docs/01-getting-started.md) | Installation, first project, basic commands |
| [02 — Skills System](docs/02-skills-system.md) | SKILL.md files, how to install, trigger phrases |
| [03 — Plugins vs Skills](docs/03-plugins-vs-skills.md) | The difference and why it matters |
| [04 — GSD Workflow](docs/04-gsd-workflow.md) | 70+ commands, 9 hooks, Plan-Execute-Review-Ship |
| [05 — Connectors & MCP](docs/05-connectors-mcp.md) | Browser connectors, filesystem access |
| [06 — CLAUDE.md Engineering](docs/06-claude-md-engineering.md) | Global vs local, what actually gets read |
| [07 — Security](docs/07-security.md) | Vibe coding survival guide |
| [08 — Multi-Project Setup](docs/08-multi-project.md) | Managing 10+ projects, sync scripts |
| [09 — Video Pipeline](docs/09-video-pipeline.md) | Remotion + Seedance 2.0 + auto-publish |
| [10 — Browser-Desktop Bridge](docs/10-browser-desktop-bridge.md) | Claude Desktop and Claude Code together |
| [02 — Skills System](docs/02-skills-system.md) | SKILL.md files, how to install, trigger phrases |
| [03 — Plugins vs Skills](docs/03-plugins-vs-skills.md) | The difference and why it matters |
| [04 — GSD Workflow](docs/04-gsd-workflow.md) | 70+ commands, 9 hooks, Plan-Execute-Review-Ship |
| [05 — Connectors & MCP](docs/05-connectors-mcp.md) | Browser connectors, filesystem access, Desktop Commander |
| [06 — CLAUDE.md Engineering](docs/06-claude-md-engineering.md) | Global vs local, what actually gets read |
| [07 — Security](docs/07-security.md) | Vibe coding survival guide |
| [08 — Multi-Project Setup](docs/08-multi-project.md) | Managing 10+ projects, sync scripts |
| [09 — Video Pipeline](docs/09-video-pipeline.md) | Remotion + Seedance 2.0 + auto-publish |
| [10 — Browser-Desktop Bridge](docs/10-browser-desktop-bridge.md) | Claude Desktop and Claude Code working together |

## Templates

Ready-to-use files in `templates/`:
- `CLAUDE.md` — Global config (skills, security, workflow)
- `project-CLAUDE.md` — Per-project template with bootstrap
- `ecosystem-awareness.md` — Browser Claude knowledge file
- `start.ps1` — Clean session launcher (no bloat)
- `browser-instructions.md` — claude.ai project instructions
- `.mcp.json` — MCP server config

## Recommended Stack

### Plugins (16) — zero redundancy
| Plugin | Purpose |
|--------|---------|
| claude-mem | Session context management, 97% reuse |
| superpowers | Brainstorming, TDD, debugging, parallel agents |
| security-guidance | Auto security check on every edit |
| code-review | 5-agent parallel PR review |
| playwright | Browser test automation |
| semgrep | OWASP static security analysis |
| coderabbit | AI-powered code review (different approach than code-review) |
| github | PR manager, issue tracker, release manager |
| firecrawl | Web scraping and crawling |
| huggingface-skills | ML model and dataset discovery |
| chrome-devtools-mcp | Browser debugging, a11y, LCP |
| code-simplifier | Code-focused simplification (complements Caveman) |
| ui-ux-pro-max | 67 styles, 96 palettes, 57 font pairings |
| obsidian | Markdown vault management |
| document-skills | docx, pdf, pptx, xlsx generation |
| example-skills | Anthropic bundle: frontend-design, canvas, theme-factory, skill-creator |

**Why 16, not 20?** We audited every plugin for redundancy. `frontend-design` and `skill-creator` are already inside `example-skills`. Two extra `superpowers` variants were duplicates. Every plugin in this list has a unique, non-overlapping purpose.

### Skills (6) — `git clone` into `.claude/skills/`
| Skill | Repo | Effect |
|-------|------|--------|
| Caveman | JuliusBrussee/caveman | 65-75% token reduction |
| Claude SEO | AgriciDaniel/claude-seo | 19 SEO sub-skills |
| Claude YouTube | AgriciDaniel/claude-youtube | Channel growth, video SEO |
| Marketing | coreyhaines31/marketingskills | Content strategy |
| Seedance 2.0 | dexhunter/seedance2-skill | AI video prompts |
| Playwright | lackeyjb/playwright-skill | Browser automation |

### Key Concepts

**GSD > RuFlo** for daily work. GSD runs your workflow. RuFlo only spawns parallel agents.

**Memory = Files.** Claude Code has no session memory. CLAUDE.md + git log = memory.

**Skills ≠ Plugins.** Plugins = capabilities. Skills = instructions. Both needed.

**Self-Learning.** Bug found? Add to CLAUDE.md. Never repeated.

## Claude Code Commands

| Command | Purpose |
|---------|---------|
| `/init` | Initialize in current directory |
| `/login` | Authenticate |
| `/compact` | Compress context window |
| `/cost` | Token usage this session |
| `/model` | Switch opus/sonnet |
| `/doctor` | Diagnose issues |
| `$caveman` | Activate token savings |
| `npx codeburn` | 7-day usage dashboard |

## Contributing

PRs welcome. Found a better config? Built a useful skill? Open a PR.

## License

MIT