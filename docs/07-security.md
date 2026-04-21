# Security — Vibe Coding Survival Guide

> AI-assisted coding is fast. But speed without guardrails = vulnerabilities at scale.

## The Problem

When Claude writes code, it optimizes for "works." Security is secondary unless you make it primary. This guide makes it primary.

## Automated Guards (already running)

These hooks fire on every edit/write in Claude Code:
- `security-guidance` plugin — scans for XSS, injection, eval, pickle, hardcoded secrets
- `security_reminder_hook.py` — Anthropic security patterns
- `semgrep` plugin — OWASP static analysis
- `gsd-prompt-guard.js` — prevents unsafe operations

## Rules by Layer

### Backend
- CORS: `app.use(cors())` is BANNED — origin whitelist only
- Input validation: Zod (TypeScript) / Pydantic (Python) on every endpoint
- Auth: bcrypt 12 rounds minimum, no hardcoded credentials
- SQL: parameterized queries only, string concatenation is BANNED
- Rate limiting: must survive server restart (Redis-backed)
- No eval(), no pickle.loads, no os.system, no shell=True, no exec()
- console.log: guard with `process.env.NODE_ENV !== 'production'`

### Frontend
- No sensitive data in localStorage
- No innerHTML, no dangerouslySetInnerHTML — XSS risk
- Error boundaries required (React)
- CSP headers in production
- Minimize external CDN dependencies

### Mobile / Android
- `minifyEnabled true` + ProGuard in release builds
- AndroidManifest: only actually-used permissions
- No API keys in manifest or source code
- Keystores stored outside project directory, never in git

### Git
- NEVER commit: .env, *.jks, *.keystore, google-services.json, API keys
- If accidentally committed: `git filter-repo` → rotate key → force push
- Pre-commit: `git status` check, no secrets staged
- Conventional commits: feat|fix|refactor|docs|test|chore

### Dependencies
- `npm audit` / `pip audit` before every deploy
- Known vulnerability = fix or document, never ignore
- Outdated critical dependency = security risk

## Common AI Coding Mistakes

| Mistake | Why it happens | Fix |
|---------|---------------|-----|
| `app.use(cors())` | Claude defaults to permissive | Add origin whitelist to CLAUDE.md |
| Hardcoded API key | Quick demo code | .env + CLAUDE.md rule |
| No input validation | "It works" mindset | Zod/Pydantic on every endpoint |
| eval() / pickle.loads | Convenience | Explicit parsing |
| Committing .env | Forgot .gitignore | Pre-commit hook |

## Breach Response Checklist

1. Revoke all tokens (API keys, OAuth, deploy tokens)
2. Rotate credentials (database, third-party services)
3. Audit git history: `git log --all -p -- .env`
4. Remove cached credentials: `git filter-repo`
5. Force push cleaned history
6. Update CLAUDE.md with "NEVER" rule for the vector