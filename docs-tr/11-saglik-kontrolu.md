# Sağlık kontrolü — codeburn optimize

Haftalık çalıştır:

```powershell
npx codeburn optimize
```

## Ne kontrol eder

| Kontrol | Ne bulur | Öncelik |
|---------|---------|---------|
| Tekrar okunan dosyalar | Aynı dosya defalarca okunuyor | Yüksek |
| Ghost skill'ler | Kurulu ama hiç tetiklenmeyen | Yüksek |
| Ghost agent'lar | Tanımlı ama hiç çağrılmayan | Yüksek |
| .claudeignore eksik | node_modules okunuyor | Yüksek |
| Read:Edit oranı | Okumadan düzenleme | Orta |
| Kullanılmayan MCP | Schema boşa yükleniyor | Orta |
| Şişmiş CLAUDE.md | 200+ satır = Claude üstünkörü okur | Orta |

## Bilinen Hook Sorunları

### PreToolUse:Edit hook error — ClaudeForge + Superpowers

**Belirti:** Her Write/Edit işleminde `PreToolUse:Edit hook error`.

**Neden:** `gsd-read-guard.js`, `CLAUDECODE` veya `CLAUDE_SESSION_ID` env var set edilince temiz çıkış yapar. ClaudeForge + Superpowers bu var'ları set etmiyor → hook advisory output yazıyor → Claude Code hata olarak yorumluyor.

**Fix:**
```powershell
[System.Environment]::SetEnvironmentVariable("CLAUDECODE", "1", "User")
```
Terminali kapat/aç. Session'lar arası kalıcı.

**Etkilenen:** `gsd-read-guard.js` v1.38.1+, ClaudeForge + Superpowers kurulumları.

## GSD skill'leri hakkında uyarı

GSD skill'leri "unused" görünebilir çünkü contextual tetiklenir. Arşivleme GSD'yi bozar. Sadece gerçekten kullanmadığın skill'leri arşivle.