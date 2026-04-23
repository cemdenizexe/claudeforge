# Global CLAUDE.md — {{USER_NAME}}
# Otomatik oluşturuldu: ClaudeForge setup
# Konum: ~/.claude/CLAUDE.md — her session, her proje

# ============================================================
# BU DOSYA NE YAPAR?
# Claude Code her açıldığında bu dosyayı otomatik okur.
# Buradaki kurallar tüm projelerine uygulanır.
# Proje içindeki CLAUDE.md bu dosyayı override eder.
# ============================================================

## ClaudeForge Aktif

Kurulum tamamlandı. Aşağıdaki araçlar çalışıyor:
- Session hook'ları: her açılışta otomatik tetiklenir
- Security guard: her dosya yazımında çalışır
- Self-learning: fix commit'leri otomatik loglanır
- Skill discovery: yeni skill'leri otomatik algılar

---

## Kimlik
Kullanıcı: {{USER_NAME}}
Projeler: {{DEV_DIR}}

---

## Davranış Kuralları

- Direkt ve teknik ol. Gereksiz söz yok.
- "Harika soru!" gibi ifadeler yasak.
- Ne yapacağını söyleme. Yap.
- Kullanıcı hatalıysa söyle.
- API/fonksiyon adlarını uydurma.
- Belirsiz durum → en mantıklı varsayımı yap, tek satırda belirt, devam et.

## Task Router

Her görevde, kodlamadan önce tek satır yaz:
`[ROUTE] Complexity: simple|medium|complex → Model: haiku|sonnet|opus → Swarm: no|yes(N)`

| Görev tipi | Model | Swarm |
|-----------|-------|-------|
| Tek satır, config düzeltme | haiku | hayır |
| Tek dosya, test, refactor | sonnet | hayır |
| Multi-dosya, mimari | opus | hayır |
| 3+ dosya paralel | opus | evet (3-5) |
| Tam audit, büyük refactor | opus | evet (5-8) |

**Auto-routing zorunlu:** Görevi oku → model seç → `[ROUTE]` yaz → başla. Sormadan.
Scope genişlerse → yeniden route, duyur, devam et.

**Swarm agent atamaları:**
- Orchestrator → opus
- Kod yazanlar → sonnet
- Lint/format/validate → haiku
- Araştırma/analiz → sonnet

---

## GSD Workflow

GSD = günlük iş motoru. 70+ komut, 9 hook.
Akış: Plan → Execute → Review → Debug → Ship

Temel komutlar:
- `gsd plan` → sprint planla
- `gsd execute` → göreve başla
- `gsd review` → kodu gözden geçir
- `gsd ship` → deploy et
- `gsd debug` → hata ayıkla

Hook'lar otomatik tetiklenir — her edit, commit, session başında.

---

# ============================================================
# ARAÇ KILAVUZU — Hangi araç ne işe yarar?
# ============================================================

## $caveman — Token Tasarrufu

Ne yapar: Claude'un cevaplarını %65-75 kısaltır. Aynı iş, çok daha az token.
Nasıl aktive edilir: Mesaja `$caveman` yaz
Nasıl deaktive edilir: `/caveman off` yaz veya yeni session aç
Ne zaman kullan: Uzun oturumlar, tekrarlı görevler, token bitince

## /compact — Context Sıkıştırma

Ne yapar: Uzun session'da context penceresini temizler, özet tutar.
Nasıl kullanılır: Claude Code'da `/compact` yaz
Ne zaman kullan: "Context window dolmak üzere" uyarısı gelince

---

# ============================================================
# CONTEXT TAKİP ARAÇLARI
# ============================================================

## claude-mem (Otomatik — elle çalıştırma gerekmez)

Ne yapar: Her session'daki gözlemleri kaydeder. Bir sonraki session'da Claude
  geçmiş context'i otomatik yükler.
Nasıl çalışır: Session açılınca hook tetiklenir, DB'den son kayıtları inject eder.
Dashboard: http://localhost:37777 (tarayıcıda aç)
Tasarruf: ~93% token — geçmiş araştırmalar yeniden yapılmaz.

## codeburn (Manuel — isteğe bağlı)

Ne yapar: 7 günlük token kullanım dashboard'u. Hangi projede ne kadar harcandı.
Nasıl çalıştırılır: `npx codeburn` veya `npx codeburn optimize`
Ne zaman kullan: Haftalık sağlık kontrolü, harcama optimizasyonu

## GSD Status Bar (Otomatik)

Ne yapar: Claude Code alt çubuğunda proje durumu gösterir.
Ne gösterir: Sprint ilerlemesi, güvenlik bulguları, bellek durumu
Kontrol: Status bar'da görmek istediğin alanları GSD ayarlarından düzenle.

## Context Status Bar Kurulumu

Claude Code'un alt çubuğuna token/rate limit göstergesi ekle.

Claude Code'da çalıştır:
```
/statusline 5h ve 7d rate limit, context yüzdesi, model adı göster
```

Veya manuel — ~/.claude/settings.json'a ekle:
```json
"statusLine": {
  "type": "command",
  "command": "node ~/.claude/hooks/status-bar.js"
}
```

---

# ============================================================
# CİHAZ FARKINDALIGI
# ============================================================

Bu bölüm her cihazda farklı olabilir. Claude Code açılınca
aşağıdakileri otomatik okur:

- İşletim sistemi: {{OS}}
- Proje dizini: {{DEV_DIR}}
- WSL mevcut mu: Setup sırasında tespit edildi
- Claude Code versiyonu: `claude --version`
- Aktif model: Session başında görünür

Cihaz bilgilerinizi güncellemek için:
```powershell
cd claudeforge
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

---

# ============================================================
# KENDİ SKILL VE SCRİPTLERİNİ YARAT
# ============================================================

skill-creator kurulu. Nasıl kullanılır:

1. Claude Code'a yaz: "Create a skill for [ne yapmak istiyorsun]"
2. Claude skill dosyasını oluşturur → ~/.claude/skills/[isim]/SKILL.md
3. Bir sonraki session'da otomatik aktif

Örnek:
"Create a skill that helps me write database migration scripts"

Kendi .ps1 script'in için şablon: templates/start.ps1
Kendi hook'un için şablon: templates/self-learning.js

---

# ============================================================
# SKILL AKTİVASYON REHBERİ
# ============================================================

### Her zaman aktif
{{CAVEMAN}}
- security-guidance — her edit'te güvenlik taraması
- code-review — PR review otomasyonu
- GSD — workflow engine

### Yeni özellik geliştirirken
- Feature Forge → "spec this feature"
- Architecture Designer → "design this system"
- SPARC → karmaşık multi-dosya: Spec → Pseudo → Arch → Refine → Complete

### Kod analizi
- Spec Miner → "reverse engineer this"
- The Fool → "challenge this" / "red team"

### API tasarımı
- API Designer → "design this API"

### UI / Frontend
- frontend-design, Shadcn UI, Figma, theme-factory

### Test ve güvenlik
- playwright, semgrep, coderabbit

### Token tasarrufu
- Caveman ($caveman), /compact

---

## Güvenlik Standartları

Backend: CORS whitelist zorunlu, Zod/Pydantic input validation,
bcrypt 12 rounds, parameterized SQL, eval/pickle/shell=True yasak.
Frontend: localStorage'da hassas veri yasak, error boundary zorunlu.
Git: .env, *.jks, *.keystore asla commit edilmez.

## Otonom Mod

YAP: dosya oku/yaz, paket kur, test çalıştır.
SOR: dosya sil, main'e push, .env düzenle, geri dönüşü olmayan işlemler.
