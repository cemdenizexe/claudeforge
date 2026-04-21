# Claude Code Commands Cheatsheet

## Session Management
| Command | What it does |
|---------|-------------|
| `/init` | Initialize Claude Code in current directory |
| `/login` | Authenticate with Anthropic |
| `/logout` | Clear auth |
| `/status` | Show project context |
| `/compact` | Compress conversation — saves context window |
| `/clear` | Clear conversation history |
| `/cost` | Token usage this session |
| `/model` | Switch model (opus/sonnet) |
| `/config` | View/edit settings |
| `/memory` | View/search session memory |
| `/doctor` | Diagnose issues |
| `/permissions` | Manage tool permissions |

## Plugin Management
| Command | What it does |
|---------|-------------|
| `/plugin list` | Show installed plugins |
| `/plugin install NAME` | Install a plugin |
| `/plugin uninstall NAME` | Remove a plugin |
| `/plugin marketplace add REPO` | Add marketplace source |
| `/reload-plugins` | Activate newly installed plugins |

## Skills & Tools
| Command | What it does |
|---------|-------------|
| `npx skills add owner/repo` | Install a skill (SKILL.md) |
| `npx codeburn` | 7-day token usage dashboard |
| `npx codeburn today` | Today's usage |
| `npx codeburn month` | Monthly breakdown |
| `$caveman` | Activate Caveman (65-75% token reduction) |

## GSD Workflow Commands
| Command | Phase | What it does |
|---------|-------|-------------|
| `gsd-plan` | Planning | Create structured plan |
| `gsd-execute` | Building | Execute plan step by step |
| `gsd-review` | Review | Review completed work |
| `gsd-debug` | Debugging | Systematic bug investigation |
| `gsd-ship` | Shipping | Pre-deploy checklist |
| `gsd-refactor` | Maintenance | Code improvement |
| `gsd-test` | Testing | Test coverage |

## RuFlo Swarm (parallel agents only)
| Command | What it does |
|---------|-------------|
| `npx ruflo@latest swarm init --topology hierarchical --max-agents 8` | Start parallel agents |
| Agent types: `coder`, `reviewer`, `tester`, `planner`, `researcher` | Core agents |
| Agent types: `security-architect`, `performance-engineer` | Specialized agents |