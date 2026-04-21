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

# ─── Environment Detection ───
$HOME_DIR = $env:USERPROFILE
$CLAUDE_DIR = Join-Path $HOME_DIR ".claude"
$SKILLS_DIR = Join-Path $CLAUDE_DIR "skills"
$HOOKS_DIR = Join-Path $CLAUDE_DIR "hooks"
$SCRIPT_ROOT = $PSScriptRoot
$PARENT_ROOT = Split-Path $SCRIPT_ROOT -Parent

# WSL Detection
$HAS_WSL = $false
try { $wslCheck = wsl --list --quiet 2>$null; if ($wslCheck) { $HAS_WSL = $true } } catch {}

Write-Host "  Home      : $HOME_DIR" -ForegroundColor $dim
Write-Host "  Claude dir: $CLAUDE_DIR" -ForegroundColor $dim
if ($HAS_WSL) { Write-Host "  WSL       : Detected - will install to both Windows and WSL" -ForegroundColor Cyan }
Write-Host ""

# ─── [1/9] Prerequisites ───
Write-Host "[1/9] Checking prerequisites..." -ForegroundColor Yellow
$missing = @()
if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) { $missing += "Node.js" }
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) { $missing += "Git" }
if (-not (Get-Command "claude" -ErrorAction SilentlyContinue)) { $missing += "Claude Code (npm install -g @anthropic-ai/claude-code)" }
if ($missing.Count -gt 0) {
    Write-Host "  Missing: $($missing -join ', ')" -ForegroundColor Red
    exit 1
}
Write-Host "  All prerequisites found." -ForegroundColor Green

# ─── [2/9] Configuration ───
Write-Host ""
Write-Host "[2/9] Configuration..." -ForegroundColor Yellow
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
$INSTALL_GSD = Read-Host "  Install GSD? 70+ workflow commands + statusbar (y/n)"
if (-not $INSTALL_GSD) { $INSTALL_GSD = "y" }
Write-Host ""

# ─── [3/9] Directories ───
Write-Host "[3/9] Setting up directories..." -ForegroundColor Yellow
foreach ($d in @($CLAUDE_DIR, $SKILLS_DIR, $HOOKS_DIR)) {
    if (-not (Test-Path $d)) { New-Item -Path $d -ItemType Directory -Force | Out-Null }
}
$TEMPLATES_DIR = Join-Path $DEV_DIR "_templates"
if (-not (Test-Path $TEMPLATES_DIR)) { New-Item -Path $TEMPLATES_DIR -ItemType Directory -Force | Out-Null }
Write-Host "  Directories created." -ForegroundColor Green

# ─── [4/9] Plugins ───
Write-Host "[4/9] Installing plugins..." -ForegroundColor Yellow
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

# ─── [5/9] Skills (Windows) ───
Write-Host "[5/9] Installing skills..." -ForegroundColor Yellow
$coreSkills = [System.Collections.ArrayList]@()
[void]$coreSkills.Add(@{ name = "awesome-design-md"; repo = "https://github.com/VoltAgent/awesome-design-md.git" })
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
if ($INSTALL_GSD -eq 'y') {
    Write-Host "  GSD workflow..." -ForegroundColor $dim
    npx get-shit-done-cc@latest --claude --global 2>$null
    Write-Host "  GSD installed." -ForegroundColor Green
}
Write-Host "  Skills installed." -ForegroundColor Green

# ─── [6/9] Hooks ───
Write-Host "[6/9] Installing hooks..." -ForegroundColor Yellow
$hookSource = Join-Path $PARENT_ROOT "templates"
foreach ($hook in @("sensitive-file-guard.js", "self-learning.js", "skill-discovery.js", "session-start.js", "update-check.js")) {
    $src = Join-Path $hookSource $hook
    $dst = Join-Path $HOOKS_DIR $hook
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $dst -Force
        Write-Host "  $hook" -ForegroundColor Green
    }
}

# ─── [7/9] Global CLAUDE.md ───
Write-Host "[7/9] Generating Global CLAUDE.md..." -ForegroundColor Yellow
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
        $fallback = Join-Path (Join-Path $PARENT_ROOT "templates") "CLAUDE.md"
        if (Test-Path $fallback) { Copy-Item -Path $fallback -Destination $globalMd -Force }
        Write-Host "  Global CLAUDE.md copied (default)." -ForegroundColor DarkYellow
    }
}

# ─── [8/9] Dependencies + Templates ───
Write-Host "[8/9] Dependencies and templates..." -ForegroundColor Yellow
foreach ($f in @("start.ps1", "ecosystem-awareness.md", ".claudeignore")) {
    $src = Join-Path (Join-Path $PARENT_ROOT "templates") $f
    $dst = Join-Path $TEMPLATES_DIR $f
    if (Test-Path $src) { Copy-Item -Path $src -Destination $dst -Force }
}
Write-Host "  CodeBurn..." -ForegroundColor $dim -NoNewline
npm install -g codeburn 2>$null
Write-Host " ok" -ForegroundColor Green

