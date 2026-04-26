$ErrorActionPreference = "Continue"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$accent = "DarkYellow"
$dim = "DarkGray"

Write-Host ""
Write-Host "  +===========================================================+" -ForegroundColor DarkYellow
Write-Host "  |   _____ _                 _      ______                  |" -ForegroundColor DarkYellow
Write-Host "  |  / ____| |               | |    |  ____|                 |" -ForegroundColor DarkYellow
Write-Host "  | | |    | | __ _ _   _  __| | ___| |__ ___  _ __ __ _  __|" -ForegroundColor DarkYellow
Write-Host "  | | |    | |/ _  | | | |/ _  |/ _ \  __/ _ \| '__/ _  |/ _|" -ForegroundColor DarkYellow
Write-Host "  | | |____| | (_| | |_| | (_| |  __/ | | (_) | | | (_| |  _|" -ForegroundColor DarkYellow
Write-Host "  |  \_____|_|\__,_|\__,_|\__,_|\___|_|  \___/|_|  \__, |\__|" -ForegroundColor DarkYellow
Write-Host "  |                                                  __/ |    |" -ForegroundColor DarkYellow
Write-Host "  |                                    by cemdenizexe|___/    |" -ForegroundColor White
Write-Host "  +-----------------------------------------------------------+" -ForegroundColor DarkYellow
Write-Host "  |  One command. 200+ skills. Security. Memory. Workflow.   |" -ForegroundColor White
Write-Host "  +-----------------------------------------------------------+" -ForegroundColor DarkYellow
Write-Host ""

# --- Env ---
$HOME_DIR    = $env:USERPROFILE
$CLAUDE_DIR  = Join-Path $HOME_DIR ".claude"
$SKILLS_DIR  = Join-Path $CLAUDE_DIR "skills"
$HOOKS_DIR   = Join-Path $CLAUDE_DIR "hooks"
$PARENT_ROOT = Split-Path $PSScriptRoot -Parent

Write-Host "  Home: $HOME_DIR" -ForegroundColor $dim; Write-Host ""

# --- [1/9] Prerequisites ---
Write-Host "[1/9] Prerequisites..." -ForegroundColor Yellow
$miss = @()
if (-not (Get-Command "node"   -EA SilentlyContinue)) { $miss += "Node.js" }
if (-not (Get-Command "git"    -EA SilentlyContinue)) { $miss += "Git" }
if (-not (Get-Command "claude" -EA SilentlyContinue)) { $miss += "Claude Code" }
if ($miss.Count -gt 0) { Write-Host "  Missing: $($miss -join ', ')" -ForegroundColor Red; exit 1 }
Write-Host "  OK" -ForegroundColor Green; Write-Host ""

# --- [2/9] Config ---
Write-Host "[2/9] Configuration..." -ForegroundColor Yellow
$DEV_DIR = (Read-Host "  Projects dir (e.g. D:\Dev)").Trim()
if (-not $DEV_DIR) { $DEV_DIR = "D:\Dev" }
if (-not (Test-Path $DEV_DIR)) {
    if ((Read-Host "  $DEV_DIR not found. Create? (y/n)") -eq 'y') { New-Item $DEV_DIR -ItemType Directory -Force | Out-Null }
}
$USER_NAME  = (Read-Host "  Your name").Trim(); if (-not $USER_NAME) { $USER_NAME = "Developer" }
$USE_CAVE   = (Read-Host "  Caveman? 65-75% token savings (y/n)").Trim(); if (-not $USE_CAVE)  { $USE_CAVE  = "y" }
$USE_VIDEO  = (Read-Host "  Video skills? Seedance/SEO/YouTube (y/n)").Trim(); if (-not $USE_VIDEO) { $USE_VIDEO = "n" }
$USE_GSD    = (Read-Host "  GSD workflow? 70+ commands (y/n)").Trim(); if (-not $USE_GSD)   { $USE_GSD   = "y" }
Write-Host ""

