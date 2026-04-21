# Ecosystem Awareness — Spade Dev
> Bu dosyayı claude.ai proje Files'a yükle. Browser Claude tüm araçları bilir.

## Aktif araçlar
- **GSD**: 70+ skill, 9 hook. Plan→Execute→Review→Debug→Ship. Birincil workflow.
- **Caveman**: Token %65-75 azaltır. `$caveman` ile aktive et.
- **200+ plugin**: security-guidance, code-review, playwright, semgrep, coderabbit, firecrawl, huggingface, github, superpowers, frontend-design, shadcn, obsidian, chrome-devtools
- **RuFlo**: SADECE swarm (paralel agent). Günlük iş için değil.

## Skill tetikleme
- Yeni feature → Feature Forge ("spec this feature")
- Mimari karar → Architecture Designer ("design this system")
- Kod analizi → Spec Miner ("reverse engineer this")
- Karar zorlama → The Fool ("challenge this" / "red team")
- API tasarımı → API Designer ("design this API")
- UI/Frontend → frontend-design + Shadcn UI + DESIGN.md + Figma
- Test → Playwright + semgrep + coderabbit
- Video → Seedance 2.0 + Remotion + Claude SEO + YouTube skill
- Token tasarruf → Caveman + `/compact`

## Connector'lar (browser Claude erişir)
Crypto.com, LunarCrush, Blockscout, MT Newswires, Massive Market Data,
Figma, Canva, Supabase, Netlify, Gmail, Google Calendar, Google Drive,
HuggingFace, Playwright, Claude in Chrome, Coupler.io

## MCP araçlar (dosya erişimi)
filesystem, Desktop Commander, Windows-MCP, git — browser'dan dosya oku/yaz yapabilirsin.
Proje CLAUDE.md: `D:\Dev\[ProjeAdı]\CLAUDE.md` — her zaman önce oku.

## Hafıza
Session arası hafıza YOK. CLAUDE.md + git log = hafıza. Dosyaya yazmadığın = unutulur.

## Claude Code prompt verirken
- Skill adını referans et (Feature Forge, Spec Miner, The Fool vb.)
- GSD komutlarını kullan (gsd-plan, gsd-execute, gsd-review)
- Connector verisi gerekiyorsa belirt (LunarCrush, Blockscout vb.)
- Swarm sadece paralel iş için: `npx ruflo@latest swarm init`
- Caveman aktif olsun: `$caveman`
- **Task Router**: her prompt'un başına model önerisi ekle:
  - Simple → `[MODEL: haiku] [SWARM: no]`
  - Medium → `[MODEL: sonnet] [SWARM: no]`
  - Complex → `[MODEL: opus] [SWARM: no]`
  - Complex + 3+ dosya → `[MODEL: opus] [SWARM: yes — agent listesi]`