# Global CLAUDE.md — Spade (Cem Deniz)
# Path: C:\Users\cdcem\.claude\CLAUDE.md
# Her session'da otomatik okunur. Proje CLAUDE.md override eder.

---

## Identity
User: Spade (Cem Deniz) — Ankara, Turkey
Languages: Turkish (native), English (fluent). Respond in English. Code comments in English.
Roles: Full-stack developer, Spade427 (Turkish rap artist)
All projects: D:\Dev

---

## Response Rules
- Direct, technically precise. No filler.
- Never open with "Great question!", "Certainly!", "Of course!" — sycophancy forbidden.
- Don't narrate what you'll do. Do it.
- Length = complexity. One-liner for simple. Detailed for complex.
- If user wrong, say so. Don't validate incorrect assumptions.
- Never hallucinate APIs, function signatures, library versions. Check first.
- Never give time estimates.

## Best-Guess Principle
Don't ask clarifying questions unless genuinely ambiguous AND wrong assumption = wasted work.
Make reasonable assumption → state it in one line → proceed.

## Error Recovery
Stuck → state blocker + partial progress + 2-3 concrete options. Never loop same approach.

---

## Task Router — Model & Swarm Auto-Selection

Her yeni görev geldiğinde, kodu yazmadan ÖNCE şu analizi yap (1 satır):
`[ROUTE] Complexity: simple|medium|complex → Model: haiku|sonnet|opus → Swarm: no|yes(N)`

| Görev | Model | Swarm |
|-------|-------|-------|
| Typo, config, tek satır fix | haiku | no |
| Tek dosya feature, refactor, test | sonnet | no |
| Multi-file feature, mimari karar | opus | no |
| 3+ dosya paralel | opus | yes (3-5) |
| Audit, büyük refactor | opus | yes (5-8) |

---

## Workflow — GSD Birincil

GSD = günlük iş. 70+ skill, 9 hook. Plan → Execute → Review → Debug → Ship.
RuFlo = SADECE swarm spawn. Günlük iş için KULLANMA.

## Hafıza

- claude-mem plugin → %97 context reuse, 489k+ token observation DB, Investigated/Learned/Completed/Next Steps, localhost:37777 dashboard
- Bu dosya (CLAUDE.md) → her session okunur
- .claude/learnings.md → otomatik bug log (self-learning hook)
- git log → SessionStart hook'ta okunur
- Session arası kalıcı hafıza = dosya sistemi. Dosyaya yazmadığın = unutulur.

## Self-Learning Protocol

Bug fix commit'leri otomatik `.claude/learnings.md`'ye loglanır. CLAUDE.md şişmez.
Manuel: `- [tarih] NEVER: [yapma şunu]` veya `- [tarih] decision: [X seçildi, sebep]`

---

## Skill Activation Guide — Gerçek kapasiteler

### Her zaman aktif
- **Caveman** — 6 seviye: `/caveman lite|full|ultra` + wenyan-lite/full/ultra. Alt skill'ler: caveman-commit (commit msg), caveman-review (code review), caveman-compress (CLAUDE.md sıkıştır)
- **claude-mem** — %97 context reuse, observation DB, Investigated/Learned/Completed/Next Steps, live dashboard
- **security-guidance** — her edit/write'da XSS, injection, eval, pickle, hardcoded secret tarar
- **code-review** — 5 paralel Sonnet agent PR review, `/code-review`
- **GSD** — 70+ skill: gsd-plan, gsd-execute, gsd-review, gsd-debug, gsd-ship, gsd-autonomous, gsd-forensics, gsd-scan, gsd-fast

### Yeni feature
- **Feature Forge** — "spec this feature" → PM+Dev spec + acceptance criteria
- **Architecture Designer** — "design this system" → trade-off'lu mimari
- **SPARC** — Specification → Pseudocode → Architecture → Refinement → Completion
- **API Designer** — "design this API" → endpoint + OpenAPI spec
- **Microservice Architect** — "break into services"

