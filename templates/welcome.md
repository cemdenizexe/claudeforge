# ClaudeForge — Hoşgeldin / Welcome

ClaudeForge kuruldu. Claude artık daha güçlü — projelerinizi tanır, hatalarınızı hatırlar, güvenliği otomatik kontrol eder.

---

## Claude Code Başlangıç Promptu

Her yeni session'da `.\start.ps1` çalıştırın, açılan Claude Code'a şunu yapıştırın:

```
Read CLAUDE.md fully. Read .claude/learnings.md if exists.
Run: git status && git log --oneline -5
GSD: What phase am I in? What is the active task? Exact next action?
Report all. No clarifying questions. Start immediately.
```

Bu prompt Claude'a şunları yaptırır:
- Proje kurallarını okur
- Geçmiş hataları hatırlar  
- Git durumunu kontrol eder
- Bir sonraki görevi raporlar

---

## Claude Desktop / claude.ai Başlangıç Promptu

claude.ai veya Claude Desktop'ta ilk kez kullanırken şunu verin:

```
Read CLAUDE.md. List active skills, hooks, and GSD status.
Confirm ClaudeForge is active. Report what you see.
```

Sonrasında her konuşmada proje bağlamını vermek için:

```
I'm working on [proje adı]. 
Active branch: [branch adı].
Current task: [ne yapıyorsunuz].
Apply ClaudeForge rules.
```

---

## Kurulu Özellikler

**GSD Workflow** — Günlük iş akışı motoru
```
gsd plan        → Sprint planla
gsd execute     → Göreve başla  
gsd review      → Kodu gözden geçir
gsd ship        → Deploy et
gsd debug       → Hata ayıkla
```

**Caveman Modu** — Token tasarrufu
```
$caveman        → Aktive et (%65-75 azalır)
$caveman off    → Kapat
/compact        → Context penceresini sıkıştır
```

**Status Bar** — Alt satırda sürekli görünür
```
5h[███38%░░░░]⏰2h14m | 7d[███87%░░░░]⏰3d05h | Opus 4.7(51k/200k)
│                          │                    │
5 saatlik limit             7 günlük limit       Model + Context
```

**Security** — Her düzenlemede otomatik
- .env dosyalarını commit'ten engeller
- XSS ve injection açıklarını yakalar
- Hardcoded API key'leri bulur

**claude-mem** — Session hafızası
- Geçmiş kararlar saklanır
- Bir sonraki session'da Claude öncekini bilir
- Dashboard: `http://localhost:37777`

---

## Skill Tetikleme

Claude'a bu ifadeleri söyleyin:

| Ne söyleyin | Ne olur |
|-------------|---------|
| `"spec this feature"` | Özelliği analiz eder, gereksinimler çıkarır |
| `"design this system"` | Mimari alternatifleri karşılaştırır |
| `"red team this"` | Tasarımdaki açıkları ve riskleri bulur |
| `"reverse engineer this"` | Kodu okuyup dokümante eder |
| `"design this API"` | Endpoint'leri ve şemaları tasarlar |
| `"scrape https://..."` | Web sayfasından veri çeker |

---

## Maliyet Azaltma

| Araç | Nasıl | Tasarruf |
|------|-------|---------|
| `$caveman` | Her session başında yaz | %65-75 token |
| `/compact` | Context %70'i geçince yaz | Context temizlenir |
| `/model` | Basit işler için haiku seç | Opus'un 1/10 fiyatı |
| `npx codeburn` | Haftalık çalıştır | Nereye para gittiğini gör |

---

## Sağlık Kontrolü

```
npx codeburn optimize   → Sorunları listeler, çözüm önerir
/doctor                 → Claude Code tanı
/context                → Anlık context kullanımı
```

---

*github.com/cemdenizexe/claudeforge*
