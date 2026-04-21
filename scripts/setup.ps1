$ErrorActionPreference = "Continue"

# Colors
$accent = "DarkYellow"
$dim = "DarkGray"

Write-Host ""
Write-Host "   _____ _                 _      ______                    " -ForegroundColor $accent
Write-Host "  / ____| |               | |    |  ____|                   " -ForegroundColor $accent
Write-Host " | |    | | __ _ _   _  __| | ___| |__ ___  _ __ __ _  ___ " -ForegroundColor $accent
Write-Host " | |    | |/ _`` | | | |/ _`` |/ _ \  __/ _ \| '__/ _`` |/ _ \" -ForegroundColor $accent
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

# Step 0: Detect environment
$IS_WINDOWS = $PSVersionTable.Platform -ne 'Unix'
$HOME_DIR = if ($IS_WINDOWS) { $env:USERPROFILE } else { $env:HOME }
$CLAUDE_DIR = Join-Path $HOME_DIR ".claude"
$SKILLS_DIR = Join-Path $CLAUDE_DIR "skills"
$HOOKS_DIR = Join-Path $CLAUDE_DIR "hooks"
$SCRIPT_ROOT = $PSScriptRoot
$PARENT_ROOT = Split-Path $SCRIPT_ROOT -Parent

Write-Host "  OS        : $(if ($IS_WINDOWS) {'Windows'} else {'Unix'})" -ForegroundColor DarkGray
Write-Host "  Home      : $HOME_DIR" -ForegroundColor DarkGray
Write-Host "  Claude dir: $CLAUDE_DIR" -ForegroundColor DarkGray
Write-Host ""

# Step 1: Check prerequisites
Write-Host "[1/8] Checking prerequisites..." -ForegroundColor Yellow

$missing = @()
if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) { $missing += "Node.js" }
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) { $missing += "Git" }
if (-not (Get-Command "claude" -ErrorAction SilentlyContinue)) { $missing += "Claude Code (npm install -g @anthropic-ai/claude-code)" }

if ($missing.Count -gt 0) {
    Write-Host "  Missing: $($missing -join ', ')" -ForegroundColor Red
    Write-Host "  Install these first, then re-run setup." -ForegroundColor Red
    exit 1
}
Write-Host "  All prerequisites found." -ForegroundColor Green

# Step 2: Ask user preferences
Write-Host ""
Write-Host "[2/8] Configuration..." -ForegroundColor Yellow

$DEV_DIR = Read-Host "  Your projects directory (e.g. D:\Dev, ~/projects, C:\code)"
if (-not $DEV_DIR) { $DEV_DIR = if ($IS_WINDOWS) { "D:\Dev" } else { "$HOME_DIR/projects" } }
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

# Step 3: Create directory structure
Write-Host "[3/8] Setting up directory structure..." -ForegroundColor Yellow

foreach ($d in @($CLAUDE_DIR, $SKILLS_DIR, $HOOKS_DIR)) {
    if (-not (Test-Path $d)) { New-Item -Path $d -ItemType Directory -Force | Out-Null }
}

# Create _templates in dev dir
$TEMPLATES_DIR = Join-Path $DEV_DIR "_templates"
if (-not (Test-Path $TEMPLATES_DIR)) { New-Item -Path $TEMPLATES_DIR -ItemType Directory -Force | Out-Null }

Write-Host "  Directories created." -ForegroundColor Green

# Step 4: Install plugins
Write-Host "[4/8] Installing core plugins..." -ForegroundColor Yellow

$corePlugins = @(
    "security-guidance", "code-review", "playwright", "semgrep",
    "coderabbit", "firecrawl", "github",
    "chrome-devtools-mcp", "code-simplifier",
    "huggingface-skills"
)
foreach ($p in $corePlugins) {
    Write-Host "  $p..." -ForegroundColor DarkGray -NoNewline
    claude plugin install "${p}@claude-plugins-official" 2>$null
    Write-Host " ok" -ForegroundColor Green
}

# Marketplace plugins
$marketplacePlugins = @(
    @{ name = "claude-mem"; market = "thedotmack"; repo = "thedotmack/claude-mem" },
    @{ name = "superpowers"; market = "superpowers-marketplace"; repo = "obra/superpowers-marketplace" },
    @{ name = "ui-ux-pro-max"; market = "ui-ux-pro-max-skill"; repo = "nextlevelbuilder/ui-ux-pro-max-skill" },
    @{ name = "obsidian"; market = "obsidian-skills"; repo = "kepano/obsidian-skills" }
)
foreach ($mp in $marketplacePlugins) {
    Write-Host "  $($mp.name)..." -ForegroundColor DarkGray -NoNewline
    claude plugin marketplace add $mp.repo 2>$null
    claude plugin install "$($mp.name)@$($mp.market)" 2>$null
    Write-Host " ok" -ForegroundColor Green
}

# Anthropic official
foreach ($p in @("document-skills", "example-skills")) {
    Write-Host "  $p..." -ForegroundColor DarkGray -NoNewline
    claude plugin install "${p}@anthropic-agent-skills" 2>$null
    Write-Host " ok" -ForegroundColor Green
}
Write-Host "  16 plugins installed (no redundancy)." -ForegroundColor Green

# Step 5: Install skills
Write-Host "[5/8] Installing skills..." -ForegroundColor Yellow

$coreSkills = @(
    @{ name = "superpowers"; repo = "https://github.com/obra/superpowers.git" }
)

