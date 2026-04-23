# Skills Library — ClaudeForge

Skills, Claude Code'un yeteneklerini genişleten dosya tabanlı talimat setleridir.
`~/.claude/skills/` altında global kurulu olurlar — her proje otomatik erişir.

---

## Nasıl çalışır?

Session açılınca `skill-discovery.js` hook'u tetiklenir ve mevcut skill'leri Claude'a bildirir.
Skill tetiklemek için tetikleyici cümleyi söylemen yeterli — ayrıca komut girmen gerekmez.

```
Kullanıcı: "spec this feature"
    ↓
Claude: Feature Forge skill'ini aktive eder, spec çıkarır
```

---

## Skill Kategorileri

### Workflow
| Skill | Tetikleyici | Ne yapar |
|-------|-------------|----------|
| GSD (70+ skill) | gsd-plan, gsd-execute, gsd-ship... | Günlük iş akışı motoru |
| Feature Forge | "spec this feature" | PM+Dev spec üretir |
| Architecture Designer | "design this system" | Mimari alternatifleri karşılaştırır |
| API Designer | "design this API" | OpenAPI spec üretir |
| Spec Miner | "reverse engineer this" | Kodu okuyup dokümante eder |
| The Fool | "red team this", "challenge this" | Tasarımdaki açıkları bulur |
| SPARC | Karmaşık multi-dosya iş | Spec→Pseudo→Arch→Refine→Complete |

### Token Tasarrufu
| Skill | Tetikleyici | Ne yapar |
|-------|-------------|----------|
| Caveman | `$caveman` | %65-75 token azaltma |
| Code Simplifier | otomatik | Gereksiz kodu temizler |

### UI & Design
| Skill | Tetikleyici |
|-------|-------------|
| frontend-design | UI kodu yazarken |
| awesome-design-md | "Apple style", "Notion style" vb. |
| canvas-design | Poster, görsel üretimi |
| theme-factory | "apply dark theme" |

### Scraping & Otomasyon
| Skill | Tetikleyici |
|-------|-------------|
| Firecrawl | "scrape https://..." |
| Playwright | Browser otomasyon |

### Doküman Üretimi
| Skill | Ne üretir |
|-------|-----------|
| docx | Word belgesi |
| pdf | PDF |
| pptx | PowerPoint |
| xlsx | Excel |

### Video Pipeline
| Skill | Amaç |
|-------|------|
| Seedance 2.0 | Video üretim promptları |
| Claude SEO | SEO analiz ve optimizasyon |
| Claude YouTube | Kanal büyütme, script, thumbnail |
| Marketing Skills | İçerik stratejisi, CRO |

---

## Skill Kurulum Yolları

### 1. ClaudeForge setup (otomatik)
```powershell
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

### 2. GSD (70+ workflow skill)
```bash
npx get-shit-done-cc@latest --claude --global
```

### 3. Plugin olarak
```bash
claude plugin install [skill-adi]@claude-plugins-official
```

### 4. Git clone (manuel)
```bash
git clone https://github.com/[repo] ~/.claude/skills/[skill-adi]
```

---

## Semgrep Notu

Semgrep **kasıtlı olarak kaldırılmıştır.** API token olmadan çalışmıyor,
sadece hata mesajı üretiyordu. Güvenlik taraması `security-guidance` plugin ile yapılıyor.

---

## Mevcut Skill Sayısı

ClaudeForge kurulumundan sonra tipik kurulumda:
- GSD: ~81 skill
- Plugin'lerden gelen: ~20 skill
- Manuel klonlanan: 6 skill (caveman, awesome-design-md, seedance2, vb.)
- **Toplam: ~107 skill**

Kendi skillini görüntülemek için:
```bash
ls ~/.claude/skills/
```