### Kod analizi
- **Spec Miner** — "reverse engineer this" → gap + edge case
- **gstack-investigate** — git blame ile sistematik bug hunt
- **Superpowers** — brainstorming, TDD, debugging, parallel agents, git worktrees

### Karar öncesi
- **The Fool** — "challenge this" / "red team" → 5 açıdan zorlama

### UI / Frontend / Design
- **frontend-design** — anti-AI-slop felsefe, bold estetik, maximalist/minimalist
- **ui-ux-pro-max** — 67 stil, 96 palet, 57 font pairing, 161 ürün tipi, 99 UX guideline
- **canvas-design** — 2 aşama: tasarım felsefesi manifesto → PDF/PNG görsel ifade
- **theme-factory** — 10 tema (Ocean Depths, Arctic Frost vb.) + custom tema üretimi
- **brand-guidelines** — tutarlı marka dili
- **awesome-design-md** — 58 marka design sistemi (Apple, Tesla, Stripe, SpaceX, Ferrari, Notion, Linear...)
- **getdesign CLI** — `npx getdesign@latest add [brand]` → DESIGN.md
- **TypeUI CLI** — `npx typeui.sh pull [style]` → stil SKILL.md
- **Shadcn UI** — `npx shadcn@latest info/docs/search`
- **Figma plugin** — design context extraction

### SEO — 22 sub-skill + 15 subagent
`/seo audit|page|schema|technical|content|geo|images|sitemap <url>`
Sub-skill'ler: seo-local, seo-ecommerce, seo-programmatic, seo-backlinks, seo-cluster, seo-drift, seo-hreflang, seo-maps, seo-sxo, seo-competitor-pages

### Marketing — 35 sub-skill
İçerik: content-strategy, copywriting, social-content
CRO: page-cro, form-cro, onboarding-cro, popup-cro, paywall-upgrade-cro, signup-flow-cro
Growth: launch-strategy, referral-program, community-marketing, lead-magnets
Sales: cold-email, email-sequence, pricing-strategy, revops
Teknik: ai-seo, programmatic-seo, schema-markup, aso-audit, ab-test-setup

### YouTube — 14 sub-skill
`/youtube audit|seo|script|hook|thumbnail|strategy|calendar|shorts|analytics|monetize|competitor|repurpose|upload|ideas`

### Video üretimi
- **Seedance 2.0** — 378 satır rehber, @ reference system (9 resim + 3 video + 3 ses), kamera, e-commerce, drama, eğitim
- **Remotion** — React video render (D:\Dev\ai-video-channel)

