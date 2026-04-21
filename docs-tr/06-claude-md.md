# CLAUDE.md mühendisliği

## Hangi dosya okunur?

Claude Code her session'da otomatik okur:
```
1. ~/.claude/CLAUDE.md          ← GLOBAL (her projede)
2. [proje]/CLAUDE.md            ← PROJE (varsa)
3. [proje]/.claude/CLAUDE.md    ← ALTERNATİF (varsa)
```

**Okunmayan:**
- `D:\Dev\GLOBAL_CLAUDE.md` — ismine rağmen otomatik okunmaz
- `ecosystem-awareness.md` — browser Claude için, Code için değil
- "See also: dosya.md" — Claude linkleri takip etmez

## Global CLAUDE.md ne içerir?
- Task Router (model seçimi)
- Skill Activation Guide (200+ skill tetikleme rehberi)
- Güvenlik kuralları (backend, frontend, mobil, git)
- GSD workflow tanımı
- Self-learning protokolü
- Proje registery + connector eşleşmesi

## Proje CLAUDE.md ne içerir?
- Tech stack
- Bootstrap prompt
- Phase checklist
- Proje-özel kurallar
- "NEVER do X" kuralları

## Self-learning
Bug fix → `.claude/learnings.md`'ye otomatik yazılır (hook).
CLAUDE.md şişmez. İkisi ayrı dosya.

## Anti-pattern'ler
- ❌ CLAUDE.md 500+ satır (Claude üstünkörü okur)
- ❌ Global kuralları proje CLAUDE.md'de tekrarlamak
- ❌ "See also: dosya.md" yazmak (takip etmez)