$ErrorActionPreference = "Continue"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8
$accent = "DarkYellow"
$dim = "DarkGray"

Write-Host ""
Write-Host "  +===========================================================+" -ForegroundColor DarkYellow
Write-Host "  |                                                           |" -ForegroundColor DarkYellow
Write-Host "  |   _____ _                 _      ______                  |" -ForegroundColor DarkYellow
Write-Host "  |  / ____| |               | |    |  ____|                 |" -ForegroundColor DarkYellow
Write-Host "  | | |    | | __ _ _   _  __| | ___| |__ ___  _ __ __ _  __|" -ForegroundColor DarkYellow
Write-Host "  | | |    | |/ _  | | | |/ _  |/ _ \  __/ _ \| '__/ _  |/ _|" -ForegroundColor DarkYellow
Write-Host "  | | |____| | (_| | |_| | (_| |  __/ | | (_) | | | (_| |  _|" -ForegroundColor DarkYellow
Write-Host "  |  \_____|_|\__,_|\__,_|\__,_|\___|_|  \___/|_|  \__, |\__|" -ForegroundColor DarkYellow
Write-Host "  |                                                  __/ |    |" -ForegroundColor DarkYellow
Write-Host "  |                                                 |___/     |" -ForegroundColor DarkYellow
Write-Host "  |                                    by cemdenizexe         |" -ForegroundColor White
Write-Host "  |                                                           |" -ForegroundColor DarkYellow
Write-Host "  +-----------------------------------------------------------+" -ForegroundColor DarkYellow
Write-Host "  |  One command. 200+ skills. Security. Memory. Workflow.   |" -ForegroundColor White
Write-Host "  +-----------------------------------------------------------+" -ForegroundColor DarkYellow
Write-Host "  |  [01] 200+ SKILLS     Preloaded AI capabilities          |" -ForegroundColor $dim
Write-Host "  |  [02] SECURITY        Auto scan on every edit            |" -ForegroundColor $dim
Write-Host "  |  [03] SESSION MEMORY  Context persists across sessions   |" -ForegroundColor $dim
Write-Host "  |  [04] GSD WORKFLOW    Plan. Execute. Review. Ship.       |" -ForegroundColor $dim
Write-Host "  |  [05] CAVEMAN MODE    65-75% token savings               |" -ForegroundColor $dim
Write-Host "  |  [06] STATUS BAR      Real-time token + rate limit       |" -ForegroundColor $dim
Write-Host "  +-----------------------------------------------------------+" -ForegroundColor DarkYellow
Write-Host ""

# --- Env ---
$HOME_DIR = $env:USERPROFILE
$CLAUDE_DIR = Join-Path $HOME_DIR ".claude"
$SKILLS_DIR = Join-Path $CLAUDE_DIR "skills"
$HOOKS_DIR  = Join-Path $CLAUDE_DIR "hooks"
$SCRIPT_ROOT = $PSScriptRoot
$PARENT_ROOT = Split-Path $SCRIPT_ROOT -Parent

Write-Host "  Home      : $HOME_DIR" -ForegroundColor $dim
Write-Host "  Claude dir: $CLAUDE_DIR" -ForegroundColor $dim
Write-Host ""

# --- [1/9] Prerequisites ---
Write-Host "[1/9] Prerequisites..." -ForegroundColor Yellow
$missing = @()
if (-not (Get-Command "node"   -EA SilentlyContinue)) { $missing += "Node.js" }
if (-not (Get-Command "git"    -EA SilentlyContinue)) { $missing += "Git" }
if (-not (Get-Command "claude" -EA SilentlyContinue)) { $missing += "Claude Code" }
if ($missing.Count -gt 0) { Write-Host "  Missing: $($missing -join ', ')" -ForegroundColor Red; exit 1 }
Write-Host "  OK" -ForegroundColor Green

# --- [2/9] Config ---
Write-Host ""
Write-Host "[2/9] Configuration..." -ForegroundColor Yellow
$DEV_DIR         = (Read-Host "  Projects directory (e.g. D:\Dev)").Trim()
if (-not $DEV_DIR) { $DEV_DIR = "D:\Dev" }
if (-not (Test-Path $DEV_DIR)) {
    if ((Read-Host "  $DEV_DIR not found. Create? (y/n)") -eq 'y') { New-Item $DEV_DIR -ItemType Directory -Force | Out-Null }
}
$USER_NAME       = (Read-Host "  Your name").Trim(); if (-not $USER_NAME) { $USER_NAME = "Developer" }
$INSTALL_CAVEMAN = (Read-Host "  Caveman? 65-75% token savings (y/n)").Trim(); if (-not $INSTALL_CAVEMAN) { $INSTALL_CAVEMAN = "y" }
$INSTALL_VIDEO   = (Read-Host "  Video skills? Seedance/SEO/YouTube (y/n)").Trim(); if (-not $INSTALL_VIDEO) { $INSTALL_VIDEO = "n" }
$INSTALL_GSD     = (Read-Host "  GSD workflow? 70+ commands (y/n)").Trim(); if (-not $INSTALL_GSD) { $INSTALL_GSD = "y" }
Write-Host ""

