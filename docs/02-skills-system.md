# 02 — Skills System

## What is a Skill?

A SKILL.md file in `.claude/skills/` that Claude Code reads as context. It teaches Claude HOW to do something — design patterns, coding standards, workflow steps.

## Where Skills Live

```
C:\Users\[you]\.claude\skills\     ← Global (every project)
D:\Dev\[Project]\.claude\skills\   ← Project-specific
```

## How to Install

### Method 1: npx (if auth works)
```
npx skills add owner/repo
```

### Method 2: git clone (always works)
```powershell
cd $env:USERPROFILE\.claude\skills
git clone --depth 1 https://github.com/owner/repo.git
```

### Method 3: Manual
Download SKILL.md → place in `.claude/skills/[name]/SKILL.md`

## How Skills Trigger

Skills don't auto-activate by magic. They trigger when:
1. You use a specific phrase ("spec this feature" → Feature Forge)
2. Claude reads CLAUDE.md and sees the Skill Activation Guide
3. A hook detects context (GSD hooks do this)

### Trigger Phrases
| Skill | Say this |
|-------|----------|
| Feature Forge | "spec this feature" |
| Spec Miner | "reverse engineer this", "document this codebase" |
| The Fool | "challenge this", "red team", "poke holes" |
| Architecture Designer | "design this system", "architecture" |
| API Designer | "design this API", "OpenAPI spec" |
| Caveman | `$caveman` |

## Syncing Skills Across Projects

```powershell
powershell -ExecutionPolicy Bypass -File scripts/sync-skills.ps1
```

This copies skills from your source-of-truth project to all others. Also syncs `ecosystem-awareness.md` and `start.ps1`.