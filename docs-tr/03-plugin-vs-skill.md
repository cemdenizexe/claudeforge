# Plugin vs Skill

## Üç farklı sistem

| Sistem | Kurulum | Ne yapar |
|--------|---------|---------|
| **Plugin** | `/plugin install` | Yetenek verir |
| **Skill** | git clone → .claude/skills/ | Talimat verir |
| **Hook** | .claude/hooks/ | Otomatik tetiklenir |

## Plugin örneği
`playwright` plugin → Claude'a browser kontrol yeteneği verir.
`semgrep` plugin → statik kod analizi yapabilir.

## Skill örneği
`caveman-skill` → Claude'a "kısa yaz, token harcama" der.
`claude-seo` → SEO workflow adımlarını öğretir.

## Hook örneği
`sensitive-file-guard.js` → git add'de .env engeller.
`self-learning.js` → fix commit'leri loglar.

## Beraber çalışırlar
Plugin = el, Skill = beyindeki bilgi, Hook = refleks.
Üçü birlikte = tam donanımlı geliştirici.