# --- [3/9] Dirs ---
Write-Host "[3/9] Directories..." -ForegroundColor Yellow
foreach ($d in @($CLAUDE_DIR, $SKILLS_DIR, $HOOKS_DIR)) {
    if (-not (Test-Path $d)) { New-Item $d -ItemType Directory -Force | Out-Null }
}
$TEMPLATES_DIR = Join-Path $DEV_DIR "_templates"
if (-not (Test-Path $TEMPLATES_DIR)) { New-Item $TEMPLATES_DIR -ItemType Directory -Force | Out-Null }
Write-Host "  OK" -ForegroundColor Green

# --- [4/9] Plugins ---
Write-Host "[4/9] Plugins..." -ForegroundColor Yellow
foreach ($p in @("security-guidance","code-review","playwright","coderabbit","firecrawl","github","chrome-devtools-mcp","code-simplifier","huggingface-skills")) {
    Write-Host "  $p..." -ForegroundColor $dim -NoNewline
    & claude plugin install "${p}@claude-plugins-official" 2>$null
    Write-Host " ok" -ForegroundColor Green
}
foreach ($mp in @("thedotmack/claude-mem","obra/superpowers-marketplace","nextlevelbuilder/ui-ux-pro-max-skill","kepano/obsidian-skills","anthropics/skills")) {
    & claude plugin marketplace add $mp 2>$null
}
& claude plugin install "claude-mem@thedotmack" 2>$null
& claude plugin install "superpowers@superpowers-marketplace" 2>$null
& claude plugin install "ui-ux-pro-max@ui-ux-pro-max-skill" 2>$null
& claude plugin install "obsidian@obsidian-skills" 2>$null
& claude plugin install "document-skills@anthropic-agent-skills" 2>$null
& claude plugin install "example-skills@anthropic-agent-skills" 2>$null
Write-Host "  16 plugins done." -ForegroundColor Green

# --- [5/9] Skills ---
Write-Host "[5/9] Skills..." -ForegroundColor Yellow
$coreSkills = [System.Collections.ArrayList]@()
[void]$coreSkills.Add(@{ name="awesome-design-md"; repo="https://github.com/VoltAgent/awesome-design-md.git" })
if ($INSTALL_CAVEMAN -eq 'y') { [void]$coreSkills.Add(@{ name="caveman-skill"; repo="https://github.com/JuliusBrussee/caveman.git" }) }
if ($INSTALL_VIDEO -eq 'y') {
    [void]$coreSkills.Add(@{ name="claude-seo";       repo="https://github.com/AgriciDaniel/claude-seo.git" })
    [void]$coreSkills.Add(@{ name="claude-youtube";   repo="https://github.com/AgriciDaniel/claude-youtube.git" })
    [void]$coreSkills.Add(@{ name="marketingskills";  repo="https://github.com/coreyhaines31/marketingskills.git" })
    [void]$coreSkills.Add(@{ name="seedance2-skill";  repo="https://github.com/dexhunter/seedance2-skill.git" })
}
foreach ($s in $coreSkills) {
    $dest = Join-Path $SKILLS_DIR $s.name
    if (-not (Test-Path $dest)) {
        Write-Host "  $($s.name)..." -ForegroundColor $dim -NoNewline
        git clone --depth 1 $s.repo $dest 2>$null
        Write-Host " ok" -ForegroundColor Green
    } else { Write-Host "  $($s.name) exists." -ForegroundColor $dim }
}
if ($INSTALL_GSD -eq 'y') {
    Write-Host "  GSD..." -ForegroundColor $dim
    npx get-shit-done-cc@latest --claude --global 2>$null
    Write-Host "  GSD ok" -ForegroundColor Green
}