# --- [3/9] Dirs ---
Write-Host "[3/9] Directories..." -ForegroundColor Yellow
foreach ($d in @($CLAUDE_DIR,$SKILLS_DIR,$HOOKS_DIR)) { if (-not (Test-Path $d)) { New-Item $d -ItemType Directory -Force | Out-Null } }
$TPL_DIR = Join-Path $DEV_DIR "_templates"
if (-not (Test-Path $TPL_DIR)) { New-Item $TPL_DIR -ItemType Directory -Force | Out-Null }
Write-Host "  OK" -ForegroundColor Green

# --- [4/9] Plugins ---
Write-Host "[4/9] Plugins..." -ForegroundColor Yellow
foreach ($p in @("security-guidance","code-review","playwright","coderabbit","firecrawl","github","chrome-devtools-mcp","code-simplifier","huggingface-skills")) {
    Write-Host "  $p..." -NoNewline -ForegroundColor $dim
    & claude plugin install "${p}@claude-plugins-official" 2>$null
    Write-Host " ok" -ForegroundColor Green
}
& claude plugin marketplace add "thedotmack/claude-mem" 2>$null;      & claude plugin install "claude-mem@thedotmack" 2>$null
& claude plugin marketplace add "obra/superpowers-marketplace" 2>$null; & claude plugin install "superpowers@superpowers-marketplace" 2>$null
& claude plugin marketplace add "nextlevelbuilder/ui-ux-pro-max-skill" 2>$null; & claude plugin install "ui-ux-pro-max@ui-ux-pro-max-skill" 2>$null
& claude plugin marketplace add "kepano/obsidian-skills" 2>$null;       & claude plugin install "obsidian@obsidian-skills" 2>$null
& claude plugin marketplace add "anthropics/skills" 2>$null
& claude plugin install "document-skills@anthropic-agent-skills" 2>$null
& claude plugin install "example-skills@anthropic-agent-skills" 2>$null
Write-Host "  16 plugins done." -ForegroundColor Green

# --- [5/9] Skills ---
Write-Host "[5/9] Skills..." -ForegroundColor Yellow
$skills = [System.Collections.ArrayList]@()
[void]$skills.Add(@{ n="awesome-design-md"; r="https://github.com/VoltAgent/awesome-design-md.git" })
if ($USE_CAVE  -eq 'y') { [void]$skills.Add(@{ n="caveman-skill";    r="https://github.com/JuliusBrussee/caveman.git" }) }
if ($USE_VIDEO -eq 'y') {
    [void]$skills.Add(@{ n="claude-seo";      r="https://github.com/AgriciDaniel/claude-seo.git" })
    [void]$skills.Add(@{ n="claude-youtube";  r="https://github.com/AgriciDaniel/claude-youtube.git" })
    [void]$skills.Add(@{ n="marketingskills"; r="https://github.com/coreyhaines31/marketingskills.git" })
    [void]$skills.Add(@{ n="seedance2-skill"; r="https://github.com/dexhunter/seedance2-skill.git" })
}
foreach ($s in $skills) {
    $dest = Join-Path $SKILLS_DIR $s.n
    if (-not (Test-Path $dest)) { Write-Host "  $($s.n)..." -NoNewline -ForegroundColor $dim; git clone --depth 1 $s.r $dest 2>$null; Write-Host " ok" -ForegroundColor Green }
    else { Write-Host "  $($s.n) exists." -ForegroundColor $dim }
}
if ($USE_GSD -eq 'y') { Write-Host "  GSD..." -ForegroundColor $dim; npx get-shit-done-cc@latest --claude --global 2>$null; Write-Host "  GSD ok" -ForegroundColor Green }

# Graphify
Write-Host "  Graphify..." -NoNewline -ForegroundColor $dim
pip install graphifyy 2>$null
graphify install --platform windows 2>$null
Write-Host " ok" -ForegroundColor Green

