$ErrorActionPreference = "Continue"

$PROJECT_DIR  = $PSScriptRoot
$PROJECT_NAME = Split-Path -Leaf $PROJECT_DIR
$GIT_BRANCH   = (git -C $PROJECT_DIR rev-parse --abbrev-ref HEAD 2>$null)
$LAST_COMMIT  = (git -C $PROJECT_DIR log --oneline -1 2>$null)
if (-not $GIT_BRANCH)  { $GIT_BRANCH  = "no-git" }
if (-not $LAST_COMMIT) { $LAST_COMMIT = "no commits yet" }

Write-Host ""
Write-Host "  ⚒️  ClaudeForge Session" -ForegroundColor DarkYellow
Write-Host "  ------------------------------------------------" -ForegroundColor DarkGray
Write-Host "  Project : $PROJECT_NAME" -ForegroundColor Cyan
Write-Host "  Branch  : $GIT_BRANCH" -ForegroundColor DarkCyan
Write-Host "  Last    : $LAST_COMMIT" -ForegroundColor DarkCyan
Write-Host "  ------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""

# Bootstrap prompt — clipboard'a kopyala
$BOOTSTRAP = "Read CLAUDE.md fully. Run git status and git log --oneline -5. Report: current phase, last git commit, exact next action. No clarifying questions."

try {
    $BOOTSTRAP | Set-Clipboard
    Write-Host "  Bootstrap prompt copied to clipboard" -ForegroundColor Green
    Write-Host "  Paste it after Claude Code loads." -ForegroundColor DarkGray
} catch {
    Write-Host "  Clipboard failed -- paste manually:" -ForegroundColor DarkYellow
    Write-Host "  $BOOTSTRAP" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "  Launching Claude Code..." -ForegroundColor Yellow
Write-Host ""
Write-Host "  TIP: Swarm gerekirse session icinde yaz:" -ForegroundColor DarkGray
Write-Host "  npx ruflo@latest swarm init --topology hierarchical --max-agents 8" -ForegroundColor DarkGray
Write-Host ""
Start-Sleep -Seconds 1
Set-Location $PROJECT_DIR
claude