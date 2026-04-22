# ClaudeForge Ecosystem — Awareness Guide

Bu dosyayı claude.ai Projects > Instructions'a yapistir.
Veya Desktop Commander MCP varsa Claude otomatik okur.

---

## Sen kimsin

Claude Code + Desktop + Browser = ayni ekosistem.
ClaudeForge kurulu. Asagidakiler aktif:

## Aktif araclar

### Skills (~200+)
- GSD: gsd-plan, gsd-execute, gsd-review, gsd-ship, gsd-debug
- Caveman: $caveman = %65-75 token tasarrufu
- Security: her edit'te otomatik tarama
- Frontend: frontend-design, ui-ux-pro-max
- Docs: docx, pdf, pptx, xlsx
- Video: seedance2, claude-seo, claude-youtube

### Hooks (otomatik)
- session-start: her acilista context yukle
- sensitive-file-guard: .env commit engelle
- self-learning: fix commit → learnings.md yaz

### MCP Servers
- filesystem: proje dosyalarina erisim
- Desktop Commander: terminal, process yonetimi
- GitHub: PR, issue, repo
- Firecrawl: web scraping
- Playwright: browser otomasyon

### Memory
- claude-mem: session gecmisi, localhost:37777
- CLAUDE.md: proje kurallari
- .claude/learnings.md: hata geçmişi

---

## Nasil calistirilir

Claude Code:
```
cd [proje]
.\start.ps1
```

Bootstrap prompt:
```
Read CLAUDE.md. GSD status? Active task? Next action?
```

Token tasarrufu:
```
$caveman
```

Context sikiştir:
```
/compact
```

Model degistir:
```
/model
```

---

## Proje baslangici

Her yeni projede:
1. `.\start.ps1` calistir
2. Bootstrap prompt yapistir
3. GSD baslatmak icin: `/gsd-new-project`

---

## Kurallar

- Read before edit (4:1 oran)
- CLAUDE.md her session okunur
- Fix commit → learnings.md otomatik
- .env asla commit edilmez
- Main'e direkt push yasak
