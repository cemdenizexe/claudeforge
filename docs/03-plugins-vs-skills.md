# 03 — Plugins vs Skills

## The Confusion

Everyone mixes these up. They're completely different systems.

## Plugins

- Installed via `/plugin install NAME`
- Live in Claude Code's internal registry
- Provide **capabilities** (tools Claude can use)
- Examples: playwright (browser control), semgrep (static analysis), github (PR management)
- Managed with `/plugin list`, `/plugin uninstall`

## Skills

- SKILL.md files in `.claude/skills/`
- Just text files Claude reads as context
- Provide **instructions** (how to do things)
- Examples: Caveman (write shorter), Claude SEO (SEO workflow), Feature Forge (spec template)
- Installed via git clone or manual copy

## How They Work Together

```
Plugin: playwright        → gives Claude the ABILITY to control a browser
Skill: playwright-skill   → teaches Claude WHEN and HOW to use browser automation well
```

Both needed. Plugin without skill = capability without strategy. Skill without plugin = instructions without tools.

## Third System: Hooks

- JavaScript/shell scripts in `.claude/hooks/`
- Fire automatically on events (SessionStart, PreToolUse, PostToolUse)
- GSD uses 9 hooks for workflow enforcement
- security_reminder_hook.py fires on every edit

## Fourth System: Connectors (Browser Claude only)

- Connected in claude.ai settings
- Provide data access (Crypto.com prices, LunarCrush sentiment, Supabase DB)
- Not available in Claude Code directly
- Bridge: browser Claude reads data → generates Claude Code prompt with that data