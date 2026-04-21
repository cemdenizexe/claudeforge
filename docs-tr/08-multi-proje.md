# Multi-proje yönetimi

## Dosya hiyerarşisi
```
~/.claude/
├── CLAUDE.md          ← Global (her projede okunur)
├── skills/            ← Global skill'ler
├── hooks/             ← Otomatik hook'lar
└── settings.json      ← Plugin + hook config

[dev-klasörü]/
├── sync-skills.ps1    ← Tüm projelere sync
├── init-project.ps1   ← Yeni proje başlat
└── [Proje]/
    ├── CLAUDE.md      ← Proje kuralları
    ├── start.ps1      ← Session başlatıcı
    └── .claude/
        ├── skills/    ← Proje skill'leri
        ├── learnings.md ← Otomatik bug log
        └── ecosystem-awareness.md ← Browser Claude bilgisi
```

## Sync komutu
```powershell
powershell -ExecutionPolicy Bypass -File sync-skills.ps1
```
Tüm projelere skill, start.ps1, ecosystem-awareness.md kopyalar.

## Yeni proje
```powershell
powershell -ExecutionPolicy Bypass -File init-project.ps1 -Name "proje-adi"
```

## Browser'dan multi-proje
Tek "Dev Hub" projesi aç. İçinde:
"Trade-Bot'a geç" → MCP ile dosyaları okur.
"HabitFlow'un durumu ne?" → CLAUDE.md okur, rapor verir.