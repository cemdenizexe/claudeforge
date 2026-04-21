# Kullanım rehberi — Günlük workflow

## Session başlatma

```powershell
cd D:\Dev\[proje]
.\start.ps1
```

Bootstrap prompt clipboard'a kopyalanır. Claude Code açılınca yapıştır.

## Senaryo 1: Yeni feature

```
Sen: "Kullanıcı kayıt sistemi lazım"

Adım 1 — Spec çıkar:
> Use Feature Forge to spec a user registration system.

Adım 2 — Mimariyi tasarla:
> Use Architecture Designer. Session vs JWT karşılaştır.

Adım 3 — Zorlama testi:
> Use The Fool. Red team: bu tasarımda ne yanlış gidebilir?

Adım 4 — Kodla:
> GSD plan: kayıt sistemi spec'e göre. $caveman

Adım 5 — Review:
> code-review ve semgrep çalıştır. OWASP top 10 kontrol.
```

## Senaryo 2: Bug fix

```
> Use gstack-investigate on src/auth/. Son commit'leri kontrol et.
> Root cause ve fix önerisi sun.
```

## Senaryo 3: Mevcut kodu anla

```
> Use Spec Miner. Bu codebase'i reverse engineer et.
> Mimari, veri akışı, gap'ler ve edge case'leri dokümante et.
```

## Senaryo 4: API tasarımı

```
> Use API Designer. Newsletter sistemi için REST API tasarla.
> Endpoint'ler, schema'lar, rate limit, OpenAPI spec.
```

## Senaryo 5: UI geliştirme

```
> Use frontend-design. DESIGN.md'deki brand token'ları kullan.
> Shadcn UI component'leri, responsive, dark mode.
```

## Senaryo 6: Deploy

```
> Deploy öncesi checklist: test, npm audit, git status,
> CORS whitelist, console.log guard. gsd-ship kullan.
```

## Senaryo 7: Video üretimi

```
Adım 1: Research → web search + connector'lar
Adım 2: Script → Claude SEO ile optimize
Adım 3: Görseller → Seedance 2.0 skill ile Higgsfield prompt'ları
Adım 4: Render → cd D:\Dev\ai-video-channel && npx remotion render
Adım 5: Yayınla → Playwright ile YouTube upload
```

## Task Router

Claude her görevde otomatik analiz yapar:

```
[ROUTE] Complexity: simple → Model: haiku → Swarm: no
[ROUTE] Complexity: medium → Model: sonnet → Swarm: no
[ROUTE] Complexity: complex → Model: opus → Swarm: yes (4 agents)
```

## Token tasarrufu

- `$caveman` → %65-75 output azaltma
- `/compact` → context sıkıştırma
- `npx codeburn` → kullanım dashboard'u
- Task Router → basit iş haiku'ya, karmaşık opus'a

## Self-learning

Bug fix commit ettiğinde otomatik `.claude/learnings.md`'ye yazılır.
Sonraki session'da Claude geçmiş hataları görür ve tekrarlamaz.