# --- [6/9] Hooks ---
Write-Host "[6/9] Hooks..." -ForegroundColor Yellow
foreach ($h in @("sensitive-file-guard.js","self-learning.js","skill-discovery.js","session-start.js","update-check.js","graphify-hint.js")) {
    $s = Join-Path $PARENT_ROOT "templates\$h"; $d = Join-Path $HOOKS_DIR $h
    if (Test-Path $s) { Copy-Item $s $d -Force; Write-Host "  $h" -ForegroundColor Green }
}
$SJ = Join-Path $CLAUDE_DIR "settings.json"
$hf = $HOOKS_DIR.Replace('\','/')
try {
    $raw = if (Test-Path $SJ) { Get-Content $SJ -Raw } else { '{}' }
    $raw = $raw -replace '(?m)^\s*//[^\n]*',''
    $ex  = $raw | ConvertFrom-Json
    if (-not $ex.hooks) {
        $ex | Add-Member -NotePropertyName "hooks" -NotePropertyValue @{
            SessionStart = @(@{ hooks = @(@{ type="command"; command="node `"$hf/session-start.js`"" }) })
            PreToolUse   = @(@{ matcher="Edit|Write|MultiEdit"; hooks = @(@{ type="command"; command="node `"$hf/sensitive-file-guard.js`""; timeout=5 }) })
            PostToolUse  = @(@{ matcher="Bash"; hooks = @(@{ type="command"; command="node `"$hf/self-learning.js`""; timeout=5 }) })
            Notification = @(@{ hooks = @(@{ type="command"; command="powershell.exe -WindowStyle Hidden -Command `"Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Claude Code needs your input in: ' + (Get-Location).Path, 'Claude Code', 'OK', 'Information')`"" }) })
        } -Force
        $ex | ConvertTo-Json -Depth 10 | Set-Content $SJ -Encoding UTF8
        Write-Host "  Hooks wired." -ForegroundColor Green
    } else { Write-Host "  Hooks already wired." -ForegroundColor $dim }
} catch { Write-Host "  Hook wire failed." -ForegroundColor DarkYellow }

# --- [7/9] CLAUDE.md ---
Write-Host "[7/9] CLAUDE.md..." -ForegroundColor Yellow
$gMd = Join-Path $CLAUDE_DIR "CLAUDE.md"; $tMd = Join-Path $PARENT_ROOT "templates\CLAUDE-template.md"; $skip = $false
if ((Test-Path $gMd) -and ((Read-Host "  Overwrite existing CLAUDE.md? (y/n)") -ne 'y')) { $skip = $true; Write-Host "  Skipped." -ForegroundColor DarkYellow }
if (-not $skip -and (Test-Path $tMd)) {
    $c = (Get-Content $tMd -Raw).Replace("{{USER_NAME}}",$USER_NAME).Replace("{{DEV_DIR}}",$DEV_DIR)
    $c = if ($USE_CAVE -eq 'y') { $c.Replace("{{CAVEMAN}}","- Caveman: type `$caveman to activate 65-75% token savings.") } else { $c.Replace("{{CAVEMAN}}","") }
    Set-Content $gMd $c -Encoding UTF8; Write-Host "  CLAUDE.md created." -ForegroundColor Green
}

# --- [8/9] Dependencies ---
Write-Host "[8/9] Dependencies..." -ForegroundColor Yellow

# Templates dagit
foreach ($f in @("start.ps1","ecosystem-awareness.md",".claudeignore")) {
    $s = Join-Path $PARENT_ROOT "templates\$f"; $d = Join-Path $TPL_DIR $f
    if (Test-Path $s) { Copy-Item $s $d -Force }
}
$ss = Join-Path $PARENT_ROOT "templates\start.ps1"; $n = 0
if (Test-Path $ss) {
    foreach ($p in (Get-ChildItem $DEV_DIR -Directory -EA SilentlyContinue)) { Copy-Item $ss (Join-Path $p.FullName "start.ps1") -Force; $n++ }
    Write-Host "  start.ps1 -- $n projects" -ForegroundColor Green
}

# CodeBurn
npm install -g codeburn 2>$null; Write-Host "  CodeBurn ok" -ForegroundColor Green

# Status bar -- leeguooooo/claude-code-usage-bar, her zaman ustune yaz
Write-Host "  Status bar..." -NoNewline -ForegroundColor $dim
$sbCmd = $null
$HAS_WSL = $false
try { $w = wsl --list --quiet 2>$null; if ($w) { $HAS_WSL = $true } } catch {}

if ($HAS_WSL) {
    wsl bash -lc 'curl -fsSL "https://raw.githubusercontent.com/leeguooooo/claude-code-usage-bar/main/web-install.sh" | bash 2>/dev/null' 2>$null
    $p = (wsl bash -lc 'which claude-code-usage-bar 2>/dev/null' 2>$null)
    if ($p -and $p.Trim()) { $sbCmd = $p.Trim() }
}
if (-not $sbCmd) {
    npm install -g claude-code-usage-bar 2>$null
    if (Get-Command "claude-code-usage-bar" -EA SilentlyContinue) { $sbCmd = "claude-code-usage-bar" }
}
if ($sbCmd) {
    try {
        $raw = if (Test-Path $SJ) { Get-Content $SJ -Raw } else { '{}' }
        $sc  = $raw -replace '(?m)^\s*//[^\n]*','' | ConvertFrom-Json
        # Her zaman ustune yaz (eski ccstatusline vs degistir)
        $sc | Add-Member -NotePropertyName "statusLine" -NotePropertyValue @{ type="command"; command=$sbCmd } -Force
        $sc | ConvertTo-Json -Depth 5 | Set-Content $SJ -Encoding UTF8
        Write-Host " ok" -ForegroundColor Green
        Write-Host "  Format: 5h[###38%]2h14m | 7d[###87%]3d05h | Opus 4.7(51k/200k)" -ForegroundColor $dim
    } catch { Write-Host " write failed" -ForegroundColor DarkYellow }
} else { Write-Host " skipped" -ForegroundColor DarkYellow }

# Claude Desktop MCP
$dCfg = "$env:APPDATA\Claude\claude_desktop_config.json"
if (Test-Path $dCfg) {
    try {
        $dc = Get-Content $dCfg -Raw | ConvertFrom-Json
        if (-not $dc.mcpServers) { $dc | Add-Member -NotePropertyName "mcpServers" -NotePropertyValue ([PSCustomObject]@{}) -Force }
        if (-not $dc.mcpServers.filesystem) {
            $dc.mcpServers | Add-Member -NotePropertyName "filesystem" -NotePropertyValue @{ command="npx"; args=@("-y","@modelcontextprotocol/server-filesystem",$CLAUDE_DIR,$DEV_DIR) } -Force
            $dc | ConvertTo-Json -Depth 8 | Set-Content $dCfg -Encoding UTF8
            Write-Host "  Desktop MCP ok" -ForegroundColor Green
        } else { Write-Host "  Desktop MCP already set" -ForegroundColor $dim }
    } catch { Write-Host "  Desktop MCP skipped" -ForegroundColor DarkYellow }
} else { Write-Host "  Desktop MCP skipped (not found)" -ForegroundColor $dim }

if (-not (Get-Command "bun" -EA SilentlyContinue)) {
    if ((Read-Host "  Install Bun? (y/n)") -eq 'y') { npm install -g bun 2>$null }
} else { Write-Host "  Bun ok" -ForegroundColor Green }

# --- [9/9] Complete ---
Write-Host "[9/9] Complete." -ForegroundColor Green
Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "   ClaudeForge ready!" -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "    Plugins : 16" -ForegroundColor $dim
Write-Host "    Skills  : $($skills.Count) + GSD" -ForegroundColor $dim
Write-Host "    Hooks   : session-start, security, self-learning" -ForegroundColor $dim
Write-Host "    Config  : CLAUDE.md generated" -ForegroundColor $dim
Write-Host "    Bar     : 5h[rate] | 7d[rate] | Model(ctx/max)" -ForegroundColor $dim
Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "  NEXT STEPS" -ForegroundColor White
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "  [1] Claude Code -- her proje icin:" -ForegroundColor Yellow
Write-Host "      cd $DEV_DIR\[proje-adi]" -ForegroundColor White
Write-Host "      .\start.ps1" -ForegroundColor White
Write-Host ""
Write-Host "  [2] Claude Desktop / claude.ai -- ilk kullanimda ver:" -ForegroundColor Yellow
if (Test-Path $dCfg) { Write-Host "      Filesystem MCP eklendi. Claude Desktop'i restart et." -ForegroundColor Green }
else { Write-Host "      claude.ai -- Projects -- Instructions -- ecosystem-awareness.md icerigini yapistir" -ForegroundColor $dim }
Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "  BASLANGIC PROMPTLARI" -ForegroundColor White
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "  [A] CLAUDE CODE (.\start.ps1 sonrasi yapistir):" -ForegroundColor Yellow
Write-Host "  +----------------------------------------------------------+" -ForegroundColor Cyan
Write-Host "  | Read CLAUDE.md fully. Read .claude/learnings.md.        |" -ForegroundColor White
Write-Host "  | Run: git status && git log --oneline -5                  |" -ForegroundColor White
Write-Host "  | GSD: phase? active task? next action? Report. Go.       |" -ForegroundColor White
Write-Host "  +----------------------------------------------------------+" -ForegroundColor Cyan
$ccP = "Read CLAUDE.md fully. Read .claude/learnings.md if exists. Run: git status && git log --oneline -5. GSD: What phase am I in? What is the active task? Exact next action? Report all. No clarifying questions. Start immediately."
try { $ccP | Set-Clipboard; Write-Host "  (Claude Code promptu clipboard'a kopyalandi)" -ForegroundColor Green } catch {}
Write-Host ""
Write-Host "  [B] CLAUDE DESKTOP / claude.ai (ilk acilista ver):" -ForegroundColor Yellow
Write-Host "  +----------------------------------------------------------+" -ForegroundColor Cyan
Write-Host "  | Read CLAUDE.md. List active skills, hooks, GSD status.  |" -ForegroundColor White
Write-Host "  | Confirm ClaudeForge is active. Report what you see.     |" -ForegroundColor White
Write-Host "  +----------------------------------------------------------+" -ForegroundColor Cyan
Write-Host "  Her projede su formati kullan:" -ForegroundColor $dim
Write-Host "  'Working on [proje]. Branch: [branch]. Task: [gorev]. Apply ClaudeForge rules.'" -ForegroundColor $dim
Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "  MALIYET AZALTMA" -ForegroundColor White
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host '  $caveman       -- her session yaz, %65-75 token azalir' -ForegroundColor White
Write-Host "  /compact       -- context dolunca sikistir" -ForegroundColor White
Write-Host "  /model         -- basit is icin haiku sec" -ForegroundColor White
Write-Host "  npx codeburn   -- haftalik harcama raporu" -ForegroundColor White
Write-Host ""
Write-Host "  SKILL TETIKLEME:" -ForegroundColor Yellow
Write-Host "  'spec this feature'   -- Feature Forge (gereksinim analizi)" -ForegroundColor $dim
Write-Host "  'design this system'  -- Architecture Designer" -ForegroundColor $dim
Write-Host "  'red team this'       -- The Fool (hata avcisi)" -ForegroundColor $dim
Write-Host "  'scrape https://...'  -- Firecrawl" -ForegroundColor $dim
Write-Host ""
Write-Host "  Az token. Guvenli kod. Hizli is." -ForegroundColor Green
Write-Host ""
Write-Host "  Docs: https://github.com/cemdenizexe/claudeforge" -ForegroundColor $dim
Write-Host ""
