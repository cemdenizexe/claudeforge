# Güvenlik — Vibe coding hayatta kalma rehberi

## Sorun
AI kod yazarken "çalışsın" diye optimize eder. Güvenlik ikinci planda kalır.
ClaudeForge bunu otomatik düzeltir.

## Otomatik koruma katmanları

| Hook | Ne zaman çalışır | Ne kontrol eder |
|------|-------------------|----------------|
| security_reminder_hook.py | Her edit/write | eval, pickle, innerHTML, hardcoded secret |
| sensitive-file-guard.js | git add/commit | .env, keystore, .gitignore eksikliği |
| gsd-validate-commit.sh | git commit | Commit format |
| self-learning.js | fix: commit sonrası | Bug'ı learnings.md'ye loglar |

Token maliyeti: **sıfır** — hook'lar Claude dışında çalışır.

## Kurallar

### Backend
- `app.use(cors())` YASAK — origin whitelist zorunlu
- Input validation: Zod (TS) / Pydantic (Python)
- bcrypt 12 rounds, hardcoded credential YASAK
- SQL: parameterized query zorunlu, string concat YASAK
- eval(), pickle.loads, os.system, shell=True YASAK

### Frontend
- localStorage'da hassas veri YASAK
- innerHTML / dangerouslySetInnerHTML YASAK
- React'ta Error Boundary zorunlu

### Git
- .env, *.jks, *.keystore, google-services.json commit YASAK
- Yanlışlıkla commit ettiysen: `git filter-repo` → key rotate → force push
- `git add .` yaparken sensitive-file-guard otomatik engeller

### Mobil
- Release build'de ProGuard + minify
- API key manifest'te veya source code'da YASAK
- Keystore proje dışında tutulur

## AI'ın sık yaptığı güvenlik hataları

| Hata | Neden | Çözüm |
|------|-------|-------|
| `app.use(cors())` | Hızlı çalışsın diye | CLAUDE.md'de YASAK kuralı |
| Hardcoded API key | Demo kodu | .env + hook engeli |
| Validation yok | "Çalışıyor" | Zod/Pydantic zorunlu |
| .env commit | .gitignore unutulmuş | sensitive-file-guard hook |