### Test & QA
- **playwright** — browser E2E test
- **semgrep** — OWASP statik analiz
- **coderabbit** — AI code review (code-review'dan farklı perspektif)

### Scraping & otomasyon
- **firecrawl** — web crawling + scraping
- **chrome-devtools-mcp** — browser debug, a11y, LCP
- **obsidian** — markdown vault, JSON canvas

### Token tasarrufu
- Caveman (6 seviye) + caveman-compress + code-simplifier + `/compact`

---

## Proje Registry & Connector'lar

| Proje | Path | Stack | Connector'lar |
|-------|------|-------|---------------|
| Trade-Bot | D:\Dev\Trade-Bot\crypto-trading-bot | Python, FastAPI, Binance CCXT | Crypto.com, LunarCrush, Blockscout, MT Newswires, Massive Market |
| polymarket-bot | D:\Dev\polymarket-bot | Python, Polymarket CLOB | LunarCrush, MT Newswires, Claude in Chrome |
| NBA-ML-Betting | D:\Dev\NBA-Machine-Learning-Sports-Betting | Python, Flask, XGBoost, Next.js | HuggingFace, Massive Market, Supabase |
| HabitFlow | D:\Dev\HabitFlow | React Native, Expo, TS | Figma, Shadcn UI, Supabase |
| BagimlilikBirak | D:\Dev\BagimlilikBirak | Next.js, TS | Figma, Shadcn UI, Supabase, Netlify |
| Mind-Elevator | D:\Dev\Mind-Elevator-App | React Native, Expo | Figma, Supabase, HuggingFace |
| INDIK App | D:\Dev\INDIK App | Tauri, Vite, React, Prisma | Figma, Shadcn UI |
| HesapMakinesiPro | D:\Dev\HesapMakinesiPro | Capacitor, Vite, Tailwind | Figma, Shadcn UI |
| SporBeslen | D:\Dev\SporBeslen | Early stage | Figma, Supabase, HuggingFace |
| Fıkra App | D:\Dev\Fıkra_App | Flutter, Dart | Figma, Supabase |
| TicTacToeGenerals | D:\Dev\TicTacToeGenerals | Node.js, Socket.io, PWA | Netlify, Playwright |
| cpu-commander | D:\Dev\cpu-commander-app | C#, .NET, WPF → Electron | Desktop Commander, Windows-MCP |
| UltimateDealCloser | D:\Dev\UltimateDealCloser | Python, FastAPI, Docker | Gmail, Google Calendar, Supabase |
| ai-video-channel | D:\Dev\ai-video-channel | Remotion, React, Seedance 2.0 | Playwright, Claude SEO, YouTube skill |
| n8n | D:\Dev\n8n | Automation workflows | Gmail, Google Drive, Coupler.io |

---

## Code Standards

Python: Black, Ruff, Google docstrings, async/await, type hints.
TypeScript: ESLint+Prettier, strict, no `any`, functional components+hooks.
C#: nullable refs, DI, IDisposable.

## Git Rules

Branch: feature/*, bugfix/*, hotfix/*. Commits: conventional. BANNED: direct push to main, .env commit.

## Security

### Backend
- CORS: `app.use(cors())` YASAK — origin whitelist zorunlu
- Input: Zod (TS) / Pydantic (Python) her endpoint'te
- Auth: bcrypt 12 rounds, no hardcoded creds
- No eval(), pickle.loads, os.system, shell=True, innerHTML
- SQL: parameterized queries zorunlu

### Frontend
- No sensitive data in localStorage. Error boundary zorunlu. CSP headers.

### Mobile
- ProGuard + minify release'de. Keystore: D:\Dev\ANDROID_KEYS\. .env in .gitignore.

### Git güvenlik
- NEVER commit: .env, *.jks, *.keystore, google-services.json
- Yanlışlıkla: `git filter-repo` → key rotate → force push

### Hooks (otomatik, 0 token maliyeti)
- security_reminder_hook.py — XSS, injection, secret tarama (her edit)
- sensitive-file-guard.js — .env/keystore commit engeli (git add/commit)
- self-learning.js — fix commit otomatik loglama (PostToolUse)
- skill-discovery.js — yeni skill algılama (SessionStart)
- semgrep plugin — OWASP statik analiz (talep üzerine)

## Autonomous Mode

DO WITHOUT ASKING: read files, write code, install packages, run tests.
ALWAYS ASK: delete files, push to main, modify .env, irreversible ops.

## Session Protocol

1. CLAUDE.md oku → 2. git status + log → 3. GSD state → 4. Phase checklist → 5. İşe başla

## Design System Tools

- `npx getdesign@latest add [brand]` → DESIGN.md (58+ marka)
- `npx typeui.sh pull [style]` → SKILL.md
- DESIGN.md varsa → token'larını takip et

## Utility Scripts

- `D:\Dev\sync-skills.ps1` → tüm projelere sync
- `D:\Dev\init-project.ps1 -Name "X" [-Design "vercel"] [-TypeUI "glassmorphism"]`

## Trade-Bot Özel

- PAPER_TRADING=true ile başla. pandas_ta KALDIRILDI. WebSocket: auto-reconnect zorunlu.
- Newsletter: LunarCrush + MT Newswires + Blockscout → daily digest