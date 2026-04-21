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

## GSD skill'leri hakkında uyarı

GSD skill'leri "unused" görünebilir çünkü contextual tetiklenir. Arşivleme GSD'yi bozar. Sadece gerçekten kullanmadığın skill'leri arşivle.