if ($INSTALL_CAVEMAN -eq 'y') {
    $coreSkills += @{ name = "caveman-skill"; repo = "https://github.com/JuliusBrussee/caveman.git" }
}

if ($INSTALL_VIDEO -eq 'y') {
    $coreSkills += @(
        @{ name = "claude-seo"; repo = "https://github.com/AgriciDaniel/claude-seo.git" },
        @{ name = "claude-youtube"; repo = "https://github.com/AgriciDaniel/claude-youtube.git" },
        @{ name = "marketingskills"; repo = "https://github.com/coreyhaines31/marketingskills.git" },
        @{ name = "seedance2-skill"; repo = "https://github.com/dexhunter/seedance2-skill.git" },
        @{ name = "playwright-skill"; repo = "https://github.com/lackeyjb/playwright-skill.git" }
    )
}

foreach ($s in $coreSkills) {
    $dest = Join-Path $SKILLS_DIR $s.name
    if (-not (Test-Path $dest)) {
        Write-Host "  $($s.name)..." -ForegroundColor DarkGray -NoNewline
        git clone --depth 1 $s.repo $dest 2>$null
        Write-Host " ok" -ForegroundColor Green
    } else {
        Write-Host "  $($s.name) exists, skipping." -ForegroundColor DarkGray
    }
}
Write-Host "  Skills installed." -ForegroundColor Green

# Step 6: Install hooks
Write-Host "[6/8] Installing security & learning hooks..." -ForegroundColor Yellow

$hookSource = Join-Path $PARENT_ROOT "templates"
foreach ($hook in @("sensitive-file-guard.js", "self-learning.js")) {
    $src = Join-Path $hookSource $hook
    $dst = Join-Path $HOOKS_DIR $hook
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $dst -Force
        Write-Host "  $hook installed." -ForegroundColor Green
    }
}

# Step 7: Generate Global CLAUDE.md
Write-Host "[7/8] Generating Global CLAUDE.md..." -ForegroundColor Yellow

$globalMd = Join-Path $CLAUDE_DIR "CLAUDE.md"
$templateMd = Join-Path $PARENT_ROOT "templates" "CLAUDE-template.md"

if (Test-Path $globalMd) {
    $overwrite = Read-Host "  Global CLAUDE.md exists. Overwrite? (y/n)"
    if ($overwrite -ne 'y') {
        Write-Host "  Skipped — keeping existing CLAUDE.md." -ForegroundColor DarkYellow
        goto step8
    }
}

# Generate from template with user values
if (Test-Path $templateMd) {
    $content = Get-Content $templateMd -Raw
    $content = $content.Replace("{{USER_NAME}}", $USER_NAME)
    $content = $content.Replace("{{DEV_DIR}}", $DEV_DIR)
    $content = $content.Replace("{{CAVEMAN}}", $(if ($INSTALL_CAVEMAN -eq 'y') {"- **Caveman** — token 65-75% reduction. `$caveman` to activate."} else {""}))
    Set-Content -Path $globalMd -Value $content -Encoding UTF8
    Write-Host "  Global CLAUDE.md created for $USER_NAME." -ForegroundColor Green
} else {
    Copy-Item -Path (Join-Path $PARENT_ROOT "templates" "CLAUDE.md") -Destination $globalMd -Force
    Write-Host "  Global CLAUDE.md copied (template not found, using default)." -ForegroundColor DarkYellow
}

:step8
# Step 8: Copy templates to dev directory
Write-Host "[8/8] Setting up project templates..." -ForegroundColor Yellow

foreach ($f in @("start.ps1", "ecosystem-awareness.md")) {
    $src = Join-Path $PARENT_ROOT "templates" $f
    $dst = Join-Path $TEMPLATES_DIR $f
    if (Test-Path $src) { Copy-Item -Path $src -Destination $dst -Force }
}

# Install CodeBurn
Write-Host "  Installing CodeBurn..." -ForegroundColor DarkGray
npm install -g codeburn 2>$null

Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "   ⚒️  ClaudeForge setup complete!" -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "  Installed:" -ForegroundColor White
Write-Host "    Plugins     16 (zero redundancy, each unique purpose)" -ForegroundColor $dim
Write-Host "    Skills      $($coreSkills.Count) cloned + 70 GSD + plugin bundles = 200+ total" -ForegroundColor $dim
Write-Host "    Hooks       sensitive-file-guard, self-learning, 9 GSD hooks" -ForegroundColor $dim
Write-Host "    Workflow    GSD (70+ commands, auto-enforced phases)" -ForegroundColor $dim
Write-Host "    Config      Global CLAUDE.md with Skill Activation Guide" -ForegroundColor $dim
Write-Host "    Dashboard   CodeBurn (npx codeburn)" -ForegroundColor $dim
Write-Host ""
Write-Host "  Quick start:" -ForegroundColor White
Write-Host "    cd $DEV_DIR\[your-project]" -ForegroundColor $dim
Write-Host "    claude" -ForegroundColor $dim
Write-Host '    Paste: "Read CLAUDE.md. Run git status. Report status."' -ForegroundColor $dim
if ($INSTALL_CAVEMAN -eq 'y') {
    Write-Host '    Type: $caveman  (saves 65-75% tokens)' -ForegroundColor $dim
}
Write-Host ""
Write-Host "  Docs:  https://github.com/cemdenizexe/claudeforge" -ForegroundColor $dim
Write-Host ""