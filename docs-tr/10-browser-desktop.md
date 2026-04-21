# Browser-Desktop köprüsü

## İki Claude, bir ekosistem

| | Browser Claude | Claude Code |
|---|---|---|
| Kod çalıştırır | ❌ | ✅ |
| Connector erişimi | ✅ | ❌ |
| Dosya okur (MCP) | ✅ | ✅ |
| Skill farkındalığı | ecosystem-awareness.md | CLAUDE.md + SKILL.md |

## Kurulum
1. claude.ai'da "Dev Hub" projesi aç
2. Instructions → `browser-instructions.md` yapıştır
3. Files → `ecosystem-awareness.md` yükle

## Workflow
```
1. Browser Claude: "Trade-Bot'un newsletter feature'ını analiz et"
   → CLAUDE.md okur (MCP ile)
   → LunarCrush'tan sentiment çeker
   → Claude Code prompt'u üretir: [MODEL: opus] [SWARM: no]

2. Sen: prompt'u Claude Code'a yapıştır

3. Claude Code: çalıştırır
   → Feature Forge → spec
   → API Designer → endpoint
   → GSD → plan-execute-ship

4. Browser Claude: "Ne yapıldı kontrol et"
   → Yeni dosyaları okur
   → Sonraki adımı önerir
```

## Ne zaman hangisi?
| Görev | Kullan |
|-------|--------|
| Kod yaz | Claude Code |
| Connector'lardan veri çek | Browser Claude |
| Prompt üret | Browser Claude |
| Deploy | Claude Code |
| Piyasa analizi | Browser Claude |
| Multi-proje genel bakış | Browser Claude |