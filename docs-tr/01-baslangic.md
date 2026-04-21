# Başlangıç

## Gereksinimler
- Node.js 18+
- Git
- Windows 10/11 (PowerShell)
- Claude Code: `npm install -g @anthropic-ai/claude-code`

## Kurulum

```powershell
git clone https://github.com/cemdenizexe/claudeforge.git
cd claudeforge
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

Wizard sana 4 soru sorar:
1. Projelerinin klasörü
2. Adın
3. Caveman ister misin (token tasarrufu)
4. Video pipeline ister misin

## İlk proje

```powershell
cd [proje-klasörün]
.\start.ps1
```

Claude Code açılınca bootstrap prompt'u yapıştır (clipboard'da).

## Kontrol

```
/plugin list          # 18+ plugin görünmeli
npx codeburn          # Token dashboard
$caveman              # Token tasarrufu aktive
```