# --- [6/9] Hooks ---
Write-Host "[6/9] Hooks..." -ForegroundColor Yellow
$hookSrc = Join-Path $PARENT_ROOT "templates"
foreach ($h in @("sensitive-file-guard.js","self-learning.js","skill-discovery.js","session-start.js","update-check.js")) {
    $src = Join-Path $hookSrc $h; $dst = Join-Path $HOOKS_DIR $h
    if (Test-Path $src) { Copy-Item $src $dst -Force; Write-Host "  $h" -ForegroundColor Green }
}
$settingsJson = Join-Path $CLAUDE_DIR "settings.json"
$hf = $HOOKS_DIR.Replace('\','/')
try {
    $raw = if (Test-Path $settingsJson) { Get-Content $settingsJson -Raw } else { '{}' }
    $raw = $raw -replace '(?m)^\s*//[^\n]*',''
    $ex = $raw | ConvertFrom-Json
    if (-not $ex.hooks) {
        $ex | Add-Member -NotePropertyName "hooks" -NotePropertyValue @{
            SessionStart = @(@{ hooks = @(@{ type="command"; command="node `"$hf/session-start.js`"" }) })
            PreToolUse   = @(@{ matcher="Edit|Write|MultiEdit"; hooks = @(@{ type="command"; command="node `"$hf/sensitive-file-guard.js`""; timeout=5 }) })
            PostToolUse  = @(@{ matcher="Bash"; hooks = @(@{ type="command"; command="node `"$hf/self-learning.js`""; timeout=5 }) })
        } -Force
        $ex | ConvertTo-Json -Depth 10 | Set-Content $settingsJson -Encoding UTF8
        Write-Host "  Hooks wired." -ForegroundColor Green
    } else { Write-Host "  Hooks already wired." -ForegroundColor $dim }
} catch { Write-Host "  Hook wire failed." -ForegroundColor DarkYellow }

# --- [7/9] CLAUDE.md ---
Write-Host "[7/9] CLAUDE.md..." -ForegroundColor Yellow
$globalMd = Join-Path $CLAUDE_DIR "CLAUDE.md"
$tmplMd   = Join-Path $PARENT_ROOT "templates\CLAUDE-template.md"
$skip = $false
if (Test-Path $globalMd) {
    if ((Read-Host "  Overwrite existing CLAUDE.md? (y/n)") -ne 'y') { $skip = $true; Write-Host "  Skipped." -ForegroundColor DarkYellow }
}
if (-not $skip -and (Test-Path $tmplMd)) {
    $c = (Get-Content $tmplMd -Raw).Replace("{{USER_NAME}}",$USER_NAME).Replace("{{DEV_DIR}}",$DEV_DIR)
    if ($INSTALL_CAVEMAN -eq 'y') { $c = $c.Replace("{{CAVEMAN}}","- Caveman active. Type `$caveman to save tokens.") }
    else { $c = $c.Replace("{{CAVEMAN}}","") }
    Set-Content $globalMd $c -Encoding UTF8
    Write-Host "  CLAUDE.md created." -ForegroundColor Green
}

# --- [8/9] Deps + dist ---
Write-Host "[8/9] Dependencies..." -ForegroundColor Yellow
foreach ($f in @("start.ps1","ecosystem-awareness.md",".claudeignore")) {
    $src = Join-Path $PARENT_ROOT "templates\$f"; $dst = Join-Path $TEMPLATES_DIR $f
    if (Test-Path $src) { Copy-Item $src $dst -Force }
}
$startSrc = Join-Path $PARENT_ROOT "templates\start.ps1"
$distributed = 0
if (Test-Path $startSrc) {
    foreach ($proj in (Get-ChildItem $DEV_DIR -Directory -EA SilentlyContinue)) {
        Copy-Item $startSrc (Join-Path $proj.FullName "start.ps1") -Force
        $distributed++
    }
    Write-Host "  start.ps1 -- $distributed projects" -ForegroundColor Green
}
npm install -g codeburn 2>$null; Write-Host "  CodeBurn ok" -ForegroundColor Green

# Status bar
Write-Host "  Status bar..." -ForegroundColor $dim -NoNewline
$sj = Join-Path $CLAUDE_DIR "settings.json"
$sbCommand = $null

# 1. ccstatusline dene
npm install -g ccstatusline 2>$null
$test = ccstatusline 2>$null
if ($LASTEXITCODE -eq 0 -or $test) { $sbCommand = "ccstatusline" }

# 2. claude-code-usage-bar dene
if (-not $sbCommand) {
    npm install -g claude-code-usage-bar 2>$null
    $test2 = claude-code-usage-bar 2>$null
    if ($LASTEXITCODE -eq 0 -or $test2) { $sbCommand = "claude-code-usage-bar" }
}

# 3. Bulunduysa settings.json'a yaz
if ($sbCommand) {
    try {
        $sc = Get-Content $sj -Raw -EA SilentlyContinue | ConvertFrom-Json
        if (-not $sc) { $sc = [PSCustomObject]@{} }
        if (-not $sc.statusLine) {
            $sc | Add-Member -NotePropertyName "statusLine" -NotePropertyValue @{ type="command"; command=$sbCommand } -Force
            $sc | ConvertTo-Json -Depth 5 | Set-Content $sj -Encoding UTF8
        }
        Write-Host " ok ($sbCommand)" -ForegroundColor Green
    } catch { Write-Host " settings write failed" -ForegroundColor DarkYellow }
} else {
    Write-Host " skipped" -ForegroundColor DarkYellow
}

$desktopConfig = "$env:APPDATA\Claude\claude_desktop_config.json"
if (Test-Path $desktopConfig) {
    try {
        $dc = Get-Content $desktopConfig -Raw | ConvertFrom-Json
        if (-not $dc.mcpServers) { $dc | Add-Member -NotePropertyName "mcpServers" -NotePropertyValue ([PSCustomObject]@{}) -Force }
        if (-not $dc.mcpServers.filesystem) {
            $dc.mcpServers | Add-Member -NotePropertyName "filesystem" -NotePropertyValue @{
                command="npx"; args=@("-y","@modelcontextprotocol/server-filesystem",$CLAUDE_DIR,$DEV_DIR)
            } -Force
            $dc | ConvertTo-Json -Depth 8 | Set-Content $desktopConfig -Encoding UTF8
            Write-Host "  Desktop MCP ok" -ForegroundColor Green
        } else { Write-Host "  Desktop MCP already set" -ForegroundColor $dim }
    } catch { Write-Host "  Desktop MCP skipped" -ForegroundColor DarkYellow }
} else { Write-Host "  Desktop MCP skipped (not found)" -ForegroundColor $dim }

if (-not (Get-Command "bun" -EA SilentlyContinue)) {
    if ((Read-Host "  Install Bun? (y/n)") -eq 'y') { npm install -g bun 2>$null }
} else { Write-Host "  Bun ok" -ForegroundColor Green }

# --- [9/9] Done ---
Write-Host "[9/9] Complete." -ForegroundColor Green

Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "   ClaudeForge ready!" -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "  Installed:" -ForegroundColor White
Write-Host "    Plugins  : 16" -ForegroundColor $dim
Write-Host "    Skills   : $($coreSkills.Count) + GSD" -ForegroundColor $dim
Write-Host "    Hooks    : session-start, security, self-learning" -ForegroundColor $dim
Write-Host "    Config   : CLAUDE.md generated" -ForegroundColor $dim
Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "  NEXT STEPS" -ForegroundColor White
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "  [1] Claude Code:" -ForegroundColor Yellow
Write-Host "      cd $DEV_DIR\[proje-adi]" -ForegroundColor White
Write-Host "      .\start.ps1" -ForegroundColor White
Write-Host ""
Write-Host "  [2] Claude Desktop / claude.ai:" -ForegroundColor Yellow
if (Test-Path $desktopConfig) {
    Write-Host "      Filesystem MCP eklendi. Claude Desktop restart." -ForegroundColor Green
} else {
    Write-Host "      claude.ai -- Projects -- Instructions -- CLAUDE.md yapistir" -ForegroundColor $dim
}
Write-Host ""
Write-Host "  Bu promptu Claude Desktop'a ver:" -ForegroundColor White
Write-Host ""
Write-Host "  +----------------------------------------------------------+" -ForegroundColor Cyan
Write-Host "  | Read CLAUDE.md. List active skills, hooks, GSD status.  |" -ForegroundColor White
Write-Host "  | Confirm ClaudeForge is active. Report what you see.     |" -ForegroundColor White
Write-Host "  +----------------------------------------------------------+" -ForegroundColor Cyan
Write-Host ""
$p = "Read CLAUDE.md. List active skills, hooks, GSD status. Confirm ClaudeForge is active. Report what you see."
try { $p | Set-Clipboard; Write-Host "  (Clipboard'a kopyalandi)" -ForegroundColor Green } catch {}
Write-Host ""
Write-Host "  [2b] claude.ai Projects farkindалigi icin ecosystem-awareness.md:" -ForegroundColor Yellow
$ecoFile = Join-Path $TEMPLATES_DIR "ecosystem-awareness.md"
if (Test-Path $ecoFile) {
    try {
        Get-Content $ecoFile -Raw | Set-Clipboard
        Write-Host "      Dosya clipboard'a kopyalandi." -ForegroundColor Green
        Write-Host "      claude.ai -- Projects -- Instructions -- Ctrl+V" -ForegroundColor White
    } catch {
        Write-Host "      Dosya: $ecoFile" -ForegroundColor $dim
        Write-Host "      Icerigini Projects > Instructions'a yapistir." -ForegroundColor $dim
    }
}
Write-Host ""
Write-Host "  [3] Token tasarrufu:" -ForegroundColor Yellow
Write-Host '      $caveman yaz' -ForegroundColor White
Write-Host ""
Write-Host "  [4] Saglik:" -ForegroundColor Yellow
Write-Host "      npx codeburn optimize" -ForegroundColor White
Write-Host ""
Write-Host "  Docs: https://github.com/cemdenizexe/claudeforge" -ForegroundColor $dim
Write-Host "  MCP'ler: https://github.com/cemdenizexe/claudeforge/blob/main/docs/12-mcp-servers.md" -ForegroundColor $dim
Write-Host ""
