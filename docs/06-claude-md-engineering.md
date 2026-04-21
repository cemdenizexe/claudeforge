# 06 — CLAUDE.md Engineering

## What Gets Read (and what doesn't)

Claude Code reads these files automatically every session:

```
1. C:\Users\[you]\.claude\CLAUDE.md     ← GLOBAL (always)
2. [project-dir]\CLAUDE.md              ← PROJECT (if exists)
3. [project-dir]\.claude\CLAUDE.md      ← PROJECT ALT (if exists)
```

**NOT automatically read:**
- `D:\Dev\GLOBAL_CLAUDE.md` — despite the name, Claude Code ignores it
- `ecosystem-awareness.md` — for browser Claude, not Claude Code
- Any `.md` file not named CLAUDE.md in the above paths

## Global CLAUDE.md

Location: `C:\Users\[you]\.claude\CLAUDE.md`

This is your most powerful file. It runs in EVERY project. Contents:
- Identity and response rules
- Skill Activation Guide (which skill, which trigger phrase)
- Security rules (backend, frontend, mobile, git)
- GSD workflow declaration
- Project registry with connector mapping
- Self-learning protocol
- Code standards and git rules

## Project CLAUDE.md

Location: `[project-dir]\CLAUDE.md`

Project-specific overrides. Contents:
- Tech stack
- Bootstrap prompt
- Phase checklist
- Architecture decisions
- Known issues / "NEVER do X" rules
- Project-specific commands

## Self-Learning Protocol

The most powerful pattern: teach Claude from mistakes.

```markdown
## Known Issues
- pandas_ta REMOVED — causes import conflicts. Use pure numpy.
- WebSocket: MUST have auto-reconnect + exponential backoff.

## Architecture Decisions
- 2024-03: Switched from MongoDB to SQLite for simplicity.
- 2025-01: Rejected Redis caching — overkill for current scale.
```

Write it once → Claude never repeats the mistake in that project.

## Anti-Patterns

- ❌ Putting skill instructions in CLAUDE.md (use Skill Activation Guide instead)
- ❌ Making CLAUDE.md 500+ lines (Claude skims long files)
- ❌ Duplicating global rules in project CLAUDE.md (global already applies)
- ❌ "See also: other-file.md" (Claude Code won't follow links)