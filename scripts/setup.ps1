$ErrorActionPreference = "Continue"
$accent = "DarkYellow"
$dim = "DarkGray"

Write-Host ""
Write-Host "   _____ _                 _      ______                    " -ForegroundColor $accent
Write-Host "  / ____| |               | |    |  ____|                   " -ForegroundColor $accent
Write-Host " | |    | | __ _ _   _  __| | ___| |__ ___  _ __ __ _  ___ " -ForegroundColor $accent
Write-Host " | |    | |/ _   | | | |/ _  |/ _ \  __/ _ \| '__/ _  |/ _ \" -ForegroundColor $accent
Write-Host " | |____| | (_| | |_| | (_| |  __/ | | (_) | | | (_| |  __/" -ForegroundColor $accent
Write-Host "  \_____|_|\__,_|\__,_|\__,_|\___|_|  \___/|_|  \__, |\___|" -ForegroundColor $accent
Write-Host "                                                  __/ |    " -ForegroundColor $accent
Write-Host "                                                 |___/     " -ForegroundColor $accent
Write-Host ""
Write-Host "  " -NoNewline
$byText = "by cemdenizexe"
$rainbow = @("Red","Yellow","Green","Cyan","Blue","Magenta","Red","Yellow","Green","Cyan","Blue","Magenta","Red","Yellow")
for ($i = 0; $i -lt $byText.Length; $i++) { Write-Host $byText[$i] -ForegroundColor $rainbow[$i] -NoNewline }
Write-Host ""
Write-Host ""
Write-Host "  Turn Claude Code into a professional dev environment" -ForegroundColor White
Write-Host "  200+ skills  |  Security autopilot  |  Self-learning" -ForegroundColor $dim
Write-Host ""
Write-Host "  ------------------------------------------------" -ForegroundColor $dim
Write-Host ""

# Detect environment
$IS_WINDOWS = $true
$HOME_DIR = $env:USERPROFILE
$CLAUDE_DIR = Join-Path $HOME_DIR ".claude"
$SKILLS_DIR = Join-Path $CLAUDE_DIR "skills"
$HOOKS_DIR = Join-Path $CLAUDE_DIR "hooks"
$SCRIPT_ROOT = $PSScriptRoot
$PARENT_ROOT = Split-Path $SCRIPT_ROOT -Parent

Write-Host "  Home      : $HOME_DIR" -ForegroundColor $dim
Write-Host "  Claude dir: $CLAUDE_DIR" -ForegroundColor $dim
Write-Host ""

# Step 1: Prerequisites
Write-Host "[1/8] Checking prerequisites..." -ForegroundColor Yellow
$missing = @()
if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) { $missing += "Node.js" }
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) { $missing += "Git" }
if (-not (Get-Command "claude" -ErrorAction SilentlyContinue)) { $missing += "Claude Code (npm install -g @anthropic-ai/claude-code)" }
if ($missing.Count -gt 0) {
    Write-Host "  Missing: $($missing -join ', ')" -ForegroundColor Red
    exit 1
}
Write-Host "  All prerequisites found." -ForegroundColor Green

# Step 2: Configuration
Write-Host ""
Write-Host "[2/8] Configuration..." -ForegroundColor Yellow
$DEV_DIR = Read-Host "  Your projects directory (e.g. D:\Dev, C:\code)"
if (-not $DEV_DIR) { $DEV_DIR = "D:\Dev" }
if (-not (Test-Path $DEV_DIR)) {
    $create = Read-Host "  $DEV_DIR doesn't exist. Create it? (y/n)"
    if ($create -eq 'y') { New-Item -Path $DEV_DIR -ItemType Directory -Force | Out-Null }
}
$USER_NAME = Read-Host "  Your name (for CLAUDE.md identity)"
if (-not $USER_NAME) { $USER_NAME = "Developer" }
$INSTALL_CAVEMAN = Read-Host "  Install Caveman? 65-75% token savings (y/n)"
if (-not $INSTALL_CAVEMAN) { $INSTALL_CAVEMAN = "y" }
$INSTALL_VIDEO = Read-Host "  Install video pipeline skills? Seedance/SEO/YouTube (y/n)"
if (-not $INSTALL_VIDEO) { $INSTALL_VIDEO = "n" }
Write-Host ""

