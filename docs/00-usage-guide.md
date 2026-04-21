# Usage Guide — Daily Workflow

> How to actually use this ecosystem day-to-day.

---

## Session Start (Every Time)

```powershell
cd D:\Dev\[your-project]
.\start.ps1
```

What happens:
1. Project info displayed (name, branch, last commit)
2. Bootstrap prompt copied to clipboard
3. Claude Code opens
4. Paste bootstrap → Claude reads CLAUDE.md, checks git, reports status

## Scenario 1: New Feature

```
You: "I need a user authentication system"

Step 1 — Spec it:
> Use Feature Forge to spec a user auth system. Include: email/password login, 
> JWT tokens, password reset flow, rate limiting. List acceptance criteria.

Step 2 — Design it:
> Use Architecture Designer. I need to decide between session-based auth and 
> JWT. Document trade-offs for this project's stack.

Step 3 — Challenge it:
> Use The Fool. Challenge my auth design. Pre-mortem: what could go wrong? 
> Red team: how would an attacker exploit this?

Step 4 — Build it:
> GSD plan: implement auth system per approved spec. Start with data models, 
> then API endpoints, then frontend. $caveman

Step 5 — Review it:
> Run code-review and semgrep on all auth-related files. Check OWASP top 10.
```

## Scenario 2: Bug Fix

```
You: "Login is returning 500 error on production"

> Use gstack-investigate on src/auth/. Check git log for recent changes 
> to auth files. Run tests. Report root cause and fix options.
```

## Scenario 3: Existing Codebase Analysis

```
You: "I inherited this project and need to understand it"

> Use Spec Miner. Reverse engineer this codebase. Document: architecture, 
> data flow, API contracts, dependencies, gaps, and edge cases.
```

## Scenario 4: API Design

```
You: "Design the REST API for our newsletter feature"

> Use API Designer. Design REST API for newsletter system. Endpoints: 
> subscribe, unsubscribe, send digest, get history. Include OpenAPI spec, 
> request/response schemas, auth requirements, rate limits.
```

## Scenario 5: UI Development

```
You: "Build a dashboard page for crypto trading"

> Use frontend-design skill. Check DESIGN.md for brand tokens. 
> Use Shadcn UI components. Responsive, dark mode, real-time data updates.
> Reference Figma if design exists.
```

## Scenario 6: Deploy

```
You: "Ready to deploy"

> Pre-deploy checklist:
> 1. Run all tests
> 2. npm audit / pip audit
> 3. git status — no .env staged
> 4. Verify CORS whitelist (no wildcard)
> 5. Check console.log guards
> 6. Conventional commit format
> Use gsd-ship.
```

## Scenario 7: Architecture Decision

```
You: "Should we use microservices or monolith?"

> Use Architecture Designer. Compare monolith vs microservices for our 
> current scale (3 devs, 10k users). Document: cost, complexity, deployment, 
> scaling. Then use The Fool to challenge the recommendation.
```

## Scenario 8: Video Production

```
You: "Create a video about Claude Code skills"

Step 1 — Research:
> Search for latest Claude Code skill developments. Check GitHub trending. 
> Pull data from HuggingFace for ML-related skills.

Step 2 — Script:
> Write a 5-minute script. Use Claude SEO for keyword optimization. 
> Use Claude YouTube for hook and retention patterns.

Step 3 — Visuals:
> Use Seedance 2.0 skill to generate video prompts for Higgsfield. 
> Style: tech tutorial, clean, dark mode aesthetic.

Step 4 — Render:
> cd D:\Dev\ai-video-channel
> npm run dev  (preview)
> npx remotion render src/index.ts VideoComp out/video.mp4

Step 5 — Publish:
> Use Playwright to upload to YouTube. Use Claude YouTube for metadata 
> (title, description, tags). Schedule via n8n.
```

---

## Token Optimization

### Start every session with Caveman
```
$caveman
```
Saves 65-75% output tokens. Code quality unchanged — only prose compressed.

### Use /compact when context fills up
```
/compact
```
Compresses conversation history. Use when Claude starts forgetting earlier context.

### Check usage
```
npx codeburn          # 7-day dashboard
npx codeburn today    # today only
/cost                 # current session
```

---

## Multi-Project Switching

### In Claude Code
```powershell
# Close current session, open new project
cd D:\Dev\[other-project]
.\start.ps1
```

### In Browser Claude (Dev Hub project)
```
"Switch to Trade-Bot. Read its CLAUDE.md and give me a status report."
"Now switch to HabitFlow. What's the current phase?"
"Generate a Claude Code prompt for adding push notifications to HabitFlow."
```

---

## Sync After Changes

When you update templates, skills, or ecosystem-awareness:
```powershell
powershell -ExecutionPolicy Bypass -File D:\Dev\sync-skills.ps1
```

Syncs to all 14+ projects: skills, start.ps1, ecosystem-awareness.md.

---

## Self-Learning

After every session, if you discovered something important:

### Bug pattern found
Add to project CLAUDE.md:
```markdown
## Known Issues
- [date]: [description]. Fix: [solution]. NEVER [what to avoid].
```

### Architecture decision made
```markdown
## Architecture Decisions
- [date]: Chose [option] over [alternative]. Reason: [why]. Trade-off: [what we gave up].
```

### Dependency broken
```markdown
## NEVER
- NEVER use [package] — causes [problem]. Use [alternative] instead.
```

Claude reads CLAUDE.md every session. Write it once → never repeated.

---

## Connector Usage (Browser Claude)

### Crypto analysis
```
"Pull BTC sentiment from LunarCrush. Check Blockscout for whale movements 
in the last 24h. Get latest crypto news from MT Newswires. Summarize and 
generate a Trade-Bot newsletter draft."
```

### Design workflow
```
"Open the HabitFlow Figma file. Extract the design context for the 
onboarding screen. Generate a React Native component using Shadcn UI 
patterns. Create a Claude Code prompt to implement it."
```

### Database management
```
"Check the Supabase tables for BagimlilikBirak. List all migrations. 
Are there any missing indexes on frequently queried columns?"
```

---

## Self-Learning System

### How it works

```
You commit: git commit -m "fix: WebSocket reconnect crash on timeout"
                ↓
self-learning.js hook fires (PostToolUse)
                ↓
Auto-appends to .claude/learnings.md:
  - [2026-04-21] fix: WebSocket reconnect crash on timeout
                ↓
Next session: SessionStart hook reads last 10 learnings
                ↓
Claude sees the bug history and avoids repeating it
```

### File structure
```
[project]/
├── CLAUDE.md                  ← Project rules (stack, phase, bootstrap)
└── .claude/
    └── learnings.md           ← Auto-generated bug/decision log (never edit CLAUDE.md for this)
```

### What gets auto-logged
- `fix:` commits
- `bugfix:` commits  
- `hotfix:` commits

### What you add manually
Open `.claude/learnings.md` and add:
```markdown
- [2026-04-21] decision: Chose SQLite over PostgreSQL — simpler for MVP, migrate later
- [2026-04-21] NEVER: Don't use pandas_ta — import conflicts. Pure numpy only.
```

### Why not CLAUDE.md?
CLAUDE.md is for permanent project rules. Learnings are incremental.
If CLAUDE.md grows to 500+ lines, Claude starts skimming. Separate file = both stay readable.