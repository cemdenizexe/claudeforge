# GSD Workflow

## Nedir?
Get Shit Done — 70+ skill, 9 hook. Birincil workflow yöneticisi.

## Akış
Plan → Execute → Review → Debug → Ship

## Hook'lar (otomatik)
| Hook | Ne zaman | Ne yapar |
|------|----------|---------|
| gsd-session-state | Session başı | State geri yükle |
| gsd-context-monitor | Her tool kullanımı | Context takibi |
| gsd-prompt-guard | Edit/write öncesi | Güvenli operasyon kontrolü |
| gsd-workflow-guard | Edit/write öncesi | Workflow kuralları |
| gsd-validate-commit | git commit öncesi | Conventional commit format |

## GSD vs RuFlo
- **GSD** = günlük iş. Her session aktif.
- **RuFlo** = sadece paralel agent spawn. Nadiren kullanılır.

## GSD vs SPARC
- **GSD** = operasyonel workflow (plan-execute-review-ship)
- **SPARC** = tasarım metodolojisi (Specification-Pseudocode-Architecture-Refinement-Completion)
- GSD'nin "Plan" aşamasında SPARC kullanılabilir.