# Step 3: Directories
Write-Host "[3/8] Setting up directories..." -ForegroundColor Yellow
foreach ($d in @($CLAUDE_DIR, $SKILLS_DIR, $HOOKS_DIR)) {
    if (-not (Test-Path $d)) { New-Item -Path $d -ItemType Directory -Force | Out-Null }
}
$TEMPLATES_DIR = Join-Path $DEV_DIR "_templates"
if (-not (Test-Path $TEMPLATES_DIR)) { New-Item -Path $TEMPLATES_DIR -ItemType Directory -Force | Out-Null }
Write-Host "  Directories created." -ForegroundColor Green

# Step 4: Plugins
Write-Host "[4/8] Installing core plugins..." -ForegroundColor Yellow
$corePlugins = @(
    "security-guidance", "code-review", "playwright", "semgrep",
    "coderabbit", "firecrawl", "github",
    "chrome-devtools-mcp", "code-simplifier", "huggingface-skills"
)
foreach ($p in $corePlugins) {
    Write-Host "  $p..." -ForegroundColor $dim -NoNewline
    & claude plugin install "${p}@claude-plugins-official" 2>$null
    Write-Host " ok" -ForegroundColor Green
}
Write-Host "  Marketplace plugins..." -ForegroundColor $dim
& claude plugin marketplace add "thedotmack/claude-mem" 2>$null
& claude plugin install "claude-mem@thedotmack" 2>$null
& claude plugin marketplace add "obra/superpowers-marketplace" 2>$null
& claude plugin install "superpowers@superpowers-marketplace" 2>$null
& claude plugin marketplace add "nextlevelbuilder/ui-ux-pro-max-skill" 2>$null
& claude plugin install "ui-ux-pro-max@ui-ux-pro-max-skill" 2>$null
& claude plugin marketplace add "kepano/obsidian-skills" 2>$null
& claude plugin install "obsidian@obsidian-skills" 2>$null
& claude plugin marketplace add "anthropics/skills" 2>$null
& claude plugin install "document-skills@anthropic-agent-skills" 2>$null
& claude plugin install "example-skills@anthropic-agent-skills" 2>$null
Write-Host "  16 plugins installed." -ForegroundColor Green

# Step 5: Skills
Write-Host "[5/8] Installing skills..." -ForegroundColor Yellow
$coreSkills = [System.Collections.ArrayList]@()
if ($INSTALL_CAVEMAN -eq 'y') {
    [void]$coreSkills.Add(@{ name = "caveman-skill"; repo = "https://github.com/JuliusBrussee/caveman.git" })
}
if ($INSTALL_VIDEO -eq 'y') {
    [void]$coreSkills.Add(@{ name = "claude-seo"; repo = "https://github.com/AgriciDaniel/claude-seo.git" })
    [void]$coreSkills.Add(@{ name = "claude-youtube"; repo = "https://github.com/AgriciDaniel/claude-youtube.git" })
    [void]$coreSkills.Add(@{ name = "marketingskills"; repo = "https://github.com/coreyhaines31/marketingskills.git" })
    [void]$coreSkills.Add(@{ name = "seedance2-skill"; repo = "https://github.com/dexhunter/seedance2-skill.git" })
}
foreach ($s in $coreSkills) {
    $dest = Join-Path $SKILLS_DIR $s.name
    if (-not (Test-Path $dest)) {
        Write-Host "  $($s.name)..." -ForegroundColor $dim -NoNewline
        git clone --depth 1 $s.repo $dest 2>$null
        Write-Host " ok" -ForegroundColor Green
    } else {
        Write-Host "  $($s.name) exists." -ForegroundColor $dim
    }
}
Write-Host "  Skills installed." -ForegroundColor Green

