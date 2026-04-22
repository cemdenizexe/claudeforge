# ClaudeForge ⚒️
### Claude Code için üretim-hazır geliştirici ortamı

🇬🇧 [English](README.md) | 🇹🇷 [Türkçe](README.tr.md)

> Tek kurulum. 200+ skill. Otomatik güvenlik. Self-learning hafıza. Multi-project sync.

---

## Bu nedir?

ClaudeForge; Anthropic'in Claude Code'unu, mevcut açık kaynak araçları, skill'ler ve hook'ları bir araya getirerek profesyonel bir geliştirici ortamına dönüştüren bir **kurulum framework'ü**dür.

Kendi başına bir ürün değildir. Aşağıdaki araçları senin cihazına kurar ve yapılandırır:
- [Claude Code](https://github.com/anthropics/claude-code) — Anthropic'in terminal AI aracı
- [GSD](https://github.com/softworks427/get-shit-done) — workflow engine
- [claude-mem](https://github.com/thedotmack/claude-mem) — session hafızası
- [Caveman](https://github.com/JuliusBrussee/caveman) — token tasarrufu
- [Superpowers](https://github.com/obra/superpowers) — paralel agent framework
- Ve 200+ başka skill/plugin

ClaudeForge bu araçların sahibi değildir. Her aracın kendi lisansı geçerlidir.

---

## Sorumluluk Reddi

> **ÖNEMLİ:** ClaudeForge, yüklediği üçüncü taraf araçların (MCP server'lar, plugin'ler, skill'ler) güvenliği, gizliliği veya güvenilirliği konusunda hiçbir garanti vermez ve sorumluluk kabul etmez. Kurulum öncesinde ilgili araçların kaynak kodunu ve lisanslarını incelemenizi öneririz. MCP server'lar yerel makinenizde çalışır ve dosya sisteminize, ağ bağlantılarınıza veya ortam değişkenlerinize erişebilir. Bilinçli kurulum yapın.

---

## Hızlı Başlangıç (5 dakika)

**Gereksinimler:** Node.js, Git, Claude Code

```powershell
git clone https://github.com/cemdenizexe/claudeforge.git
cd claudeforge
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

Wizard sorar:
1. Projelerinizin dizini (`D:\Dev`, `C:\code` vb.)
2. İsminiz (CLAUDE.md kimliği için)
3. Caveman kurulsun mu? (token tasarrufu)
4. Video pipeline kurulsun mu? (Seedance, SEO, YouTube)
5. GSD kurulsun mu? (workflow engine)

Sonra otomatik: 16 plugin + skill'ler + security hook'ları + GSD + global CLAUDE.md.

---

## Kurulumdan Sonra

Setup tamamlandığında terminal şunu gösterir:

```
ClaudeForge setup complete!

Installed:
  Plugins      16
  Skills       caveman + GSD + seçtikleriniz
  Hooks        session-start, sensitive-file-guard, self-learning, skill-discovery
  Config       Global CLAUDE.md oluşturuldu

Quick start:
  cd [proje-dizini]
  .\start.ps1
  → Bootstrap prompt clipboard'a kopyalanır, yapıştır
```

---

## Dokümantasyon

| Rehber | İçerik |
|--------|--------|
| [Başlangıç](docs/01-getting-started.md) | İlk proje, temel komutlar |
| [CLAUDE.md Rehberi](docs/06-claude-md-engineering.md) | Ne işe yarar, nasıl çalışır |
| [Skill Sistemi](docs/02-skills-system.md) | Skill nedir, nasıl kurulur |
| [GSD Workflow](docs/04-gsd-workflow.md) | Günlük iş akışı |
| [Güvenlik](docs/07-security.md) | Otomatik hook'lar, riskler |
| [Multi-Project](docs/08-multi-project.md) | 10+ proje yönetimi |
| [Context Takibi](docs/11-health-check.md) | claude-mem, codeburn, status bar |

---

## Lisans

MIT — ClaudeForge kodu için. Yüklenen araçların kendi lisansları geçerlidir.
