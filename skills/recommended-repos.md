# Recommended GitHub Repos for Claude Code

> ClaudeForge ile uyumlu araçlar. `git clone` ile `.claude/skills/` altına kur.
> Yeni skill ekleyince skill-discovery hook otomatik algılar.

## Skill Kaynakları

| Repo | Kategori | Ne sağlar |
|------|----------|-----------|
| [anthropics/skills](https://github.com/anthropics/skills) | Resmi | frontend-design, canvas-design, theme-factory, skill-creator, mcp-builder |
| [obra/superpowers](https://github.com/obra/superpowers) | Workflow | TDD, debugging, parallel agents, brainstorming, git worktrees |
| [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) | Token | %65-75 output token azaltma |
| [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) | SEO | 19 sub-skill: teknik SEO, GEO/AEO, schema |
| [AgriciDaniel/claude-youtube](https://github.com/AgriciDaniel/claude-youtube) | Video | Kanal audit, video SEO, script, thumbnail |
| [coreyhaines31/marketingskills](https://github.com/coreyhaines31/marketingskills) | Marketing | İçerik stratejisi, copywriting, CRO |
| [dexhunter/seedance2-skill](https://github.com/dexhunter/seedance2-skill) | Video | Higgsfield Seedance 2.0 video prompt üretimi |
| [lackeyjb/playwright-skill](https://github.com/lackeyjb/playwright-skill) | Test | Browser otomasyon pattern'leri |
| [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) | Design | DESIGN.md koleksiyonu, UI/UX referansları |

## Plugin Kaynakları

| Repo | Kategori | Ne sağlar |
|------|----------|-----------|
| [obra/superpowers-marketplace](https://github.com/obra/superpowers-marketplace) | Marketplace | Superpowers plugin ekosistemi |
| [thedotmack/claude-mem](https://github.com/thedotmack/claude-mem) | Memory | Session içi hafıza |
| [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Design | 67 stil, 96 palet, 57 font pairing |
| [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) | Notes | Obsidian vault yönetimi |

## MCP Sunucuları

| Repo | Kategori | Ne sağlar |
|------|----------|-----------|
| [firecrawl/firecrawl](https://github.com/firecrawl) | Scraping | Web crawling + scraping |
| [MaitreyaM/WEB-SCRAPING-MCP](https://github.com/MaitreyaM/WEB-SCRAPING-MCP) | Scraping | Hafif web scraping alternatifi |
| [LaurieWired/GhidraMCP](https://github.com/LaurieWired/GhidraMCP) | Security | Reverse engineering (Ghidra) |
| [haris-musa/excel-mcp-server](https://github.com/haris-musa/excel-mcp-server) | Data | Excel dosya manipülasyonu |
| [PleasePrompto/notebooklm-skill](https://github.com/PleasePrompto/notebooklm-skill) | Research | Google NotebookLM entegrasyonu |
| [tirth8205/code-review-graph](https://github.com/tirth8205/code-review-graph) | Code quality | Graph-based kod review analizi |

## Video & Medya

| Repo | Kategori | Ne sağlar |
|------|----------|-----------|
| [remotion-dev/remotion](https://github.com/remotion-dev/remotion) | Video | React ile programatik video üretimi |
| ffmpeg-mcp | Video/ses | Video ve ses işleme |
| imagen3-mcp | Görsel | Google Imagen 3.0 ile görsel üretimi |

## Referans & İlham

| Repo | Ne için |
|------|---------|
| [BehiSecc/awesome-claude-skills](https://github.com/BehiSecc/awesome-claude-skills) | Topluluk skill listesi |
| [jeffallan.github.io/claude-skills](https://jeffallan.github.io/claude-skills/skills-guide/) | Skill rehberi |
| [Smithery.ai](https://smithery.ai) | MCP marketplace |
| [remotion-dev/remotion](https://github.com/remotion-dev/remotion) | React video framework |
| [tirth8205/code-review-graph](https://github.com/tirth8205/code-review-graph) | Graph-based code review |
| [AgentSeal/codeburn](https://github.com/AgentSeal/codeburn) | Token usage dashboard |

## Önerilen workflow'lar

### Obsidian + Claude Code
Obsidian plugin yüklü. Workflow: Obsidian vault'ta notlar yaz → Claude Code vault'u okur (MCP ile) → kodlama sırasında notlara referans verir. Knowledge management + development birleşir.

### NotebookLM + Claude Code
Research aşaması: NotebookLM'e kaynak yükle → özetler çıkar → Claude Code'a prompt olarak ver. Özellikle video kanal scriptleri ve teknik araştırma için güçlü.

### claude-mem + ClaudeForge
claude-mem session hafıza ve context reuse sağlar (%97 tasarruf). ClaudeForge güvenlik, Task Router, skill discovery ekler. Birlikte = tam donanım.

## Skill ekleme

```powershell
# Herhangi bir skill ekle
cd $env:USERPROFILE\.claude\skills
git clone --depth 1 https://github.com/[owner]/[repo].git

# Sonraki session'da skill-discovery hook otomatik algılar
# CLAUDE.md'yi düzenlemeye gerek yok
```