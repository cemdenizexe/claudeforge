# ClaudeForge — Plugin & Skill Install Commands

> Redundancy-free list. Her plugin benzersiz amaca hizmet eder.

## Core plugins (10) — claude-plugins-official

```
/plugin install security-guidance@claude-plugins-official
/plugin install code-review@claude-plugins-official
/plugin install playwright@claude-plugins-official
/plugin install semgrep@claude-plugins-official
/plugin install coderabbit@claude-plugins-official
/plugin install firecrawl@claude-plugins-official
/plugin install github@claude-plugins-official
/plugin install chrome-devtools-mcp@claude-plugins-official
/plugin install code-simplifier@claude-plugins-official
/plugin install huggingface-skills@claude-plugins-official
```

## Marketplace plugins (4)

```
/plugin marketplace add thedotmack/claude-mem
/plugin install claude-mem@thedotmack

/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace

/plugin marketplace add nextlevelbuilder/ui-ux-pro-max-skill
/plugin install ui-ux-pro-max@ui-ux-pro-max-skill

/plugin marketplace add kepano/obsidian-skills
/plugin install obsidian@obsidian-skills
```

## Anthropic official (2)

```
/plugin marketplace add anthropics/skills
/plugin install document-skills@anthropic-agent-skills
/plugin install example-skills@anthropic-agent-skills
```

> example-skills zaten frontend-design, canvas-design, theme-factory, skill-creator içerir.
> Bunları ayrıca kurmayın — duplicate olur.

## KURMAYIN (redundant)

| Plugin | Neden kurulmamalı |
|--------|------------------|
| frontend-design standalone | example-skills'te zaten var |
| skill-creator standalone | example-skills'te zaten var |
| superpowers-developing-for-claude-code | superpowers'ın alt kümesi |
| İkinci superpowers@claude-plugins-official | Bir tanesi yeterli |

## Skill'ler — git clone

```powershell
cd $env:USERPROFILE\.claude\skills

# Token tasarruf
git clone --depth 1 https://github.com/JuliusBrussee/caveman.git caveman-skill

# Video pipeline (opsiyonel)
git clone --depth 1 https://github.com/AgriciDaniel/claude-seo.git
git clone --depth 1 https://github.com/AgriciDaniel/claude-youtube.git
git clone --depth 1 https://github.com/coreyhaines31/marketingskills.git
git clone --depth 1 https://github.com/dexhunter/seedance2-skill.git

# Design referans (opsiyonel)
git clone --depth 1 https://github.com/VoltAgent/awesome-design-md.git
```

## CLI araçları

```powershell
npm install -g codeburn
npx codeburn        # 7 günlük token dashboard
npx codeburn today  # bugünkü kullanım
```