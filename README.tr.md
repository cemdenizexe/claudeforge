# ClaudeForge ⚒️
### Claude Code'u profesyonel geliştirme ortamına dönüştür

🇬🇧 [English](README.md) | 🇹🇷 [Türkçe](README.tr.md)

> Tek kurulum. 200+ skill. Güvenlik otopilotu. Kendi kendine öğrenen sistem. Multi-proje sync.
> [cemdenizexe](https://github.com/cemdenizexe) tarafından geliştirildi.

## Ne işe yarar?

Claude Code'u kullanan çoğu geliştirici şunu yaşıyor:
- 200+ skill yüklü ama hangisi ne zaman çalışır bilmiyor
- Her session sıfırdan başlıyor, önceki hataları tekrarlıyor
- `.env` dosyasını yanlışlıkla commit ediyor
- Token israf ediyor çünkü her iş için aynı modeli kullanıyor
- 10 projesi var ama her birinde farklı config

**ClaudeForge bunların hepsini çözer.**

## Hızlı kurulum (5 dakika)

```powershell
git clone https://github.com/cemdenizexe/claudeforge.git
cd claudeforge
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

Wizard soracak:
1. Projelerinin klasörü (ör: `D:\Dev`)
2. Adın
3. Caveman ister misin? (%65-75 token tasarrufu)
4. Video pipeline ister misin? (Seedance 2.0, SEO, YouTube)

## Özellikler

### ⚡ Task Router — akıllı model seçimi
Her görev geldiğinde Claude otomatik analiz eder:
- Basit iş → Haiku (hızlı, ucuz)
- Orta iş → Sonnet (dengeli)
- Karmaşık → Opus (kaliteli)
- 3+ dosya paralel → Swarm (çoklu agent)

### 🛡️ Güvenlik otopilotu
- Her edit'te XSS, injection, hardcoded secret taraması
- `git add .` yaparken `.env` otomatik engellenir
- `.gitignore` eksikse commit bloklanır
- Tüm bunlar otomatik — token harcamaz

### 🧠 Kendi kendine öğrenme
- Bug fix commit'leri otomatik loglanır
- Sonraki session'da Claude geçmiş hataları görür
- Aynı hatayı tekrarlamaz
- CLAUDE.md şişmez — ayrı `learnings.md` dosyası

### 🔄 Multi-proje sync
- 1 template → tüm projelerine sync
- Yeni proje 30 saniyede hazır
- Skill ekleyince otomatik algılanır (hook)

### 📊 Token dashboard
```powershell
npx codeburn        # 7 günlük kullanım
npx codeburn today  # bugünkü
```

## Dökümanlar

| Rehber | Ne öğreneceksin |
|--------|----------------|
| [00 — Kullanım rehberi](docs-tr/00-kullanim-rehberi.md) | Günlük workflow, 8 senaryo |
| [01 — Başlangıç](docs-tr/01-baslangic.md) | Kurulum, ilk proje |
| [02 — Skill sistemi](docs-tr/02-skill-sistemi.md) | SKILL.md, nasıl kurulur |
| [03 — Plugin vs Skill](docs-tr/03-plugin-vs-skill.md) | Fark ve neden önemli |
| [04 — GSD Workflow](docs-tr/04-gsd-workflow.md) | 70+ komut, Plan-Execute-Ship |
| [05 — Connector & MCP](docs-tr/05-connector-mcp.md) | Browser bağlantıları |
| [06 — CLAUDE.md mühendisliği](docs-tr/06-claude-md.md) | Global vs local |
| [07 — Güvenlik](docs-tr/07-guvenlik.md) | Vibe coding hayatta kalma rehberi |
| [08 — Multi-proje](docs-tr/08-multi-proje.md) | 10+ proje yönetimi |
| [09 — Video pipeline](docs-tr/09-video-pipeline.md) | Remotion + Seedance 2.0 |
| [10 — Browser-Desktop köprüsü](docs-tr/10-browser-desktop.md) | İki Claude birlikte |

## Katkıda bulun

PR'lar açık. Faydalı skill, workflow veya config bulduysanız paylaşın.

## Lisans

MIT