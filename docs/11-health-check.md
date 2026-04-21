# Health Check — codeburn optimize

Run periodically (weekly recommended):

```powershell
npx codeburn optimize
```

## What it detects (11 checks)

| Check | What it finds | Priority |
|-------|-------------|----------|
| Redundant re-reads | Same files read across sessions | High |
| Ghost skills | Installed but never triggered | High |
| Ghost agents | Defined but never invoked | High |
| Missing .claudeignore | node_modules etc. being read | High |
| Read:Edit ratio | Low ratio = editing without reading | Medium |
| Unused MCP servers | Loading tool schemas for nothing | Medium |
| Bloated CLAUDE.md | Over 200 lines = Claude skims | Medium |
| Bash output limit | Default 30K too high, 15K enough | Medium |
| Unused slash commands | Extra tokens per session | Medium |
| Cache overhead | Unnecessary cache creation | Low |
| Junk directory reads | Reading irrelevant directories | Low |

## ClaudeForge defaults that prevent common issues

| Issue | ClaudeForge solution |
|-------|---------------------|
| Missing .claudeignore | Template included, auto-synced |
| Bloated CLAUDE.md | Template under 200 lines |
| No read-before-edit | Rule in Global CLAUDE.md |
| Bash output too high | BASH_MAX_OUTPUT_LENGTH=15000 recommended |

## Interpreting "ghost skills"

GSD skills may appear as "unused" because they trigger contextually, not via direct invocation. Don't archive GSD skills — it breaks the workflow. Only archive skills you're SURE aren't being used (e.g. algorithmic-art if you never make generative art).