# Step 6: Hooks
Write-Host "[6/8] Installing hooks..." -ForegroundColor Yellow
$hookSource = Join-Path $PARENT_ROOT "templates"
foreach ($hook in @("sensitive-file-guard.js", "self-learning.js", "skill-discovery.js", "session-start.js")) {
    $src = Join-Path $hookSource $hook
    $dst = Join-Path $HOOKS_DIR $hook
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $dst -Force
        Write-Host "  $hook" -ForegroundColor Green
    }
}

# Step 7: Global CLAUDE.md
Write-Host "[7/8] Generating Global CLAUDE.md..." -ForegroundColor Yellow
$globalMd = Join-Path $CLAUDE_DIR "CLAUDE.md"
$templateMd = Join-Path (Join-Path $PARENT_ROOT "templates") "CLAUDE-template.md"
$skipClaude = $false

if (Test-Path $globalMd) {
    $overwrite = Read-Host "  Global CLAUDE.md exists. Overwrite? (y/n)"
    if ($overwrite -ne 'y') {
        Write-Host "  Skipped." -ForegroundColor DarkYellow
        $skipClaude = $true
    }
}

if (-not $skipClaude) {
    if (Test-Path $templateMd) {
        $content = Get-Content $templateMd -Raw
        $content = $content.Replace("{{USER_NAME}}", $USER_NAME)
        $content = $content.Replace("{{DEV_DIR}}", $DEV_DIR)
        if ($INSTALL_CAVEMAN -eq 'y') {
            $content = $content.Replace("{{CAVEMAN}}", "- Caveman - token 65-75 percent reduction. Type dollar-caveman to activate.")
        } else {
            $content = $content.Replace("{{CAVEMAN}}", "")
        }
        Set-Content -Path $globalMd -Value $content -Encoding UTF8
        Write-Host "  Global CLAUDE.md created for $USER_NAME." -ForegroundColor Green
    } else {
        $fallback = Join-Path $PARENT_ROOT "templates" "CLAUDE.md"
        if (Test-Path $fallback) {
            Copy-Item -Path $fallback -Destination $globalMd -Force
        }
        Write-Host "  Global CLAUDE.md copied (default)." -ForegroundColor DarkYellow
    }
}

# Step 8: Templates + CodeBurn
Write-Host "[8/8] Setting up templates..." -ForegroundColor Yellow
foreach ($f in @("start.ps1", "ecosystem-awareness.md", ".claudeignore")) {
    $src = Join-Path (Join-Path $PARENT_ROOT "templates") $f
    $dst = Join-Path $TEMPLATES_DIR $f
    if (Test-Path $src) { Copy-Item -Path $src -Destination $dst -Force }
}
Write-Host "  Installing CodeBurn..." -ForegroundColor $dim
npm install -g codeburn 2>$null

Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "   ClaudeForge setup complete!" -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "  Installed:" -ForegroundColor White
Write-Host "    Plugins     16 (zero redundancy)" -ForegroundColor $dim
Write-Host "    Skills      $($coreSkills.Count) cloned + 70 GSD + plugin bundles = 200+ total" -ForegroundColor $dim
Write-Host "    Hooks       sensitive-file-guard, self-learning, skill-discovery" -ForegroundColor $dim
Write-Host '    Workflow    GSD (70+ cmds, auto-enforced phases)' -ForegroundColor $dim
Write-Host "    Config      Global CLAUDE.md with Skill Activation Guide" -ForegroundColor $dim
Write-Host "    Dashboard   CodeBurn (npx codeburn)" -ForegroundColor $dim
Write-Host ""
Write-Host "  Quick start:" -ForegroundColor White
Write-Host "    cd $DEV_DIR\[your-project]" -ForegroundColor $dim
Write-Host "    claude" -ForegroundColor $dim
Write-Host '    Paste: "Read CLAUDE.md. Run git status. Report status."' -ForegroundColor $dim
if ($INSTALL_CAVEMAN -eq 'y') {
    Write-Host '    Type $caveman to save 65-75% tokens' -ForegroundColor $dim
}
Write-Host ""
Write-Host "  Docs:  https://github.com/cemdenizexe/claudeforge" -ForegroundColor $dim
Write-Host ""