# Global CLAUDE.md — Spade (Cem Deniz)
# C:\Users\cdcem\.claude\CLAUDE.md — read every session, every project

## Identity
User: Spade (Cem Deniz) — Ankara, Turkey. English output. Code comments English. All projects: D:\Dev

## Response Rules
- Direct, precise. No filler, no sycophancy ("Great question!" forbidden).
- Don't narrate. Do it. Length = complexity.
- If user wrong, say so. Never hallucinate APIs/signatures/versions.
- Best-Guess: assume → state 1 line → proceed. Don't over-ask.
- Stuck: blocker + partial progress + 2-3 options. Never loop.

---

## Task Router

Every task, BEFORE coding, output: `[ROUTE] Complexity → Model → Swarm`

| Task | Model | Swarm |
|------|-------|-------|
| Typo, config, 1-line | haiku | no |
| Single-file feature/test | sonnet | no |
| Multi-file, architecture | opus | no |
| 3+ files parallel | opus | yes (3-5) |
| Full audit/refactor | opus | yes (5-8) |

Swarm auto-setup: `claude mcp add ruflo -- npx -y ruflo@latest mcp start` → init → remove after.

## Workflow — GSD Primary
GSD = daily. 70+ skills, 9 hooks. Plan→Execute→Review→Debug→Ship. RuFlo = swarm only.

## Memory
- claude-mem: %97 reuse, observation DB, localhost:37777 dashboard
- CLAUDE.md + .claude/learnings.md + git log = persistent memory
- self-learning hook: fix commits auto-log to learnings.md

---

## Skill Activation Guide

### Always active
- **Caveman** — `/caveman lite|full|ultra`, caveman-commit, caveman-review, caveman-compress
- **claude-mem** — %97 reuse, Investigated/Learned/Completed/Next Steps
- **security-guidance** — every edit: XSS, injection, eval, pickle, secrets
- **code-review** — 5 parallel Sonnet agents, `/code-review`
- **GSD** — gsd-plan, gsd-execute, gsd-review, gsd-debug, gsd-ship, gsd-autonomous, gsd-fast

### New feature
- **Feature Forge** — "spec this feature"
- **Architecture Designer** — "design this system"
- **API Designer** — "design this API" → OpenAPI spec
- **SPARC** — Spec→Pseudo→Arch→Refine→Complete

### Analysis
- **Spec Miner** — "reverse engineer this"
- **The Fool** — "challenge this" / "red team"
- **Superpowers** — brainstorming, TDD, debug, parallel agents

### UI / Design
- **frontend-design** — anti-AI-slop, bold aesthetic
- **ui-ux-pro-max** — 67 styles, 96 palettes, 57 fonts, 99 UX guidelines
- **canvas-design** — manifesto → PDF/PNG
- **theme-factory** — 10 themes + custom
- **awesome-design-md** — 58 brand systems (Apple, Tesla, Stripe, SpaceX...)
- **getdesign** `npx getdesign@latest add [brand]` / **TypeUI** `npx typeui.sh pull [style]`
- **Shadcn UI** / **Figma plugin** / **brand-guidelines**

### SEO — 22 sub-skills
`/seo audit|page|schema|technical|content|geo|images|sitemap <url>`

### Marketing — 35 sub-skills
CRO (6 types), growth, sales, content, analytics, pricing, programmatic-seo

### YouTube — 14 sub-skills
`/youtube audit|seo|script|hook|thumbnail|strategy|calendar|shorts|analytics|monetize|competitor|repurpose|upload|ideas`

### Video
- **Seedance 2.0** — @ reference (img+video+audio), camera, e-commerce, drama
- **Remotion** — D:\Dev\ai-video-channel

### Test: playwright + semgrep + coderabbit
### Scraping: firecrawl + chrome-devtools-mcp + obsidian
### Token: Caveman + caveman-compress + code-simplifier + `/compact`

---

## Projects

Trade-Bot (Python/FastAPI/Binance) → Crypto.com, LunarCrush, Blockscout, MT Newswires
polymarket-bot (Python/Polymarket) → LunarCrush, MT Newswires
NBA-ML (Python/Flask/XGBoost/Next.js) → HuggingFace, Massive Market, Supabase
HabitFlow (RN/Expo/TS) → Figma, Shadcn, Supabase
BagimlilikBirak (Next.js/TS) → Figma, Shadcn, Supabase, Netlify
Mind-Elevator (RN/Expo) → Figma, Supabase, HF
INDIK (Tauri/Vite/Prisma) → Figma, Shadcn
HesapMakinesiPro (Capacitor/Vite) → Figma, Shadcn
SporBeslen → Figma, Supabase, HF
Fıkra (Flutter) → Figma, Supabase
TicTacToeGenerals (Node/Socket.io) → Netlify, Playwright
cpu-commander (C#/.NET→Electron) → Desktop Commander, Windows-MCP
UltimateDealCloser (Python/FastAPI) → Gmail, Calendar, Supabase
ai-video-channel (Remotion/Seedance) → Playwright, SEO, YouTube
n8n (automation) → Gmail, Drive, Coupler.io

---

## Standards
Python: Black, Ruff, Google docstrings, async, type hints. TS: ESLint+Prettier, strict, no any. C#: nullable, DI.
Git: feature/*/bugfix/*/hotfix/*, conventional commits. BANNED: push to main, .env commit.

## Security
Backend: CORS whitelist only, Zod/Pydantic, bcrypt 12, parameterized SQL, no eval/pickle/shell=True/innerHTML.
Frontend: no localStorage secrets, error boundaries, CSP. Mobile: ProGuard, keystore outside project.
Hooks: security_reminder(edit), sensitive-file-guard(git), self-learning(fix commits), skill-discovery(session start), semgrep(on demand).

## Autonomous
DO: read, write, install, test. ASK: delete, push main, modify .env.

## Session
1.CLAUDE.md→2.git status→3.GSD state→4.phase checklist→5.start. Read before edit (4:1 ratio). BASH output ≤15000.