if (-not (Get-Command "semgrep" -ErrorAction SilentlyContinue)) {
    $installSemgrep = Read-Host "  Semgrep not found. Install for security scanning? (y/n)"
    if ($installSemgrep -eq 'y') {
        Write-Host "  Installing semgrep..." -ForegroundColor $dim
        pip install semgrep --break-system-packages 2>$null
        if (-not $?) { python -m pip install semgrep 2>$null }
    }
} else { Write-Host "  Semgrep found." -ForegroundColor Green }

if (-not (Get-Command "bun" -ErrorAction SilentlyContinue)) {
    $installBun = Read-Host "  Bun not found. Install? Some plugins use it. (y/n)"
    if ($installBun -eq 'y') { npm install -g bun 2>$null }
} else { Write-Host "  Bun found." -ForegroundColor Green }

# ─── [9/9] WSL Mirror ───
if ($HAS_WSL) {
    Write-Host "[9/9] Syncing to WSL..." -ForegroundColor Yellow
    Write-Host "  Claude Code uses WSL - mirroring skills, hooks, and dependencies..." -ForegroundColor $dim

    # Create WSL .claude directories
    wsl bash -lc 'mkdir -p ~/.claude/skills ~/.claude/hooks'

    # Mirror skills
    Write-Host "  Mirroring skills..." -ForegroundColor $dim
    $uname = $env:USERNAME
    wsl bash -lc "cp -r /mnt/c/Users/$uname/.claude/skills/* ~/.claude/skills/"
    Write-Host "  Skills mirrored to WSL." -ForegroundColor Green

    # Mirror hooks
    Write-Host "  Mirroring hooks..." -ForegroundColor $dim
    wsl bash -lc "cp /mnt/c/Users/$uname/.claude/hooks/*.js ~/.claude/hooks/"
    wsl bash -lc "cp /mnt/c/Users/$uname/.claude/hooks/*.py ~/.claude/hooks/"
    wsl bash -lc "cp /mnt/c/Users/$uname/.claude/hooks/*.sh ~/.claude/hooks/"
    Write-Host "  Hooks mirrored to WSL." -ForegroundColor Green

    # Mirror CLAUDE.md
    wsl bash -lc "cp /mnt/c/Users/$uname/.claude/CLAUDE.md ~/.claude/CLAUDE.md"
    Write-Host "  CLAUDE.md mirrored to WSL." -ForegroundColor Green

    # Install dependencies in WSL
    Write-Host "  Installing WSL dependencies..." -ForegroundColor $dim
    wsl bash -lc 'which semgrep || pip3 install semgrep --break-system-packages'
    wsl bash -lc 'which bun || npm install -g bun'

    # Fix PATH for non-interactive shells
    wsl bash -lc 'grep -q local/bin ~/.profile || echo "export PATH=\$HOME/.local/bin:\$HOME/.npm-global/bin:\$PATH" >> ~/.profile'
    Write-Host "  WSL dependencies ready." -ForegroundColor Green

    # Report
    $wslSkillCount = wsl bash -lc 'ls ~/.claude/skills/ | wc -l'
    $wslHookCount = wsl bash -lc 'ls ~/.claude/hooks/ | wc -l'
    Write-Host "  WSL: $wslSkillCount skills, $wslHookCount hooks synced." -ForegroundColor Cyan
} else {
    Write-Host "[9/9] No WSL detected — skipping." -ForegroundColor $dim
}

# ─── Complete ───
Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "   ClaudeForge setup complete!" -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "  Installed:" -ForegroundColor White
Write-Host "    Plugins     16 (zero redundancy)" -ForegroundColor $dim
Write-Host "    Skills      $($coreSkills.Count) cloned + GSD + plugin bundles" -ForegroundColor $dim
Write-Host "    Hooks       session-start, sensitive-file-guard, self-learning, skill-discovery, update-check" -ForegroundColor $dim
Write-Host '    Workflow    GSD workflow engine' -ForegroundColor $dim
Write-Host "    Config      Global CLAUDE.md with Skill Activation Guide" -ForegroundColor $dim
Write-Host "    Dashboard   CodeBurn (npx codeburn)" -ForegroundColor $dim
if ($HAS_WSL) {
    Write-Host "    WSL         All skills, hooks, deps mirrored" -ForegroundColor Cyan
}
Write-Host ""
Write-Host "  Quick start:" -ForegroundColor White
Write-Host "    cd $DEV_DIR\[your-project]" -ForegroundColor $dim
Write-Host "    claude" -ForegroundColor $dim
Write-Host '    Paste: "Read CLAUDE.md. Run git status. Report status."' -ForegroundColor $dim
if ($INSTALL_CAVEMAN -eq 'y') {
    Write-Host '    Type $caveman to save tokens' -ForegroundColor $dim
}
Write-Host ""
Write-Host "  Health check: npx codeburn optimize" -ForegroundColor $dim
Write-Host "  Docs: https://github.com/cemdenizexe/claudeforge" -ForegroundColor $dim
Write-Host ""