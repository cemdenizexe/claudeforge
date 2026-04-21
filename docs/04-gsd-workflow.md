# 04 — GSD Workflow

## What is GSD?

Get Shit Done — 70+ skills and 9 hooks that enforce a structured development workflow. It's the primary workflow engine.

## The Cycle

```
Plan → Execute → Review → Debug → Ship
```

Each phase has dedicated commands and guards that prevent skipping steps.

## Hooks (auto-fire)

| Hook | When | What |
|------|------|------|
| gsd-check-update.js | Session start | Check for GSD updates |
| gsd-session-state.sh | Session start | Restore workflow state |
| gsd-context-monitor.js | After every tool use | Track context usage |
| gsd-phase-boundary.sh | After edit/write | Enforce phase transitions |
| gsd-prompt-guard.js | Before edit/write | Validate operations |
| gsd-read-guard.js | Before edit/write | Prevent reading wrong files |
| gsd-workflow-guard.js | Before edit/write | Enforce workflow rules |
| gsd-validate-commit.sh | Before bash (git) | Validate commit format |

## GSD vs RuFlo

| | GSD | RuFlo |
|---|---|---|
| Purpose | Daily workflow | Parallel agents |
| Skills | 70+ | 0 (not a skill provider) |
| Hooks | 9 active | SessionStart only |
| Use when | Every session | Multi-file parallel work |
| Memory | gsd-session-state | Unreliable (errors swallowed) |

**Rule: GSD for daily work. RuFlo only for swarm.**

## GSD vs SPARC

GSD = operational workflow (plan-execute-review-ship).
SPARC = design methodology (Specification-Pseudocode-Architecture-Refinement-Completion).

Use SPARC inside GSD's "Plan" phase for complex features. They complement each other.