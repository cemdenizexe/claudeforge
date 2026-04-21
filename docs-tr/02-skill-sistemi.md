# Skill sistemi

## Skill nedir?
`.claude/skills/` klasöründe duran SKILL.md dosyası. Claude Code'a nasıl yapacağını öğretir.

## Nerede durur?
```
~/.claude/skills/     ← Global (her projede geçerli)
[proje]/.claude/skills/ ← Projeye özel
```

## Nasıl kurulur?

```powershell
cd $env:USERPROFILE\.claude\skills
git clone --depth 1 https://github.com/[owner]/[repo].git
```

Sonraki session'da `skill-discovery` hook otomatik algılar. CLAUDE.md düzenlemeye gerek yok.

## Tetikleme cümleleri

| Skill | Ne zaman söyle |
|-------|---------------|
| Feature Forge | "spec this feature" |
| Spec Miner | "reverse engineer this" |
| The Fool | "challenge this", "red team" |
| Architecture Designer | "design this system" |
| API Designer | "design this API" |
| Caveman | `$caveman` |

## Plugin vs Skill farkı

| | Plugin | Skill |
|---|---|---|
| Kurulum | `/plugin install` | git clone |
| Ne yapar | Yetenek verir (browser kontrol, analiz) | Talimat verir (nasıl yapacağını söyler) |
| Nerede | Claude Code registry | .claude/skills/ klasörü |
| Örnek | playwright → browser kontrol edebilir | playwright-skill → ne zaman, nasıl kullanacağını öğretir |

İkisi birlikte çalışır. Plugin = yetenek, Skill = bilgi.