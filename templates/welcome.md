# Welcome to ClaudeForge

ClaudeForge kuruldu. Artık Claude sadece bir chatbot değil — projenizi tanıyan,
güvenliği otomatik kontrol eden, geçmişi hatırlayan bir geliştirici ortamı.

---

## Ne kuruldu?

**GSD Workflow** — Plan, execute, review, ship. 70+ komut.
Nasıl kullanılır: `gsd plan` yazın. Claude bir sprint planı çıkarır.

**Caveman Modu** — Her token para demek. Caveman %65-75 azaltır.
Nasıl kullanılır: `$caveman` yazın. Kısa, öz, verimli yanıtlar gelir.
Kapatmak için: Yeni session açın veya `$caveman off` yazın.

**Güvenlik Taraması** — Her dosya düzenlemesinde otomatik çalışır.
.env commit edilmesini engeller. XSS ve injection açıklarını yakalar.
Bir şey yapmanıza gerek yok — kendiliğinden çalışır.

**Session Hafızası** — claude-mem geçmiş kararlarınızı ve hatalarınızı saklar.
Bir sonraki session'da Claude öncekini bilir.
Dashboard: `http://localhost:37777`

**Status Bar** — Alt satırda sürekli görünür:
`5h[███38%░░░░]⏰2h14m | 7d[███87%░░░░]⏰3d05h | Opus 4.7(51k/200k)`
- 5h: 5 saatlik kullanım limiti ve sıfırlanma süresi
- 7d: 7 günlük kullanım limiti
- Son kısım: Model, kullanılan token / toplam limit

---

## Maliyet düşürme

Claude Code kullanımınız token harcar. Bunu azaltmanın yolları:

1. **`$caveman`** — Her session başında yazın. En büyük tasarruf buradan.
2. **`/compact`** — Context %70'i geçince yazın. Temizler, devam eder.
3. **`/model`** — Basit görevler için haiku seçin. Opus'un 1/10 fiyatı.
4. **`npx codeburn`** — Haftalık rapor. Nereye para gittiğini görün.

---

## Doğru prompt verme

**Verimsiz:**
```
Bu projeyi analiz et, hataları bul, düzelt, test yaz, dökümantasyon ekle, deploy et
```
→ Claude her şeyi yapmaya çalışır, fazla token harcar, sonuç karmaşık çıkar.

**Verimli:**
```
Fix the null check bug in auth.js
```
→ Tek iş. Net hedef. Hızlı çözüm.

---

## Skill tetikleme

Claude'a şu ifadeleri söyleyin, ilgili skill otomatik devreye girer:

| Ne söylersiniz | Ne olur |
|----------------|---------|
| `"spec this feature"` | Özelliği analiz eder, kabul kriterlerini yazar |
| `"design this system"` | Mimari alternatifleri karşılaştırır |
| `"red team this"` | Tasarımınızdaki açıkları bulur |
| `"reverse engineer this"` | Kodu okuyup dokümante eder |
| `"scrape https://..."` | Web sayfasından veri çeker |

---

## Her session başında

```powershell
.\start.ps1
```

Otomatik olarak:
- Git durumu gösterilir
- GSD fazı hatırlatılır
- Bootstrap prompt clipboard'a kopyalanır
- Claude Code açılır

---

## Sorun mu var?

```
npx codeburn optimize    → Sağlık raporu
/doctor                  → Claude Code tanı
```

github.com/cemdenizexe/claudeforge
