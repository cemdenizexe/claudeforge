# Connector & MCP

## İki erişim katmanı

### MCP araçları (Claude Code + Browser)
Dosya sistemi erişimi:
- **filesystem** — dosya oku/yaz/listele
- **Desktop Commander** — gelişmiş dosya okuma, process başlatma
- **Windows-MCP** — PowerShell, uygulama kontrolü, screenshot
- **git** — status, log, diff, commit

### Browser connector'ları (sadece Browser Claude)
| Kategori | Connector'lar |
|----------|-------------|
| Kripto | Crypto.com, LunarCrush, Blockscout |
| Finans | MT Newswires, Massive Market Data |
| Tasarım | Figma, Canva, Shadcn UI |
| Backend | Supabase, Netlify |
| İletişim | Gmail, Google Calendar, Google Drive |
| AI/ML | Hugging Face |
| Otomasyon | Playwright, Claude in Chrome, Coupler.io |

## Köprü pattern
Browser Claude connector'lardan veri çeker → Claude Code prompt'u üretir → sen yapıştırırsın → Code çalıştırır.