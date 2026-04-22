# ClaudeForge ⚒️

**Claude Code için profesyonel geliştirici ortamı kurulum framework'ü**

🇹🇷 [Türkçe](README.tr.md) | 🇬🇧 English

> Tek komut. 200+ skill. Otomatik güvenlik. Session hafızası. GSD workflow.

---

## Ne yapar?

ClaudeForge, Anthropic'in Claude Code'unu kutudan çıkardığınız haliyle değil — profesyonel bir geliştirici ortamı olarak kurar.

**Kurulmadan önce:** Boş terminal. Her session sıfırdan başlar. Claude projenizi tanımaz.

**Kurulduktan sonra:** 200+ skill aktif. Güvenlik otomatik çalışır. Session hafızası var. GSD workflow hazır.

ClaudeForge kendi başına bir ürün değildir. Şu araçları sizin cihazınıza kurar ve yapılandırır:
- [Claude Code](https://github.com/anthropics/claude-code) — Anthropic'in terminal AI aracı
- [GSD](https://github.com/softworks427/get-shit-done) — Workflow engine (70+ komut)
- [claude-mem](https://github.com/thedotmack/claude-mem) — Session hafızası
- [Caveman](https://github.com/JuliusBrussee/caveman) — %65-75 token tasarrufu
- Ve 200+ skill/plugin

ClaudeForge bu araçların sahibi değildir. Her aracın kendi lisansı geçerlidir.

---

## Sorumluluk Reddi

ClaudeForge, kurduğu üçüncü taraf araçların güvenliği veya gizliliği konusunda garanti vermez. MCP server'lar yerel makinenizde çalışır ve dosya sisteminize erişebilir. Kurulum öncesinde araçların kaynak kodunu incelemenizi öneririz.

---

## Kurulum (5 dakika)

**Gereksinimler:** Node.js, Git, Claude Code

```powershell
git clone https://github.com/cemdenizexe/claudeforge.git
cd claudeforge
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

Setup sırasında sorulacaklar:
1. Projelerinizin bulunduğu klasör (`D:\Dev`, `C:\code` vb.)
2. İsminiz (CLAUDE.md kimliği için)
3. Caveman kurulsun mu? (token tasarrufu)
4. Video pipeline kurulsun mu? (Seedance, SEO, YouTube)
5. GSD kurulsun mu? (workflow engine)

---

## Kurulumdan Sonra

### Claude Code ile kullanım

Her projede:
```powershell
cd [proje-klasoru]
.\start.ps1
```

Bootstrap prompt yapıştırın (clipboard'a kopyalanır). Claude projeyi tanır, sıfırdan anlatmak gerekmez.

### Claude Desktop / claude.ai farkındalığı

Setup sırasında `ecosystem-awareness.md` içeriği clipboard'a kopyalanır.

**claude.ai kullanıyorsanız:** Projects → Instructions → Ctrl+V

**Claude Desktop kullanıyorsanız:** Filesystem MCP setup sırasında otomatik eklenir. Desktop'ı yeniden başlatın.

---

## Özellikler

| Özellik | Ne yapar | Nasıl kullanılır |
|---------|----------|-----------------|
| **GSD Workflow** | Plan→Execute→Review→Ship | `gsd plan`, `gsd execute`, `gsd ship` |
| **Caveman** | %65-75 token tasarrufu | `$caveman` yazın |
| **Security** | Her düzenlemede otomatik güvenlik taraması | Kendiliğinden çalışır |
| **claude-mem** | Session hafızası, geçmiş kararlar | Otomatik, `localhost:37777` |
| **Status Bar** | Rate limit, context, model bilgisi | Altta otomatik görünür |
| **Skill'ler** | 200+ uzman yetenek | Tetikleyici cümle söyleyin |

---

## Skill Tetikleme

Claude'a ne söylerseniz ilgili skill devreye girer:

```
"spec this feature"        → Feature Forge (gereksinim analizi)
"design this system"       → Architecture Designer
"red team this"            → The Fool (hata avcısı)
"reverse engineer this"    → Spec Miner (kod analizi)
"design this API"          → API Designer
"scrape https://..."       → Firecrawl (web scraping)
```

---

## Maliyet Azaltma

```
$caveman              → Her session'da yazın. %65-75 token azalır.
/compact              → Context penceresi dolunca sıkıştırır.
/model                → Basit işler için haiku seçin.
npx codeburn          → Haftalık token harcama raporu.
```

---

## Dokümantasyon

| Rehber | İçerik |
|--------|--------|
| [Başlangıç](docs/01-getting-started.md) | İlk proje, temel komutlar |
| [CLAUDE.md](docs/06-claude-md-engineering.md) | Nasıl çalışır, ne içerir |
| [Skill Sistemi](docs/02-skills-system.md) | Skill nedir, nasıl kurulur |
| [GSD Workflow](docs/04-gsd-workflow.md) | Günlük iş akışı |
| [Güvenlik](docs/07-security.md) | Otomatik hook'lar |
| [Multi-Proje](docs/08-multi-project.md) | 10+ proje yönetimi |
| [Context Takibi](docs/11-health-check.md) | claude-mem, codeburn, status bar |
| [MCP Sunucuları](docs/12-mcp-servers.md) | Önerilen MCP'ler, kurulum |

---

## Lisans

MIT — ClaudeForge kodu için. Yüklenen araçların kendi lisansları geçerlidir.
