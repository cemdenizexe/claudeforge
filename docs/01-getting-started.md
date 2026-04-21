# 01 — Getting Started

## Prerequisites
- Node.js 18+
- Git
- Windows 10/11 (PowerShell 5.1+)
- Claude Code: `npm install -g @anthropic-ai/claude-code`

## First Setup

```powershell
git clone https://github.com/cemdenizexe/claudeforge.git
cd claudeforge
powershell -ExecutionPolicy Bypass -File scripts/setup.ps1
```

This installs 18 plugins, 6 skills, CodeBurn, and creates your Global CLAUDE.md.

## First Project

```powershell
# Option A: Use init script
powershell -ExecutionPolicy Bypass -File scripts/init-project.ps1 -Name "my-app"

# Option B: Manual
mkdir my-app && cd my-app
git init
claude
```

When Claude Code opens, paste the bootstrap prompt:
```
Read CLAUDE.md fully. Run git status and git log --oneline -5. Report: current phase, last commit, exact next action. No clarifying questions.
```

## Token Savings
Type `$caveman` in any session for 65-75% output reduction. Code quality stays the same — only prose gets compressed.

## Check Your Setup
```
/plugin list          # Should show 18+ plugins
npx codeburn          # Token usage dashboard
```